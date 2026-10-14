import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/native/native_bridge.dart';

class AppController extends ChangeNotifier with WidgetsBindingObserver {
  AppController({NativeBridge? bridge}) : bridge = bridge ?? NativeBridge() {
    WidgetsBinding.instance.addObserver(this);
    refresh();
    loadUpdatePreferences();
  }

  static const _automaticUpdatesKey = 'github_automatic_update_checks';
  static const _lastUpdateCheckKey = 'github_last_update_check_ms';
  static const _updateSnoozedUntilKey = 'github_update_snoozed_until_ms';
  static const updateCheckInterval = Duration(hours: 24);

  final NativeBridge bridge;
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  NativeSnapshot? snapshot;
  Object? loadError;
  bool loading = true;
  bool automaticUpdateChecks = true;
  DateTime? _lastUpdateCheckAt;
  DateTime? _updateSnoozedUntil;
  Future<void>? _updatePreferencesLoad;

  bool get shouldCheckForUpdatesAutomatically {
    if (!automaticUpdateChecks) return false;
    final now = DateTime.now();
    final snoozedUntil = _updateSnoozedUntil;
    if (snoozedUntil != null && now.isBefore(snoozedUntil)) return false;
    final lastCheck = _lastUpdateCheckAt;
    return lastCheck == null ||
        now.difference(lastCheck) >= updateCheckInterval;
  }

  Future<void> loadUpdatePreferences() =>
      _updatePreferencesLoad ??= _loadUpdatePreferences();

  Future<void> _loadUpdatePreferences() async {
    try {
      automaticUpdateChecks =
          await _preferences.getBool(_automaticUpdatesKey) ?? true;
      final lastCheckMillis = await _preferences.getInt(_lastUpdateCheckKey);
      final snoozedUntilMillis = await _preferences.getInt(
        _updateSnoozedUntilKey,
      );
      _lastUpdateCheckAt = lastCheckMillis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(lastCheckMillis);
      _updateSnoozedUntil = snoozedUntilMillis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(snoozedUntilMillis);
    } on Object {
      // Update checks are optional and must not block the notification filter.
    }
    notifyListeners();
  }

  Future<void> setAutomaticUpdateChecks(bool enabled) async {
    await loadUpdatePreferences();
    automaticUpdateChecks = enabled;
    if (enabled) {
      _lastUpdateCheckAt = null;
      _updateSnoozedUntil = null;
      try {
        await _preferences.remove(_lastUpdateCheckKey);
        await _preferences.remove(_updateSnoozedUntilKey);
      } on Object {
        // The next launch can still retry if local preferences are unavailable.
      }
    }
    notifyListeners();
    try {
      await _preferences.setBool(_automaticUpdatesKey, enabled);
    } on Object {
      // Keep the current choice in memory for this app session.
    }
  }

  Future<void> markUpdateCheck() async {
    await loadUpdatePreferences();
    _lastUpdateCheckAt = DateTime.now();
    notifyListeners();
    try {
      await _preferences.setInt(
        _lastUpdateCheckKey,
        _lastUpdateCheckAt!.millisecondsSinceEpoch,
      );
    } on Object {
      // A failed write must not block the app from opening.
    }
  }

  Future<void> snoozeUpdateChecks({
    Duration duration = const Duration(days: 1),
  }) async {
    await loadUpdatePreferences();
    _updateSnoozedUntil = DateTime.now().add(duration);
    notifyListeners();
    try {
      await _preferences.setInt(
        _updateSnoozedUntilKey,
        _updateSnoozedUntil!.millisecondsSinceEpoch,
      );
    } on Object {
      // A failed write must not block the app from opening.
    }
  }

  Future<void> refresh() async {
    loading = snapshot == null;
    notifyListeners();
    try {
      snapshot = await bridge.getSnapshot();
      loadError = null;
    } catch (error) {
      loadError = error;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
