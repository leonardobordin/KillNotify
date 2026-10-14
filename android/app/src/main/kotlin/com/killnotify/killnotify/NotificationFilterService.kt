package com.killnotify.killnotify

import android.content.ComponentName
import android.os.PowerManager
import android.provider.Settings
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import com.killnotify.killnotify.data.LocalConfigurationStore
import com.killnotify.killnotify.domain.NotificationBypassPolicy
import com.killnotify.killnotify.domain.WeeklyScheduleEngine
import java.time.ZoneId

/** Notification processing stays native and does not create or depend on a Dart engine. */
class NotificationFilterService : NotificationListenerService() {
    private val store by lazy { LocalConfigurationStore(applicationContext) }

    override fun onListenerConnected() {
        super.onListenerConnected()
        isConnected = true
    }

    override fun onListenerDisconnected() {
        isConnected = false
        if (!hasNotificationAccess() || !hasBatteryOptimizationExemption()) {
            runCatching { store.setFilterEnabled(false) }
        }
        super.onListenerDisconnected()
    }

    override fun onDestroy() {
        isConnected = false
        super.onDestroy()
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (sbn.packageName == packageName) return

        if (!hasNotificationAccess() || !hasBatteryOptimizationExemption()) {
            runCatching { store.setFilterEnabled(false) }
            store.completePending(sbn.key)
            return
        }

        val read = store.read()
        if (read.error != null || !read.configuration.filterEnabled) {
            store.completePending(sbn.key)
            return
        }

        val rule = read.configuration.appRules[sbn.packageName]
        if (rule == null || !rule.selected || rule.intervals.isEmpty()) {
            store.completePending(sbn.key)
            return
        }

        val now = System.currentTimeMillis()
        if (NotificationBypassPolicy.temporaryExceptionActive(rule.temporaryAllowUntilEpochMillis, now)) {
            store.completePending(sbn.key)
            return
        }

        val category = sbn.notification.category
        if (NotificationBypassPolicy.categoryExceptionApplies(category, rule.allowCalls, rule.allowAlarms)) {
            store.completePending(sbn.key)
            return
        }

        val decision = runCatching {
            WeeklyScheduleEngine.evaluate(rule.intervals, now, ZoneId.systemDefault())
        }.getOrNull()
        if (decision == null || decision.allowed) {
            store.completePending(sbn.key)
            return
        }

        val nextStart = decision.nextStartEpochMillis ?: run {
            store.completePending(sbn.key)
            return
        }
        val remainingMillis = (nextStart - now).coerceAtLeast(1L)
        try {
            // Persist only a digest of the system key and scheduling metadata; never inspect content/extras.
            store.markPending(sbn.key, sbn.packageName, nextStart)
            snoozeNotification(sbn.key, remainingMillis)
        } catch (_: Exception) {
            store.forgetPending(sbn.key)
            // The system still owns the original notification; no replacement is posted here.
        }
    }

    override fun onNotificationRemoved(
        sbn: StatusBarNotification,
        rankingMap: RankingMap,
        reason: Int,
    ) {
        if (sbn.packageName != packageName && reason != REASON_SNOOZED) {
            store.forgetPending(sbn.key)
        }
    }

    private fun hasNotificationAccess(): Boolean {
        val enabledListeners = Settings.Secure.getString(contentResolver, "enabled_notification_listeners")
            ?: return false
        val component = ComponentName(this, NotificationFilterService::class.java).flattenToString()
        return enabledListeners.split(':').any { it.equals(component, ignoreCase = true) }
    }

    private fun hasBatteryOptimizationExemption(): Boolean =
        getSystemService(PowerManager::class.java)
            ?.isIgnoringBatteryOptimizations(packageName) == true

    companion object {
        @Volatile
        var isConnected: Boolean = false
            private set
    }
}
