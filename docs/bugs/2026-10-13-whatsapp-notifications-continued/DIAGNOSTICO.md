# Diagnóstico — Notificações do WhatsApp continuaram chegando

## Estado

- ID: 2026-10-13-whatsapp-notifications-continued
- Fase: triagem
- Atualizado em: 2026-10-13
- Próximo passo: confirmar se a notificação chegou dentro de um período permitido ou fora de todos os períodos e coletar o estado do filtro no aparelho testado.
- Confiança na causa: baixa — o relato não informa a programação exata, o estado do serviço, o aparelho nem a versão instalada.

## Sintoma e ambiente

- Esperado: durante um período configurado como permitido, as notificações chegam. Fora de todos os períodos permitidos, com o filtro ativo e o acesso concedido, o KillNotify adia a notificação original até a próxima abertura.
- Observado: a pessoa relata que ativou o WhatsApp “no horário de agora” e as notificações continuaram chegando. Não está claro se isso significa que o horário atual foi incluído em uma janela permitida ou que ela esperava bloqueá-las nesse horário.
- Passos mínimos: selecionar/ativar o WhatsApp, definir uma programação relacionada ao horário atual e observar uma notificação chegar. Dia, início/fim e estado do filtro não foram informados.
- Aparelho e fabricante: não informados. A única AVD disponível é `KillQR_API_36`.
- Versão do Android: aparelho do relato desconhecido; AVD disponível: Android 16 / API 36.
- Versão/build do app: não confirmados no aparelho do relato. A versão local do projeto é 1.0.0+1.
- Permissões e estado do NotificationListenerService: não informados no aparelho do relato. Na AVD disponível, o serviço KillNotify não está entre os listeners autorizados.
- Apps envolvidos, identificados por package name: WhatsApp; o package name do aparelho do relato não foi observado.

## Fatos confirmados

- Os requisitos definem os períodos configurados como períodos em que as notificações podem chegar; notificações fora deles devem ser adiadas (`docs/requirements/REQUIREMENTS.md:10`, `:15`).
- A tela informa que sem horários definidos as notificações chegam normalmente (`lib/features/apps/app_rule_page.dart:56`, `:357`).
- O serviço deixa a notificação passar quando não há regra selecionada ou quando a lista de períodos está vazia (`NotificationFilterService.kt:42`).
- O serviço também deixa passar quando a avaliação indica que o horário atual está dentro de um período permitido; somente horários fora da janela seguem para `snoozeNotification` (`NotificationFilterService.kt:62`; `WeeklySchedule.kt:94`).
- Esta sessão não tem aparelho físico conectado. A única AVD é API 36; nela não há WhatsApp nem o app produtor de notificações sintéticas instalados, e o acesso do KillNotify não aparece na lista de listeners habilitados (`adb devices -l`, `pm list packages`, `settings get secure enabled_notification_listeners`). Portanto, o relato não foi reproduzido neste ambiente.
- Foi esclarecido à pessoa que os horários configurados são períodos permitidos; ela ainda não confirmou se a notificação do relato chegou dentro de um deles.
- Um registro anterior de teste sintético da AVD API 36 consta em `docs/prototype/ANDROID_API36_EMULATOR.md`; ele não valida o WhatsApp nem o aparelho do relato.
- Em 2026-10-14, a mesma camada genérica foi exercitada com `dev.killnotify.probe`: dois originais sintéticos voltaram após a janela 08:00–17:00 na AVD API 36 com relógio acelerado. Esse resultado está em `docs/bugs/2026-10-14-google-chat-scheduled-redelivery/EVIDENCIAS.md`; não confirma nem exclui comportamento específico do WhatsApp.

## Hipóteses

| Hipótese | Estado | Evidência favorável | Evidência contrária | Próximo teste |
|---|---|---|---|---|
| O horário atual foi incluído como período permitido; receber notificações é o comportamento previsto. | Aberta | O relato menciona “no horário de agora”; o produto libera dentro da janela. A semântica foi esclarecida à pessoa. | Não sabemos se a notificação do relato chegou dentro ou fora da janela. | Conferir dia, início/fim, fuso e se o horário do teste está dentro do período. |
| O filtro não estava efetivamente ativo, a regra do WhatsApp estava desmarcada/vazia ou faltava o acesso especial. | Aberta | Qualquer uma dessas condições faz a notificação passar conforme o serviço. | O estado do aparelho não foi informado. | Conferir a tela inicial (Filtro ativo), seleção do WhatsApp e acesso às notificações. |
| O horário estava fora de todas as janelas, mas a notificação passou por falha no serviço/sistema ou exceção ativa. | Aberta | Pode explicar o sintoma se filtro, regra e acesso estiverem ativos e corretos. | Ainda não há evidência de que o horário estava fora da janela ou de exceção ativa. | Reproduzir com dados sintéticos no mesmo aparelho, anotando estado, horário e exceções. |

## Causa raiz

Ainda não determinada. O relato também é compatível com o comportamento previsto se o horário atual foi configurado como período permitido. Não há evidência suficiente para classificar como regressão.

## Escopo e impacto

- Comportamentos afetados: suposta entrega sem adiamento de notificações do WhatsApp.
- Comportamentos que não foram investigados: programação exata, exceção temporária, categoria da notificação, acesso/reconexão do listener, fabricante, economia de bateria e versão instalada.
- Risco de perda, duplicação ou atraso de notificações: não avaliado no aparelho do relato; não foi feita alteração de código.

## Decisões e pendências

- Decisões confirmadas pela pessoa: nenhuma sobre o significado do horário configurado; confirmar se desejava permitir ou bloquear nesse horário.
- Perguntas bloqueantes: a notificação chegou dentro de um período permitido ou fora de todos? Se chegou fora, qual aparelho/Android/build foi usado e a tela inicial mostrava “Filtro ativo” com acesso concedido?
- Limitações conhecidas: nenhum aparelho físico está conectado a esta sessão e a AVD disponível não tem WhatsApp instalado.

## Próximo passo

Confirmar se o horário da notificação estava dentro ou fora dos períodos permitidos e obter o estado do aparelho onde ocorreu. O ensaio genérico na AVD passou, mas não substitui reprodução do WhatsApp no aparelho relatado.
