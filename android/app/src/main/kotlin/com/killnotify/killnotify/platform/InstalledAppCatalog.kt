package com.killnotify.killnotify.platform

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build

data class InstalledApp(
    val packageName: String,
    val label: String,
    val isSystemApp: Boolean,
    val hasLauncherActivity: Boolean,
)

class InstalledAppCatalog(context: Context) {
    private val appContext = context.applicationContext

    @Suppress("DEPRECATION")
    fun listApps(): List<InstalledApp> {
        val packageManager = appContext.packageManager
        val installed = if (Build.VERSION.SDK_INT >= 33) {
            packageManager.getInstalledApplications(PackageManager.ApplicationInfoFlags.of(0))
        } else {
            packageManager.getInstalledApplications(0)
        }
        return installed.asSequence()
            .filterNot { it.packageName == appContext.packageName }
            .map { info ->
                val label = runCatching { info.loadLabel(packageManager).toString().trim() }
                    .getOrNull()
                    .orEmpty()
                    .ifBlank { info.packageName }
                InstalledApp(
                    packageName = info.packageName,
                    label = label,
                    isSystemApp = info.flags and ApplicationInfo.FLAG_SYSTEM != 0,
                    hasLauncherActivity = packageManager.getLaunchIntentForPackage(info.packageName) != null,
                )
            }
            .sortedWith(compareBy<InstalledApp> { it.label.lowercase() }.thenBy { it.packageName })
            .toList()
    }
}
