import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../native/native_bridge.dart';
import 'run_native_action.dart';
import '../../l10n/app_localizations.dart';

class BatteryRequirementCard extends StatelessWidget {
  const BatteryRequirementCard({
    required this.controller,
    required this.snapshot,
    super.key,
  });

  final AppController controller;
  final NativeSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final granted = snapshot.batteryOptimizationExempt;
    final manufacturerHelp = switch (snapshot.manufacturerFamily) {
      'samsung' => l10n.batteryHelpSamsung,
      'xiaomi' => l10n.batteryHelpXiaomi,
      'huawei' => l10n.batteryHelpHuawei,
      'realme' => l10n.batteryHelpRealme,
      'oppo' => l10n.batteryHelpOppo,
      'oneplus' => l10n.batteryHelpOneplus,
      'vivo' => l10n.batteryHelpVivo,
      'motorola' => l10n.batteryHelpMotorola,
      _ => l10n.batteryHelpOther,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  granted ? Icons.check_circle_outline : Icons.battery_alert,
                  color: granted
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.backgroundActivityTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        granted
                            ? l10n.batteryExemptionGranted
                            : l10n.batteryExemptionNeeded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!granted) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () async {
                  await runNativeAction<void>(
                    context,
                    controller.bridge.requestBatteryOptimizationExemption,
                  );
                },
                icon: const Icon(Icons.battery_saver_outlined),
                label: Text(l10n.adjustBattery),
              ),
            ],
            const SizedBox(height: 12),
            Text(manufacturerHelp),
            const SizedBox(height: 8),
            Text(
              l10n.noNeedKeepScreenOpen,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
