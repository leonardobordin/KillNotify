import 'package:flutter/services.dart';

class NativeBridge {
  static const _channel = MethodChannel('com.killnotify/v1');

  Future<NativeSnapshot> getSnapshot() async {
    final raw = await _channel.invokeMapMethod<String, Object?>('getSnapshot');
    if (raw == null || raw['contractVersion'] != 1) {
      throw PlatformException(
        code: 'unsupported_version',
        message: 'Não foi possível consultar o estado do app. Tente novamente.',
      );
    }
    return NativeSnapshot.fromMap(raw);
  }

  Future<List<InstalledApp>> listApps() async {
    final raw =
        await _channel.invokeListMethod<Object?>('listApps') ?? const [];
    return raw
        .whereType<Map<Object?, Object?>>()
        .map(InstalledApp.fromMap)
        .toList(growable: false);
  }

  Future<NativeSnapshot> setFilterEnabled(bool enabled) =>
      _snapshotAfter('setFilterEnabled', {'enabled': enabled});

  Future<NativeSnapshot> saveAppRule(AppRuleData rule) => _snapshotAfter(
    'saveAppRule',
    {
      'packageName': rule.packageName,
      'selected': rule.selected,
      'intervals': rule.intervals.map((interval) => interval.toMap()).toList(),
      'allowCalls': rule.allowCalls,
      'allowAlarms': rule.allowAlarms,
      'temporaryAllowUntilEpochMillis': rule.temporaryAllowUntilEpochMillis,
    },
  );

  Future<NativeSnapshot> removeAppRule(String packageName) =>
      _snapshotAfter('removeAppRule', {'packageName': packageName});

  Future<NativeSnapshot> setTemporaryException({
    required List<String> packageNames,
    required int? untilEpochMillis,
  }) => _snapshotAfter('setTemporaryException', {
    'packageNames': packageNames,
    'untilEpochMillis': untilEpochMillis,
  });

  Future<NativeSnapshot> setCategoryExceptions({
    required String packageName,
    required bool allowCalls,
    required bool allowAlarms,
  }) => _snapshotAfter('setCategoryExceptions', {
    'packageName': packageName,
    'allowCalls': allowCalls,
    'allowAlarms': allowAlarms,
  });

  Future<NativeSnapshot> setThemeChoice(String themeChoice) =>
      _snapshotAfter('setThemeChoice', {'themeChoice': themeChoice});

  Future<NativeSnapshot> setAccentColor(int accentColor) =>
      _snapshotAfter('setAccentColor', {'accentColor': accentColor});

  Future<void> openNotificationAccessSettings() =>
      _channel.invokeMethod<void>('openNotificationAccessSettings');

  Future<void> requestBatteryOptimizationExemption() =>
      _channel.invokeMethod<void>('requestBatteryOptimizationExemption');

  Future<void> exportBackup() => _channel.invokeMethod<void>('exportBackup');

  Future<BackupImportResult?> importBackup() async {
    final raw = await _channel.invokeMapMethod<String, Object?>('importBackup');
    if (raw == null || raw['cancelled'] == true) return null;
    await getSnapshot();
    return BackupImportResult(
      missingPackages: (raw['missingPackages'] as List<Object?>? ?? const [])
          .whereType<String>()
          .toList(growable: false),
      accessRequired: raw['accessRequired'] == true,
      batteryOptimizationRequired: raw['batteryOptimizationRequired'] == true,
    );
  }

  Future<NativeSnapshot> _snapshotAfter(
    String method,
    Map<String, Object?> arguments,
  ) async {
    await _channel.invokeMethod<Object?>(method, arguments);
    return getSnapshot();
  }
}

class NativeSnapshot {
  const NativeSnapshot({
    required this.state,
    required this.accessGranted,
    required this.batteryOptimizationExempt,
    required this.manufacturerFamily,
    required this.filterEnabled,
    required this.filterActive,
    required this.listenerConnected,
    required this.themeChoice,
    required this.accentColor,
    required this.zoneId,
    required this.checkedAtEpochMillis,
    required this.releasedCountToday,
    required this.appRules,
    this.nextPackageName,
    this.nextAllowedStartEpochMillis,
    this.configurationError,
  });

  final String state;
  final bool accessGranted;
  final bool batteryOptimizationExempt;
  final String manufacturerFamily;
  final bool filterEnabled;
  final bool filterActive;
  final bool listenerConnected;
  final String themeChoice;
  final int accentColor;
  final String zoneId;
  final int checkedAtEpochMillis;
  final int releasedCountToday;
  final List<AppRuleView> appRules;
  final String? nextPackageName;
  final int? nextAllowedStartEpochMillis;
  final String? configurationError;

  Map<String, AppRuleView> get rulesByPackage => {
    for (final rule in appRules) rule.packageName: rule,
  };

