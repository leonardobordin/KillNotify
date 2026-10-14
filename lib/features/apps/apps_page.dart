import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/ui/run_native_action.dart';
import 'app_rule_page.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({required this.controller, super.key});

  final AppController controller;

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  final _searchController = TextEditingController();
  List<InstalledApp> _apps = const [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadApps() async {
    setState(() => _loading = true);
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
    final snapshot = widget.controller.snapshot;
    final rules = snapshot?.rulesByPackage ?? const <String, AppRuleView>{};
    final filtered = _apps.where((app) {
      final query = _query.trim().toLowerCase();
      return query.isEmpty ||
          app.label.toLowerCase().contains(query) ||
          app.packageName.toLowerCase().contains(query);
    }).toList();
    filtered.sort((left, right) {
      final leftSelected = rules[left.packageName]?.selected == true;
      final rightSelected = rules[right.packageName]?.selected == true;
      if (leftSelected != rightSelected) return leftSelected ? -1 : 1;
      final labelOrder = left.label.toLowerCase().compareTo(
        right.label.toLowerCase(),
      );
      return labelOrder != 0
          ? labelOrder
          : left.packageName.compareTo(right.packageName);
    });
    final installedPackages = _apps.map((app) => app.packageName).toSet();
    final missingRules = (snapshot?.appRules ?? const <AppRuleView>[])
        .where((rule) => !installedPackages.contains(rule.packageName))
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicativos'),
        actions: [
          IconButton(
            tooltip: 'Atualizar lista',
            onPressed: _loadApps,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loading && _apps.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: 'Buscar aplicativo',
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpar busca',
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.close),
                          ),
                  ),
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 12),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Text(
                      'A lista também inclui apps do sistema e apps sem ícone na tela inicial. '
                      'O Android pode não permitir filtrar notificações de perfis de trabalho '
                      'ou de alguns serviços.',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text('Nenhum app corresponde à busca.'),
                    ),
                  )
                else
                  ...filtered.map((app) {
                    final rule = rules[app.packageName];
                    final selected = rule?.selected ?? false;
                    final intervalCount = rule?.intervals.length ?? 0;
                    final details = <String>[
                      if (app.isSystemApp) 'App do sistema',
                      if (!app.hasLauncherActivity) 'Sem ícone na tela inicial',
                      if (intervalCount > 0)
                        '$intervalCount ${intervalCount == 1 ? 'período' : 'períodos'} definidos',
                    ];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(child: Text(_initial(app.label))),
                        title: Text(
                          app.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: details.isEmpty
                            ? null
                            : Text(
                                details.join(' · '),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                        trailing: Switch(
                          value: selected,
                          onChanged: (value) => _toggleApp(app, rule, value),
                        ),
                        onTap: () => _openRuleEditor(app, rule),
                      ),
                    );
                  }),
                if (missingRules.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Apps não instalados',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Os horários foram preservados e voltam a valer se o app for instalado novamente.',
                  ),
                  const SizedBox(height: 8),
                  ...missingRules.map(
                    (rule) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.warning_amber_outlined),
                        title: const Text('App não encontrado'),
                        subtitle: Text(
                          'Identificador: ${rule.packageName}. Os horários serão mantidos se o app voltar a ser instalado.',
                        ),
                        trailing: IconButton(
                          tooltip: 'Remover regra',
                          onPressed: () => _removeRule(rule.packageName),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Future<void> _toggleApp(
    InstalledApp app,
    AppRuleView? existing,
    bool selected,
  ) async {
    final rule =
        existing?.toEditable() ??
        AppRuleData(
          packageName: app.packageName,
          selected: selected,
          intervals: const [],
        );
    final saved = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.saveAppRule(
        AppRuleData(
          packageName: app.packageName,
          selected: selected,
          intervals: rule.intervals,
          allowCalls: rule.allowCalls,
          allowAlarms: rule.allowAlarms,
          temporaryAllowUntilEpochMillis: rule.temporaryAllowUntilEpochMillis,
        ),
      ),
    );
    if (saved != null) await widget.controller.refresh();
  }

  Future<void> _openRuleEditor(InstalledApp app, AppRuleView? rule) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => AppRulePage(
          app: app,
          initialRule: rule,
          controller: widget.controller,
        ),
      ),
    );
    await widget.controller.refresh();
  }

  Future<void> _removeRule(String packageName) async {
    final removed = await runNativeAction<NativeSnapshot>(
      context,
      () => widget.controller.bridge.removeAppRule(packageName),
    );
    if (removed != null) await widget.controller.refresh();
  }

  String _initial(String label) => label.trim().isEmpty
      ? '?'
      : String.fromCharCode(label.trim().runes.first).toUpperCase();
}
