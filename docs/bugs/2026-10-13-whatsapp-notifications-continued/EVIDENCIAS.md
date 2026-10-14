# Evidências — 2026-10-13-whatsapp-notifications-continued

Acrescente entradas ao final. Não apague evidência antiga; marque-a como invalidada e explique por quê. Não inclua corpo de notificações ou dados pessoais.

## E001 — Semântica dos períodos e do filtro

- Data/hora: 2026-10-13
- Tipo: código
- Ambiente: código-fonte local
- Procedimento ou comando: leitura de `docs/requirements/REQUIREMENTS.md`, `lib/features/apps/app_rule_page.dart`, `android/app/src/main/kotlin/com/killnotify/killnotify/NotificationFilterService.kt` e `android/app/src/main/kotlin/com/killnotify/killnotify/domain/WeeklySchedule.kt`.
- Resultado observado: requisitos tratam os intervalos como períodos permitidos; o serviço passa sem regra/seleção/períodos e quando `decision.allowed` é verdadeiro. O snooze só é chamado para decisão fora da janela.
- O que prova: receber notificações dentro da janela configurada é o comportamento previsto pelo produto.
- Escopo da busca e o que ficou de fora: não prova qual horário foi configurado nem o estado do aparelho do relato.
- Arquivo/linha ou caminho do artefato: `docs/requirements/REQUIREMENTS.md:10`, `:15`; `lib/features/apps/app_rule_page.dart:56`, `:357`; `NotificationFilterService.kt:42`, `:62`; `WeeklySchedule.kt:94`.
- Estado: válida

## E002 — Aparelho de teste disponível nesta sessão

- Data/hora: 2026-10-13
- Tipo: análise de configuração
- Ambiente: Windows; ADB/Flutter local; AVD Android 16 / API 36.
- Procedimento ou comando: `flutter devices`; `adb devices -l`; `adb shell pm list packages`; `adb shell settings get secure enabled_notification_listeners`.
- Resultado observado: somente `emulator-5554` aparece no ADB; não foi encontrado WhatsApp nem o produtor de teste na lista; os listeners autorizados listados são do sistema/launcher, sem o serviço KillNotify.
- O que prova: o ambiente desta sessão não consegue reproduzir agora o caso do WhatsApp, e a AVD não está configurada para testar o serviço.
- Escopo da busca e o que ficou de fora: não informa o aparelho nem as permissões do relato da pessoa.
- Arquivo/linha ou caminho do artefato: inventário de dispositivos ADB desta sessão; estado não alterado.
- Estado: válida

## E003 — Relato da pessoa

- Data/hora: 2026-10-13
- Tipo: outra
- Ambiente: aparelho/build não informados.
- Procedimento ou comando: relato na conversa: “ativei para o Whatsapp no horário de agora e as notificações continuaram chegando”.
- Resultado observado: notificações do WhatsApp continuaram chegando.
- O que prova: existe uma diferença entre expectativa e comportamento percebido.
- Escopo da busca e o que ficou de fora: não identifica se o horário estava permitido, se o filtro estava ativo, se havia exceção ou qual versão foi testada.
- Arquivo/linha ou caminho do artefato: relato da conversa.
- Estado: válida

## E004 — Esclarecimento da semântica dos horários

- Data/hora: 2026-10-13
- Tipo: outra
- Ambiente: conversa de suporte; código local conferido nas evidências E001.
- Procedimento ou comando: a pessoa perguntou se o horário escolhido para o aplicativo é o horário em que as notificações ficam permitidas.
- Resultado observado: foi esclarecido que os intervalos são janelas permitidas; sem períodos, as notificações passam normalmente.
- O que prova: a semântica do produto foi explicada; não confirma qual regra estava configurada no aparelho do relato.
- Escopo da busca e o que ficou de fora: o dia, início/fim, fuso e instante exato da notificação continuam desconhecidos.
- Arquivo/linha ou caminho do artefato: `docs/requirements/REQUIREMENTS.md:10`, `:15`; `NotificationFilterService.kt:42`, `:62`.
- Estado: válida
