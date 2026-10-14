// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tabHome => 'Home';

  @override
  String get tabApps => 'Apps';

  @override
  String get tabExceptions => 'Exceptions';

  @override
  String get tabSettings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get systemLanguage => 'System';

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
  String get refreshStatus => 'Refresh status';

  @override
  String get refreshAppList => 'Refresh app list';

  @override
  String get notificationsReleasedToday => 'Notifications released today';

  @override
  String get notificationCountPrivacy =>
      'Count on this device; message content and actions are not saved.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps with schedules',
      one: '$count app with schedules',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule => 'Each app can have its own schedule.';

  @override
  String get filterActive => 'Filter active';

  @override
  String get filterActiveExplanation =>
      'KillNotify is applying the configured schedules.';

  @override
  String get filterInactive => 'Filter inactive';

  @override
  String get listenerNotFollowing =>
      'KillNotify is not monitoring notifications yet. Some may arrive without being delayed.';

  @override
  String get batterySetupRequired => 'Adjust battery settings to continue';

  @override
  String get batterySetupExplanation =>
      'Allow background activity to turn on the filter.';

  @override
  String get schedulesUnavailable => 'Schedules unavailable';

  @override
  String get schedulesUnavailableExplanation =>
      'The filter is off until the saved settings can be read.';

  @override
  String get filterDisabled => 'Filter off';

  @override
  String get notificationsArriveNormally =>
      'Notifications arrive normally, without being delayed.';

  @override
  String get accessNeeded => 'Permission needed';

  @override
  String get notificationAccessNeeded =>
      'To apply schedules, allow KillNotify to access notifications in Android settings.';

  @override
  String get openAndroidSettings => 'Open Android settings';

  @override
  String get activateFilter => 'Turn on filter';

  @override
  String get filterNeedsBoth =>
      'Allow notification access and adjust battery settings before turning it on.';

  @override
  String get filterNeedsAccess =>
      'Allow notification access before turning it on.';

  @override
  String get filterNeedsBattery =>
      'Adjust battery settings so the filter can run in the background.';

  @override
  String get filterAppliesSchedules =>
      'Applies the schedules set for each app.';

  @override
  String get restoreBackupForSchedules =>
      'Import a backup in Settings to restore your schedules.';

  @override
  String get checkingFilter => 'Checking filter…';

  @override
  String get cannotCheckFilter =>
      'Could not check the filter. Tap refresh and try again.';

  @override
  String get nextAllowedStart => 'Next allowed time';

  @override
  String get nextConfiguredWindow => 'Next scheduled window';

  @override
  String get noAppWaiting => 'No app is waiting for its schedule right now';

  @override
  String get noSchedulesYet => 'No schedules yet';

  @override
  String get filterInactiveInformative =>
      'The filter is off; this time is informational.';

  @override
  String get timezoneInfo => 'Schedules use the time zone set on this device.';

  @override
  String get chooseAppsAndPeriods =>
      'Choose apps and set when their notifications may arrive.';

  @override
  String get androidControlsSnooze =>
      'Android controls when a delayed notification appears again. Timing may vary with battery saving, device settings, or clock changes.';

  @override
  String get searchApp => 'Search apps';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get appsListDisclosure =>
      'This list includes system apps and apps without a home-screen icon. Android may not expose notifications from work profiles or some services.';

  @override
  String get noSearchMatch => 'No apps match your search.';

  @override
  String get systemApp => 'System app';

  @override
  String get noLauncherIcon => 'No home-screen icon';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count periods set',
      one: '$count period set',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps with schedules',
      one: '$count app with schedules',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'Apps not installed';

  @override
  String get schedulesPreserved =>
      'Schedules are kept and will apply again if the app is installed.';

  @override
  String get appNotFound => 'App not found';

  @override
  String get removeRule => 'Remove rule';

  @override
  String packageIdentifier(String packageName) {
    return 'Package: $packageName';
  }

  @override
  String get applySchedulesToApp => 'Apply schedules to this app';

  @override
  String get noSchedulesAllowNormally =>
      'Without a schedule, notifications arrive normally.';

  @override
  String get weeklyPeriods => 'Weekly periods';

  @override
  String get addPeriod => 'Add period';

  @override
  String get noPeriodsForApp =>
      'No schedules yet. Notifications from this app arrive normally.';

  @override
  String get period24HoursHint =>
      'If the start and end times are the same, the period lasts 24 hours.';

  @override
  String get removePeriod => 'Remove period';

  @override
  String get exceptions => 'Exceptions';

  @override
  String get allowCallNotifications => 'Allow call notifications';

  @override
  String get callsCategoryOnly =>
      'Only when the sending app marks it as a call.';

  @override
  String get allowAlarmNotifications => 'Allow alarm notifications';

  @override
  String get alarmsCategoryOnly =>
      'Only when the sending app marks it as an alarm.';

  @override
  String get saveSchedules => 'Save schedules';

  @override
  String get schedulesSaved => 'Schedules saved.';

  @override
  String get newPeriod => 'New period';

  @override
  String get editPeriod => 'Edit period';

  @override
  String get allowedDays => 'Days when notifications may arrive';

  @override
  String get selectAtLeastOneDay => 'Select at least one day.';

  @override
  String get startTime => 'Start';

  @override
  String get endTime => 'End';

  @override
  String get periodMayCrossMidnight =>
      'A period can end the next day. If start and end are the same, it lasts 24 hours.';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get effectiveSchedule => 'Effective schedule';

  @override
  String get overlappingPeriodsGrouped =>
      'Overlapping or adjacent periods are combined. Your original schedules remain saved.';

  @override
  String get saveToPreviewPeriods =>
      'Save to see how these periods will be combined.';

  @override
  String get noSchedulesNotificationsPass =>
      'Without schedules, notifications arrive normally.';

  @override
  String get temporaryException => 'Temporary exception';

  @override
  String allowUntil(String time) {
    return 'Allow until $time';
  }

  @override
  String get noActiveExceptionForApp => 'No active exception for this app.';

  @override
  String get oneHour => '1 hour';

  @override
  String get fourHours => '4 hours';

  @override
  String get eightHours => '8 hours';

  @override
  String get twentyFourHours => '24 hours';

  @override
  String get remove => 'Remove';

  @override
  String get temporaryExceptions => 'Temporary exceptions';

  @override
  String get temporaryExceptionsExplanation =>
      'Temporarily allow notifications for one or more apps. The exception ends at the chosen time, based on this device\'s clock.';

  @override
  String get duration => 'Duration';

  @override
  String get chooseTime => 'Choose time';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selected',
      one: '$count selected',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Select results';

  @override
  String get clear => 'Clear';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps',
      one: '$count app',
    );
    return 'Temporarily allow $_temp0';
  }

  @override
  String get activeTemporaryExceptions => 'Active temporary exceptions';

  @override
  String get noTemporaryExceptions => 'No active temporary exceptions.';

  @override
  String untilTime(String time) {
    return 'Until $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Until $time · Package: $packageName';
  }

  @override
  String get endException => 'End exception';

  @override
  String get chooseFutureTime => 'Choose a time in the future.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Temporary exception applied to $count apps.',
      one: 'Temporary exception applied to $count app.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Notification access';

  @override
  String get accessGrantedInAndroid => 'Allowed in Android settings.';

  @override
  String get accessRequiredToFilter =>
      'Required to filter notifications from other apps.';

  @override
  String get automaticUpdates => 'Check for updates automatically';

  @override
  String get automaticUpdatesHint =>
      'Checks GitHub at most once a day and lets you know when a new version is available.';

  @override
  String get checkForUpdateNow => 'Check for updates now';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get followSystem => 'Follow system';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Accent color';

  @override
  String get customColor => 'Custom';

  @override
  String selectedColor(String color) {
    return 'Selected: $color';
  }

  @override
  String get localBackup => 'Local backup';

  @override
  String get backupDescription =>
      'The settings file contains rules, exceptions and preferences. It does not contain notification content, messages or actions.';

  @override
  String get exportSettings => 'Export settings';

  @override
  String get importSettings => 'Import settings';

  @override
  String get noAccountPrivacy =>
      'KillNotify has no account and sends no personal data. The app is distributed manually and is not on Google Play.';

  @override
  String get importBackupTitle => 'Import backup?';

  @override
  String get importBackupWarning =>
      'Importing replaces your current settings. The file is validated before it is applied.';

  @override
  String get chooseBackupFile => 'Choose file';

  @override
  String get backupImported => 'Backup imported';

  @override
  String backupMissingApps(String packages) {
    return 'Some apps in the backup are not installed: $packages. Their schedules were kept.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'The filter was imported turned off because notification access is missing.';

  @override
  String get importedWithoutBatteryExemption =>
      'The filter was imported turned off because background battery access is missing.';

  @override
  String get backupApplied => 'Settings were validated and applied.';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'What this access means';

  @override
  String get notificationAccessExplanation =>
      'This access lets KillNotify decide whether to delay a notification. The app does not read or store titles, text, contacts or actions, and does not send them anywhere.';

  @override
  String get installedAppsVisibility => 'Visibility of installed apps';

  @override
  String get installedAppsExplanation =>
      'To let you choose any installed app, Android shows KillNotify the app list on this device. It is used locally and is not sent anywhere. This gives the app access to more information about installed apps, so distribution is manual through GitHub, outside Google Play.';

  @override
  String get githubUpdatesPrivacy =>
      'When automatic updates are enabled, KillNotify checks GitHub\'s public releases API at most once a day. GitHub receives normal connection metadata such as your IP address; schedules, selected apps and notifications are not sent. Android still asks you to confirm installation.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Calls and alarms can only be allowed automatically when the sending app identifies them that way. Verification codes have no universal category; KillNotify does not read message content to detect them.';

  @override
  String get customColorTitle => 'Custom color';

  @override
  String get hexColor => 'HEX color';

  @override
  String red(int value) {
    return 'Red: $value';
  }

  @override
  String green(int value) {
    return 'Green: $value';
  }

  @override
  String blue(int value) {
    return 'Blue: $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Enter 6 hexadecimal digits.';

  @override
  String get apply => 'Apply';

  @override
  String get backgroundActivityTitle => 'Allow background activity';

  @override
  String get batteryExemptionGranted => 'Android battery access is enabled.';

  @override
  String get batteryExemptionNeeded =>
      'Required to turn on the filter and monitor notifications while the screen is off.';

  @override
  String get adjustBattery => 'Adjust battery settings';

  @override
  String get batteryHelpSamsung =>
      'On Samsung, add KillNotify to Settings > Battery and device care > Battery > Background usage limits > Never sleeping apps. Menu names may vary by version.';

  @override
  String get batteryHelpXiaomi =>
      'On Xiaomi, enable Background autostart in Settings > Apps > Permissions. If available, set KillNotify battery use to No restrictions. Menu names vary by model.';

  @override
  String get batteryHelpHuawei =>
      'On Huawei, find App launch, select KillNotify and allow Auto-launch, Secondary launch and Run in background. Menu names vary by version.';

  @override
  String get batteryHelpRealme =>
      'On realme, find App battery management in Settings and allow background activity and auto launch for KillNotify if those options are available.';

  @override
  String get batteryHelpOppo =>
      'On OPPO/ColorOS, some power-saving modes limit background apps. Check Battery or Apps settings for KillNotify and allow background activity if available.';

  @override
  String get batteryHelpOneplus =>
      'On OnePlus, check Settings > Battery > More settings > App battery management. Make sure KillNotify background activity is not restricted; labels may vary.';

  @override
  String get batteryHelpVivo =>
      'On vivo, look for Settings > Apps > Special app access > Autostart and allow KillNotify if the option is available.';

  @override
  String get batteryHelpMotorola =>
      'On Motorola, if Manage background apps is available, set KillNotify to Always allow. Menu names and availability vary by model.';

  @override
  String get batteryHelpOther =>
      'Some phones have their own background app controls. If interruptions continue, look for KillNotify battery settings on your device.';

  @override
  String get noNeedKeepScreenOpen =>
      'You do not need to keep KillNotify open on screen. Avoid Force stop; it interrupts monitoring until Android reconnects the service.';

  @override
  String get checkingUpdates => 'Checking for updates';

  @override
  String get consultingGithub => 'Checking GitHub…';

  @override
  String get updateOpenFailed => 'Could not open the download.';

  @override
  String get noReleasePublished =>
      'There is no release published on GitHub yet.';

  @override
  String get updateCheckFailed => 'Could not check for updates right now.';

  @override
  String get alreadyLatestVersion =>
      'You are already using the latest version.';

  @override
  String get updateAvailable => 'Update available';

  @override
  String versionAvailable(String version) {
    return 'Version $version is available.';
  }

  @override
  String get releaseNotes => 'Release notes';

  @override
  String get updateInstallConfirmation =>
      'The download opens in your browser. Android will ask you to confirm installation.';

  @override
  String get neverRemind => 'Don\'t remind me again';

  @override
  String get remindTomorrow => 'Remind me tomorrow';

  @override
  String get downloadUpdate => 'Download update';

  @override
  String get operationNotCompleted => 'The operation could not be completed.';

  @override
  String get errorAccessRequired =>
      'Allow notification access in Android settings before turning on the filter.';

  @override
  String get errorBatteryRequired =>
      'Allow background activity in Android battery settings before turning on the filter.';

  @override
  String get errorInvalidBackup =>
      'The backup file is invalid or could not be read.';

  @override
  String get errorConfigurationUnreadable =>
      'Saved settings could not be read.';

  @override
  String get errorBusy => 'Another operation is already in progress.';

  @override
  String get errorInvalidInput =>
      'Some information is invalid. Check it and try again.';

  @override
  String get errorUnsupportedVersion =>
      'This app version cannot read the response. Update the app and try again.';
}
