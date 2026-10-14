# Evidências — 2026-10-14-google-chat-scheduled-redelivery

Acrescente entradas ao final. Não inclua conteúdo real de notificações, contatos, mensagens, tokens ou chaves brutas.

## E001 — O caminho do produto usa snooze do sistema e reavalia no callback

- Data/hora: 2026-10-14
- Tipo: análise de código e documentação de API
- Ambiente: projeto local; API Android.
- Procedimento ou comando: leitura de `NotificationFilterService.kt`, `WeeklySchedule.kt` e referência oficial `NotificationListenerService.snoozeNotification`.
- Resultado observado: fora da janela, o listener calcula o próximo início, registra somente hash/pacote/prazo e chama `snoozeNotification`. A referência Android descreve callback `onNotificationPosted` quando o snooze expira.
- O que prova: implementação planejada para a entrega depende do agendador do Android e de um callback para reavaliar; não cria uma notificação substituta.
- Escopo da busca e o que ficou de fora: não prova que um prazo longo expira em todos os aparelhos/OEMs nem comportamento específico de Google Chat.
- Arquivo/linha ou caminho do artefato: `android/app/src/main/kotlin/com/killnotify/killnotify/NotificationFilterService.kt`; `android/app/src/main/kotlin/com/killnotify/killnotify/domain/WeeklySchedule.kt`; [API oficial](https://developer.android.com/reference/android/service/notification/NotificationListenerService).
- Estado: válida

## E002 — Google Chat ausente no AVD; regra 08:00–17:00 preservada

- Data/hora: 2026-10-14
- Tipo: inspeção de pacote e configuração de teste
- Ambiente: `KillQR_API_36`, Android 16 / API 36.
- Procedimento ou comando: `adb shell pm list packages` filtrado para `com.google.android.apps.dynamite`; importar backup de teste schema v1 com regra diária 08:00–17:00.
- Resultado observado: o package `com.google.android.apps.dynamite` não está instalado. A importação informou que o app está ausente e que os horários foram preservados.
- O que prova: a regra do Google Chat está configurada nos dados locais do AVD, mas não há como produzir notificação real do Chat aqui.
- Escopo da busca e o que ficou de fora: não verifica aparelho físico nem versão instalada do Google Chat no aparelho do relato.
- Arquivo/linha ou caminho do artefato: backup local de teste em `C:\Temp\killnotify-chat-0817-test.json`; tela de importação no AVD.
- Estado: válida

## E003 — Primeiro snooze sintético e desvio de fuso no harness

- Data/hora: 2026-10-14
- Tipo: teste sintético / configuração do AVD
- Ambiente: AVD API 36; KillNotify com acesso concedido; filtro ativo; relógio AVD em 17:05 `America/Sao_Paulo`.
- Procedimento ou comando: publicar um ID novo por `dev.killnotify.probe`; ler apenas o registro de metadados pendentes filtrado pelo package, sem imprimir o hash da chave.
- Resultado observado: o original saiu da lista ativa e o KillNotify registrou prazo para o dia seguinte às 05:00 local. O AVD estava em GMT quando o serviço foi iniciado e o fuso foi alterado com o processo em execução.
- O que prova: a integração chegou ao caminho de snooze e preservou metadado pendente. Não prova que a entrega falha às 08:00; o cálculo ocorreu sob uma transição de fuso artificial e exige reprodução limpa.
- Escopo da busca e o que ficou de fora: ainda não foi aguardada a expiração; não foi verificado Google Chat.
- Arquivo/linha ou caminho do artefato: `NotificationFilterService.onNotificationPosted`; metadado local contém somente digest, package e prazo.
- Estado: válida, mas não usar como resultado final do caso

## E004 — Callback do snooze acelerado e retorno às 08:00

- Data/hora: 2026-10-14/15; horário do dispositivo acelerado para teste.
- Tipo: reprodução manual com notificações sintéticas.
- Ambiente: AVD `KillQR_API_36`, Android 16 / API 36, fuso `America/Sao_Paulo`; KillNotify debug com acesso concedido e filtro ativo; produtor `dev.killnotify.probe`.
- Procedimento ou comando: após reiniciar o serviço no fuso correto, publicar um novo ID às 17:12; ler somente package e prazo dos metadados locais; avançar o relógio AVD para 15/10 às 05:01 e depois 08:01, sem abrir a tela do KillNotify no intervalo.
- Resultado observado: o novo ID foi registrado para 15/10 às 08:00. Às 05:01, a entrada de calibração anterior foi entregue ao listener e voltou a ficar pendente até 08:00. Às 08:01, havia zero entradas pendentes do produtor, o contador agregado de reentregas passou a 2 e `cmd notification list` encontrou registros ativos do produtor.
- O que prova: no AVD API 36, o Android disparou callbacks de snooze e o serviço reavaliou uma janela ainda fechada, depois liberando os originais ao retomar a janela. Não foi necessário abrir o KillNotify para provocar o callback.
- Escopo da busca e o que ficou de fora: o relógio foi avançado, não transcorreram 15 horas reais; o Google Chat não está instalado, e o ensaio não valida comportamento específico de Chat/OEM.
- Arquivo/linha ou caminho do artefato: `C:\Temp\killnotify-chat-0817-test.json` (fixture sem conteúdo de notificação); `C:\Temp\killnotify-final-home.png`; `NotificationFilterService.kt` e metadados locais filtrados por package, sem exibir ou salvar digest de chave.
- Estado: válida para a integração sintética na AVD API 36

## E005 — Regra Google Chat mantida; AVD restaurada

- Data/hora: 2026-10-14
- Tipo: verificação de configuração e limpeza do teste
- Ambiente: AVD `KillQR_API_36`, Android 16 / API 36, fuso São Paulo.
- Procedimento ou comando: ler apenas campos permitidos do backup local; reimportar a configuração anterior junto com a regra Chat; remover o pacote/regra sintética; restaurar filtro e acesso ao estado anterior.
- Resultado observado: `com.google.android.apps.dynamite` permanece configurado com dias 0–6, início 480 e fim 1020; `filterEnabled=false`; a regra e app `dev.killnotify.probe` não permanecem. As duas regras anteriores e o tema da AVD foram preservados; o acesso especial foi revogado.
- O que prova: a AVD guarda a regra pedida para quando Google Chat for instalado, sem deixar o filtro global ativo depois do teste.
- Escopo da busca e o que ficou de fora: não configura nem instala o próprio Google Chat e, portanto, não valida notificações reais dele.
- Arquivo/linha ou caminho do artefato: configuração local `configuration_v1`; backup de preparo em `C:\Temp\killnotify-chat-preserve-setup.json`.
- Estado: válida
