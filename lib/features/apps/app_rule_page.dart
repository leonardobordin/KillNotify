import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/ui/formatters.dart';
import '../../core/ui/run_native_action.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(widget.app.label)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text('Aplicar horários a este app'),
              subtitle: const Text(
                'Sem horários definidos, as notificações chegam normalmente.',
              ),
              value: _selected,
              onChanged: (value) => setState(() => _selected = value),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Períodos semanais',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton.filledTonal(
                tooltip: 'Adicionar período',
                onPressed: _addPeriod,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_periods.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Ainda não há horários. As notificações deste app chegam normalmente.',
                ),
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
                      ? const Text(
                          'Se início e fim forem iguais, o período dura 24 horas.',
                        )
                      : null,
                  trailing: IconButton(
                    tooltip: 'Remover período',
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
          Text('Exceções', style: Theme.of(context).textTheme.titleLarge),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Permitir notificações de chamadas'),
                  subtitle: const Text(
                    'Só quando o app que enviou a notificação informa que é uma chamada.',
                  ),
                  value: _allowCalls,
                  onChanged: (value) => setState(() => _allowCalls = value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Permitir notificações de alarmes'),
                  subtitle: const Text(
                    'Só quando o app que enviou a notificação informa que é um alarme.',
                  ),
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
            label: const Text('Salvar horários'),
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
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Horários salvos.')));
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
    final selectedDays = Set<int>.from(initial?.dayIndexes ?? const {0});
    var start = _timeOf(initial?.startMinute ?? 9 * 60);
    var end = _timeOf(initial?.endMinute ?? 17 * 60);
    return showDialog<_WeeklyPeriodDraft>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(initial == null ? 'Novo período' : 'Editar período'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dias em que as notificações podem chegar',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (final day in _weekdaysSundayFirst)
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
                    'Selecione pelo menos um dia.',
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
                    decoration: const InputDecoration(
                      labelText: 'Início',
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
                    decoration: const InputDecoration(
                      labelText: 'Fim',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    child: Text(end.format(context)),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'O período pode terminar no dia seguinte. Se início e fim forem iguais, ele dura 24 horas.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
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
              child: Text(initial == null ? 'Adicionar' : 'Salvar'),
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
    final days = _weekdaysSundayFirst
        .where((day) => period.dayIndexes.contains(day.dayIndex))
        .map((day) => formatDay(day.dayIndex))
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

const _weekdaysSundayFirst = [
  _WeekdayOption(6, 'D', 'Domingo'),
  _WeekdayOption(0, 'S', 'Segunda-feira'),
  _WeekdayOption(1, 'T', 'Terça-feira'),
  _WeekdayOption(2, 'Q', 'Quarta-feira'),
  _WeekdayOption(3, 'Q', 'Quinta-feira'),
  _WeekdayOption(4, 'S', 'Sexta-feira'),
  _WeekdayOption(5, 'S', 'Sábado'),
];

class _EffectiveWindowsCard extends StatelessWidget {
  const _EffectiveWindowsCard({
    required this.windows,
    required this.hasDraftIntervals,
  });

  final List<ScheduleWindowData> windows;
  final bool hasDraftIntervals;

  @override
  Widget build(BuildContext context) {
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
              'Horários usados pelo filtro',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            const Text(
              'Períodos que se sobrepõem ou se encostam são agrupados. Os horários que você configurou continuam salvos.',
            ),
            const SizedBox(height: 10),
            if (windows.isEmpty)
              Text(
                hasDraftIntervals
                    ? 'Salve para conferir como os períodos serão agrupados.'
                    : 'Sem horários definidos, as notificações chegam normalmente.',
              )
            else
              ...grouped.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '${formatDay(entry.key)}  ${entry.value.map((window) => '${formatMinute(window.startMinute)}–${formatMinute(window.endMinute)}').join(', ')}',
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
    final until = untilEpochMillis;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exceção temporária',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              until != null && until > DateTime.now().millisecondsSinceEpoch
                  ? 'Permitir até ${formatLocalDateTime(until)}'
                  : 'Sem exceção ativa para este app.',
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in const [
                  (Duration(hours: 1), '1 hora'),
                  (Duration(hours: 4), '4 horas'),
                  (Duration(hours: 8), '8 horas'),
                  (Duration(days: 1), '24 horas'),
                ])
                  OutlinedButton(
                    onPressed: () => onSet(option.$1),
                    child: Text(option.$2),
                  ),
                if (until != null)
                  TextButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.close),
                    label: const Text('Remover'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
