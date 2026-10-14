package com.killnotify.killnotify

import android.content.ComponentName
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import com.killnotify.killnotify.data.AppRule
import com.killnotify.killnotify.data.ConfigurationException
import com.killnotify.killnotify.data.LocalConfigurationStore
import com.killnotify.killnotify.domain.ScheduleInterval
import com.killnotify.killnotify.domain.WeeklyScheduleEngine
import com.killnotify.killnotify.platform.InstalledAppCatalog
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.IOException
import java.nio.charset.StandardCharsets
import java.time.ZoneId

class MainActivity : FlutterActivity() {
    private val store by lazy { LocalConfigurationStore(applicationContext) }
    private val appCatalog by lazy { InstalledAppCatalog(applicationContext) }
    private var pendingDocumentResult: MethodChannel.Result? = null
    private var pendingDocumentMode: DocumentMode? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
            .setMethodCallHandler { call, result -> handleMethod(call, result) }
    }

    private fun handleMethod(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "getSnapshot" -> result.success(snapshot())
                "listApps" -> result.success(appCatalog.listApps().map { app ->
                    mapOf(
                        "packageName" to app.packageName,
                        "label" to app.label,
                        "isSystemApp" to app.isSystemApp,
                        "hasLauncherActivity" to app.hasLauncherActivity,
                    )
                })
                "saveAppRule" -> {
                    store.saveAppRule(readRule(call))
                    result.success(snapshot())
                }
                "removeAppRule" -> {
                    store.removeAppRule(requireString(call, "packageName"))
                    result.success(snapshot())
                }
                "setFilterEnabled" -> {
                    val enabled = call.argument<Boolean>("enabled")
                        ?: throw ConfigurationException("invalid_argument", "O estado do filtro é obrigatório.")
                    if (enabled && !hasNotificationAccess()) {
                        throw ConfigurationException("access_required", "Conceda acesso às notificações nas configurações do Android antes de ativar o filtro.")
                    }
                    if (enabled && !hasBatteryOptimizationExemption()) {
                        throw ConfigurationException("battery_optimization_required", "Permita a atividade do KillNotify em segundo plano nas configurações de bateria antes de ativar o filtro.")
                    }
                    store.setFilterEnabled(enabled)
                    result.success(snapshot())
                }
                "setThemeChoice" -> {
                    store.setThemeChoice(requireString(call, "themeChoice"))
                    result.success(snapshot())
                }
                "setAccentColor" -> {
                    val accentColor = call.argument<Number>("accentColor")?.toLong()
                        ?: throw ConfigurationException("invalid_argument", "A cor de destaque é obrigatória.")
                    store.setAccentColor(accentColor)
                    result.success(snapshot())
                }
                "setTemporaryException" -> {
                    val packageNames = readPackageNames(call)
                    val until = call.argument<Number>("untilEpochMillis")?.toLong()
                    if (until != null && until <= System.currentTimeMillis()) {
                        throw ConfigurationException("invalid_argument", "A exceção precisa terminar no futuro.")
                    }
                    store.setTemporaryException(packageNames, until)
                    result.success(snapshot())
                }
                "setCategoryExceptions" -> {
                    val packageName = requireString(call, "packageName")
                    val allowCalls = call.argument<Boolean>("allowCalls")
                        ?: throw ConfigurationException("invalid_argument", "Informe a exceção de chamadas.")
                    val allowAlarms = call.argument<Boolean>("allowAlarms")
                        ?: throw ConfigurationException("invalid_argument", "Informe a exceção de alarmes.")
                    store.setCategoryExceptions(packageName, allowCalls, allowAlarms)
                    result.success(snapshot())
                }
                "openNotificationAccessSettings" -> {
                    startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
                    result.success(null)
                }
                "requestBatteryOptimizationExemption" -> {
                    val request = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
                        .setData(Uri.parse("package:$packageName"))
                    if (request.resolveActivity(packageManager) != null) {
                        startActivity(request)
                    } else {
                        startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
                    }
                    result.success(null)
                }
                "exportBackup" -> launchDocumentPicker(DocumentMode.EXPORT, result)
                "importBackup" -> launchDocumentPicker(DocumentMode.IMPORT, result)
                else -> result.notImplemented()
            }
        } catch (error: ConfigurationException) {
            result.error(error.errorCode, error.message, null)
        } catch (error: IllegalArgumentException) {
            result.error("invalid_argument", error.message ?: "Parâmetro inválido.", null)
        } catch (_: IOException) {
            result.error("platform_error", "Não foi possível acessar o armazenamento local.", null)
        } catch (_: Exception) {
            result.error("platform_error", "Não foi possível concluir a operação Android.", null)
        }
    }

    private fun snapshot(): Map<String, Any?> {
        val access = hasNotificationAccess()
        val batteryExempt = hasBatteryOptimizationExemption()
        var read = store.read()
        if ((!access || !batteryExempt) && read.error == null && read.configuration.filterEnabled) {
            store.setFilterEnabled(false)
            read = store.read()
        }
        val now = System.currentTimeMillis()
        val zone = ZoneId.systemDefault()
        val rules = read.configuration.appRules.values.sortedBy(AppRule::packageName).map { rule ->
            val decision = if (rule.selected && rule.intervals.isNotEmpty() &&
                (rule.temporaryAllowUntilEpochMillis == null || now >= rule.temporaryAllowUntilEpochMillis)
            ) {
                WeeklyScheduleEngine.evaluate(rule.intervals, now, zone)
            } else {
                null
            }
            val effective = WeeklyScheduleEngine.toDailyWindows(WeeklyScheduleEngine.normalize(rule.intervals))
            mapOf(
                "packageName" to rule.packageName,
                "selected" to rule.selected,
                "intervals" to rule.intervals.map(::intervalMap),
                "effectiveWindows" to effective.map { window ->
                    mapOf(
                        "dayIndex" to window.dayIndex,
                        "startMinute" to window.startMinute,
                        "endMinute" to window.endMinute,
                    )
                },
                "isAllowedNow" to (decision?.allowed ?: true),
                "nextAllowedStartEpochMillis" to decision?.nextStartEpochMillis,
                "allowCalls" to rule.allowCalls,
                "allowAlarms" to rule.allowAlarms,
                "temporaryAllowUntilEpochMillis" to rule.temporaryAllowUntilEpochMillis,
            )
        }
        val next = rules.mapNotNull { item ->
            (item["nextAllowedStartEpochMillis"] as? Long)?.let { (item["packageName"] as String) to it }
        }.minByOrNull { it.second }
        val serviceConnected = NotificationFilterService.isConnected
        val state = when {
            read.error != null -> "configuration_error"
            !access -> "needs_access"
            !batteryExempt -> "needs_battery_optimization"
            !read.configuration.filterEnabled -> "disabled"
            !serviceConnected -> "waiting_for_listener"
            else -> "active"
        }
        return mapOf(
            "contractVersion" to CONTRACT_VERSION,
            "state" to state,
            "accessGranted" to access,
            "batteryOptimizationExempt" to batteryExempt,
            "manufacturerFamily" to manufacturerFamily(),
            "filterEnabled" to read.configuration.filterEnabled,
            "filterActive" to (state == "active"),
            "themeChoice" to read.configuration.themeChoice,
            "accentColor" to read.configuration.accentColorArgb,
            "listenerConnected" to serviceConnected,
            "zoneId" to zone.id,
            "checkedAtEpochMillis" to now,
            "releasedCountToday" to store.releasedCountToday(),
            "nextPackageName" to next?.first,
            "nextAllowedStartEpochMillis" to next?.second,
            "appRules" to rules,
            "configurationError" to read.error,
        )
    }

    private fun readRule(call: MethodCall): AppRule {
        val packageName = requireString(call, "packageName")
        val intervalsArgument = call.argument<List<*>>("intervals")
            ?: throw ConfigurationException("invalid_argument", "A lista de intervalos é obrigatória.")
        val intervals = intervalsArgument.mapIndexed { index, value ->
            val map = value as? Map<*, *>
                ?: throw ConfigurationException("invalid_argument", "Intervalo $index inválido.")
            ScheduleInterval(
                dayIndex = map.number("dayIndex")?.toInt()
                    ?: throw ConfigurationException("invalid_argument", "Dia do intervalo $index inválido."),
                startMinute = map.number("startMinute")?.toInt()
                    ?: throw ConfigurationException("invalid_argument", "Início do intervalo $index inválido."),
                endMinute = map.number("endMinute")?.toInt()
                    ?: throw ConfigurationException("invalid_argument", "Fim do intervalo $index inválido."),
            )
        }
        return AppRule(
            packageName = packageName,
            selected = call.argument<Boolean>("selected") ?: true,
            intervals = intervals,
            allowCalls = call.argument<Boolean>("allowCalls") ?: false,
            allowAlarms = call.argument<Boolean>("allowAlarms") ?: false,
            temporaryAllowUntilEpochMillis = call.argument<Number>("temporaryAllowUntilEpochMillis")?.toLong(),
        )
    }

    private fun readPackageNames(call: MethodCall): List<String> =
        call.argument<List<*>>("packageNames")?.mapIndexed { index, value ->
            value as? String ?: throw ConfigurationException("invalid_argument", "App $index inválido.")
        } ?: throw ConfigurationException("invalid_argument", "A lista de apps é obrigatória.")

    private fun requireString(call: MethodCall, key: String): String =
        call.argument<String>(key)?.takeIf { it.isNotBlank() }
            ?: throw ConfigurationException("invalid_argument", "Campo obrigatório ausente: $key.")

    private fun Map<*, *>.number(key: String): Number? = this[key] as? Number

    private fun intervalMap(interval: ScheduleInterval): Map<String, Int> = mapOf(
        "dayIndex" to interval.dayIndex,
        "startMinute" to interval.startMinute,
        "endMinute" to interval.endMinute,
    )

    private fun hasNotificationAccess(): Boolean {
        val enabledListeners = Settings.Secure.getString(contentResolver, "enabled_notification_listeners")
            ?: return false
        val component = ComponentName(this, NotificationFilterService::class.java).flattenToString()
        return enabledListeners.split(':').any { it.equals(component, ignoreCase = true) }
    }

    private fun hasBatteryOptimizationExemption(): Boolean =
        getSystemService(PowerManager::class.java)
            ?.isIgnoringBatteryOptimizations(packageName) == true

    private fun manufacturerFamily(): String {
        val manufacturer = Build.MANUFACTURER.lowercase()
        val brand = Build.BRAND.lowercase()
        return when {
            manufacturer.contains("samsung") || brand.contains("samsung") -> "samsung"
            manufacturer.contains("xiaomi") || manufacturer.contains("redmi") ||
                manufacturer.contains("poco") || brand.contains("xiaomi") ||
                brand.contains("redmi") || brand.contains("poco") -> "xiaomi"
            manufacturer.contains("huawei") || brand.contains("huawei") -> "huawei"
            manufacturer.contains("realme") || brand.contains("realme") -> "realme"
            manufacturer.contains("oppo") || brand.contains("oppo") -> "oppo"
            manufacturer.contains("oneplus") || brand.contains("oneplus") -> "oneplus"
            manufacturer.contains("vivo") || brand.contains("vivo") -> "vivo"
            manufacturer.contains("motorola") || brand.contains("motorola") -> "motorola"
            else -> "other"
        }
    }

    private fun launchDocumentPicker(mode: DocumentMode, result: MethodChannel.Result) {
        if (pendingDocumentResult != null) {
            result.error("busy", "Outra operação de backup está em andamento.", null)
            return
        }
        val intent = Intent(
            if (mode == DocumentMode.EXPORT) Intent.ACTION_CREATE_DOCUMENT else Intent.ACTION_OPEN_DOCUMENT,
        ).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            type = "application/json"
            if (mode == DocumentMode.EXPORT) {
                putExtra(Intent.EXTRA_TITLE, "killnotify-config-v1.json")
            }
        }
        pendingDocumentMode = mode
        pendingDocumentResult = result
        try {
            startActivityForResult(intent, DOCUMENT_REQUEST_CODE)
        } catch (_: Exception) {
            pendingDocumentMode = null
            pendingDocumentResult = null
            result.error("platform_error", "O seletor de arquivos não está disponível.", null)
        }
    }

    @Deprecated("The Activity Result API is not needed for this one-shot SAF contract.")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != DOCUMENT_REQUEST_CODE) {
            super.onActivityResult(requestCode, resultCode, data)
            return
        }
        val result = pendingDocumentResult
        val mode = pendingDocumentMode
        pendingDocumentResult = null
        pendingDocumentMode = null
        if (result == null || mode == null) return
        val uri = data?.data
        if (resultCode != RESULT_OK || uri == null) {
            result.success(mapOf("cancelled" to true))
            return
        }
        try {
            when (mode) {
                DocumentMode.EXPORT -> {
                    val backup = store.exportBackup()
                    contentResolver.openOutputStream(uri, "wt")?.bufferedWriter(StandardCharsets.UTF_8)?.use {
                        it.write(backup)
                    } ?: throw IOException("Could not open the selected document.")
                    result.success(mapOf("cancelled" to false))
                }
                DocumentMode.IMPORT -> {
                    val backup = contentResolver.openInputStream(uri)?.use(::readBackup)
                        ?: throw IOException("Could not read the selected document.")
                    val imported = store.importBackup(
                        backup,
                        hasNotificationAccess(),
                        hasBatteryOptimizationExemption(),
                    )
                    result.success(
                        mapOf(
                            "cancelled" to false,
                            "missingPackages" to imported.missingPackages,
                            "accessRequired" to imported.accessRequired,
                            "batteryOptimizationRequired" to imported.batteryOptimizationRequired,
                            "snapshot" to snapshot(),
                        ),
                    )
                }
            }
        } catch (error: ConfigurationException) {
            result.error(error.errorCode, error.message, null)
        } catch (error: IOException) {
            result.error("platform_error", "Não foi possível ler ou gravar o backup.", null)
        } catch (_: Exception) {
            result.error("platform_error", "O backup não pôde ser processado.", null)
        }
    }

    private enum class DocumentMode { EXPORT, IMPORT }

    private fun readBackup(input: java.io.InputStream): String {
        val output = ByteArrayOutputStream()
        val buffer = ByteArray(8192)
        var totalBytes = 0
        while (true) {
            val count = input.read(buffer)
            if (count < 0) break
            totalBytes += count
            if (totalBytes > MAX_BACKUP_BYTES) {
                throw ConfigurationException("invalid_backup", "O arquivo de backup excede 1 MB.")
            }
            output.write(buffer, 0, count)
        }
        return output.toString(StandardCharsets.UTF_8.name())
    }

    companion object {
        private const val CHANNEL_NAME = "com.killnotify/v1"
        private const val CONTRACT_VERSION = 1
        private const val DOCUMENT_REQUEST_CODE = 7301
        private const val MAX_BACKUP_BYTES = 1_048_576
    }
}
