import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/theme/app_theme.dart';
import '../../core/update/release_update_service.dart';
import '../../core/ui/battery_requirement_card.dart';
import '../../core/ui/run_native_action.dart';
import '../../l10n/app_localizations.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({required this.controller, super.key});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snapshot = controller.snapshot;
    final accentColor = Color(
      snapshot?.accentColor ?? killNotifyAccent.toARGB32(),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabSettings)),
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
              title: Text(l10n.notificationAccess),
              subtitle: Text(
                snapshot?.accessGranted == true
                    ? l10n.accessGrantedInAndroid
                    : l10n.accessRequiredToFilter,
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
                  title: Text(l10n.automaticUpdates),
                  subtitle: Text(l10n.automaticUpdatesHint),
                  value: controller.automaticUpdateChecks,
                  onChanged: controller.setAutomaticUpdateChecks,
                ),
                ListTile(
                  leading: const Icon(Icons.refresh),
                  title: Text(l10n.checkForUpdateNow),
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
                    l10n.appearance,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    key: ValueKey('language-${controller.languageChoice}'),
                    initialValue: controller.languageChoice,
                    decoration: InputDecoration(labelText: l10n.language),
                    items: [
                      DropdownMenuItem(
                        value: 'system',
                        child: Text(l10n.systemLanguage),
                      ),
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(l10n.languageEnglish),
                      ),
                      DropdownMenuItem(
                        value: 'pt_BR',
                        child: Text(l10n.languagePortugueseBrazil),
                      ),
                      DropdownMenuItem(
                        value: 'es',
                        child: Text(l10n.languageSpanish),
                      ),
                      DropdownMenuItem(
                        value: 'fr',
                        child: Text(l10n.languageFrench),
                      ),
                      DropdownMenuItem(
                        value: 'de',
                        child: Text(l10n.languageGerman),
                      ),
                      DropdownMenuItem(
                        value: 'it',
                        child: Text(l10n.languageItalian),
                      ),
                      DropdownMenuItem(
                        value: 'ja',
                        child: Text(l10n.languageJapanese),
                      ),
                      DropdownMenuItem(
                        value: 'zh_CN',
                        child: Text(l10n.languageChineseSimplified),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) controller.setLanguageChoice(value);
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: snapshot?.themeChoice ?? 'system',
                    decoration: InputDecoration(labelText: l10n.theme),
                    items: [
                      DropdownMenuItem(
                        value: 'system',
                        child: Text(l10n.followSystem),
                      ),
                      DropdownMenuItem(
                        value: 'light',
                        child: Text(l10n.lightTheme),
                      ),
                      DropdownMenuItem(
                        value: 'dark',
                        child: Text(l10n.darkTheme),
                      ),
                      DropdownMenuItem(
                        value: 'amoled',
                        child: Text(l10n.amoledTheme),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) _setTheme(context, value);
                    },
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.accentColor,
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
                          label: '${l10n.accentColor} ${_hexColor(color)}',
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
                        label: Text(l10n.customColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.selectedColor(_hexColor(accentColor)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(l10n.localBackup, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(l10n.backupDescription),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () async {
              await runNativeAction<void>(
                context,
                controller.bridge.exportBackup,
              );
            },
            icon: const Icon(Icons.file_upload_outlined),
            label: Text(l10n.exportSettings),
          ),
          FilledButton.tonalIcon(
            onPressed: () => _confirmImport(context),
            icon: const Icon(Icons.file_download_outlined),
            label: Text(l10n.importSettings),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.noAccountPrivacy),
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
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.importBackupTitle),
        content: Text(l10n.importBackupWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.chooseBackupFile),
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
      messages.add(l10n.backupMissingApps(imported.missingPackages.join(', ')));
    }
    if (imported.accessRequired) {
      messages.add(l10n.importedWithoutNotificationAccess);
    }
    if (imported.batteryOptimizationRequired) {
      messages.add(l10n.importedWithoutBatteryExemption);
    }
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.backupImported),
        content: Text(
          messages.isEmpty ? l10n.backupApplied : messages.join('\n\n'),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.ok),
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
            AppLocalizations.of(context)!.whatAccessMeans,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.notificationAccessExplanation),
          const SizedBox(height: 14),
          Text(
            AppLocalizations.of(context)!.installedAppsVisibility,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 6),
          Text(AppLocalizations.of(context)!.installedAppsExplanation),
          const SizedBox(height: 14),
          Text('GitHub', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 6),
          Text(AppLocalizations.of(context)!.githubUpdatesPrivacy),
          const SizedBox(height: 14),
          Text(AppLocalizations.of(context)!.callsAlarmsOtpPrivacy),
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.customColorTitle),
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
                labelText: l10n.hexColor,
                prefixText: '#',
                errorText: _hexError,
                counterText: '',
              ),
              onChanged: _onHexChanged,
            ),
            const SizedBox(height: 8),
            Text(l10n.red(_red)),
            Slider(
              value: _red.toDouble(),
              min: 0,
              max: 255,
              divisions: 255,
              activeColor: Colors.red,
              onChanged: (value) => _updateChannel(red: value.round()),
            ),
            Text(l10n.green(_green)),
            Slider(
              value: _green.toDouble(),
              min: 0,
              max: 255,
              divisions: 255,
              activeColor: Colors.green,
              onChanged: (value) => _updateChannel(green: value.round()),
            ),
            Text(l10n.blue(_blue)),
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
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _apply, child: Text(l10n.apply)),
      ],
    );
  }

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
      setState(
        () => _hexError = AppLocalizations.of(context)!.hexColorNeedsSixDigits,
      );
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
