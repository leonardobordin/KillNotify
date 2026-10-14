// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get tabHome => 'Accueil';

  @override
  String get tabApps => 'Applications';

  @override
  String get tabExceptions => 'Exceptions';

  @override
  String get tabSettings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get systemLanguage => 'Suivre le système';

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
  String get refreshStatus => 'Actualiser l’état';

  @override
  String get refreshAppList => 'Actualiser la liste';

  @override
  String get notificationsReleasedToday =>
      'Notifications délivrées aujourd’hui';

  @override
  String get notificationCountPrivacy =>
      'Nombre sur cet appareil ; le contenu et les actions ne sont pas enregistrés.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps avec des horaires',
      one: '$count app avec des horaires',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule =>
      'Chaque app peut avoir ses propres horaires.';

  @override
  String get filterActive => 'Filtre actif';

  @override
  String get filterActiveExplanation =>
      'KillNotify applique les horaires configurés.';

  @override
  String get filterInactive => 'Filtre inactif';

  @override
  String get listenerNotFollowing =>
      'KillNotify ne surveille pas encore les notifications. Certaines peuvent arriver sans délai.';

  @override
  String get batterySetupRequired => 'Réglez la batterie pour continuer';

  @override
  String get batterySetupExplanation =>
      'Autorisez l’activité en arrière-plan pour activer le filtre.';

  @override
  String get schedulesUnavailable => 'Horaires indisponibles';

  @override
  String get schedulesUnavailableExplanation =>
      'Le filtre est désactivé jusqu’à ce que les réglages enregistrés puissent être lus.';

  @override
  String get filterDisabled => 'Filtre désactivé';

  @override
  String get notificationsArriveNormally =>
      'Les notifications arrivent normalement, sans délai.';

  @override
  String get accessNeeded => 'Accès nécessaire';

  @override
  String get notificationAccessNeeded =>
      'Pour appliquer les horaires, autorisez KillNotify à accéder aux notifications dans les paramètres Android.';

  @override
  String get openAndroidSettings => 'Ouvrir les paramètres Android';

  @override
  String get activateFilter => 'Activer le filtre';

  @override
  String get filterNeedsBoth =>
      'Autorisez l’accès aux notifications et réglez la batterie avant l’activation.';

  @override
  String get filterNeedsAccess =>
      'Autorisez l’accès aux notifications avant l’activation.';

  @override
  String get filterNeedsBattery =>
      'Réglez la batterie pour que le filtre fonctionne en arrière-plan.';

  @override
  String get filterAppliesSchedules =>
      'Applique les horaires définis pour chaque app.';

  @override
  String get restoreBackupForSchedules =>
      'Importez une sauvegarde dans Paramètres pour restaurer vos horaires.';

  @override
  String get checkingFilter => 'Vérification du filtre…';

  @override
  String get cannotCheckFilter =>
      'Impossible de vérifier le filtre. Touchez Actualiser et réessayez.';

  @override
  String get nextAllowedStart => 'Prochaine heure autorisée';

  @override
  String get nextConfiguredWindow => 'Prochaine plage programmée';

  @override
  String get noAppWaiting => 'Aucune app n’attend son horaire pour le moment';

  @override
  String get noSchedulesYet => 'Aucun horaire pour le moment';

  @override
  String get filterInactiveInformative =>
      'Le filtre est désactivé ; horaire donné à titre indicatif.';

  @override
  String get timezoneInfo =>
      'Les horaires utilisent le fuseau défini sur l’appareil.';

  @override
  String get chooseAppsAndPeriods =>
      'Choisissez des apps et définissez quand leurs notifications peuvent arriver.';

  @override
  String get androidControlsSnooze =>
      'Android contrôle le moment où une notification différée réapparaît. Le délai peut varier selon l’économie de batterie, les réglages de l’appareil ou les changements d’horloge.';

  @override
  String get searchApp => 'Rechercher des apps';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get appsListDisclosure =>
      'La liste inclut les apps système et celles sans icône d’accueil. Android peut ne pas exposer les notifications des profils professionnels ou de certains services.';

  @override
  String get noSearchMatch => 'Aucune app ne correspond à la recherche.';

  @override
  String get systemApp => 'App système';

  @override
  String get noLauncherIcon => 'Pas d’icône sur l’écran d’accueil';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count périodes définies',
      one: '$count période définie',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps avec horaires',
      one: '$count app avec horaires',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'Apps non installées';

  @override
  String get schedulesPreserved =>
      'Les horaires sont conservés et s’appliqueront à nouveau si l’app est installée.';

  @override
  String get appNotFound => 'App introuvable';

  @override
  String get removeRule => 'Supprimer la règle';

  @override
  String packageIdentifier(String packageName) {
    return 'Paquet : $packageName';
  }

  @override
  String get applySchedulesToApp => 'Appliquer les horaires à cette app';

  @override
  String get noSchedulesAllowNormally =>
      'Sans horaire, les notifications arrivent normalement.';

  @override
  String get weeklyPeriods => 'Plages hebdomadaires';

  @override
  String get addPeriod => 'Ajouter une plage';

  @override
  String get noPeriodsForApp =>
      'Aucun horaire. Les notifications de cette app arrivent normalement.';

  @override
  String get period24HoursHint =>
      'Si l’heure de début et de fin est identique, la plage dure 24 heures.';

  @override
  String get removePeriod => 'Supprimer la plage';

  @override
  String get exceptions => 'Exceptions';

  @override
  String get allowCallNotifications => 'Autoriser les notifications d’appel';

  @override
  String get callsCategoryOnly =>
      'Uniquement si l’app émettrice l’identifie comme un appel.';

  @override
  String get allowAlarmNotifications => 'Autoriser les notifications d’alarme';

  @override
  String get alarmsCategoryOnly =>
      'Uniquement si l’app émettrice l’identifie comme une alarme.';

  @override
  String get saveSchedules => 'Enregistrer les horaires';

  @override
  String get schedulesSaved => 'Horaires enregistrés.';

  @override
  String get newPeriod => 'Nouvelle plage';

  @override
  String get editPeriod => 'Modifier la plage';

  @override
  String get allowedDays => 'Jours où les notifications peuvent arriver';

  @override
  String get selectAtLeastOneDay => 'Sélectionnez au moins un jour.';

  @override
  String get startTime => 'Début';

  @override
  String get endTime => 'Fin';

  @override
  String get periodMayCrossMidnight =>
      'La plage peut se terminer le lendemain. Si début et fin sont identiques, elle dure 24 heures.';

  @override
  String get cancel => 'Annuler';

  @override
  String get add => 'Ajouter';

  @override
  String get save => 'Enregistrer';

  @override
  String get effectiveSchedule => 'Horaires appliqués par le filtre';

  @override
  String get overlappingPeriodsGrouped =>
      'Les plages qui se chevauchent ou se touchent sont regroupées. Vos horaires d’origine restent enregistrés.';

  @override
  String get saveToPreviewPeriods =>
      'Enregistrez pour voir comment les plages seront regroupées.';

  @override
  String get noSchedulesNotificationsPass =>
      'Sans horaire, les notifications arrivent normalement.';

  @override
  String get temporaryException => 'Exception temporaire';

  @override
  String allowUntil(String time) {
    return 'Autoriser jusqu’à $time';
  }

  @override
  String get noActiveExceptionForApp =>
      'Aucune exception active pour cette app.';

  @override
  String get oneHour => '1 heure';

  @override
  String get fourHours => '4 heures';

  @override
  String get eightHours => '8 heures';

  @override
  String get twentyFourHours => '24 heures';

  @override
  String get remove => 'Supprimer';

  @override
  String get temporaryExceptions => 'Exceptions temporaires';

  @override
  String get temporaryExceptionsExplanation =>
      'Autorisez temporairement les notifications d’une ou plusieurs apps. L’exception se termine à l’heure choisie selon l’horloge de l’appareil.';

  @override
  String get duration => 'Durée';

  @override
  String get chooseTime => 'Choisir l’heure';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sélectionnées',
      one: '$count sélectionnée',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Sélectionner les résultats';

  @override
  String get clear => 'Effacer';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps',
      one: '$count app',
    );
    return 'Autoriser temporairement $_temp0';
  }

  @override
  String get activeTemporaryExceptions => 'Exceptions temporaires actives';

  @override
  String get noTemporaryExceptions => 'Aucune exception temporaire active.';

  @override
  String untilTime(String time) {
    return 'Jusqu’à $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Jusqu’à $time · Paquet : $packageName';
  }

  @override
  String get endException => 'Terminer l’exception';

  @override
  String get chooseFutureTime => 'Choisissez une heure future.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Exception appliquée à $count apps.',
      one: 'Exception appliquée à $count app.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Accès aux notifications';

  @override
  String get accessGrantedInAndroid => 'Autorisé dans les paramètres Android.';

  @override
  String get accessRequiredToFilter =>
      'Nécessaire pour filtrer les notifications des autres apps.';

  @override
  String get automaticUpdates => 'Rechercher automatiquement les mises à jour';

  @override
  String get automaticUpdatesHint =>
      'Consulte GitHub au maximum une fois par jour et vous avertit lorsqu’une nouvelle version est disponible.';

  @override
  String get checkForUpdateNow => 'Rechercher une mise à jour';

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get followSystem => 'Suivre le système';

  @override
  String get lightTheme => 'Clair';

  @override
  String get darkTheme => 'Sombre';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Couleur d’accentuation';

  @override
  String get customColor => 'Personnalisée';

  @override
  String selectedColor(String color) {
    return 'Sélectionnée : $color';
  }

  @override
  String get localBackup => 'Sauvegarde locale';

  @override
  String get backupDescription =>
      'Le fichier contient les règles, exceptions et préférences. Il ne contient pas le contenu des notifications, messages ou actions.';

  @override
  String get exportSettings => 'Exporter les paramètres';

  @override
  String get importSettings => 'Importer les paramètres';

  @override
  String get noAccountPrivacy =>
      'KillNotify n’a pas de compte et n’envoie pas de données personnelles. L’app est distribuée manuellement, hors Google Play.';

  @override
  String get importBackupTitle => 'Importer la sauvegarde ?';

  @override
  String get importBackupWarning =>
      'L’importation remplace les paramètres actuels. Le fichier est validé avant application.';

  @override
  String get chooseBackupFile => 'Choisir un fichier';

  @override
  String get backupImported => 'Sauvegarde importée';

  @override
  String backupMissingApps(String packages) {
    return 'Certaines apps de la sauvegarde ne sont pas installées : $packages. Leurs horaires sont conservés.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'Le filtre a été importé désactivé car l’accès aux notifications manque.';

  @override
  String get importedWithoutBatteryExemption =>
      'Le filtre a été importé désactivé car l’activité en arrière-plan n’est pas autorisée.';

  @override
  String get backupApplied => 'Les paramètres ont été validés et appliqués.';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'Signification de cet accès';

  @override
  String get notificationAccessExplanation =>
      'Cet accès permet à KillNotify de décider s’il doit différer une notification. L’app ne lit ni ne conserve les titres, textes, contacts ou actions, et ne les envoie nulle part.';

  @override
  String get installedAppsVisibility => 'Visibilité des apps installées';

  @override
  String get installedAppsExplanation =>
      'Pour vous permettre de choisir n’importe quelle app installée, Android montre à KillNotify la liste des apps de l’appareil. Elle est utilisée localement et n’est envoyée à personne. C’est pourquoi la distribution est manuelle, hors Google Play.';

  @override
  String get githubUpdatesPrivacy =>
      'Lorsque les mises à jour automatiques sont activées, KillNotify consulte l’API publique des releases GitHub au maximum une fois par jour. GitHub reçoit les métadonnées normales de connexion, comme l’adresse IP ; les horaires, apps choisies et notifications ne sont pas envoyés. Android demande toujours de confirmer l’installation.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Les appels et alarmes ne sont autorisés automatiquement que si l’app émettrice les identifie ainsi. Les codes de vérification n’ont pas de catégorie universelle ; KillNotify ne lit pas le contenu des messages pour les détecter.';

  @override
  String get customColorTitle => 'Couleur personnalisée';

  @override
  String get hexColor => 'Couleur HEX';

  @override
  String red(int value) {
    return 'Rouge : $value';
  }

  @override
  String green(int value) {
    return 'Vert : $value';
  }

  @override
  String blue(int value) {
    return 'Bleu : $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Saisissez 6 chiffres hexadécimaux.';

  @override
  String get apply => 'Appliquer';

  @override
  String get backgroundActivityTitle => 'Autoriser l’activité en arrière-plan';

  @override
  String get batteryExemptionGranted =>
      'L’autorisation de batterie Android est active.';

  @override
  String get batteryExemptionNeeded =>
      'Nécessaire pour activer le filtre et surveiller les notifications écran éteint.';

  @override
  String get adjustBattery => 'Régler la batterie';

  @override
  String get batteryHelpSamsung =>
      'Sur Samsung, ajoutez KillNotify à Paramètres > Batterie et maintenance de l’appareil > Batterie > Limites d’utilisation en arrière-plan > Apps jamais en veille. Les noms peuvent varier.';

  @override
  String get batteryHelpXiaomi =>
      'Sur Xiaomi, activez le démarrage automatique en arrière-plan dans Paramètres > Apps > Autorisations. Si disponible, choisissez Aucune restriction pour la batterie de KillNotify.';

  @override
  String get batteryHelpHuawei =>
      'Sur Huawei, cherchez Lancement des apps, choisissez KillNotify et autorisez lancement automatique, lancement secondaire et exécution en arrière-plan.';

  @override
  String get batteryHelpRealme =>
      'Sur realme, cherchez Gestion de la batterie des apps et autorisez l’activité en arrière-plan et le démarrage automatique si ces options existent.';

  @override
  String get batteryHelpOppo =>
      'Sur OPPO/ColorOS, certains modes d’économie limitent les apps en arrière-plan. Vérifiez la batterie de KillNotify et autorisez l’activité en arrière-plan si disponible.';

  @override
  String get batteryHelpOneplus =>
      'Sur OnePlus, vérifiez Paramètres > Batterie > Plus de paramètres > Gestion de la batterie des apps et assurez-vous que KillNotify n’est pas limité en arrière-plan.';

  @override
  String get batteryHelpVivo =>
      'Sur vivo, cherchez Paramètres > Apps > Accès spécial aux apps > Démarrage automatique et autorisez KillNotify si disponible.';

  @override
  String get batteryHelpMotorola =>
      'Sur Motorola, si Gestion des apps en arrière-plan existe, choisissez Toujours autoriser pour KillNotify.';

  @override
  String get batteryHelpOther =>
      'Certains téléphones ont leurs propres contrôles d’apps en arrière-plan. Si les interruptions persistent, vérifiez les options de batterie de KillNotify.';

  @override
  String get noNeedKeepScreenOpen =>
      'Il n’est pas nécessaire de laisser KillNotify ouvert à l’écran. Évitez Forcer l’arrêt, qui interrompt le suivi jusqu’à la reconnexion du service Android.';

  @override
  String get checkingUpdates => 'Recherche de mises à jour';

  @override
  String get consultingGithub => 'Consultation de GitHub…';

  @override
  String get updateOpenFailed => 'Impossible d’ouvrir le téléchargement.';

  @override
  String get noReleasePublished =>
      'Aucune version n’a encore été publiée sur GitHub.';

  @override
  String get updateCheckFailed =>
      'Impossible de rechercher des mises à jour maintenant.';

  @override
  String get alreadyLatestVersion => 'Vous utilisez déjà la dernière version.';

  @override
  String get updateAvailable => 'Mise à jour disponible';

  @override
  String versionAvailable(String version) {
    return 'La version $version est disponible.';
  }

  @override
  String get releaseNotes => 'Notes de version';

  @override
  String get updateInstallConfirmation =>
      'Le téléchargement s’ouvrira dans le navigateur. Android vous demandera de confirmer l’installation.';

  @override
  String get neverRemind => 'Ne plus me le rappeler';

  @override
  String get remindTomorrow => 'Me le rappeler demain';

  @override
  String get downloadUpdate => 'Télécharger la mise à jour';

  @override
  String get operationNotCompleted => 'L’opération n’a pas pu aboutir.';

  @override
  String get errorAccessRequired =>
      'Autorisez l’accès aux notifications dans les paramètres Android avant d’activer le filtre.';

  @override
  String get errorBatteryRequired =>
      'Autorisez l’activité en arrière-plan dans les paramètres de batterie avant d’activer le filtre.';

  @override
  String get errorInvalidBackup =>
      'Le fichier de sauvegarde est invalide ou illisible.';

  @override
  String get errorConfigurationUnreadable =>
      'Impossible de lire les paramètres enregistrés.';

  @override
  String get errorBusy => 'Une autre opération est déjà en cours.';

  @override
  String get errorInvalidInput =>
      'Certaines informations sont invalides. Vérifiez-les et réessayez.';

  @override
  String get errorUnsupportedVersion =>
      'Cette version de l’app ne peut pas lire la réponse. Mettez l’app à jour et réessayez.';
}
