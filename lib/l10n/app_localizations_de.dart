// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get tabHome => 'Startseite';

  @override
  String get tabApps => 'Apps';

  @override
  String get tabExceptions => 'Ausnahmen';

  @override
  String get tabSettings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get systemLanguage => 'Systemsprache';

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
  String get refreshStatus => 'Status aktualisieren';

  @override
  String get refreshAppList => 'App-Liste aktualisieren';

  @override
  String get notificationsReleasedToday =>
      'Heute zugelassene Benachrichtigungen';

  @override
  String get notificationCountPrivacy =>
      'Zählung auf diesem Gerät; Nachrichteninhalte und Aktionen werden nicht gespeichert.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Apps mit Zeitplänen',
      one: '$count App mit Zeitplänen',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule =>
      'Für jede App kann ein eigener Zeitplan festgelegt werden.';

  @override
  String get filterActive => 'Filter aktiv';

  @override
  String get filterActiveExplanation =>
      'KillNotify wendet die festgelegten Zeitpläne an.';

  @override
  String get filterInactive => 'Filter inaktiv';

  @override
  String get listenerNotFollowing =>
      'KillNotify überwacht noch keine Benachrichtigungen. Einige können ohne Verzögerung eintreffen.';

  @override
  String get batterySetupRequired => 'Akku-Einstellungen anpassen';

  @override
  String get batterySetupExplanation =>
      'Erlaube Hintergrundaktivität, um den Filter einzuschalten.';

  @override
  String get schedulesUnavailable => 'Zeitpläne nicht verfügbar';

  @override
  String get schedulesUnavailableExplanation =>
      'Der Filter ist ausgeschaltet, bis die gespeicherten Einstellungen gelesen werden können.';

  @override
  String get filterDisabled => 'Filter ausgeschaltet';

  @override
  String get notificationsArriveNormally =>
      'Benachrichtigungen treffen wie gewohnt und ohne Verzögerung ein.';

  @override
  String get accessNeeded => 'Berechtigung erforderlich';

  @override
  String get notificationAccessNeeded =>
      'Erlaube KillNotify in den Android-Einstellungen den Zugriff auf Benachrichtigungen, damit Zeitpläne angewendet werden können.';

  @override
  String get openAndroidSettings => 'Android-Einstellungen öffnen';

  @override
  String get activateFilter => 'Filter einschalten';

  @override
  String get filterNeedsBoth =>
      'Erlaube den Benachrichtigungszugriff und passe die Akku-Einstellungen an, bevor du den Filter einschaltest.';

  @override
  String get filterNeedsAccess =>
      'Erlaube den Benachrichtigungszugriff, bevor du den Filter einschaltest.';

  @override
  String get filterNeedsBattery =>
      'Passe die Akku-Einstellungen an, damit der Filter im Hintergrund laufen kann.';

  @override
  String get filterAppliesSchedules =>
      'Wendet die für jede App festgelegten Zeitpläne an.';

  @override
  String get restoreBackupForSchedules =>
      'Importiere in den Einstellungen ein Backup, um deine Zeitpläne wiederherzustellen.';

  @override
  String get checkingFilter => 'Filter wird geprüft …';

  @override
  String get cannotCheckFilter =>
      'Der Filter konnte nicht geprüft werden. Tippe auf Aktualisieren und versuche es erneut.';

  @override
  String get nextAllowedStart => 'Nächster erlaubter Zeitpunkt';

  @override
  String get nextConfiguredWindow => 'Nächstes Zeitfenster';

  @override
  String get noAppWaiting => 'Momentan wartet keine App auf ihren Zeitplan.';

  @override
  String get noSchedulesYet => 'Noch keine Zeitpläne';

  @override
  String get filterInactiveInformative =>
      'Der Filter ist ausgeschaltet; diese Uhrzeit dient nur zur Information.';

  @override
  String get timezoneInfo =>
      'Zeitpläne richten sich nach der Zeitzone dieses Geräts.';

  @override
  String get chooseAppsAndPeriods =>
      'Wähle Apps aus und lege fest, wann ihre Benachrichtigungen eintreffen dürfen.';

  @override
  String get androidControlsSnooze =>
      'Android bestimmt, wann eine zurückgestellte Benachrichtigung wieder erscheint. Akku-Sparmodus, Geräteeinstellungen oder Änderungen der Uhrzeit können den Zeitpunkt beeinflussen.';

  @override
  String get searchApp => 'Apps suchen';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get appsListDisclosure =>
      'Diese Liste enthält System-Apps und Apps ohne Startbildschirm-Symbol. Android zeigt möglicherweise keine Benachrichtigungen aus Arbeitsprofilen oder bestimmten Diensten an.';

  @override
  String get noSearchMatch => 'Keine Apps entsprechen deiner Suche.';

  @override
  String get systemApp => 'System-App';

  @override
  String get noLauncherIcon => 'Kein Startbildschirm-Symbol';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zeiträume festgelegt',
      one: '$count Zeitraum festgelegt',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Apps mit Zeitplänen',
      one: '$count App mit Zeitplänen',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'Nicht installierte Apps';

  @override
  String get schedulesPreserved =>
      'Die Zeitpläne bleiben gespeichert und gelten wieder, wenn die App installiert wird.';

  @override
  String get appNotFound => 'App nicht gefunden';

  @override
  String get removeRule => 'Regel entfernen';

  @override
  String packageIdentifier(String packageName) {
    return 'Paket: $packageName';
  }

  @override
  String get applySchedulesToApp => 'Zeitpläne auf diese App anwenden';

  @override
  String get noSchedulesAllowNormally =>
      'Ohne Zeitplan treffen Benachrichtigungen wie gewohnt ein.';

  @override
  String get weeklyPeriods => 'Wöchentliche Zeiträume';

  @override
  String get addPeriod => 'Zeitraum hinzufügen';

  @override
  String get noPeriodsForApp =>
      'Noch keine Zeitpläne. Benachrichtigungen dieser App treffen wie gewohnt ein.';

  @override
  String get period24HoursHint =>
      'Sind Start- und Endzeit gleich, dauert der Zeitraum 24 Stunden.';

  @override
  String get removePeriod => 'Zeitraum entfernen';

  @override
  String get exceptions => 'Ausnahmen';

  @override
  String get allowCallNotifications => 'Anrufbenachrichtigungen erlauben';

  @override
  String get callsCategoryOnly =>
      'Nur wenn die sendende App die Benachrichtigung als Anruf kennzeichnet.';

  @override
  String get allowAlarmNotifications => 'Weckerbenachrichtigungen erlauben';

  @override
  String get alarmsCategoryOnly =>
      'Nur wenn die sendende App die Benachrichtigung als Wecker kennzeichnet.';

  @override
  String get saveSchedules => 'Zeitpläne speichern';

  @override
  String get schedulesSaved => 'Zeitpläne gespeichert.';

  @override
  String get newPeriod => 'Neuer Zeitraum';

  @override
  String get editPeriod => 'Zeitraum bearbeiten';

  @override
  String get allowedDays =>
      'Tage, an denen Benachrichtigungen eintreffen dürfen';

  @override
  String get selectAtLeastOneDay => 'Wähle mindestens einen Tag aus.';

  @override
  String get startTime => 'Beginn';

  @override
  String get endTime => 'Ende';

  @override
  String get periodMayCrossMidnight =>
      'Ein Zeitraum kann am nächsten Tag enden. Sind Start- und Endzeit gleich, dauert er 24 Stunden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get save => 'Speichern';

  @override
  String get effectiveSchedule => 'Wirksamer Zeitplan';

  @override
  String get overlappingPeriodsGrouped =>
      'Überlappende oder direkt aufeinanderfolgende Zeiträume werden zusammengefasst. Deine ursprünglichen Zeitpläne bleiben gespeichert.';

  @override
  String get saveToPreviewPeriods =>
      'Speichere, um die Zusammenfassung der Zeiträume anzuzeigen.';

  @override
  String get noSchedulesNotificationsPass =>
      'Ohne Zeitpläne treffen Benachrichtigungen wie gewohnt ein.';

  @override
  String get temporaryException => 'Vorübergehende Ausnahme';

  @override
  String allowUntil(String time) {
    return 'Erlauben bis $time';
  }

  @override
  String get noActiveExceptionForApp =>
      'Für diese App ist keine Ausnahme aktiv.';

  @override
  String get oneHour => '1 Stunde';

  @override
  String get fourHours => '4 Stunden';

  @override
  String get eightHours => '8 Stunden';

  @override
  String get twentyFourHours => '24 Stunden';

  @override
  String get remove => 'Entfernen';

  @override
  String get temporaryExceptions => 'Vorübergehende Ausnahmen';

  @override
  String get temporaryExceptionsExplanation =>
      'Erlaube Benachrichtigungen vorübergehend für eine oder mehrere Apps. Die Ausnahme endet zur gewählten Uhrzeit nach der Geräteuhr.';

  @override
  String get duration => 'Dauer';

  @override
  String get chooseTime => 'Uhrzeit wählen';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ausgewählt',
      one: '$count ausgewählt',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Ergebnisse auswählen';

  @override
  String get clear => 'Leeren';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Benachrichtigungen für $count Apps vorübergehend erlauben',
      one: 'Benachrichtigungen für $count App vorübergehend erlauben',
    );
    return '$_temp0';
  }

  @override
  String get activeTemporaryExceptions => 'Aktive vorübergehende Ausnahmen';

  @override
  String get noTemporaryExceptions => 'Keine vorübergehenden Ausnahmen aktiv.';

  @override
  String untilTime(String time) {
    return 'Bis $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Bis $time · Paket: $packageName';
  }

  @override
  String get endException => 'Ausnahme beenden';

  @override
  String get chooseFutureTime => 'Wähle eine zukünftige Uhrzeit.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vorübergehende Ausnahme für $count Apps aktiviert.',
      one: 'Vorübergehende Ausnahme für $count App aktiviert.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Benachrichtigungszugriff';

  @override
  String get accessGrantedInAndroid => 'In den Android-Einstellungen erlaubt.';

  @override
  String get accessRequiredToFilter =>
      'Erforderlich, um Benachrichtigungen anderer Apps zu filtern.';

  @override
  String get automaticUpdates => 'Automatisch nach Updates suchen';

  @override
  String get automaticUpdatesHint =>
      'Prüft höchstens einmal täglich GitHub und informiert dich über neue Versionen.';

  @override
  String get checkForUpdateNow => 'Jetzt nach Updates suchen';

  @override
  String get appearance => 'Darstellung';

  @override
  String get theme => 'Design';

  @override
  String get followSystem => 'Systemeinstellung verwenden';

  @override
  String get lightTheme => 'Hell';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Akzentfarbe';

  @override
  String get customColor => 'Benutzerdefiniert';

  @override
  String selectedColor(String color) {
    return 'Ausgewählt: $color';
  }

  @override
  String get localBackup => 'Lokales Backup';

  @override
  String get backupDescription =>
      'Die Einstellungsdatei enthält Regeln, Ausnahmen und Einstellungen. Sie enthält keine Benachrichtigungsinhalte, Nachrichten oder Aktionen.';

  @override
  String get exportSettings => 'Einstellungen exportieren';

  @override
  String get importSettings => 'Einstellungen importieren';

  @override
  String get noAccountPrivacy =>
      'KillNotify hat kein Konto und sendet keine persönlichen Daten. Die App wird manuell verteilt und ist nicht bei Google Play erhältlich.';

  @override
  String get importBackupTitle => 'Backup importieren?';

  @override
  String get importBackupWarning =>
      'Beim Import werden deine aktuellen Einstellungen ersetzt. Die Datei wird vor der Übernahme geprüft.';

  @override
  String get chooseBackupFile => 'Datei auswählen';

  @override
  String get backupImported => 'Backup importiert';

  @override
  String backupMissingApps(String packages) {
    return 'Einige Apps aus dem Backup sind nicht installiert: $packages. Ihre Zeitpläne bleiben gespeichert.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'Der Filter wurde ausgeschaltet importiert, da der Benachrichtigungszugriff fehlt.';

  @override
  String get importedWithoutBatteryExemption =>
      'Der Filter wurde ausgeschaltet importiert, da der Hintergrundzugriff des Akkus fehlt.';

  @override
  String get backupApplied =>
      'Die Einstellungen wurden geprüft und übernommen.';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'Was dieser Zugriff bedeutet';

  @override
  String get notificationAccessExplanation =>
      'Mit diesem Zugriff kann KillNotify entscheiden, ob eine Benachrichtigung zurückgestellt wird. Die App liest oder speichert keine Titel, Texte, Kontakte oder Aktionen und sendet sie nirgendwohin.';

  @override
  String get installedAppsVisibility => 'Sichtbarkeit installierter Apps';

  @override
  String get installedAppsExplanation =>
      'Damit du beliebige installierte Apps auswählen kannst, zeigt Android KillNotify die App-Liste auf diesem Gerät. Sie wird lokal verwendet und nicht übertragen. Dadurch erhält die App mehr Informationen über installierte Apps; deshalb wird sie manuell über GitHub und außerhalb von Google Play verteilt.';

  @override
  String get githubUpdatesPrivacy =>
      'Wenn automatische Updates aktiviert sind, fragt KillNotify höchstens einmal täglich die öffentliche GitHub-Releases-API ab. GitHub erhält übliche Verbindungsdaten wie deine IP-Adresse; Zeitpläne, ausgewählte Apps und Benachrichtigungen werden nicht gesendet. Android fragt weiterhin nach deiner Bestätigung zur Installation.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Anrufe und Wecker können nur automatisch erlaubt werden, wenn die sendende App sie entsprechend kennzeichnet. Verifizierungscodes haben keine allgemeingültige Kategorie; KillNotify liest keine Nachrichteninhalte, um sie zu erkennen.';

  @override
  String get customColorTitle => 'Benutzerdefinierte Farbe';

  @override
  String get hexColor => 'HEX-Farbe';

  @override
  String red(int value) {
    return 'Rot: $value';
  }

  @override
  String green(int value) {
    return 'Grün: $value';
  }

  @override
  String blue(int value) {
    return 'Blau: $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Gib sechs hexadezimale Ziffern ein.';

  @override
  String get apply => 'Anwenden';

  @override
  String get backgroundActivityTitle => 'Hintergrundaktivität erlauben';

  @override
  String get batteryExemptionGranted =>
      'Akku-Hintergrundzugriff von Android ist aktiviert.';

  @override
  String get batteryExemptionNeeded =>
      'Erforderlich, um den Filter einzuschalten und Benachrichtigungen bei ausgeschaltetem Bildschirm zu überwachen.';

  @override
  String get adjustBattery => 'Akku-Einstellungen anpassen';

  @override
  String get batteryHelpSamsung =>
      'Samsung: Füge KillNotify unter Einstellungen > Akku und Gerätewartung > Akku > Grenzen der Hintergrundnutzung > Nie in Standby versetzen hinzu. Menüs können je nach Version anders heißen.';

  @override
  String get batteryHelpXiaomi =>
      'Xiaomi: Aktiviere den automatischen Start im Hintergrund unter Einstellungen > Apps > Berechtigungen. Falls verfügbar, stelle die Akku-Nutzung von KillNotify auf Keine Einschränkungen. Die Menüs unterscheiden sich je nach Modell.';

  @override
  String get batteryHelpHuawei =>
      'Huawei: Suche nach App-Start, wähle KillNotify und erlaube Automatischen Start, Sekundären Start und Ausführung im Hintergrund. Die Menüs können je nach Version anders heißen.';

  @override
  String get batteryHelpRealme =>
      'realme: Suche in den Einstellungen nach Akkuverwaltung für Apps und erlaube KillNotify Hintergrundaktivität und automatischen Start, falls verfügbar.';

  @override
  String get batteryHelpOppo =>
      'OPPO/ColorOS: Einige Energiesparmodi beschränken Hintergrund-Apps. Suche in den Akku- oder App-Einstellungen nach der Akkuverwaltung von KillNotify und erlaube die Hintergrundaktivität, falls verfügbar.';

  @override
  String get batteryHelpOneplus =>
      'OnePlus: Prüfe Einstellungen > Akku > Weitere Einstellungen > Akkuverwaltung für Apps. Die Hintergrundaktivität von KillNotify sollte nicht eingeschränkt sein; Bezeichnungen können abweichen.';

  @override
  String get batteryHelpVivo =>
      'vivo: Suche nach Einstellungen > Apps > Spezieller App-Zugriff > Autostart und erlaube KillNotify, falls die Option verfügbar ist.';

  @override
  String get batteryHelpMotorola =>
      'Motorola: Falls Hintergrund-Apps verwalten verfügbar ist, wähle für KillNotify Immer erlauben. Menüs und Verfügbarkeit unterscheiden sich je nach Modell.';

  @override
  String get batteryHelpOther =>
      'Manche Smartphones haben eigene Einstellungen für Hintergrund-Apps. Wenn Unterbrechungen auftreten, suche in den Geräteeinstellungen nach Akku-Optionen für KillNotify.';

  @override
  String get noNeedKeepScreenOpen =>
      'KillNotify muss nicht auf dem Bildschirm geöffnet bleiben. Verwende nicht Stopp erzwingen; dadurch wird die Überwachung unterbrochen, bis Android den Dienst wieder verbindet.';

  @override
  String get checkingUpdates => 'Updates werden gesucht';

  @override
  String get consultingGithub => 'GitHub wird geprüft …';

  @override
  String get updateOpenFailed => 'Der Download konnte nicht geöffnet werden.';

  @override
  String get noReleasePublished =>
      'Auf GitHub wurde noch keine Version veröffentlicht.';

  @override
  String get updateCheckFailed => 'Updates können gerade nicht gesucht werden.';

  @override
  String get alreadyLatestVersion =>
      'Du verwendest bereits die neueste Version.';

  @override
  String get updateAvailable => 'Update verfügbar';

  @override
  String versionAvailable(String version) {
    return 'Version $version ist verfügbar.';
  }

  @override
  String get releaseNotes => 'Versionshinweise';

  @override
  String get updateInstallConfirmation =>
      'Der Download wird im Browser geöffnet. Android fragt vor der Installation nach deiner Bestätigung.';

  @override
  String get neverRemind => 'Nicht mehr erinnern';

  @override
  String get remindTomorrow => 'Morgen erinnern';

  @override
  String get downloadUpdate => 'Update herunterladen';

  @override
  String get operationNotCompleted =>
      'Der Vorgang konnte nicht abgeschlossen werden.';

  @override
  String get errorAccessRequired =>
      'Erlaube den Benachrichtigungszugriff in den Android-Einstellungen, bevor du den Filter einschaltest.';

  @override
  String get errorBatteryRequired =>
      'Erlaube Hintergrundaktivität in den Android-Akku-Einstellungen, bevor du den Filter einschaltest.';

  @override
  String get errorInvalidBackup =>
      'Die Backup-Datei ist ungültig oder konnte nicht gelesen werden.';

  @override
  String get errorConfigurationUnreadable =>
      'Die gespeicherten Einstellungen konnten nicht gelesen werden.';

  @override
  String get errorBusy => 'Ein anderer Vorgang läuft bereits.';

  @override
  String get errorInvalidInput =>
      'Einige Angaben sind ungültig. Prüfe sie und versuche es erneut.';

  @override
  String get errorUnsupportedVersion =>
      'Diese App-Version kann die Antwort nicht lesen. Aktualisiere die App und versuche es erneut.';
}
