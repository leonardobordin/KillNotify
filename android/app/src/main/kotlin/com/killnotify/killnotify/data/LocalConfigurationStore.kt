package com.killnotify.killnotify.data

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import com.killnotify.killnotify.domain.ScheduleInterval
import com.killnotify.killnotify.domain.WeeklyScheduleEngine
import org.json.JSONArray
import org.json.JSONObject
import java.io.IOException
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.time.LocalDate

private const val DEFAULT_ACCENT_COLOR_ARGB = 0xFF4F46E5L

data class AppRule(
    val packageName: String,
    val selected: Boolean = true,
    val intervals: List<ScheduleInterval> = emptyList(),
    val allowCalls: Boolean = false,
    val allowAlarms: Boolean = false,
    val temporaryAllowUntilEpochMillis: Long? = null,
)

data class LocalConfiguration(
    val filterEnabled: Boolean = false,
    val appRules: Map<String, AppRule> = emptyMap(),
    val themeChoice: String = "system",
    val accentColorArgb: Long = DEFAULT_ACCENT_COLOR_ARGB,
)

data class ConfigurationReadResult(
    val configuration: LocalConfiguration,
    val error: String? = null,
)

data class BackupImportResult(
    val missingPackages: List<String>,
    val accessRequired: Boolean,
    val batteryOptimizationRequired: Boolean,
)

class ConfigurationException(val errorCode: String, message: String) : IllegalArgumentException(message)

