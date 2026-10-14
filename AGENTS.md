# AGENTS.md — KillNotify

## Produto e plataforma

- App Android apenas nesta etapa; Flutter apresenta a interface e Kotlin é a fonte única da regra semanal executada em segundo plano.
- Sem conta, backend, sincronização, telemetria ou publicidade. A única rede é a consulta opcional à API pública de releases do GitHub; não enviar configurações, apps ou notificações. Distribuição pelo GitHub; não publicar na Play Store.
- O filtro depende do acesso especial `NotificationListenerService`. Se o acesso não existir, não ative o filtro; ao detectar revogação, desative-o e informe a pendência.
- Use `snoozeNotification` para a notificação original e reavalie no callback. Não recrie silenciosamente notificações nem prometa horário exato, preservação universal de ações ou reagrupamento.
- A seleção ampla usa `QUERY_ALL_PACKAGES`; explique a visibilidade ampliada na tela de privacidade.

## Arquitetura e privacidade

- Avaliação, validação, normalização e próxima janela semanal ficam em Kotlin. Dart envia/mostra dados e consome o resultado nativo pelo `MethodChannel com.killnotify/v1`.
- Configurações e metadados mínimos ficam em armazenamento local. Não leia nem persista conteúdo, contatos, ações ou tokens de notificações; o backup versionado contém somente configurações.
- Ausência de regra permite notificações. OTP não tem categoria universal; não examine o conteúdo para classificá-lo.
- Mudanças relevantes devem atualizar requisitos, arquitetura, decisões e plano. Registre limitações por API/dispositivo.

## Comandos

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `cd android; .\gradlew.bat --no-daemon :app:testDebugUnitTest`
- `flutter build apk --debug`
- Protótipo sintético separado: `cd android; .\gradlew.bat --no-daemon :notification-probe:assembleDebug`

Nesta estação Windows, se Gradle falhar com `Unable to establish loopback connection`, defina `JAVA_TOOL_OPTIONS=-Djdk.net.unixdomain.tmpdir=C:/Temp` para essa sessão, conforme o README. Não grave essa configuração local nem credenciais no repositório.

## Skills e distribuição

- Funcionalidade, arquitetura ou planejamento: `.agents/skills/planejamento/SKILL.md`.
- Bug ou regressão: leia `.agents/skills/analise-bug/SKILL.md` antes de alterar código; investigue e registre antes da correção.
- Use os modelos de `assets/` das skills e mantenha o estado retomável nos documentos de `docs/`.
- Não publique releases nem exponha segredos sem solicitação explícita. O verificador consulta releases uma vez por dia quando habilitado, abre o APK no navegador e deixa a instalação para confirmação do Android.
