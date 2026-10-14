// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get tabHome => 'Home';

  @override
  String get tabApps => 'App';

  @override
  String get tabExceptions => 'Eccezioni';

  @override
  String get tabSettings => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get systemLanguage => 'Lingua del sistema';

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
  String get refreshStatus => 'Aggiorna stato';

  @override
  String get refreshAppList => 'Aggiorna elenco app';

  @override
  String get notificationsReleasedToday => 'Notifiche mostrate oggi';

  @override
  String get notificationCountPrivacy =>
      'Conteggio locale; contenuti e azioni dei messaggi non vengono salvati.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count app con orari',
      one: '$count app con orari',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule =>
      'Ogni app può avere orari personalizzati.';

  @override
  String get filterActive => 'Filtro attivo';

  @override
  String get filterActiveExplanation =>
      'KillNotify applica gli orari configurati.';

  @override
  String get filterInactive => 'Filtro inattivo';

  @override
  String get listenerNotFollowing =>
      'KillNotify non sta ancora monitorando le notifiche. Alcune potrebbero arrivare senza ritardo.';

  @override
  String get batterySetupRequired => 'Modifica le impostazioni della batteria';

  @override
  String get batterySetupExplanation =>
      'Consenti l\'attività in background per attivare il filtro.';

  @override
  String get schedulesUnavailable => 'Orari non disponibili';

  @override
  String get schedulesUnavailableExplanation =>
      'Il filtro è disattivato finché non sarà possibile leggere le impostazioni salvate.';

  @override
  String get filterDisabled => 'Filtro disattivato';

  @override
  String get notificationsArriveNormally =>
      'Le notifiche arrivano normalmente, senza ritardi.';

  @override
  String get accessNeeded => 'Autorizzazione necessaria';

  @override
  String get notificationAccessNeeded =>
      'Per applicare gli orari, consenti a KillNotify di accedere alle notifiche nelle impostazioni Android.';

  @override
  String get openAndroidSettings => 'Apri impostazioni Android';

  @override
  String get activateFilter => 'Attiva filtro';

  @override
  String get filterNeedsBoth =>
      'Consenti l\'accesso alle notifiche e modifica le impostazioni della batteria prima di attivare il filtro.';

  @override
  String get filterNeedsAccess =>
      'Consenti l\'accesso alle notifiche prima di attivare il filtro.';

  @override
  String get filterNeedsBattery =>
      'Modifica le impostazioni della batteria per consentire al filtro di funzionare in background.';

  @override
  String get filterAppliesSchedules =>
      'Applica gli orari impostati per ogni app.';

  @override
  String get restoreBackupForSchedules =>
      'Importa un backup in Impostazioni per ripristinare gli orari.';

  @override
  String get checkingFilter => 'Verifica del filtro…';

  @override
  String get cannotCheckFilter =>
      'Impossibile verificare il filtro. Tocca Aggiorna e riprova.';

  @override
  String get nextAllowedStart => 'Prossimo orario consentito';

  @override
  String get nextConfiguredWindow => 'Prossima fascia programmata';

  @override
  String get noAppWaiting => 'Nessuna app è in attesa del proprio orario';

  @override
  String get noSchedulesYet => 'Nessun orario impostato';

  @override
  String get filterInactiveInformative =>
      'Il filtro è disattivato; questo orario è solo informativo.';

  @override
  String get timezoneInfo =>
      'Gli orari seguono il fuso orario impostato su questo dispositivo.';

  @override
  String get chooseAppsAndPeriods =>
      'Scegli le app e imposta quando possono arrivare le notifiche.';

  @override
  String get androidControlsSnooze =>
      'Android decide quando mostrare di nuovo una notifica posticipata. Il risparmio energetico, le impostazioni del dispositivo o i cambiamenti dell\'orologio possono influire sui tempi.';

  @override
  String get searchApp => 'Cerca app';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get appsListDisclosure =>
      'L\'elenco include app di sistema e app senza icona nella schermata Home. Android potrebbe non mostrare le notifiche dei profili di lavoro o di alcuni servizi.';

  @override
  String get noSearchMatch => 'Nessuna app corrisponde alla ricerca.';

  @override
  String get systemApp => 'App di sistema';

  @override
  String get noLauncherIcon => 'Nessuna icona nella schermata Home';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fasce impostate',
      one: '$count fascia impostata',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count app con orari',
      one: '$count app con orari',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'App non installate';

  @override
  String get schedulesPreserved =>
      'Gli orari restano salvati e verranno applicati di nuovo se l\'app viene installata.';

  @override
  String get appNotFound => 'App non trovata';

  @override
  String get removeRule => 'Rimuovi regola';

  @override
  String packageIdentifier(String packageName) {
    return 'Pacchetto: $packageName';
  }

  @override
  String get applySchedulesToApp => 'Applica gli orari a questa app';

  @override
  String get noSchedulesAllowNormally =>
      'Senza orari, le notifiche arrivano normalmente.';

  @override
  String get weeklyPeriods => 'Fasce settimanali';

  @override
  String get addPeriod => 'Aggiungi fascia';

  @override
  String get noPeriodsForApp =>
      'Nessun orario impostato. Le notifiche di questa app arrivano normalmente.';

  @override
  String get period24HoursHint =>
      'Se l\'ora di inizio e di fine coincidono, la fascia dura 24 ore.';

  @override
  String get removePeriod => 'Rimuovi fascia';

  @override
  String get exceptions => 'Eccezioni';

  @override
  String get allowCallNotifications => 'Consenti notifiche di chiamata';

  @override
  String get callsCategoryOnly =>
      'Solo se l\'app mittente identifica la notifica come chiamata.';

  @override
  String get allowAlarmNotifications => 'Consenti notifiche di sveglia';

  @override
  String get alarmsCategoryOnly =>
      'Solo se l\'app mittente identifica la notifica come sveglia.';

  @override
  String get saveSchedules => 'Salva orari';

  @override
  String get schedulesSaved => 'Orari salvati.';

  @override
  String get newPeriod => 'Nuova fascia';

  @override
  String get editPeriod => 'Modifica fascia';

  @override
  String get allowedDays => 'Giorni in cui le notifiche possono arrivare';

  @override
  String get selectAtLeastOneDay => 'Seleziona almeno un giorno.';

  @override
  String get startTime => 'Inizio';

  @override
  String get endTime => 'Fine';

  @override
  String get periodMayCrossMidnight =>
      'Una fascia può terminare il giorno successivo. Se inizio e fine coincidono, dura 24 ore.';

  @override
  String get cancel => 'Annulla';

  @override
  String get add => 'Aggiungi';

  @override
  String get save => 'Salva';

  @override
  String get effectiveSchedule => 'Orari effettivi';

  @override
  String get overlappingPeriodsGrouped =>
      'Le fasce sovrapposte o consecutive vengono unite. Gli orari originali restano salvati.';

  @override
  String get saveToPreviewPeriods =>
      'Salva per vedere come verranno unite le fasce.';

  @override
  String get noSchedulesNotificationsPass =>
      'Senza orari, le notifiche arrivano normalmente.';

  @override
  String get temporaryException => 'Eccezione temporanea';

  @override
  String allowUntil(String time) {
    return 'Consenti fino alle $time';
  }

  @override
  String get noActiveExceptionForApp =>
      'Nessuna eccezione attiva per questa app.';

  @override
  String get oneHour => '1 ora';

  @override
  String get fourHours => '4 ore';

  @override
  String get eightHours => '8 ore';

  @override
  String get twentyFourHours => '24 ore';

  @override
  String get remove => 'Rimuovi';

  @override
  String get temporaryExceptions => 'Eccezioni temporanee';

  @override
  String get temporaryExceptionsExplanation =>
      'Consenti temporaneamente le notifiche per una o più app. L\'eccezione termina all\'ora scelta, in base all\'orologio del dispositivo.';

  @override
  String get duration => 'Durata';

  @override
  String get chooseTime => 'Scegli orario';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selezionate',
      one: '$count selezionata',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Seleziona risultati';

  @override
  String get clear => 'Cancella';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count app',
      one: 'l\'app $count',
    );
    return 'Consenti temporaneamente $_temp0';
  }

  @override
  String get activeTemporaryExceptions => 'Eccezioni temporanee attive';

  @override
  String get noTemporaryExceptions => 'Nessuna eccezione temporanea attiva.';

  @override
  String untilTime(String time) {
    return 'Fino alle $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Fino alle $time · Pacchetto: $packageName';
  }

  @override
  String get endException => 'Termina eccezione';

  @override
  String get chooseFutureTime => 'Scegli un orario futuro.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Eccezione temporanea applicata a $count app.',
      one: 'Eccezione temporanea applicata a $count app.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Accesso alle notifiche';

  @override
  String get accessGrantedInAndroid => 'Consentito nelle impostazioni Android.';

  @override
  String get accessRequiredToFilter =>
      'Necessario per filtrare le notifiche delle altre app.';

  @override
  String get automaticUpdates => 'Cerca aggiornamenti automaticamente';

  @override
  String get automaticUpdatesHint =>
      'Controlla GitHub al massimo una volta al giorno e ti avvisa quando è disponibile una nuova versione.';

  @override
  String get checkForUpdateNow => 'Cerca aggiornamenti ora';

  @override
  String get appearance => 'Aspetto';

  @override
  String get theme => 'Tema';

  @override
  String get followSystem => 'Segui il sistema';

  @override
  String get lightTheme => 'Chiaro';

  @override
  String get darkTheme => 'Scuro';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Colore principale';

  @override
  String get customColor => 'Personalizzato';

  @override
  String selectedColor(String color) {
    return 'Selezionato: $color';
  }

  @override
  String get localBackup => 'Backup locale';

  @override
  String get backupDescription =>
      'Il file delle impostazioni contiene regole, eccezioni e preferenze. Non contiene notifiche, messaggi o azioni.';

  @override
  String get exportSettings => 'Esporta impostazioni';

  @override
  String get importSettings => 'Importa impostazioni';

  @override
  String get noAccountPrivacy =>
      'KillNotify non ha un account e non invia dati personali. L\'app è distribuita manualmente e non è disponibile su Google Play.';

  @override
  String get importBackupTitle => 'Importare il backup?';

  @override
  String get importBackupWarning =>
      'L\'importazione sostituisce le impostazioni attuali. Il file viene verificato prima di applicare le modifiche.';

  @override
  String get chooseBackupFile => 'Scegli file';

  @override
  String get backupImported => 'Backup importato';

  @override
  String backupMissingApps(String packages) {
    return 'Alcune app del backup non sono installate: $packages. I loro orari sono stati conservati.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'Il filtro è stato importato disattivato perché manca l\'accesso alle notifiche.';

  @override
  String get importedWithoutBatteryExemption =>
      'Il filtro è stato importato disattivato perché manca l\'autorizzazione della batteria per l\'attività in background.';

  @override
  String get backupApplied =>
      'Le impostazioni sono state verificate e applicate.';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'Cosa comporta questo accesso';

  @override
  String get notificationAccessExplanation =>
      'Questo accesso consente a KillNotify di decidere se posticipare una notifica. L\'app non legge né salva titoli, testi, contatti o azioni e non li invia altrove.';

  @override
  String get installedAppsVisibility => 'Visibilità delle app installate';

  @override
  String get installedAppsExplanation =>
      'Per consentirti di scegliere qualsiasi app installata, Android mostra a KillNotify l\'elenco delle app presenti sul dispositivo. Viene usato localmente e non viene inviato. Questo dà all\'app accesso a più informazioni sulle app installate; per questo la distribuzione è manuale tramite GitHub, fuori da Google Play.';

  @override
  String get githubUpdatesPrivacy =>
      'Con gli aggiornamenti automatici attivi, KillNotify consulta l\'API pubblica delle release di GitHub al massimo una volta al giorno. GitHub riceve i normali metadati di connessione, come l\'indirizzo IP; orari, app selezionate e notifiche non vengono inviati. Android continuerà a chiedere conferma per l\'installazione.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Le chiamate e le sveglie possono essere consentite automaticamente solo quando l\'app mittente le identifica come tali. I codici di verifica non hanno una categoria universale; KillNotify non legge i messaggi per rilevarli.';

  @override
  String get customColorTitle => 'Colore personalizzato';

  @override
  String get hexColor => 'Colore HEX';

  @override
  String red(int value) {
    return 'Rosso: $value';
  }

  @override
  String green(int value) {
    return 'Verde: $value';
  }

  @override
  String blue(int value) {
    return 'Blu: $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Inserisci 6 cifre esadecimali.';

  @override
  String get apply => 'Applica';

  @override
  String get backgroundActivityTitle => 'Consenti attività in background';

  @override
  String get batteryExemptionGranted =>
      'L\'accesso alla batteria di Android è attivo.';

  @override
  String get batteryExemptionNeeded =>
      'Necessario per attivare il filtro e monitorare le notifiche a schermo spento.';

  @override
  String get adjustBattery => 'Modifica impostazioni batteria';

  @override
  String get batteryHelpSamsung =>
      'Samsung: aggiungi KillNotify in Impostazioni > Assistenza dispositivo e batteria > Batteria > Limiti uso in background > App mai in sospensione. I nomi possono variare in base alla versione.';

  @override
  String get batteryHelpXiaomi =>
      'Xiaomi: attiva Avvio automatico in background in Impostazioni > App > Autorizzazioni. Se disponibile, imposta l\'uso della batteria di KillNotify su Nessuna restrizione. I menu variano in base al modello.';

  @override
  String get batteryHelpHuawei =>
      'Huawei: cerca Avvio app, seleziona KillNotify e consenti Avvio automatico, Avvio secondario ed Esecuzione in background. I nomi possono variare in base alla versione.';

  @override
  String get batteryHelpRealme =>
      'realme: cerca Gestione batteria app nelle impostazioni e consenti l\'attività in background e l\'avvio automatico di KillNotify, se disponibili.';

  @override
  String get batteryHelpOppo =>
      'OPPO/ColorOS: alcune modalità di risparmio energetico limitano le app in background. Cerca le impostazioni batteria o app di KillNotify e consenti l\'attività in background, se disponibile.';

  @override
  String get batteryHelpOneplus =>
      'OnePlus: controlla Impostazioni > Batteria > Altre impostazioni > Gestione batteria app. Verifica che l\'attività in background di KillNotify non sia limitata; le voci possono variare.';

  @override
  String get batteryHelpVivo =>
      'vivo: cerca Impostazioni > App > Accesso speciale app > Avvio automatico e consenti KillNotify, se l\'opzione è disponibile.';

  @override
  String get batteryHelpMotorola =>
      'Motorola: se è disponibile Gestisci app in background, imposta KillNotify su Consenti sempre. Menu e disponibilità variano in base al modello.';

  @override
  String get batteryHelpOther =>
      'Alcuni telefoni hanno controlli propri per le app in background. Se il servizio si interrompe, cerca le impostazioni batteria di KillNotify sul dispositivo.';

  @override
  String get noNeedKeepScreenOpen =>
      'Non è necessario tenere KillNotify aperto sullo schermo. Evita Forza arresto: interrompe il monitoraggio finché Android non riconnette il servizio.';

  @override
  String get checkingUpdates => 'Ricerca aggiornamenti';

  @override
  String get consultingGithub => 'Controllo GitHub…';

  @override
  String get updateOpenFailed => 'Impossibile aprire il download.';

  @override
  String get noReleasePublished =>
      'Non è ancora stata pubblicata una versione su GitHub.';

  @override
  String get updateCheckFailed =>
      'Impossibile controllare gli aggiornamenti al momento.';

  @override
  String get alreadyLatestVersion => 'Stai già usando la versione più recente.';

  @override
  String get updateAvailable => 'Aggiornamento disponibile';

  @override
  String versionAvailable(String version) {
    return 'È disponibile la versione $version.';
  }

  @override
  String get releaseNotes => 'Note di rilascio';

  @override
  String get updateInstallConfirmation =>
      'Il download si aprirà nel browser. Android chiederà conferma prima dell\'installazione.';

  @override
  String get neverRemind => 'Non ricordarmelo più';

  @override
  String get remindTomorrow => 'Ricordamelo domani';

  @override
  String get downloadUpdate => 'Scarica aggiornamento';

  @override
  String get operationNotCompleted => 'Impossibile completare l\'operazione.';

  @override
  String get errorAccessRequired =>
      'Consenti l\'accesso alle notifiche nelle impostazioni Android prima di attivare il filtro.';

  @override
  String get errorBatteryRequired =>
      'Consenti l\'attività in background nelle impostazioni batteria Android prima di attivare il filtro.';

  @override
  String get errorInvalidBackup =>
      'Il file di backup non è valido o non può essere letto.';

  @override
  String get errorConfigurationUnreadable =>
      'Impossibile leggere le impostazioni salvate.';

  @override
  String get errorBusy => 'È già in corso un\'altra operazione.';

  @override
  String get errorInvalidInput =>
      'Alcune informazioni non sono valide. Controllale e riprova.';

  @override
  String get errorUnsupportedVersion =>
      'Questa versione dell\'app non può leggere la risposta. Aggiorna l\'app e riprova.';
}
