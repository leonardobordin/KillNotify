import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/ui/formatters.dart';
import '../../core/ui/run_native_action.dart';
import '../../l10n/app_localizations.dart';

class AppRulePage extends StatefulWidget {
  const AppRulePage({
    required this.app,
    required this.initialRule,
    required this.controller,
    super.key,
  });

  final InstalledApp app;
  final AppRuleView? initialRule;
  final AppController controller;

  @override
  State<AppRulePage> createState() => _AppRulePageState();
}

class _AppRulePageState extends State<AppRulePage> {
  late bool _selected;
  late bool _allowCalls;
  late bool _allowAlarms;
  late List<_WeeklyPeriodDraft> _periods;
  late List<ScheduleWindowData> _effectiveWindows;
  int? _temporaryUntil;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final rule = widget.initialRule;
    _selected = rule?.selected ?? true;
    _allowCalls = rule?.allowCalls ?? false;
    _allowAlarms = rule?.allowAlarms ?? false;
    _periods = _periodsFromIntervals(
      rule?.intervals ?? const <ScheduleIntervalData>[],
    );
    _effectiveWindows = [...?rule?.effectiveWindows];
    _temporaryUntil = rule?.temporaryAllowUntilEpochMillis;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.app.label)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Card(
            child: SwitchListTile(
              title: Text(l10n.applySchedulesToApp),
              subtitle: Text(l10n.noSchedulesAllowNormally),
              value: _selected,
              onChanged: (value) => setState(() => _selected = value),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.weeklyPeriods,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton.filledTonal(
                tooltip: l10n.addPeriod,
                onPressed: _addPeriod,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_periods.isEmpty)
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(l10n.noPeriodsForApp),
              ),
            )
          else
            ..._periods.asMap().entries.map((entry) {
              final index = entry.key;
              final period = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.schedule),
                  title: Text(_periodLabel(period)),
                  subtitle: period.startMinute == period.endMinute
                      ? Text(l10n.period24HoursHint)
                      : null,
                  trailing: IconButton(
                    tooltip: l10n.removePeriod,
                    onPressed: () => setState(() => _periods.removeAt(index)),
                    icon: const Icon(Icons.delete_outline),
                  ),
                  onTap: () => _editPeriod(index),
                ),
              );
            }),
          const SizedBox(height: 12),
          _EffectiveWindowsCard(
            windows: _effectiveWindows,
            hasDraftIntervals: _periods.isNotEmpty,
          ),
          const SizedBox(height: 16),
          Text(l10n.exceptions, style: Theme.of(context).textTheme.titleLarge),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.allowCallNotifications),
                  subtitle: Text(l10n.callsCategoryOnly),
                  value: _allowCalls,
                  onChanged: (value) => setState(() => _allowCalls = value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: Text(l10n.allowAlarmNotifications),
                  subtitle: Text(l10n.alarmsCategoryOnly),
                  value: _allowAlarms,
                  onChanged: (value) => setState(() => _allowAlarms = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _TemporaryExceptionCard(
            untilEpochMillis: _temporaryUntil,
            onSet: _setTemporaryException,
            onClear: _clearTemporaryException,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(l10n.saveSchedules),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final saved = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.saveAppRule(
        AppRuleData(
          packageName: widget.app.packageName,
          selected: _selected,
          intervals: _periods
              .expand((period) => period.toIntervals())
              .toList(growable: false),
          allowCalls: _allowCalls,
          allowAlarms: _allowAlarms,
          temporaryAllowUntilEpochMillis: _temporaryUntil,
        ),
      ),
    );
    if (!mounted) return;
    setState(() {
      _saving = false;
      if (saved != null) {
        _effectiveWindows =
            saved.rulesByPackage[widget.app.packageName]?.effectiveWindows ??
            const [];
      }
    });
    if (saved != null) {
      await widget.controller.refresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.schedulesSaved)),
        );
      }
    }
  }

  Future<void> _addPeriod() async {
    final period = await _showPeriodDialog();
    if (period != null) setState(() => _periods.add(period));
  }

  Future<void> _editPeriod(int index) async {
    final period = await _showPeriodDialog(initial: _periods[index]);
    if (period != null) setState(() => _periods[index] = period);
  }

  Future<_WeeklyPeriodDraft?> _showPeriodDialog({
    _WeeklyPeriodDraft? initial,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final weekdays = _weekdays(context);
    final selectedDays = Set<int>.from(initial?.dayIndexes ?? const {0});
    var start = _timeOf(initial?.startMinute ?? 9 * 60);
    var end = _timeOf(initial?.endMinute ?? 17 * 60);
    return showDialog<_WeeklyPeriodDraft>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(initial == null ? l10n.newPeriod : l10n.editPeriod),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.allowedDays,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final day in weekdays)
                      Expanded(
                        child: Tooltip(
                          message: day.fullName,
                          child: Semantics(
                            label: day.fullName,
                            selected: selectedDays.contains(day.dayIndex),
                            button: true,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                setDialogState(() {
                                  if (selectedDays.contains(day.dayIndex)) {
                                    selectedDays.remove(day.dayIndex);
                                  } else {
                                    selectedDays.add(day.dayIndex);
                                  }
                                });
                              },
                              child: SizedBox(
                                height: 48,
                                child: Center(
                                  child: AnimatedContainer(
                                    duration: kThemeAnimationDuration,
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedDays.contains(day.dayIndex)
                                          ? Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                          : Colors.transparent,
                                      border: Border.all(
                                        color:
                                            selectedDays.contains(day.dayIndex)
                                            ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                            : Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        day.initial,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (selectedDays.isEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    l10n.selectAtLeastOneDay,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: start,
                    );
                    if (picked != null) setDialogState(() => start = picked);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.startTime,
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    child: Text(start.format(context)),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: end,
                    );
                    if (picked != null) setDialogState(() => end = picked);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.endTime,
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    child: Text(end.format(context)),
                  ),
                ),
                const SizedBox(height: 14),
                Text(l10n.periodMayCrossMidnight),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: selectedDays.isEmpty
                  ? null
                  : () => Navigator.pop(
                      dialogContext,
                      _WeeklyPeriodDraft(
                        dayIndexes: selectedDays,
                        startMinute: start.hour * 60 + start.minute,
                        endMinute: end.hour * 60 + end.minute,
                      ),
                    ),
              child: Text(initial == null ? l10n.add : l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  List<_WeeklyPeriodDraft> _periodsFromIntervals(
    List<ScheduleIntervalData> intervals,
  ) {
    final periods = <_WeeklyPeriodDraft>[];
    for (final interval in intervals) {
      final previous = periods.isEmpty ? null : periods.last;
      if (previous != null &&
          previous.startMinute == interval.startMinute &&
          previous.endMinute == interval.endMinute &&
          !previous.dayIndexes.contains(interval.dayIndex)) {
        previous.dayIndexes.add(interval.dayIndex);
      } else {
        periods.add(
          _WeeklyPeriodDraft(
            dayIndexes: {interval.dayIndex},
            startMinute: interval.startMinute,
            endMinute: interval.endMinute,
          ),
        );
      }
    }
    return periods;
  }

  String _periodLabel(_WeeklyPeriodDraft period) {
    final localeName = Localizations.localeOf(context).toString();
    final days = _weekdays(context)
        .where((day) => period.dayIndexes.contains(day.dayIndex))
        .map((day) => formatDay(day.dayIndex, localeName: localeName))
        .join(', ');
    return '$days · ${formatMinute(period.startMinute)}–${formatMinute(period.endMinute)}';
  }

  Future<void> _setTemporaryException(Duration duration) async {
    final until = DateTime.now().add(duration).millisecondsSinceEpoch;
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.setTemporaryException(
        packageNames: [widget.app.packageName],
        untilEpochMillis: until,
      ),
    );
    if (updated != null && mounted) {
      setState(() => _temporaryUntil = until);
      await widget.controller.refresh();
    }
  }

  Future<void> _clearTemporaryException() async {
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.setTemporaryException(
        packageNames: [widget.app.packageName],
        untilEpochMillis: null,
      ),
    );
    if (updated != null && mounted) {
      setState(() => _temporaryUntil = null);
      await widget.controller.refresh();
    }
  }

  TimeOfDay _timeOf(int minute) =>
      TimeOfDay(hour: minute ~/ 60, minute: minute % 60);
}

class _WeeklyPeriodDraft {
  _WeeklyPeriodDraft({
    required this.dayIndexes,
    required this.startMinute,
    required this.endMinute,
  });

  final Set<int> dayIndexes;
  final int startMinute;
  final int endMinute;

  List<ScheduleIntervalData> toIntervals() {
    final orderedDays = dayIndexes.toList()..sort();
    return orderedDays
        .map(
          (dayIndex) => ScheduleIntervalData(
            dayIndex: dayIndex,
            startMinute: startMinute,
            endMinute: endMinute,
          ),
        )
        .toList(growable: false);
  }
}

class _WeekdayOption {
  const _WeekdayOption(this.dayIndex, this.initial, this.fullName);

  final int dayIndex;
  final String initial;
  final String fullName;
}

List<_WeekdayOption> _weekdays(BuildContext context) {
  final localeName = Localizations.localeOf(context).toString();
  const sundayFirstIndexes = [6, 0, 1, 2, 3, 4, 5];
  return [
    for (final index in sundayFirstIndexes) _weekdayOption(index, localeName),
  ];
}

_WeekdayOption _weekdayOption(int dayIndex, String localeName) {
  final dayName = DateFormat.EEEE(localeName)
      .format(DateTime(2024, 1, dayIndex + 1));
  final runes = dayName.runes.toList(growable: false);
  final initial = localeName.startsWith('zh') ? runes.last : runes.first;
  return _WeekdayOption(
    dayIndex,
    String.fromCharCode(initial).toUpperCase(),
    dayName,
  );
}

class _EffectiveWindowsCard extends StatelessWidget {
  const _EffectiveWindowsCard({
    required this.windows,
    required this.hasDraftIntervals,
  });

  final List<ScheduleWindowData> windows;
  final bool hasDraftIntervals;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeName = Localizations.localeOf(context).toString();
    final grouped = <int, List<ScheduleWindowData>>{};
    for (final window in windows) {
      grouped.putIfAbsent(window.dayIndex, () => []).add(window);
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.effectiveSchedule,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(l10n.overlappingPeriodsGrouped),
            const SizedBox(height: 10),
            if (windows.isEmpty)
              Text(
                hasDraftIntervals
                    ? l10n.saveToPreviewPeriods
                    : l10n.noSchedulesNotificationsPass,
              )
            else
              ...grouped.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '${formatDay(entry.key, localeName: localeName)}  ${entry.value.map((window) => '${formatMinute(window.startMinute)}–${formatMinute(window.endMinute)}').join(', ')}',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TemporaryExceptionCard extends StatelessWidget {
  const _TemporaryExceptionCard({
    required this.untilEpochMillis,
    required this.onSet,
    required this.onClear,
  });

  final int? untilEpochMillis;
  final ValueChanged<Duration> onSet;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeName = Localizations.localeOf(context).toString();
    final until = untilEpochMillis;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.temporaryException,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              until != null && until > DateTime.now().millisecondsSinceEpoch
                  ? l10n.allowUntil(
                      formatLocalDateTime(until, localeName: localeName),
                    )
                  : l10n.noActiveExceptionForApp,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in [
                  (Duration(hours: 1), l10n.oneHour),
                  (Duration(hours: 4), l10n.fourHours),
                  (Duration(hours: 8), l10n.eightHours),
                  (Duration(days: 1), l10n.twentyFourHours),
                ])
                  OutlinedButton(
                    onPressed: () => onSet(option.$1),
                    child: Text(option.$2),
                  ),
                if (until != null)
                  TextButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.close),
                    label: Text(l10n.remove),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
