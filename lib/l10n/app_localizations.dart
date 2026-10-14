import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('zh'),
    Locale('zh', 'CN'),
  ];

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabApps.
  ///
  /// In en, this message translates to:
  /// **'Apps'**
  String get tabApps;

  /// No description provided for @tabExceptions.
  ///
  /// In en, this message translates to:
  /// **'Exceptions'**
  String get tabExceptions;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languagePortugueseBrazil.
  ///
  /// In en, this message translates to:
  /// **'Português (Brasil)'**
  String get languagePortugueseBrazil;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get languageItalian;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get languageJapanese;

  /// No description provided for @languageChineseSimplified.
  ///
  /// In en, this message translates to:
  /// **'简体中文'**
  String get languageChineseSimplified;

  /// No description provided for @refreshStatus.
  ///
  /// In en, this message translates to:
  /// **'Refresh status'**
  String get refreshStatus;

  /// No description provided for @refreshAppList.
  ///
  /// In en, this message translates to:
  /// **'Refresh app list'**
  String get refreshAppList;

  /// No description provided for @notificationsReleasedToday.
  ///
  /// In en, this message translates to:
  /// **'Notifications released today'**
  String get notificationsReleasedToday;

  /// No description provided for @notificationCountPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Count on this device; message content and actions are not saved.'**
  String get notificationCountPrivacy;

  /// No description provided for @configuredAppsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} app with schedules} other{{count} apps with schedules}}'**
  String configuredAppsCount(int count);

  /// No description provided for @eachAppHasOwnSchedule.
  ///
  /// In en, this message translates to:
  /// **'Each app can have its own schedule.'**
  String get eachAppHasOwnSchedule;

  /// No description provided for @filterActive.
  ///
  /// In en, this message translates to:
  /// **'Filter active'**
  String get filterActive;

  /// No description provided for @filterActiveExplanation.
  ///
  /// In en, this message translates to:
  /// **'KillNotify is applying the configured schedules.'**
  String get filterActiveExplanation;

  /// No description provided for @filterInactive.
  ///
  /// In en, this message translates to:
  /// **'Filter inactive'**
  String get filterInactive;

  /// No description provided for @listenerNotFollowing.
  ///
  /// In en, this message translates to:
  /// **'KillNotify is not monitoring notifications yet. Some may arrive without being delayed.'**
  String get listenerNotFollowing;

  /// No description provided for @batterySetupRequired.
  ///
  /// In en, this message translates to:
  /// **'Adjust battery settings to continue'**
  String get batterySetupRequired;

  /// No description provided for @batterySetupExplanation.
  ///
  /// In en, this message translates to:
  /// **'Allow background activity to turn on the filter.'**
  String get batterySetupExplanation;

  /// No description provided for @schedulesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Schedules unavailable'**
  String get schedulesUnavailable;

  /// No description provided for @schedulesUnavailableExplanation.
  ///
  /// In en, this message translates to:
  /// **'The filter is off until the saved settings can be read.'**
  String get schedulesUnavailableExplanation;

  /// No description provided for @filterDisabled.
  ///
  /// In en, this message translates to:
  /// **'Filter off'**
  String get filterDisabled;

  /// No description provided for @notificationsArriveNormally.
  ///
  /// In en, this message translates to:
  /// **'Notifications arrive normally, without being delayed.'**
  String get notificationsArriveNormally;

  /// No description provided for @accessNeeded.
  ///
  /// In en, this message translates to:
  /// **'Permission needed'**
  String get accessNeeded;

  /// No description provided for @notificationAccessNeeded.
  ///
  /// In en, this message translates to:
  /// **'To apply schedules, allow KillNotify to access notifications in Android settings.'**
  String get notificationAccessNeeded;

  /// No description provided for @openAndroidSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Android settings'**
  String get openAndroidSettings;

  /// No description provided for @activateFilter.
  ///
  /// In en, this message translates to:
  /// **'Turn on filter'**
  String get activateFilter;

  /// No description provided for @filterNeedsBoth.
  ///
  /// In en, this message translates to:
  /// **'Allow notification access and adjust battery settings before turning it on.'**
  String get filterNeedsBoth;

  /// No description provided for @filterNeedsAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow notification access before turning it on.'**
  String get filterNeedsAccess;

  /// No description provided for @filterNeedsBattery.
  ///
  /// In en, this message translates to:
  /// **'Adjust battery settings so the filter can run in the background.'**
  String get filterNeedsBattery;

  /// No description provided for @filterAppliesSchedules.
  ///
  /// In en, this message translates to:
  /// **'Applies the schedules set for each app.'**
  String get filterAppliesSchedules;

  /// No description provided for @restoreBackupForSchedules.
  ///
  /// In en, this message translates to:
  /// **'Import a backup in Settings to restore your schedules.'**
  String get restoreBackupForSchedules;

  /// No description provided for @checkingFilter.
  ///
  /// In en, this message translates to:
  /// **'Checking filter…'**
  String get checkingFilter;

  /// No description provided for @cannotCheckFilter.
  ///
  /// In en, this message translates to:
  /// **'Could not check the filter. Tap refresh and try again.'**
  String get cannotCheckFilter;

  /// No description provided for @nextAllowedStart.
  ///
  /// In en, this message translates to:
  /// **'Next allowed time'**
  String get nextAllowedStart;

  /// No description provided for @nextConfiguredWindow.
  ///
  /// In en, this message translates to:
  /// **'Next scheduled window'**
  String get nextConfiguredWindow;

  /// No description provided for @noAppWaiting.
  ///
  /// In en, this message translates to:
  /// **'No app is waiting for its schedule right now'**
  String get noAppWaiting;

  /// No description provided for @noSchedulesYet.
  ///
  /// In en, this message translates to:
  /// **'No schedules yet'**
  String get noSchedulesYet;

  /// No description provided for @filterInactiveInformative.
  ///
  /// In en, this message translates to:
  /// **'The filter is off; this time is informational.'**
  String get filterInactiveInformative;

  /// No description provided for @timezoneInfo.
  ///
  /// In en, this message translates to:
  /// **'Schedules use the time zone set on this device.'**
  String get timezoneInfo;

  /// No description provided for @chooseAppsAndPeriods.
  ///
  /// In en, this message translates to:
  /// **'Choose apps and set when their notifications may arrive.'**
  String get chooseAppsAndPeriods;

  /// No description provided for @androidControlsSnooze.
  ///
  /// In en, this message translates to:
  /// **'Android controls when a delayed notification appears again. Timing may vary with battery saving, device settings, or clock changes.'**
  String get androidControlsSnooze;

  /// No description provided for @searchApp.
  ///
  /// In en, this message translates to:
  /// **'Search apps'**
  String get searchApp;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @appsListDisclosure.
  ///
  /// In en, this message translates to:
  /// **'This list includes system apps and apps without a home-screen icon. Android may not expose notifications from work profiles or some services.'**
  String get appsListDisclosure;

  /// No description provided for @noSearchMatch.
  ///
  /// In en, this message translates to:
  /// **'No apps match your search.'**
  String get noSearchMatch;

  /// No description provided for @systemApp.
  ///
  /// In en, this message translates to:
  /// **'System app'**
  String get systemApp;

  /// No description provided for @noLauncherIcon.
  ///
  /// In en, this message translates to:
  /// **'No home-screen icon'**
  String get noLauncherIcon;

  /// No description provided for @periodsDefined.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} period set} other{{count} periods set}}'**
  String periodsDefined(int count);

  /// No description provided for @appsWithSchedules.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} app with schedules} other{{count} apps with schedules}}'**
  String appsWithSchedules(int count);

  /// No description provided for @uninstalledApps.
  ///
  /// In en, this message translates to:
  /// **'Apps not installed'**
  String get uninstalledApps;

  /// No description provided for @schedulesPreserved.
  ///
  /// In en, this message translates to:
  /// **'Schedules are kept and will apply again if the app is installed.'**
  String get schedulesPreserved;

  /// No description provided for @appNotFound.
  ///
  /// In en, this message translates to:
  /// **'App not found'**
  String get appNotFound;

  /// No description provided for @removeRule.
  ///
  /// In en, this message translates to:
  /// **'Remove rule'**
  String get removeRule;

  /// No description provided for @packageIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Package: {packageName}'**
  String packageIdentifier(String packageName);

  /// No description provided for @applySchedulesToApp.
  ///
  /// In en, this message translates to:
  /// **'Apply schedules to this app'**
  String get applySchedulesToApp;

  /// No description provided for @noSchedulesAllowNormally.
  ///
  /// In en, this message translates to:
  /// **'Without a schedule, notifications arrive normally.'**
  String get noSchedulesAllowNormally;

  /// No description provided for @weeklyPeriods.
  ///
  /// In en, this message translates to:
  /// **'Weekly periods'**
  String get weeklyPeriods;

  /// No description provided for @addPeriod.
  ///
  /// In en, this message translates to:
  /// **'Add period'**
  String get addPeriod;

  /// No description provided for @noPeriodsForApp.
  ///
  /// In en, this message translates to:
  /// **'No schedules yet. Notifications from this app arrive normally.'**
  String get noPeriodsForApp;

  /// No description provided for @period24HoursHint.
  ///
  /// In en, this message translates to:
  /// **'If the start and end times are the same, the period lasts 24 hours.'**
  String get period24HoursHint;

  /// No description provided for @removePeriod.
  ///
  /// In en, this message translates to:
  /// **'Remove period'**
  String get removePeriod;

  /// No description provided for @exceptions.
  ///
  /// In en, this message translates to:
  /// **'Exceptions'**
  String get exceptions;

  /// No description provided for @allowCallNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow call notifications'**
  String get allowCallNotifications;

  /// No description provided for @callsCategoryOnly.
  ///
  /// In en, this message translates to:
  /// **'Only when the sending app marks it as a call.'**
  String get callsCategoryOnly;

  /// No description provided for @allowAlarmNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow alarm notifications'**
  String get allowAlarmNotifications;

  /// No description provided for @alarmsCategoryOnly.
  ///
  /// In en, this message translates to:
  /// **'Only when the sending app marks it as an alarm.'**
  String get alarmsCategoryOnly;

  /// No description provided for @saveSchedules.
  ///
  /// In en, this message translates to:
  /// **'Save schedules'**
  String get saveSchedules;

  /// No description provided for @schedulesSaved.
  ///
  /// In en, this message translates to:
  /// **'Schedules saved.'**
  String get schedulesSaved;

  /// No description provided for @newPeriod.
  ///
  /// In en, this message translates to:
  /// **'New period'**
  String get newPeriod;

  /// No description provided for @editPeriod.
  ///
  /// In en, this message translates to:
  /// **'Edit period'**
  String get editPeriod;

  /// No description provided for @allowedDays.
  ///
  /// In en, this message translates to:
  /// **'Days when notifications may arrive'**
  String get allowedDays;

  /// No description provided for @selectAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day.'**
  String get selectAtLeastOneDay;

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get endTime;

  /// No description provided for @periodMayCrossMidnight.
  ///
  /// In en, this message translates to:
  /// **'A period can end the next day. If start and end are the same, it lasts 24 hours.'**
  String get periodMayCrossMidnight;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @effectiveSchedule.
  ///
  /// In en, this message translates to:
  /// **'Effective schedule'**
  String get effectiveSchedule;

  /// No description provided for @overlappingPeriodsGrouped.
  ///
  /// In en, this message translates to:
  /// **'Overlapping or adjacent periods are combined. Your original schedules remain saved.'**
  String get overlappingPeriodsGrouped;

  /// No description provided for @saveToPreviewPeriods.
  ///
  /// In en, this message translates to:
  /// **'Save to see how these periods will be combined.'**
  String get saveToPreviewPeriods;

  /// No description provided for @noSchedulesNotificationsPass.
  ///
  /// In en, this message translates to:
  /// **'Without schedules, notifications arrive normally.'**
  String get noSchedulesNotificationsPass;

  /// No description provided for @temporaryException.
  ///
  /// In en, this message translates to:
  /// **'Temporary exception'**
  String get temporaryException;

  /// No description provided for @allowUntil.
  ///
  /// In en, this message translates to:
  /// **'Allow until {time}'**
  String allowUntil(String time);

  /// No description provided for @noActiveExceptionForApp.
  ///
  /// In en, this message translates to:
  /// **'No active exception for this app.'**
  String get noActiveExceptionForApp;

  /// No description provided for @oneHour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get oneHour;

  /// No description provided for @fourHours.
  ///
  /// In en, this message translates to:
  /// **'4 hours'**
  String get fourHours;

  /// No description provided for @eightHours.
  ///
  /// In en, this message translates to:
  /// **'8 hours'**
  String get eightHours;

  /// No description provided for @twentyFourHours.
  ///
  /// In en, this message translates to:
  /// **'24 hours'**
  String get twentyFourHours;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @temporaryExceptions.
  ///
  /// In en, this message translates to:
  /// **'Temporary exceptions'**
  String get temporaryExceptions;

  /// No description provided for @temporaryExceptionsExplanation.
  ///
  /// In en, this message translates to:
  /// **'Temporarily allow notifications for one or more apps. The exception ends at the chosen time, based on this device\'s clock.'**
  String get temporaryExceptionsExplanation;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get chooseTime;

  /// No description provided for @selectedAppsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} selected} other{{count} selected}}'**
  String selectedAppsCount(int count);

  /// No description provided for @selectResults.
  ///
  /// In en, this message translates to:
  /// **'Select results'**
  String get selectResults;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @allowAppsTemporarily.
  ///
  /// In en, this message translates to:
  /// **'Temporarily allow {count, plural, one{{count} app} other{{count} apps}}'**
  String allowAppsTemporarily(int count);

  /// No description provided for @activeTemporaryExceptions.
  ///
  /// In en, this message translates to:
  /// **'Active temporary exceptions'**
  String get activeTemporaryExceptions;

  /// No description provided for @noTemporaryExceptions.
  ///
  /// In en, this message translates to:
  /// **'No active temporary exceptions.'**
  String get noTemporaryExceptions;

  /// No description provided for @untilTime.
  ///
  /// In en, this message translates to:
  /// **'Until {time}'**
  String untilTime(String time);

  /// No description provided for @untilTimeWithIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Until {time} · Package: {packageName}'**
  String untilTimeWithIdentifier(String time, String packageName);

  /// No description provided for @endException.
  ///
  /// In en, this message translates to:
  /// **'End exception'**
  String get endException;

  /// No description provided for @chooseFutureTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a time in the future.'**
  String get chooseFutureTime;

  /// No description provided for @exceptionAppliedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Temporary exception applied to {count} app.} other{Temporary exception applied to {count} apps.}}'**
  String exceptionAppliedCount(int count);

  /// No description provided for @notificationAccess.
  ///
  /// In en, this message translates to:
  /// **'Notification access'**
  String get notificationAccess;

  /// No description provided for @accessGrantedInAndroid.
  ///
  /// In en, this message translates to:
  /// **'Allowed in Android settings.'**
  String get accessGrantedInAndroid;

  /// No description provided for @accessRequiredToFilter.
  ///
  /// In en, this message translates to:
  /// **'Required to filter notifications from other apps.'**
  String get accessRequiredToFilter;

  /// No description provided for @automaticUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates automatically'**
  String get automaticUpdates;

  /// No description provided for @automaticUpdatesHint.
  ///
  /// In en, this message translates to:
  /// **'Checks GitHub at most once a day and lets you know when a new version is available.'**
  String get automaticUpdatesHint;

  /// No description provided for @checkForUpdateNow.
  ///
  /// In en, this message translates to:
  /// **'Check for updates now'**
  String get checkForUpdateNow;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @followSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get followSystem;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @amoledTheme.
  ///
  /// In en, this message translates to:
  /// **'AMOLED'**
  String get amoledTheme;

  /// No description provided for @accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent color'**
  String get accentColor;

  /// No description provided for @customColor.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customColor;

  /// No description provided for @selectedColor.
  ///
  /// In en, this message translates to:
  /// **'Selected: {color}'**
  String selectedColor(String color);

  /// No description provided for @localBackup.
  ///
  /// In en, this message translates to:
  /// **'Local backup'**
  String get localBackup;

  /// No description provided for @backupDescription.
  ///
  /// In en, this message translates to:
  /// **'The settings file contains rules, exceptions and preferences. It does not contain notification content, messages or actions.'**
  String get backupDescription;

  /// No description provided for @exportSettings.
  ///
  /// In en, this message translates to:
  /// **'Export settings'**
  String get exportSettings;

  /// No description provided for @importSettings.
  ///
  /// In en, this message translates to:
  /// **'Import settings'**
  String get importSettings;

  /// No description provided for @noAccountPrivacy.
  ///
  /// In en, this message translates to:
  /// **'KillNotify has no account and sends no personal data. The app is distributed manually and is not on Google Play.'**
  String get noAccountPrivacy;

  /// No description provided for @importBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Import backup?'**
  String get importBackupTitle;

  /// No description provided for @importBackupWarning.
  ///
  /// In en, this message translates to:
  /// **'Importing replaces your current settings. The file is validated before it is applied.'**
  String get importBackupWarning;

  /// No description provided for @chooseBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get chooseBackupFile;

  /// No description provided for @backupImported.
  ///
  /// In en, this message translates to:
  /// **'Backup imported'**
  String get backupImported;

  /// No description provided for @backupMissingApps.
  ///
  /// In en, this message translates to:
  /// **'Some apps in the backup are not installed: {packages}. Their schedules were kept.'**
  String backupMissingApps(String packages);

  /// No description provided for @importedWithoutNotificationAccess.
  ///
  /// In en, this message translates to:
  /// **'The filter was imported turned off because notification access is missing.'**
  String get importedWithoutNotificationAccess;

  /// No description provided for @importedWithoutBatteryExemption.
  ///
  /// In en, this message translates to:
  /// **'The filter was imported turned off because background battery access is missing.'**
  String get importedWithoutBatteryExemption;

  /// No description provided for @backupApplied.
  ///
  /// In en, this message translates to:
  /// **'Settings were validated and applied.'**
  String get backupApplied;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @whatAccessMeans.
  ///
  /// In en, this message translates to:
  /// **'What this access means'**
  String get whatAccessMeans;

  /// No description provided for @notificationAccessExplanation.
  ///
  /// In en, this message translates to:
  /// **'This access lets KillNotify decide whether to delay a notification. The app does not read or store titles, text, contacts or actions, and does not send them anywhere.'**
  String get notificationAccessExplanation;

  /// No description provided for @installedAppsVisibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility of installed apps'**
  String get installedAppsVisibility;

  /// No description provided for @installedAppsExplanation.
  ///
  /// In en, this message translates to:
  /// **'To let you choose any installed app, Android shows KillNotify the app list on this device. It is used locally and is not sent anywhere. This gives the app access to more information about installed apps, so distribution is manual through GitHub, outside Google Play.'**
  String get installedAppsExplanation;

  /// No description provided for @githubUpdatesPrivacy.
  ///
  /// In en, this message translates to:
  /// **'When automatic updates are enabled, KillNotify checks GitHub\'s public releases API at most once a day. GitHub receives normal connection metadata such as your IP address; schedules, selected apps and notifications are not sent. Android still asks you to confirm installation.'**
  String get githubUpdatesPrivacy;

  /// No description provided for @callsAlarmsOtpPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Calls and alarms can only be allowed automatically when the sending app identifies them that way. Verification codes have no universal category; KillNotify does not read message content to detect them.'**
  String get callsAlarmsOtpPrivacy;

  /// No description provided for @customColorTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom color'**
  String get customColorTitle;

  /// No description provided for @hexColor.
  ///
  /// In en, this message translates to:
  /// **'HEX color'**
  String get hexColor;

  /// No description provided for @red.
  ///
  /// In en, this message translates to:
  /// **'Red: {value}'**
  String red(int value);

  /// No description provided for @green.
  ///
  /// In en, this message translates to:
  /// **'Green: {value}'**
  String green(int value);

  /// No description provided for @blue.
  ///
  /// In en, this message translates to:
  /// **'Blue: {value}'**
  String blue(int value);

  /// No description provided for @hexColorNeedsSixDigits.
  ///
  /// In en, this message translates to:
  /// **'Enter 6 hexadecimal digits.'**
  String get hexColorNeedsSixDigits;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @backgroundActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow background activity'**
  String get backgroundActivityTitle;

  /// No description provided for @batteryExemptionGranted.
  ///
  /// In en, this message translates to:
  /// **'Android battery access is enabled.'**
  String get batteryExemptionGranted;

  /// No description provided for @batteryExemptionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Required to turn on the filter and monitor notifications while the screen is off.'**
  String get batteryExemptionNeeded;

  /// No description provided for @adjustBattery.
  ///
  /// In en, this message translates to:
  /// **'Adjust battery settings'**
  String get adjustBattery;

  /// No description provided for @batteryHelpSamsung.
  ///
  /// In en, this message translates to:
  /// **'On Samsung, add KillNotify to Settings > Battery and device care > Battery > Background usage limits > Never sleeping apps. Menu names may vary by version.'**
  String get batteryHelpSamsung;

  /// No description provided for @batteryHelpXiaomi.
  ///
  /// In en, this message translates to:
  /// **'On Xiaomi, enable Background autostart in Settings > Apps > Permissions. If available, set KillNotify battery use to No restrictions. Menu names vary by model.'**
  String get batteryHelpXiaomi;

  /// No description provided for @batteryHelpHuawei.
  ///
  /// In en, this message translates to:
  /// **'On Huawei, find App launch, select KillNotify and allow Auto-launch, Secondary launch and Run in background. Menu names vary by version.'**
  String get batteryHelpHuawei;

  /// No description provided for @batteryHelpRealme.
  ///
  /// In en, this message translates to:
  /// **'On realme, find App battery management in Settings and allow background activity and auto launch for KillNotify if those options are available.'**
  String get batteryHelpRealme;

  /// No description provided for @batteryHelpOppo.
  ///
  /// In en, this message translates to:
  /// **'On OPPO/ColorOS, some power-saving modes limit background apps. Check Battery or Apps settings for KillNotify and allow background activity if available.'**
  String get batteryHelpOppo;

  /// No description provided for @batteryHelpOneplus.
  ///
  /// In en, this message translates to:
  /// **'On OnePlus, check Settings > Battery > More settings > App battery management. Make sure KillNotify background activity is not restricted; labels may vary.'**
  String get batteryHelpOneplus;

  /// No description provided for @batteryHelpVivo.
  ///
  /// In en, this message translates to:
  /// **'On vivo, look for Settings > Apps > Special app access > Autostart and allow KillNotify if the option is available.'**
  String get batteryHelpVivo;

  /// No description provided for @batteryHelpMotorola.
  ///
  /// In en, this message translates to:
  /// **'On Motorola, if Manage background apps is available, set KillNotify to Always allow. Menu names and availability vary by model.'**
  String get batteryHelpMotorola;

  /// No description provided for @batteryHelpOther.
  ///
  /// In en, this message translates to:
  /// **'Some phones have their own background app controls. If interruptions continue, look for KillNotify battery settings on your device.'**
  String get batteryHelpOther;

  /// No description provided for @noNeedKeepScreenOpen.
  ///
  /// In en, this message translates to:
  /// **'You do not need to keep KillNotify open on screen. Avoid Force stop; it interrupts monitoring until Android reconnects the service.'**
  String get noNeedKeepScreenOpen;

  /// No description provided for @checkingUpdates.
  ///
  /// In en, this message translates to:
  /// **'Checking for updates'**
  String get checkingUpdates;

  /// No description provided for @consultingGithub.
  ///
  /// In en, this message translates to:
  /// **'Checking GitHub…'**
  String get consultingGithub;

  /// No description provided for @updateOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the download.'**
  String get updateOpenFailed;

  /// No description provided for @noReleasePublished.
  ///
  /// In en, this message translates to:
  /// **'There is no release published on GitHub yet.'**
  String get noReleasePublished;

  /// No description provided for @updateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not check for updates right now.'**
  String get updateCheckFailed;

  /// No description provided for @alreadyLatestVersion.
  ///
  /// In en, this message translates to:
  /// **'You are already using the latest version.'**
  String get alreadyLatestVersion;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @versionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Version {version} is available.'**
  String versionAvailable(String version);

  /// No description provided for @releaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Release notes'**
  String get releaseNotes;

  /// No description provided for @updateInstallConfirmation.
  ///
  /// In en, this message translates to:
  /// **'The download opens in your browser. Android will ask you to confirm installation.'**
  String get updateInstallConfirmation;

  /// No description provided for @neverRemind.
  ///
  /// In en, this message translates to:
  /// **'Don\'t remind me again'**
  String get neverRemind;

  /// No description provided for @remindTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Remind me tomorrow'**
  String get remindTomorrow;

  /// No description provided for @downloadUpdate.
  ///
  /// In en, this message translates to:
  /// **'Download update'**
  String get downloadUpdate;

  /// No description provided for @operationNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'The operation could not be completed.'**
  String get operationNotCompleted;

  /// No description provided for @errorAccessRequired.
  ///
  /// In en, this message translates to:
  /// **'Allow notification access in Android settings before turning on the filter.'**
  String get errorAccessRequired;

  /// No description provided for @errorBatteryRequired.
  ///
  /// In en, this message translates to:
  /// **'Allow background activity in Android battery settings before turning on the filter.'**
  String get errorBatteryRequired;

  /// No description provided for @errorInvalidBackup.
  ///
  /// In en, this message translates to:
  /// **'The backup file is invalid or could not be read.'**
  String get errorInvalidBackup;

  /// No description provided for @errorConfigurationUnreadable.
  ///
  /// In en, this message translates to:
  /// **'Saved settings could not be read.'**
  String get errorConfigurationUnreadable;

  /// No description provided for @errorBusy.
  ///
  /// In en, this message translates to:
  /// **'Another operation is already in progress.'**
  String get errorBusy;

  /// No description provided for @errorInvalidInput.
  ///
  /// In en, this message translates to:
  /// **'Some information is invalid. Check it and try again.'**
  String get errorInvalidInput;

  /// No description provided for @errorUnsupportedVersion.
  ///
  /// In en, this message translates to:
  /// **'This app version cannot read the response. Update the app and try again.'**
  String get errorUnsupportedVersion;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
