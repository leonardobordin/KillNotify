import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/ui/battery_requirement_card.dart';
import '../../core/ui/formatters.dart';
import '../../core/ui/run_native_action.dart';
import '../../l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.controller,
    required this.onOpenApps,
    super.key,
  });

  final AppController controller;
  final VoidCallback onOpenApps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snapshot = controller.snapshot;
    return Scaffold(
      appBar: AppBar(
        title: const Text('KillNotify'),
        actions: [
          IconButton(
            tooltip: l10n.refreshStatus,
            onPressed: controller.refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            if (snapshot == null)
              _LoadingCard(error: controller.loadError)
            else ...[
              if (snapshot.state != 'needs_access' &&
                  snapshot.state != 'needs_battery_optimization') ...[
                _StatusCard(snapshot: snapshot),
                const SizedBox(height: 12),
              ],
              if (snapshot.state == 'configuration_error')
                const _StorageErrorCard(),
              if (!snapshot.accessGranted) ...[
                _NotificationAccessCard(controller: controller),
                const SizedBox(height: 12),
              ],
              if (!snapshot.batteryOptimizationExempt) ...[
                BatteryRequirementCard(
                  controller: controller,
                  snapshot: snapshot,
                ),
                const SizedBox(height: 12),
              ],
              _FilterControlCard(snapshot: snapshot, controller: controller),
              const SizedBox(height: 12),
              _NextWindowCard(snapshot: snapshot),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.notifications_active_outlined),
                  title: Text(l10n.notificationsReleasedToday),
                  trailing: Text(
                    '${snapshot.releasedCountToday}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(l10n.notificationCountPrivacy),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.apps),
                  title: Text(
                    l10n.configuredAppsCount(_configuredCount(snapshot)),
                  ),
                  subtitle: Text(l10n.eachAppHasOwnSchedule),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onOpenApps,
                ),
              ),
              const SizedBox(height: 12),
              const _LimitationCard(),
            ],
          ],
        ),
      ),
    );
  }

  int _configuredCount(NativeSnapshot snapshot) => snapshot.appRules
      .where((rule) => rule.selected && rule.intervals.isNotEmpty)
      .length;
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.snapshot});

  final NativeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (icon, title, subtitle, color) = switch (snapshot.state) {
      'active' => (
        Icons.verified_outlined,
        l10n.filterActive,
        l10n.filterActiveExplanation,
        Theme.of(context).colorScheme.primary,
      ),
      'waiting_for_listener' => (
        Icons.hourglass_top,
        l10n.filterInactive,
        l10n.listenerNotFollowing,
        Theme.of(context).colorScheme.tertiary,
      ),
      'needs_battery_optimization' => (
        Icons.battery_alert,
        l10n.batterySetupRequired,
        l10n.batterySetupExplanation,
        Theme.of(context).colorScheme.tertiary,
      ),
      'configuration_error' => (
        Icons.error_outline,
        l10n.schedulesUnavailable,
        l10n.schedulesUnavailableExplanation,
        Theme.of(context).colorScheme.error,
      ),
      _ => (
        Icons.pause_circle_outline,
        l10n.filterDisabled,
        l10n.notificationsArriveNormally,
        Theme.of(context).colorScheme.secondary,
      ),
    };
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationAccessCard extends StatelessWidget {
  const _NotificationAccessCard({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lock_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.accessNeeded,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.notificationAccessNeeded),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await runNativeAction<void>(
                context,
                controller.bridge.openNotificationAccessSettings,
              );
            },
            icon: const Icon(Icons.settings),
            label: Text(AppLocalizations.of(context)!.openAndroidSettings),
          ),
        ],
      ),
    ),
  );
}

class _FilterControlCard extends StatelessWidget {
  const _FilterControlCard({required this.controller, required this.snapshot});

  final AppController controller;
  final NativeSnapshot snapshot;

  @override
  Widget build(BuildContext context) => Card(
    child: SwitchListTile(
      title: Text(AppLocalizations.of(context)!.activateFilter),
      subtitle: Text(
        !snapshot.accessGranted && !snapshot.batteryOptimizationExempt
            ? AppLocalizations.of(context)!.filterNeedsBoth
            : !snapshot.accessGranted
            ? AppLocalizations.of(context)!.filterNeedsAccess
            : !snapshot.batteryOptimizationExempt
            ? AppLocalizations.of(context)!.filterNeedsBattery
            : AppLocalizations.of(context)!.filterAppliesSchedules,
      ),
      value: snapshot.filterEnabled,
      onChanged: !snapshot.accessGranted || !snapshot.batteryOptimizationExempt
          ? null
          : (value) => _toggleFilter(context, value),
    ),
  );

  Future<void> _toggleFilter(BuildContext context, bool value) async {
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => controller.bridge.setFilterEnabled(value),
    );
    if (updated != null) await controller.refresh();
  }
}

class _StorageErrorCard extends StatelessWidget {
  const _StorageErrorCard();

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.errorContainer,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text(AppLocalizations.of(context)!.restoreBackupForSchedules),
    ),
  );
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (error == null)
            const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            const Icon(Icons.error_outline),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              error == null
                  ? AppLocalizations.of(context)!.checkingFilter
                  : AppLocalizations.of(context)!.cannotCheckFilter,
            ),
          ),
        ],
      ),
    ),
  );
}

class _NextWindowCard extends StatelessWidget {
  const _NextWindowCard({required this.snapshot});

  final NativeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeName = Localizations.localeOf(context).toString();
    final epoch = snapshot.nextAllowedStartEpochMillis;
    final hasConfiguredRules = snapshot.appRules.any(
      (rule) => rule.selected && rule.intervals.isNotEmpty,
    );
    final title = epoch != null
        ? snapshot.filterActive
              ? l10n.nextAllowedStart
              : l10n.nextConfiguredWindow
        : hasConfiguredRules
        ? l10n.noAppWaiting
        : l10n.noSchedulesYet;
    final detail = epoch != null
        ? '${formatLocalDateTime(epoch, localeName: localeName)}'
              '${snapshot.filterActive ? '' : '\n${l10n.filterInactiveInformative}'}'
        : hasConfiguredRules
        ? l10n.timezoneInfo
        : l10n.chooseAppsAndPeriods;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.event_available_outlined),
        title: Text(title),
        subtitle: Text(detail),
        isThreeLine: epoch != null,
      ),
    );
  }
}

class _LimitationCard extends StatelessWidget {
  const _LimitationCard();

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        AppLocalizations.of(context)!.androidControlsSnooze,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}
