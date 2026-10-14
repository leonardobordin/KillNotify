import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/ui/formatters.dart';
import '../../core/ui/run_native_action.dart';

class ExceptionsPage extends StatefulWidget {
  const ExceptionsPage({required this.controller, super.key});

  final AppController controller;

  @override
  State<ExceptionsPage> createState() => _ExceptionsPageState();
}

class _ExceptionsPageState extends State<ExceptionsPage> {
  List<InstalledApp> _apps = const [];
  final Set<String> _selectedPackages = {};
  String _query = '';
  Duration _duration = const Duration(hours: 4);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  Future<void> _loadApps() async {
    final apps = await runNativeAction<List<InstalledApp>>(
      context,
      widget.controller.bridge.listApps,
    );
    if (!mounted) return;
    setState(() {
      _apps = apps ?? const [];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleApps = _apps
        .where((app) {
          final query = _query.toLowerCase().trim();
          return query.isEmpty ||
              app.label.toLowerCase().contains(query) ||
              app.packageName.toLowerCase().contains(query);
        })
        .toList(growable: false);
    final snapshot = widget.controller.snapshot;
    final appLabels = {for (final app in _apps) app.packageName: app.label};
    final active = (snapshot?.appRules ?? const <AppRuleView>[])
        .where((rule) {
          final until = rule.temporaryAllowUntilEpochMillis;
          return until != null && until > DateTime.now().millisecondsSinceEpoch;
        })
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Exceções temporárias')),
      body: _loading && _apps.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Permita notificações temporariamente para um ou vários apps. '
                      'Essa permissão termina no horário escolhido, conforme o relógio do aparelho.',
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text('Duração', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final option in const [
                      (Duration(hours: 1), '1 hora'),
                      (Duration(hours: 4), '4 horas'),
                      (Duration(hours: 8), '8 horas'),
                      (Duration(days: 1), '24 horas'),
                    ])
                      ChoiceChip(
                        label: Text(option.$2),
                        selected: _duration == option.$1,
                        onSelected: (_) =>
                            setState(() => _duration = option.$1),
                      ),
                    ActionChip(
                      avatar: const Icon(
                        Icons.edit_calendar_outlined,
                        size: 18,
                      ),
                      label: const Text('Escolher horário'),
                      onPressed: _chooseCustomEnd,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Buscar apps',
                  ),
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${_selectedPackages.length} selecionados',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() {
                        for (final app in visibleApps) {
                          _selectedPackages.add(app.packageName);
                        }
                      }),
                      child: const Text('Selecionar resultados'),
                    ),
                    TextButton(
                      onPressed: () => setState(_selectedPackages.clear),
                      child: const Text('Limpar'),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 360),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: visibleApps.length,
                    itemBuilder: (context, index) {
                      final app = visibleApps[index];
                      return CheckboxListTile(
                        dense: true,
                        value: _selectedPackages.contains(app.packageName),
                        title: Text(
                          app.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: app.isSystemApp
                            ? const Text('App do sistema')
                            : !app.hasLauncherActivity
                            ? const Text('Sem ícone na tela inicial')
                            : null,
                        onChanged: (selected) => setState(() {
                          if (selected == true) {
                            _selectedPackages.add(app.packageName);
                          } else {
                            _selectedPackages.remove(app.packageName);
                          }
                        }),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _selectedPackages.isEmpty ? null : _applyException,
                  icon: const Icon(Icons.notifications_active_outlined),
                  label: Text(
                    'Permitir ${_selectedPackages.length} apps temporariamente',
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Permissões temporárias ativas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (active.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Nenhuma exceção temporária ativa.'),
                    ),
                  )
                else
                  ...active.map((rule) {
                    final until = rule.temporaryAllowUntilEpochMillis!;
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.timer_outlined),
                        title: Text(
                          appLabels[rule.packageName] ?? 'App não encontrado',
                        ),
                        subtitle: Text(
                          appLabels.containsKey(rule.packageName)
                              ? 'Até ${formatLocalDateTime(until)}'
                              : 'Até ${formatLocalDateTime(until)} · Identificador: ${rule.packageName}',
                        ),
                        trailing: IconButton(
                          tooltip: 'Encerrar exceção',
                          onPressed: () => _clearException(rule.packageName),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    );
                  }),
              ],
            ),
    );
  }

  Future<void> _chooseCustomEnd() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (!mounted || date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
    );
    if (!mounted || time == null) return;
    final end = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    final duration = end.difference(DateTime.now());
    if (duration <= Duration.zero) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escolha um horário futuro.')),
      );
      return;
    }
    setState(() => _duration = duration);
  }

  Future<void> _applyException() async {
    final packages = _selectedPackages.toList(growable: false);
    final until = DateTime.now().add(_duration).millisecondsSinceEpoch;
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.setTemporaryException(
        packageNames: packages,
        untilEpochMillis: until,
      ),
    );
    if (updated != null && mounted) {
      setState(_selectedPackages.clear);
      await widget.controller.refresh();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exceção aplicada a ${packages.length} apps.')),
      );
    }
  }

  Future<void> _clearException(String packageName) async {
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.setTemporaryException(
        packageNames: [packageName],
        untilEpochMillis: null,
      ),
    );
    if (updated != null) await widget.controller.refresh();
  }
}
