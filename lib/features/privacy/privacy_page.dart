import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/theme/app_theme.dart';
import '../../core/update/release_update_service.dart';
import '../../core/ui/battery_requirement_card.dart';
import '../../core/ui/run_native_action.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({required this.controller, super.key});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final snapshot = controller.snapshot;
    final accentColor = Color(
      snapshot?.accentColor ?? killNotifyAccent.toARGB32(),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Card(
            child: ListTile(
              leading: Icon(
                snapshot?.accessGranted == true
                    ? Icons.check_circle_outline
                    : Icons.lock_outline,
              ),
              title: const Text('Acesso às notificações'),
              subtitle: Text(
                snapshot?.accessGranted == true
                    ? 'Concedido nas configurações do Android.'
                    : 'Necessário para filtrar notificações de outros apps.',
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () async {
                await runNativeAction<void>(
                  context,
                  controller.bridge.openNotificationAccessSettings,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          if (snapshot != null) ...[
            BatteryRequirementCard(controller: controller, snapshot: snapshot),
            const SizedBox(height: 10),
          ],
          const _PrivacyExplanationCard(),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.system_update_outlined),
                  title: const Text('Buscar atualizações automaticamente'),
                  subtitle: const Text(
                    'Consulta o GitHub no máximo uma vez por dia e avisa quando há uma nova versão.',
                  ),
                  value: controller.automaticUpdateChecks,
                  onChanged: controller.setAutomaticUpdateChecks,
                ),
                ListTile(
                  leading: const Icon(Icons.refresh),
                  title: const Text('Buscar atualização agora'),
                  onTap: () =>
                      checkForUpdates(context: context, controller: controller),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aparência',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: snapshot?.themeChoice ?? 'system',
                    decoration: const InputDecoration(labelText: 'Tema'),
                    items: const [
                      DropdownMenuItem(
                        value: 'system',
                        child: Text('Seguir sistema'),
                      ),
                      DropdownMenuItem(value: 'light', child: Text('Claro')),
                      DropdownMenuItem(value: 'dark', child: Text('Escuro')),
                      DropdownMenuItem(value: 'amoled', child: Text('AMOLED')),
                    ],
                    onChanged: (value) {
                      if (value != null) _setTheme(context, value);
                    },
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Cor de destaque',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final color in _accentColors)
                        Semantics(
                          label: 'Cor de destaque ${_hexColor(color)}',
                          selected: accentColor.toARGB32() == color.toARGB32(),
                          button: true,
                          child: InkWell(
                            onTap: () => _setAccentColor(context, color),
                            borderRadius: BorderRadius.circular(24),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: color,
                              child: accentColor.toARGB32() == color.toARGB32()
                                  ? Icon(
                                      Icons.check,
                                      color: AppTheme.readableForeground(color),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      OutlinedButton.icon(
                        onPressed: () =>
                            _pickCustomAccentColor(context, accentColor),
                        icon: const Icon(Icons.colorize_outlined),
                        label: const Text('Personalizada'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selecionada: ${_hexColor(accentColor)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text('Backup local', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          const Text(
            'O arquivo de configurações contém regras, exceções e preferências. '
            'Não contém conteúdo de notificações, mensagens ou ações.',
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () async {
              await runNativeAction<void>(
                context,
                controller.bridge.exportBackup,
              );
            },
            icon: const Icon(Icons.file_upload_outlined),
            label: const Text('Exportar configurações'),
          ),
          FilledButton.tonalIcon(
            onPressed: () => _confirmImport(context),
            icon: const Icon(Icons.file_download_outlined),
            label: const Text('Importar configurações'),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'O KillNotify não tem conta nem envia dados pela internet. '
                'O app é instalado manualmente e não é distribuído pela Play Store.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setTheme(BuildContext context, String choice) async {
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => controller.bridge.setThemeChoice(choice),
    );
    if (updated != null) await controller.refresh();
  }

  Future<void> _setAccentColor(BuildContext context, Color color) async {
    final updated = await runNativeAction<NativeSnapshot>(
      context,
      () => controller.bridge.setAccentColor(color.toARGB32()),
    );
    if (updated != null) await controller.refresh();
  }

  Future<void> _pickCustomAccentColor(
    BuildContext context,
    Color initialColor,
  ) async {
    final color = await showDialog<Color>(
      context: context,
      builder: (_) => _AccentColorPickerDialog(initialColor: initialColor),
    );
    if (color != null && context.mounted) {
      await _setAccentColor(context, color);
    }
  }

  Future<void> _confirmImport(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Importar backup?'),
        content: const Text(
          'A importação substitui as configurações atuais. O arquivo será validado antes de aplicar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Escolher arquivo'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final imported = await runNativeAction<BackupImportResult?>(
      context,
      controller.bridge.importBackup,
    );
    if (imported == null || !context.mounted) return;
    await controller.refresh();
    if (!context.mounted) return;
    final messages = <String>[];
    if (imported.missingPackages.isNotEmpty) {
      messages.add(
        'Alguns apps do backup não estão instalados: ${imported.missingPackages.join(', ')}. Os horários foram preservados.',
      );
    }
    if (imported.accessRequired) {
      messages.add(
        'O filtro foi importado desativado porque falta o acesso às notificações.',
      );
    }
    if (imported.batteryOptimizationRequired) {
      messages.add(
        'O filtro foi importado desativado porque falta permitir a atividade em segundo plano nas configurações de bateria.',
      );
    }
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Backup importado'),
        content: Text(
          messages.isEmpty
              ? 'As configurações foram validadas e aplicadas.'
              : messages.join('\n\n'),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _PrivacyExplanationCard extends StatelessWidget {
  const _PrivacyExplanationCard();

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'O que o acesso significa',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Esse acesso permite que o KillNotify decida se deve adiar cada notificação. '
            'O app não lê nem guarda títulos, textos, contatos ou ações, e não envia essas informações para fora do aparelho.',
          ),
          const SizedBox(height: 14),
          Text(
            'Visibilidade de apps instalados',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          const Text(
            'Para você poder escolher qualquer app instalado, o Android mostra ao KillNotify a lista de apps do aparelho. '
            'Ela é usada localmente e não é enviada para ninguém. Isso dá ao app acesso a mais informações sobre os apps instalados; '
            'por esse motivo, a distribuição é manual pelo GitHub, fora da Play Store.',
          ),
          const SizedBox(height: 14),
          Text(
            'Atualizações pelo GitHub',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          const Text(
            'Com a busca automática ligada, o KillNotify consulta a API pública de releases do GitHub no máximo uma vez por dia. O GitHub recebe metadados normais da conexão, como o endereço IP; regras, apps escolhidos e notificações não são enviados. A instalação continua dependendo da confirmação do Android.',
          ),
          const SizedBox(height: 14),
          const Text(
            'Chamadas e alarmes só podem ser liberados automaticamente quando o próprio app os identifica dessa forma. '
            'Códigos de verificação não têm identificação padronizada; o KillNotify não lê o conteúdo das mensagens para detectá-los.',
          ),
        ],
      ),
    ),
  );
}

class _AccentColorPickerDialog extends StatefulWidget {
  const _AccentColorPickerDialog({required this.initialColor});

  final Color initialColor;

  @override
  State<_AccentColorPickerDialog> createState() =>
      _AccentColorPickerDialogState();
}

class _AccentColorPickerDialogState extends State<_AccentColorPickerDialog> {
  late final TextEditingController _hexController;
  late int _red;
  late int _green;
  late int _blue;
  String? _hexError;

  Color get _color => Color.fromARGB(255, _red, _green, _blue);

  @override
  void initState() {
    super.initState();
    final argb = widget.initialColor.toARGB32();
    _red = (argb >> 16) & 0xFF;
    _green = (argb >> 8) & 0xFF;
    _blue = argb & 0xFF;
    _hexController = TextEditingController(
      text: _hexColor(_color).substring(1),
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Cor personalizada'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              _hexColor(_color),
              style: TextStyle(
                color: AppTheme.readableForeground(_color),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _hexController,
            maxLength: 6,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              labelText: 'Cor HEX',
              prefixText: '#',
              errorText: _hexError,
              counterText: '',
            ),
            onChanged: _onHexChanged,
          ),
          const SizedBox(height: 8),
          Text('Vermelho: $_red'),
          Slider(
            value: _red.toDouble(),
            min: 0,
            max: 255,
            divisions: 255,
            activeColor: Colors.red,
            onChanged: (value) => _updateChannel(red: value.round()),
          ),
          Text('Verde: $_green'),
          Slider(
            value: _green.toDouble(),
            min: 0,
            max: 255,
            divisions: 255,
            activeColor: Colors.green,
            onChanged: (value) => _updateChannel(green: value.round()),
          ),
          Text('Azul: $_blue'),
          Slider(
            value: _blue.toDouble(),
            min: 0,
            max: 255,
            divisions: 255,
            activeColor: Colors.blue,
            onChanged: (value) => _updateChannel(blue: value.round()),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
      FilledButton(onPressed: _apply, child: const Text('Aplicar')),
    ],
  );

  void _updateChannel({int? red, int? green, int? blue}) {
    setState(() {
      _red = red ?? _red;
      _green = green ?? _green;
      _blue = blue ?? _blue;
      _hexError = null;
      final text = _hexColor(_color).substring(1);
      _hexController.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }

  void _onHexChanged(String value) {
    final color = _parseHexColor(value);
    if (color == null) {
      setState(() => _hexError = null);
      return;
    }
    final argb = color.toARGB32();
    setState(() {
      _red = (argb >> 16) & 0xFF;
      _green = (argb >> 8) & 0xFF;
      _blue = argb & 0xFF;
      _hexError = null;
    });
  }

  void _apply() {
    if (_parseHexColor(_hexController.text) == null) {
      setState(() => _hexError = 'Informe 6 dígitos hexadecimais.');
      return;
    }
    Navigator.pop(context, _color);
  }
}

const _accentColors = <Color>[
  Color(0xFF4F46E5),
  Color(0xFF0F766E),
  Color(0xFFB45309),
  Color(0xFFBE123C),
  Color(0xFF7C3AED),
  Color(0xFF0369A1),
];

String _hexColor(Color color) =>
    '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

Color? _parseHexColor(String value) {
  final normalized = value.trim().replaceFirst('#', '');
  if (!RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(normalized)) return null;
  final rgb = int.tryParse(normalized, radix: 16);
  return rgb == null ? null : Color(0xFF000000 | rgb);
}
