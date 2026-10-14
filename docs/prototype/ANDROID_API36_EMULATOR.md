# Protótipo de snooze — Android API 36

## Ambiente

- Data: 2026-10-13
- AVD: `KillQR_API_36`, imagem `sdk_gphone64_x86_64`, Android API 36 (emulador Pixel); sem fabricante físico.
- App receptor: KillNotify debug, package `com.killnotify.killnotify`.
- App produtor separado: `dev.killnotify.probe`; notificações com conteúdo fixo sintético, ação explícita e grupo com dois filhos e resumo.
- Acesso especial concedido pela tela do sistema. `POST_NOTIFICATIONS` concedida ao produtor.
- Fonte consultada: [NotificationListenerService API](https://developer.android.com/reference/android/service/notification/NotificationListenerService), [visibilidade de pacotes](https://developer.android.com/training/package-visibility/declaring).

## Procedimento

1. Instalar `app-debug.apk` e `notification-probe-debug.apk` na AVD.
2. Conceder acesso de leitura de notificações pela tela do Android.
3. Ativar o protótipo na compilação debug; publicar apenas notificações sintéticas do app produtor.
4. Consultar o estado agregador do protótipo e `adb shell dumpsys notification`; nenhuma mensagem real foi usada.

## Resultados observados

| Cenário | Resultado na AVD API 36 | O que prova / o que não prova |
|---|---|---|
| Terceiro, snooze de 10 s | O original sumiu da central enquanto snoozed e retornou após aproximadamente 10 s. | `snoozeNotification` e callback de reentrega funcionaram neste AVD; sem precisão garantida. |
| Atualização no mesmo package/ID após 2 s | O original retornou com a versão sintética v2. O serviço viu uma única chamada de snooze inicial. | O sistema atualizou o objeto snoozed antes de reentregar; não prova comportamento de todos os apps/OEMs. |
| Ação original | Tocar a ação na notificação reapresentada incrementou o contador do `BroadcastReceiver` do produtor. | A `PendingIntent` de teste funcionou após snooze neste AVD. Não generaliza para ações de todos os apps. |
| Snooze de 7 dias | Após solicitar `604800000 ms`, o original não estava na central. `dumpsys notification` listou os IDs pendentes com seus prazos. | Prazo longo foi aceito e continuou pendente por alguns segundos; não foi observado até a expiração de sete dias. |
| Agrupamento | Dois itens e o resumo do grupo apareceram como três entradas snoozed independentes no sistema. | O listener pode snoozar cada entrada; a reagrupação visual após reentrega não foi verificada. |
| Reinicialização da AVD | Após reboot, `Pending snoozed notifications` ainda listou as quatro entradas e os mesmos prazos. A seção `Snoozed notifications` de registros correntes estava vazia. | Indício de que o agendamento pendente sobrevive ao reboot nesta AVD; não observamos a chegada final após o reboot. |

## Conclusão e limite de adoção

O caminho de reapresentar a notificação original por `snoozeNotification` é viável no emulador API 36 e preservou uma ação sintética e a versão v2. O MVP usa esse caminho e recalcula a política no callback de reentrega. Não criar cópia silenciosa caso o Android não devolva a notificação.

Ainda não testado: API 26 real, Android Q de pouca memória, fabricante físico, Doze/economia de bateria, perfil de trabalho, som, ordem de grupo e reapresentação de prazo longo/reboot no instante final. O requisito de acesso do listener continua sujeito ao Android; a referência oficial registra que listeners não recebem acesso em aparelhos de pouca memória no Android Q ou anterior e que work profiles limitam o listener.

## Verificação adicional do MVP

- Terça-feira às 16:55 GMT, com regra terça 09:00–17:00 para `dev.killnotify.probe`, uma notificação de ID novo apareceu imediatamente na central.
- Ao trocar a regra para segunda 09:00–17:00 e publicar outro ID, `dumpsys notification` listou o original como snoozed e o prazo para segunda 09:00. A preferência local guardou o hash da chave, pacote e prazo, sem chave bruta ou texto.
- Exportar por SAF criou o JSON v1; importar um backup válido com `com.example.killnotify.absent` preservou a regra e apresentou aviso não bloqueante. A reimportação do backup de teste restaurou as regras.
- Revogar o listener em Settings e reabrir o app mostrou “Acesso necessário”, desabilitou o controle de ativação e persistiu `filterEnabled=false`.
- Resultado restrito a esta execução API 36; a janela futura não foi aguardada até reaparecer.

## Reentrega de período noturno acelerada — 2026-10-14

- O AVD foi configurado em `America/Sao_Paulo`, com regra sintética diária 08:00–17:00 e filtro ativo. O pacote Google Chat (`com.google.android.apps.dynamite`) não estava instalado; a regra foi preservada no backup, mas a origem real não pôde ser testada.
- Um ID novo de `dev.killnotify.probe` publicado às 17:12, após reiniciar KillNotify já no fuso correto, ficou pendente para o dia seguinte às 08:00.
- Uma entrada de calibração, publicada antes de reiniciar o serviço após a troca GMT → São Paulo, tinha alvo inicial 05:00. Ao avançar o relógio do AVD para 05:01, o callback foi recebido, reavaliou a janela fechada e a adiou novamente até 08:00.
- Com o relógio avançado para 08:01, as duas notificações originais sintéticas reapareceram; o contador agregado do KillNotify ficou em 2 e não havia metadados pendentes do produtor. O app KillNotify permaneceu em segundo plano durante os callbacks.
- Esse ensaio valida o caminho RTC/callback e a reavaliação em API 36 com relógio avançado. Não aguardou 15 horas reais, não testa o app Google Chat nem cobre OEM/Doze. A regra de teste do produtor e o app auxiliar foram removidos da AVD; a regra 08:00–17:00 do Google Chat permanece salva embora o app não esteja instalado.

## Artefatos de teste

- A tela temporária do protótipo foi substituída pela interface do produto; o harness de snooze hardcoded não está no APK principal.
- `android/notification-probe`: app debug separado para reproduzir ações, atualizações e grupos sintéticos. Não integra o APK KillNotify distribuível.
- Nenhum texto real de notificação foi registrado ou exportado. A persistência de chaves/contadores descrita no código é exclusiva do protótipo e não deve ser confundida com o desenho do produto.
