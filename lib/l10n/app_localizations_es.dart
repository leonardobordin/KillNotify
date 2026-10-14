// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabApps => 'Aplicaciones';

  @override
  String get tabExceptions => 'Excepciones';

  @override
  String get tabSettings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Seguir el sistema';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get refreshStatus => 'Actualizar estado';

  @override
  String get refreshAppList => 'Actualizar lista';

  @override
  String get notificationsReleasedToday => 'Notificaciones liberadas hoy';

  @override
  String get notificationCountPrivacy =>
      'Recuento en este dispositivo; no se guardan mensajes ni acciones.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps con horarios',
      one: '$count app con horarios',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule =>
      'Cada app puede tener sus propios horarios.';

  @override
  String get filterActive => 'Filtro activo';

  @override
  String get filterActiveExplanation =>
      'KillNotify está aplicando los horarios configurados.';

  @override
  String get filterInactive => 'Filtro inactivo';

  @override
  String get listenerNotFollowing =>
      'KillNotify todavía no está supervisando las notificaciones. Algunas pueden llegar sin aplazarse.';

  @override
  String get batterySetupRequired => 'Ajusta la batería para continuar';

  @override
  String get batterySetupExplanation =>
      'Permite la actividad en segundo plano para activar el filtro.';

  @override
  String get schedulesUnavailable => 'Horarios no disponibles';

  @override
  String get schedulesUnavailableExplanation =>
      'El filtro está apagado hasta que se puedan leer los ajustes guardados.';

  @override
  String get filterDisabled => 'Filtro desactivado';

  @override
  String get notificationsArriveNormally =>
      'Las notificaciones llegan normalmente, sin aplazarse.';

  @override
  String get accessNeeded => 'Acceso necesario';

  @override
  String get notificationAccessNeeded =>
      'Para aplicar los horarios, permite que KillNotify acceda a las notificaciones en los ajustes de Android.';

  @override
  String get openAndroidSettings => 'Abrir ajustes de Android';

  @override
  String get activateFilter => 'Activar filtro';

  @override
  String get filterNeedsBoth =>
      'Permite el acceso a las notificaciones y ajusta la batería antes de activarlo.';

  @override
  String get filterNeedsAccess =>
      'Permite el acceso a las notificaciones antes de activarlo.';

  @override
  String get filterNeedsBattery =>
      'Ajusta la batería para que el filtro funcione en segundo plano.';

  @override
  String get filterAppliesSchedules =>
      'Aplica los horarios definidos para cada app.';

  @override
  String get restoreBackupForSchedules =>
      'Importa una copia de seguridad en Configuración para recuperar tus horarios.';

  @override
  String get checkingFilter => 'Comprobando el filtro…';

  @override
  String get cannotCheckFilter =>
      'No se pudo comprobar el filtro. Toca actualizar e inténtalo de nuevo.';

  @override
  String get nextAllowedStart => 'Próximo inicio permitido';

  @override
  String get nextConfiguredWindow => 'Próxima franja programada';

  @override
  String get noAppWaiting => 'Ninguna app está esperando su horario ahora';

  @override
  String get noSchedulesYet => 'Todavía no hay horarios';

  @override
  String get filterInactiveInformative =>
      'El filtro está desactivado; horario informativo.';

  @override
  String get timezoneInfo =>
      'Los horarios usan la zona horaria configurada en el dispositivo.';

  @override
  String get chooseAppsAndPeriods =>
      'Elige apps y define cuándo pueden llegar sus notificaciones.';

  @override
  String get androidControlsSnooze =>
      'Android controla cuándo vuelve a aparecer una notificación aplazada. El horario puede variar por el ahorro de batería, los ajustes del dispositivo o cambios del reloj.';

  @override
  String get searchApp => 'Buscar apps';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get appsListDisclosure =>
      'La lista incluye apps del sistema y apps sin icono en la pantalla de inicio. Android quizá no permita filtrar notificaciones de perfiles de trabajo o algunos servicios.';

  @override
  String get noSearchMatch => 'Ninguna app coincide con la búsqueda.';

  @override
  String get systemApp => 'App del sistema';

  @override
  String get noLauncherIcon => 'Sin icono en la pantalla de inicio';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count periodos definidos',
      one: '$count periodo definido',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps con horarios',
      one: '$count app con horarios',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'Apps no instaladas';

  @override
  String get schedulesPreserved =>
      'Los horarios se conservaron y volverán a aplicarse si se instala la app.';

  @override
  String get appNotFound => 'App no encontrada';

  @override
  String get removeRule => 'Eliminar regla';

  @override
  String packageIdentifier(String packageName) {
    return 'Paquete: $packageName';
  }

  @override
  String get applySchedulesToApp => 'Aplicar horarios a esta app';

  @override
  String get noSchedulesAllowNormally =>
      'Sin horarios, las notificaciones llegan normalmente.';

  @override
  String get weeklyPeriods => 'Periodos semanales';

  @override
  String get addPeriod => 'Añadir periodo';

  @override
  String get noPeriodsForApp =>
      'Aún no hay horarios. Las notificaciones de esta app llegan normalmente.';

  @override
  String get period24HoursHint =>
      'Si la hora de inicio y fin es la misma, el periodo dura 24 horas.';

  @override
  String get removePeriod => 'Eliminar periodo';

  @override
  String get exceptions => 'Excepciones';

  @override
  String get allowCallNotifications => 'Permitir notificaciones de llamadas';

  @override
  String get callsCategoryOnly =>
      'Solo cuando la app emisora la identifica como llamada.';

  @override
  String get allowAlarmNotifications => 'Permitir notificaciones de alarmas';

  @override
  String get alarmsCategoryOnly =>
      'Solo cuando la app emisora la identifica como alarma.';

  @override
  String get saveSchedules => 'Guardar horarios';

  @override
  String get schedulesSaved => 'Horarios guardados.';

  @override
  String get newPeriod => 'Nuevo periodo';

  @override
  String get editPeriod => 'Editar periodo';

  @override
  String get allowedDays => 'Días en los que pueden llegar notificaciones';

  @override
  String get selectAtLeastOneDay => 'Selecciona al menos un día.';

  @override
  String get startTime => 'Inicio';

  @override
  String get endTime => 'Fin';

  @override
  String get periodMayCrossMidnight =>
      'El periodo puede terminar al día siguiente. Si inicio y fin coinciden, dura 24 horas.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Añadir';

  @override
  String get save => 'Guardar';

  @override
  String get effectiveSchedule => 'Horario efectivo';

  @override
  String get overlappingPeriodsGrouped =>
      'Los periodos superpuestos o contiguos se agrupan. Los horarios originales se conservan.';

  @override
  String get saveToPreviewPeriods =>
      'Guarda para ver cómo se agruparán los periodos.';

  @override
  String get noSchedulesNotificationsPass =>
      'Sin horarios, las notificaciones llegan normalmente.';

  @override
  String get temporaryException => 'Excepción temporal';

  @override
  String allowUntil(String time) {
    return 'Permitir hasta $time';
  }

  @override
  String get noActiveExceptionForApp =>
      'No hay excepciones activas para esta app.';

  @override
  String get oneHour => '1 hora';

  @override
  String get fourHours => '4 horas';

  @override
  String get eightHours => '8 horas';

  @override
  String get twentyFourHours => '24 horas';

  @override
  String get remove => 'Eliminar';

  @override
  String get temporaryExceptions => 'Excepciones temporales';

  @override
  String get temporaryExceptionsExplanation =>
      'Permite temporalmente las notificaciones de una o varias apps. La excepción termina a la hora elegida según el reloj del dispositivo.';

  @override
  String get duration => 'Duración';

  @override
  String get chooseTime => 'Elegir hora';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionadas',
      one: '$count seleccionada',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Seleccionar resultados';

  @override
  String get clear => 'Borrar';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps',
      one: '$count app',
    );
    return 'Permitir temporalmente $_temp0';
  }

  @override
  String get activeTemporaryExceptions => 'Excepciones temporales activas';

  @override
  String get noTemporaryExceptions => 'No hay excepciones temporales activas.';

  @override
  String untilTime(String time) {
    return 'Hasta $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Hasta $time · Paquete: $packageName';
  }

  @override
  String get endException => 'Finalizar excepción';

  @override
  String get chooseFutureTime => 'Elige una hora futura.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Excepción temporal aplicada a $count apps.',
      one: 'Excepción temporal aplicada a $count app.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Acceso a las notificaciones';

  @override
  String get accessGrantedInAndroid => 'Concedido en los ajustes de Android.';

  @override
  String get accessRequiredToFilter =>
      'Necesario para filtrar notificaciones de otras apps.';

  @override
  String get automaticUpdates => 'Buscar actualizaciones automáticamente';

  @override
  String get automaticUpdatesHint =>
      'Consulta GitHub como máximo una vez al día y avisa cuando hay una nueva versión.';

  @override
  String get checkForUpdateNow => 'Buscar actualización ahora';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get followSystem => 'Seguir el sistema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Color de acento';

  @override
  String get customColor => 'Personalizado';

  @override
  String selectedColor(String color) {
    return 'Seleccionado: $color';
  }

  @override
  String get localBackup => 'Copia de seguridad local';

  @override
  String get backupDescription =>
      'El archivo contiene reglas, excepciones y preferencias. No incluye contenido de notificaciones, mensajes ni acciones.';

  @override
  String get exportSettings => 'Exportar ajustes';

  @override
  String get importSettings => 'Importar ajustes';

  @override
  String get noAccountPrivacy =>
      'KillNotify no tiene cuenta ni envía datos personales. La app se distribuye manualmente y no está en Google Play.';

  @override
  String get importBackupTitle => '¿Importar copia de seguridad?';

  @override
  String get importBackupWarning =>
      'La importación reemplaza los ajustes actuales. El archivo se valida antes de aplicarse.';

  @override
  String get chooseBackupFile => 'Elegir archivo';

  @override
  String get backupImported => 'Copia de seguridad importada';

  @override
  String backupMissingApps(String packages) {
    return 'Algunas apps de la copia no están instaladas: $packages. Se conservaron sus horarios.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'El filtro se importó desactivado porque falta el acceso a las notificaciones.';

  @override
  String get importedWithoutBatteryExemption =>
      'El filtro se importó desactivado porque falta permitir la actividad en segundo plano.';

  @override
  String get backupApplied => 'Los ajustes se validaron y se aplicaron.';

  @override
  String get ok => 'Aceptar';

  @override
  String get whatAccessMeans => 'Qué significa este acceso';

  @override
  String get notificationAccessExplanation =>
      'Este acceso permite que KillNotify decida si debe aplazar una notificación. La app no lee ni guarda títulos, textos, contactos o acciones, ni los envía a ningún sitio.';

  @override
  String get installedAppsVisibility => 'Visibilidad de las apps instaladas';

  @override
  String get installedAppsExplanation =>
      'Para que puedas elegir cualquier app instalada, Android muestra a KillNotify la lista de apps del dispositivo. Se usa localmente y no se envía a nadie. Esto da a la app acceso a más información sobre las apps instaladas; por eso se distribuye manualmente fuera de Google Play.';

  @override
  String get githubUpdatesPrivacy =>
      'Con las actualizaciones automáticas activadas, KillNotify consulta las releases públicas de GitHub como máximo una vez al día. GitHub recibe metadatos normales de conexión, como la IP; no se envían horarios, apps elegidas ni notificaciones. Android sigue pidiendo confirmación para instalar.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Las llamadas y alarmas solo se permiten automáticamente si la app emisora las identifica así. Los códigos de verificación no tienen una categoría universal; KillNotify no lee el contenido de los mensajes para detectarlos.';

  @override
  String get customColorTitle => 'Color personalizado';

  @override
  String get hexColor => 'Color HEX';

  @override
  String red(int value) {
    return 'Rojo: $value';
  }

  @override
  String green(int value) {
    return 'Verde: $value';
  }

  @override
  String blue(int value) {
    return 'Azul: $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Introduce 6 dígitos hexadecimales.';

  @override
  String get apply => 'Aplicar';

  @override
  String get backgroundActivityTitle => 'Permitir actividad en segundo plano';

  @override
  String get batteryExemptionGranted =>
      'El permiso de batería de Android está activo.';

  @override
  String get batteryExemptionNeeded =>
      'Necesario para activar el filtro y supervisar notificaciones con la pantalla apagada.';

  @override
  String get adjustBattery => 'Ajustar batería';

  @override
  String get batteryHelpSamsung =>
      'En Samsung, añade KillNotify a Ajustes > Batería y cuidado del dispositivo > Batería > Límites de uso en segundo plano > Apps nunca inactivas. Los nombres pueden variar.';

  @override
  String get batteryHelpXiaomi =>
      'En Xiaomi, activa el inicio automático en segundo plano en Ajustes > Apps > Permisos. Si existe, elige Sin restricciones para la batería de KillNotify.';

  @override
  String get batteryHelpHuawei =>
      'En Huawei, busca Inicio de apps, selecciona KillNotify y permite Inicio automático, Inicio secundario y Ejecutar en segundo plano.';

  @override
  String get batteryHelpRealme =>
      'En realme, busca Gestión de batería de apps y permite la actividad en segundo plano y el inicio automático para KillNotify si están disponibles.';

  @override
  String get batteryHelpOppo =>
      'En OPPO/ColorOS, algunos modos de ahorro limitan las apps en segundo plano. Revisa la batería de KillNotify y permite la actividad en segundo plano si está disponible.';

  @override
  String get batteryHelpOneplus =>
      'En OnePlus, revisa Ajustes > Batería > Más ajustes > Gestión de batería de apps y comprueba que KillNotify no esté restringido en segundo plano.';

  @override
  String get batteryHelpVivo =>
      'En vivo, busca Ajustes > Apps > Acceso especial de apps > Inicio automático y permite KillNotify si está disponible.';

  @override
  String get batteryHelpMotorola =>
      'En Motorola, si existe Gestionar apps en segundo plano, elige Permitir siempre para KillNotify.';

  @override
  String get batteryHelpOther =>
      'Algunos teléfonos tienen controles propios para apps en segundo plano. Si continúan las interrupciones, revisa los ajustes de batería de KillNotify.';

  @override
  String get noNeedKeepScreenOpen =>
      'No hace falta dejar KillNotify abierto en pantalla. Evita Forzar detención; interrumpe la supervisión hasta que Android reconecte el servicio.';

  @override
  String get checkingUpdates => 'Buscando actualizaciones';

  @override
  String get consultingGithub => 'Consultando GitHub…';

  @override
  String get updateOpenFailed => 'No se pudo abrir la descarga.';

  @override
  String get noReleasePublished =>
      'Todavía no hay una versión publicada en GitHub.';

  @override
  String get updateCheckFailed =>
      'No se pudieron buscar actualizaciones ahora.';

  @override
  String get alreadyLatestVersion => 'Ya tienes la versión más reciente.';

  @override
  String get updateAvailable => 'Actualización disponible';

  @override
  String versionAvailable(String version) {
    return 'La versión $version está disponible.';
  }

  @override
  String get releaseNotes => 'Notas de la versión';

  @override
  String get updateInstallConfirmation =>
      'La descarga se abrirá en el navegador. Android te pedirá confirmar la instalación.';

  @override
  String get neverRemind => 'No volver a avisarme';

  @override
  String get remindTomorrow => 'Recordármelo mañana';

  @override
  String get downloadUpdate => 'Descargar actualización';

  @override
  String get operationNotCompleted => 'No se pudo completar la operación.';

  @override
  String get errorAccessRequired =>
      'Concede acceso a las notificaciones en los ajustes de Android antes de activar el filtro.';

  @override
  String get errorBatteryRequired =>
      'Permite la actividad en segundo plano en los ajustes de batería de Android antes de activar el filtro.';

  @override
  String get errorInvalidBackup =>
      'El archivo de copia de seguridad no es válido o no se pudo leer.';

  @override
  String get errorConfigurationUnreadable =>
      'No se pudieron leer los ajustes guardados.';

  @override
  String get errorBusy => 'Ya hay otra operación en curso.';

  @override
  String get errorInvalidInput =>
      'Algunos datos no son válidos. Revísalos e inténtalo de nuevo.';

  @override
  String get errorUnsupportedVersion =>
      'Esta versión de la app no puede leer la respuesta. Actualiza la app e inténtalo de nuevo.';
}