/** Native-only configuration store shared by the Activity and NotificationListenerService. */
class LocalConfigurationStore(context: Context) {
    private val appContext = context.applicationContext
    private val preferences = appContext.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)

    fun read(): ConfigurationReadResult = synchronized(lock) {
        val raw = preferences.getString(CONFIG_KEY, null) ?: return@synchronized ConfigurationReadResult(LocalConfiguration())
        try {
            ConfigurationReadResult(decodeConfiguration(raw))
        } catch (_: Exception) {
            ConfigurationReadResult(LocalConfiguration(), STORAGE_ERROR)
        }
    }

    fun setFilterEnabled(enabled: Boolean) {
        update { it.copy(filterEnabled = enabled) }
    }

    fun setThemeChoice(themeChoice: String) {
        if (themeChoice !in THEME_CHOICES) {
            throw ConfigurationException("invalid_argument", "Tema inválido.")
        }
        update { it.copy(themeChoice = themeChoice) }
    }

    fun setAccentColor(accentColorArgb: Long) {
        if (accentColorArgb !in OPAQUE_ARGB_RANGE) {
            throw ConfigurationException("invalid_argument", "A cor precisa ser opaca e válida.")
        }
        update { it.copy(accentColorArgb = accentColorArgb) }
    }

    fun saveAppRule(rule: AppRule) {
        validateRule(rule)
        update { current -> current.copy(appRules = current.appRules + (rule.packageName to rule)) }
    }

    fun removeAppRule(packageName: String) {
        update { current -> current.copy(appRules = current.appRules - packageName) }
    }

    fun setTemporaryException(packageNames: List<String>, untilEpochMillis: Long?) {
        packageNames.distinct().forEach(::validatePackageName)
        update { current ->
            val rules = current.appRules.toMutableMap()
            packageNames.distinct().forEach { packageName ->
                val existing = rules[packageName]
                if (untilEpochMillis == null && existing == null) return@forEach
                val rule = existing ?: AppRule(packageName = packageName, selected = false)
                val updated = rule.copy(temporaryAllowUntilEpochMillis = untilEpochMillis)
                if (untilEpochMillis == null && !updated.selected && updated.intervals.isEmpty() &&
                    !updated.allowCalls && !updated.allowAlarms
                ) {
                    rules.remove(packageName)
                } else {
                    rules[packageName] = updated
                }
            }
            current.copy(appRules = rules)
        }
    }

    fun setCategoryExceptions(packageName: String, allowCalls: Boolean, allowAlarms: Boolean) {
        validatePackageName(packageName)
        update { current ->
            val existing = current.appRules[packageName] ?: AppRule(packageName = packageName, selected = false)
            current.copy(
                appRules = current.appRules + (
                    packageName to existing.copy(allowCalls = allowCalls, allowAlarms = allowAlarms)
                ),
            )
        }
    }

    fun exportBackup(): String {
        val result = read()
        if (result.error != null) throw ConfigurationException("configuration_unreadable", STORAGE_ERROR)
        return encodeConfiguration(result.configuration).toString(2)
    }

    fun importBackup(
        json: String,
        notificationAccessGranted: Boolean,
        batteryOptimizationExempt: Boolean,
    ): BackupImportResult {
        val parsed = try {
            decodeConfiguration(json)
        } catch (error: ConfigurationException) {
            throw error
        } catch (_: Exception) {
            throw ConfigurationException("invalid_backup", "O arquivo JSON não contém uma configuração válida.")
        }

        val requiresAccess = parsed.filterEnabled && !notificationAccessGranted
        val requiresBatteryOptimization = parsed.filterEnabled && !batteryOptimizationExempt
        val imported = parsed.copy(
            filterEnabled = parsed.filterEnabled && notificationAccessGranted && batteryOptimizationExempt,
        )
        synchronized(lock) {
            writeConfiguration(imported)
        }
        val missing = imported.appRules.keys.filterNot(::isPackageInstalled).sorted()
        return BackupImportResult(
            missingPackages = missing,
            accessRequired = requiresAccess,
            batteryOptimizationRequired = requiresBatteryOptimization,
        )
    }

    fun markPending(notificationKey: String, packageName: String, untilEpochMillis: Long) {
        val digest = notificationKeyDigest(notificationKey)
        synchronized(lock) {
            val pending = readPending()
            pending[digest] = PendingNotification(packageName, untilEpochMillis)
            writePending(pending)
        }
    }

    /** Returns true only for a key that the listener previously snoozed. */
    fun completePending(notificationKey: String): Boolean = synchronized(lock) {
        val pending = readPending()
        val removed = pending.remove(notificationKeyDigest(notificationKey)) != null
        if (removed) {
            try {
                writePending(pending)
            } catch (_: IOException) {
                return@synchronized false
            }
            val today = LocalDate.now().toString()
            val storedDay = preferences.getString(RELEASE_COUNT_DATE_KEY, null)
            val count = if (storedDay == today) preferences.getInt(RELEASE_COUNT_KEY, 0) else 0
            preferences.edit()
                .putString(RELEASE_COUNT_DATE_KEY, today)
                .putInt(RELEASE_COUNT_KEY, count + 1)
                .commit()
        }
        removed
    }

    fun forgetPending(notificationKey: String) {
        synchronized(lock) {
            val pending = readPending()
            if (pending.remove(notificationKeyDigest(notificationKey)) != null) {
                runCatching { writePending(pending) }
            }
        }
    }

    fun releasedCountToday(): Int = synchronized(lock) {
        if (preferences.getString(RELEASE_COUNT_DATE_KEY, null) == LocalDate.now().toString()) {
            preferences.getInt(RELEASE_COUNT_KEY, 0)
        } else {
            0
        }
    }

    private fun update(transform: (LocalConfiguration) -> LocalConfiguration) {
        synchronized(lock) {
            val current = read()
            if (current.error != null) throw ConfigurationException("configuration_unreadable", STORAGE_ERROR)
            val updated = transform(current.configuration)
            updated.appRules.values.forEach(::validateRule)
            writeConfiguration(updated)
        }
    }

    private fun writeConfiguration(configuration: LocalConfiguration) {
        val written = preferences.edit().putString(CONFIG_KEY, encodeConfiguration(configuration).toString()).commit()
        if (!written) throw IOException("Could not persist local configuration.")
    }

    private fun encodeConfiguration(configuration: LocalConfiguration): JSONObject = JSONObject().apply {
        put("schemaVersion", SCHEMA_VERSION)
        put("filterEnabled", configuration.filterEnabled)
        put("themeChoice", configuration.themeChoice)
        put("accentColor", configuration.accentColorArgb)
        put("appRules", JSONArray().apply {
            configuration.appRules.values.sortedBy(AppRule::packageName).forEach { rule ->
                put(JSONObject().apply {
                    put("packageName", rule.packageName)
                    put("selected", rule.selected)
                    put("allowCalls", rule.allowCalls)
                    put("allowAlarms", rule.allowAlarms)
                    put("temporaryAllowUntilEpochMillis", rule.temporaryAllowUntilEpochMillis ?: JSONObject.NULL)
                    put("intervals", JSONArray().apply {
                        rule.intervals.forEach { interval ->
                            put(JSONObject().apply {
                                put("dayIndex", interval.dayIndex)
                                put("startMinute", interval.startMinute)
                                put("endMinute", interval.endMinute)
                            })
                        }
                    })
                })
            }
        })
    }

    private fun decodeConfiguration(json: String): LocalConfiguration {
        val root = JSONObject(json)
        val version = root.optInt("schemaVersion", -1)
        if (version != SCHEMA_VERSION) {
            throw ConfigurationException("unsupported_version", "Versão de backup não suportada: $version.")
        }
        if (!root.has("filterEnabled") || !root.has("appRules") || !root.has("themeChoice")) {
            throw ConfigurationException("invalid_backup", "O backup está incompleto.")
        }
        val rulesJson = root.getJSONArray("appRules")
        val rules = linkedMapOf<String, AppRule>()
        for (index in 0 until rulesJson.length()) {
            val item = rulesJson.getJSONObject(index)
            val packageName = item.getString("packageName")
            validatePackageName(packageName)
            if (rules.containsKey(packageName)) {
                throw ConfigurationException("invalid_backup", "O backup contém regras duplicadas para um app.")
            }
            val intervalsJson = item.getJSONArray("intervals")
            val intervals = buildList {
                for (intervalIndex in 0 until intervalsJson.length()) {
                    val interval = intervalsJson.getJSONObject(intervalIndex)
                    add(
                        ScheduleInterval(
                            dayIndex = interval.getInt("dayIndex"),
                            startMinute = interval.getInt("startMinute"),
                            endMinute = interval.getInt("endMinute"),
                        ),
                    )
                }
            }
            val until = if (item.isNull("temporaryAllowUntilEpochMillis")) null else
                item.getLong("temporaryAllowUntilEpochMillis").takeIf { it > 0L }
            val rule = AppRule(
                packageName = packageName,
                selected = item.getBoolean("selected"),
                intervals = intervals,
                allowCalls = item.getBoolean("allowCalls"),
                allowAlarms = item.getBoolean("allowAlarms"),
                temporaryAllowUntilEpochMillis = until,
            )
            validateRule(rule)
            rules[packageName] = rule
        }
        val themeChoice = root.getString("themeChoice")
        if (themeChoice !in THEME_CHOICES) {
            throw ConfigurationException("invalid_backup", "O backup contém um tema inválido.")
        }
        val accentColorArgb = root.optLong("accentColor", DEFAULT_ACCENT_COLOR_ARGB)
        if (accentColorArgb !in OPAQUE_ARGB_RANGE) {
            throw ConfigurationException("invalid_backup", "O backup contém uma cor de destaque inválida.")
        }
        return LocalConfiguration(
            root.getBoolean("filterEnabled"),
            rules,
            themeChoice,
            accentColorArgb,
        )
    }

    private fun validateRule(rule: AppRule) {
        validatePackageName(rule.packageName)
        WeeklyScheduleEngine.validate(rule.intervals)
        require(rule.temporaryAllowUntilEpochMillis == null || rule.temporaryAllowUntilEpochMillis > 0L) {
            "Temporary exception expiry must be a positive epoch timestamp."
        }
    }

    private fun validatePackageName(packageName: String) {
        if (!PACKAGE_NAME.matches(packageName)) {
            throw ConfigurationException("invalid_argument", "Nome de pacote inválido.")
        }
    }

    private fun readPending(): MutableMap<String, PendingNotification> {
        val raw = preferences.getString(PENDING_KEY, null) ?: return mutableMapOf()
        return try {
            val array = JSONArray(raw)
            buildMap {
                for (index in 0 until array.length()) {
                    val item = array.getJSONObject(index)
                    val digest = item.getString("keyDigest")
                    put(digest, PendingNotification(item.getString("packageName"), item.getLong("untilEpochMillis")))
                }
            }.toMutableMap()
        } catch (_: Exception) {
            mutableMapOf()
        }
    }

    private fun writePending(pending: Map<String, PendingNotification>) {
        val array = JSONArray().apply {
            pending.toSortedMap().forEach { (digest, item) ->
                put(JSONObject().apply {
                    put("keyDigest", digest)
                    put("packageName", item.packageName)
                    put("untilEpochMillis", item.untilEpochMillis)
                })
            }
        }
        if (!preferences.edit().putString(PENDING_KEY, array.toString()).commit()) {
            throw IOException("Could not persist notification metadata.")
        }
    }

    private fun notificationKeyDigest(key: String): String {
        val digest = MessageDigest.getInstance("SHA-256").digest(key.toByteArray(StandardCharsets.UTF_8))
        return digest.joinToString("") { byte -> "%02x".format(byte.toInt() and 0xff) }
    }

    private fun isPackageInstalled(packageName: String): Boolean = try {
        if (Build.VERSION.SDK_INT >= 33) {
            appContext.packageManager.getApplicationInfo(packageName, PackageManager.ApplicationInfoFlags.of(0))
        } else {
            @Suppress("DEPRECATION")
            appContext.packageManager.getApplicationInfo(packageName, 0)
        }
        true
    } catch (_: PackageManager.NameNotFoundException) {
        false
    }

    private data class PendingNotification(val packageName: String, val untilEpochMillis: Long)

    companion object {
        private const val PREFERENCES = "killnotify_local"
        private const val CONFIG_KEY = "configuration_v1"
        private const val PENDING_KEY = "pending_snoozed_metadata_v1"
        private const val RELEASE_COUNT_DATE_KEY = "released_count_date"
        private const val RELEASE_COUNT_KEY = "released_count"
        private const val SCHEMA_VERSION = 1
        private val OPAQUE_ARGB_RANGE = 0xFF000000L..0xFFFFFFFFL
        private const val STORAGE_ERROR = "As configurações locais não puderam ser lidas. O filtro permanece inativo até importar um backup válido."
        private val PACKAGE_NAME = Regex("[A-Za-z0-9_]+(?:\\.[A-Za-z0-9_]+)+")
        private val THEME_CHOICES = setOf("system", "light", "dark", "amoled")
        private val lock = Any()
    }
}
