import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/app_localizations.dart';

Future<T?> runNativeAction<T>(
  BuildContext context,
  Future<T> Function() action,
) async {
  try {
    return await action();
  } on PlatformException catch (error) {
    if (context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      final message = switch (error.code) {
        'access_required' => l10n.errorAccessRequired,
        'battery_optimization_required' => l10n.errorBatteryRequired,
        'invalid_backup' => l10n.errorInvalidBackup,
        'configuration_unreadable' => l10n.errorConfigurationUnreadable,
        'busy' => l10n.errorBusy,
        'invalid_argument' => l10n.errorInvalidInput,
        'unsupported_version' => l10n.errorUnsupportedVersion,
        _ => l10n.operationNotCompleted,
      };
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.operationNotCompleted),
        ),
      );
    }
  }
  return null;
}