  factory NativeSnapshot.fromMap(Map<String, Object?> map) {
    return NativeSnapshot(
      state: map['state'] as String? ?? 'configuration_error',
      accessGranted: map['accessGranted'] == true,
      batteryOptimizationExempt: map['batteryOptimizationExempt'] == true,
      manufacturerFamily: map['manufacturerFamily'] as String? ?? 'other',
      filterEnabled: map['filterEnabled'] == true,
      filterActive: map['filterActive'] == true,
      listenerConnected: map['listenerConnected'] == true,
      themeChoice: map['themeChoice'] as String? ?? 'system',
      accentColor: map['accentColor'] as int? ?? 0xFF4F46E5,
      zoneId: map['zoneId'] as String? ?? 'local',
      checkedAtEpochMillis: map['checkedAtEpochMillis'] as int? ?? 0,
      releasedCountToday: map['releasedCountToday'] as int? ?? 0,
      nextPackageName: map['nextPackageName'] as String?,
      nextAllowedStartEpochMillis: map['nextAllowedStartEpochMillis'] as int?,
      configurationError: map['configurationError'] as String?,
      appRules: (map['appRules'] as List<Object?>? ?? const [])
          .whereType<Map<Object?, Object?>>()
          .map(AppRuleView.fromMap)
          .toList(growable: false),
    );
  }
}

class AppRuleView {
  const AppRuleView({
    required this.packageName,
    required this.selected,
    required this.intervals,
    required this.effectiveWindows,
    required this.isAllowedNow,
    required this.allowCalls,
    required this.allowAlarms,
    this.nextAllowedStartEpochMillis,
    this.temporaryAllowUntilEpochMillis,
  });

  final String packageName;
  final bool selected;
  final List<ScheduleIntervalData> intervals;
  final List<ScheduleWindowData> effectiveWindows;
  final bool isAllowedNow;
  final bool allowCalls;
  final bool allowAlarms;
  final int? nextAllowedStartEpochMillis;
  final int? temporaryAllowUntilEpochMillis;

  factory AppRuleView.fromMap(Map<Object?, Object?> map) => AppRuleView(
    packageName: map['packageName'] as String? ?? '',
    selected: map['selected'] == true,
    intervals: (map['intervals'] as List<Object?>? ?? const [])
        .whereType<Map<Object?, Object?>>()
        .map(ScheduleIntervalData.fromMap)
        .toList(growable: false),
    effectiveWindows: (map['effectiveWindows'] as List<Object?>? ?? const [])
        .whereType<Map<Object?, Object?>>()
        .map(ScheduleWindowData.fromMap)
        .toList(growable: false),
    isAllowedNow: map['isAllowedNow'] != false,
    allowCalls: map['allowCalls'] == true,
    allowAlarms: map['allowAlarms'] == true,
    nextAllowedStartEpochMillis: map['nextAllowedStartEpochMillis'] as int?,
    temporaryAllowUntilEpochMillis:
        map['temporaryAllowUntilEpochMillis'] as int?,
  );

  AppRuleData toEditable() => AppRuleData(
    packageName: packageName,
    selected: selected,
    intervals: intervals,
    allowCalls: allowCalls,
    allowAlarms: allowAlarms,
    temporaryAllowUntilEpochMillis: temporaryAllowUntilEpochMillis,
  );
}

class ScheduleIntervalData {
  const ScheduleIntervalData({
    required this.dayIndex,
    required this.startMinute,
    required this.endMinute,
  });

  final int dayIndex;
  final int startMinute;
  final int endMinute;

  Map<String, int> toMap() => {
    'dayIndex': dayIndex,
    'startMinute': startMinute,
    'endMinute': endMinute,
  };

  factory ScheduleIntervalData.fromMap(Map<Object?, Object?> map) =>
      ScheduleIntervalData(
        dayIndex: map['dayIndex'] as int? ?? 0,
        startMinute: map['startMinute'] as int? ?? 0,
        endMinute: map['endMinute'] as int? ?? 0,
      );
}

class ScheduleWindowData {
  const ScheduleWindowData({
    required this.dayIndex,
    required this.startMinute,
    required this.endMinute,
  });

  final int dayIndex;
  final int startMinute;
  final int endMinute;

  factory ScheduleWindowData.fromMap(Map<Object?, Object?> map) =>
      ScheduleWindowData(
        dayIndex: map['dayIndex'] as int? ?? 0,
        startMinute: map['startMinute'] as int? ?? 0,
        endMinute: map['endMinute'] as int? ?? 0,
      );
}

class AppRuleData {
  const AppRuleData({
    required this.packageName,
    required this.selected,
    required this.intervals,
    this.allowCalls = false,
    this.allowAlarms = false,
    this.temporaryAllowUntilEpochMillis,
  });

  final String packageName;
  final bool selected;
  final List<ScheduleIntervalData> intervals;
  final bool allowCalls;
  final bool allowAlarms;
  final int? temporaryAllowUntilEpochMillis;
}

class InstalledApp {
  const InstalledApp({
    required this.packageName,
    required this.label,
    required this.isSystemApp,
    required this.hasLauncherActivity,
  });

  final String packageName;
  final String label;
  final bool isSystemApp;
  final bool hasLauncherActivity;

  factory InstalledApp.fromMap(Map<Object?, Object?> map) => InstalledApp(
    packageName: map['packageName'] as String? ?? '',
    label: map['label'] as String? ?? '',
    isSystemApp: map['isSystemApp'] == true,
    hasLauncherActivity: map['hasLauncherActivity'] == true,
  );
}

class BackupImportResult {
  const BackupImportResult({
    required this.missingPackages,
    required this.accessRequired,
    required this.batteryOptimizationRequired,
  });

  final List<String> missingPackages;
  final bool accessRequired;
  final bool batteryOptimizationRequired;
}
