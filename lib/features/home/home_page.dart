import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../../core/native/native_bridge.dart';
import '../../core/ui/battery_requirement_card.dart';
import '../../core/ui/formatters.dart';
import '../../core/ui/run_native_action.dart';

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
    final snapshot = controller.snapshot;
    return Scaffold(
      appBar: AppBar(
        title: const Text('KillNotify'),
        actions: [
          IconButton(
            tooltip: 'Atualizar estado',
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
                  title: const Text('Notificações liberadas hoje'),
                  trailing: Text(
                    '${snapshot.releasedCountToday}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: const Text(
                    'Contagem neste aparelho; mensagens e ações não são salvas.',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.apps),
                  title: Text(
                    '${_configuredCount(snapshot)} apps com horários',
                  ),
                  subtitle: const Text(
                    'Cada app pode ter seus próprios horários.',
                  ),
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
    final (icon, title, subtitle, color) = switch (snapshot.state) {
      'active' => (
        Icons.verified_outlined,
        'Filtro ativo',
        'O KillNotify está aplicando os horários configurados.',
        Theme.of(context).colorScheme.primary,
      ),
      'waiting_for_listener' => (
        Icons.hourglass_top,
        'Filtro inativo',
        'O KillNotify ainda não está acompanhando as notificações. Algumas podem chegar sem adiamento.',
        Theme.of(context).colorScheme.tertiary,
      ),
      'needs_battery_optimization' => (
        Icons.battery_alert,
        'Ajuste a bateria para continuar',
        'Permita a atividade do KillNotify em segundo plano para ativar o filtro.',
        Theme.of(context).colorScheme.tertiary,
      ),
      'configuration_error' => (
        Icons.error_outline,
        'Horários indisponíveis',
        'O filtro está desligado até que suas configurações sejam recuperadas.',
        Theme.of(context).colorScheme.error,
      ),
      _ => (
        Icons.pause_circle_outline,
        'Filtro desativado',
        'As notificações chegam normalmente, sem adiamento.',
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
                'Acesso necessário',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Para aplicar os horários, permita que o KillNotify acompanhe as notificações nas configurações do Android.',
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await runNativeAction<void>(
                context,
                controller.bridge.openNotificationAccessSettings,
              );
            },
            icon: const Icon(Icons.settings),
            label: const Text('Abrir configurações do Android'),
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
      title: const Text('Ativar filtro'),
      subtitle: Text(
        !snapshot.accessGranted && !snapshot.batteryOptimizationExempt
            ? 'Libere o acesso às notificações e ajuste a bateria antes de ativar.'
            : !snapshot.accessGranted
            ? 'Permita o acesso às notificações antes de ativar.'
            : !snapshot.batteryOptimizationExempt
            ? 'Ajuste a bateria para o filtro funcionar em segundo plano.'
            : 'Aplica os horários definidos para cada app.',
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
    child: const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Importe um backup na tela Privacidade para recuperar seus horários.',
      ),
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
              error == null ? 'Verificando o filtro…' : 'Não foi possível verificar o filtro. Toque em atualizar e tente novamente.',
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
    final epoch = snapshot.nextAllowedStartEpochMillis;
    final hasConfiguredRules = snapshot.appRules.any(
      (rule) => rule.selected && rule.intervals.isNotEmpty,
    );
    final title = epoch != null
        ? snapshot.filterActive
              ? 'Próximo início permitido'
              : 'Próxima janela configurada'
        : hasConfiguredRules
        ? 'Nenhum app aguarda horário agora'
        : 'Ainda sem horários configurados';
    final detail = epoch != null
        ? '${formatLocalDateTime(epoch)}'
              '${snapshot.filterActive ? '' : '\nO filtro está inativo; horário informativo.'}'
        : hasConfiguredRules
        ? 'Os horários seguem o fuso configurado no aparelho.'
        : 'Escolha os apps e defina quando as notificações podem chegar.';
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
        'O Android controla quando uma notificação adiada volta a aparecer. '
        'O horário pode variar por economia de bateria, configurações do aparelho ou mudanças no relógio.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}
