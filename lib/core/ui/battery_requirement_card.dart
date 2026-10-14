import 'package:flutter/material.dart';

import '../../app/app_controller.dart';
import '../native/native_bridge.dart';
import 'run_native_action.dart';

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
    final granted = snapshot.batteryOptimizationExempt;
    final manufacturerHelp = switch (snapshot.manufacturerFamily) {
      'samsung' => 'Em Samsung, adicione o KillNotify em Configurações > Bateria e assistência do aparelho > Bateria > Limites de uso em segundo plano > Apps nunca suspensos. Os nomes podem variar conforme a versão.',
      'xiaomi' => 'Em Xiaomi, ative a Inicialização automática em segundo plano em Configurações > Apps > Permissões. Se houver a opção, escolha Sem restrições em Bateria para o KillNotify. Os nomes variam conforme o modelo.',
      'huawei' => 'Em Huawei, procure “Inicialização de apps”, escolha o KillNotify e permita Inicialização automática, Inicialização secundária e Executar em segundo plano. Os nomes variam por versão.',
      'realme' => 'Em realme, procure Gerenciamento de bateria dos apps nas configurações e permita atividade em segundo plano e inicialização automática para o KillNotify, se essas opções estiverem disponíveis.',
      'oppo' => 'Em OPPO/ColorOS, alguns modos de economia limitam apps em segundo plano. Procure nas configurações de Bateria ou Apps a gestão de bateria do KillNotify e permita a atividade em segundo plano, se disponível.',
      'oneplus' => 'Em OnePlus, confira Configurações > Bateria > Mais configurações > Gerenciamento de bateria de apps. Verifique se a atividade em segundo plano do KillNotify não está restrita; o texto e o caminho podem variar.',
      'vivo' => 'Em vivo, procure Configurações > Apps > Acesso especial a apps > Inicialização automática e permita o KillNotify, se essa opção estiver disponível.',
      'motorola' => 'Em Motorola, se o aparelho tiver Gerenciar apps em segundo plano, escolha Sempre permitir para o KillNotify. Os nomes e a disponibilidade variam por modelo.',
      _ => 'Alguns aparelhos oferecem controles próprios para apps em segundo plano. Se ainda houver interrupções, procure as opções de bateria do KillNotify nas configurações do aparelho.',
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
                        'Permitir atividade em segundo plano',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        granted
                            ? 'A permissão de bateria do Android está ativa.'
                            : 'Necessário para ativar o filtro e acompanhar as notificações com a tela apagada.',
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
                label: const Text('Ajustar bateria'),
              ),
            ],
            const SizedBox(height: 12),
            Text(manufacturerHelp),
            const SizedBox(height: 8),
            Text(
              'Não é necessário deixar o KillNotify aberto na tela. Evite usar “Forçar parada”; isso interrompe o acompanhamento até o Android reconectar o serviço.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
