# Plano — MVP KillNotify

## Estado de retomada

- Fase: follow-up visual concluído; APKs atuais compilados
- Etapa atual: K central combinado com sino no módulo superior esquerdo e linhas de notificação no inferior direito; tela de aparência e launcher conferidos no emulador.
- Concluído nesta etapa: seletor de cores; persistência/backup v1; composição do ícone aproximada ao KillQR com módulos próprios do KillNotify; APK debug e release reconstruídos.
- Pendências: o APK release está assinado com a chave debug; propriedades de assinatura release são necessárias antes de distribuir. Permanecem as validações físicas/OEM do MVP.
- Arquivos alterados nesta etapa: `lib/app/app.dart`, `lib/core/native/native_bridge.dart`, `lib/core/theme/app_theme.dart`, `lib/features/privacy/privacy_page.dart`, `android/app/src/main/kotlin/com/killnotify/killnotify/MainActivity.kt`, `android/app/src/main/kotlin/com/killnotify/killnotify/data/LocalConfigurationStore.kt`, `android/app/src/main/res/` e documentos de requisitos, arquitetura, decisões e plano.
- Última validação: `flutter build apk --debug` e `flutter build apk --release` passaram; versão debug instalada no `KillQR_API_36` (Android 16 / API 36). Capturas: `build/killnotify-more-similar.png` e `build/killnotify-appearance-final.png`. APK release 50,8 MB; `apksigner` confirmou `CN=Android Debug`; SHA-256 `6DBED58B89857BEA1C2E888B9DEB0AFFE030024BCFEC0ACD2B84F20D8AA90AB5`. Testes automatizados não foram executados.
- Próxima ação: nenhuma para esta revisão; não publicar o APK sem assinatura release configurada. Nenhuma release foi publicada.

### Follow-up anterior — permissão e textos da interface

- O aviso de acesso e o controle de ativação foram reunidos no mesmo cartão; textos com termos de implementação e identificadores de apps instalados foram substituídos por linguagem de usuário.
- `dart format` passou; o APK debug anterior foi aberto no emulador API 36 para conferir a tela inicial. A captura ficou em `build/killnotify-emulator.png`.

### Histórico de validação do MVP

`flutter analyze`, `flutter test`, `:app:testDebugUnitTest`, builds Gradle debug/release e produtor passaram; também `flutter build apk --debug` e `flutter build apk --release` passaram com JDK 17 e `JAVA_TOOL_OPTIONS=-Djdk.net.unixdomain.tmpdir=C:/Temp`. Manifesto release declara `QUERY_ALL_PACKAGES`, sem INTERNET ou POST_NOTIFICATIONS; `minSdk 26`, `targetSdk 36`. AVD API 36 confirmou fluxo permitido/bloqueado, atualização/ação no protótipo, backup/aviso de app ausente e revogação desligando filtro. APK release de 49,3 MB usa a chave debug na falta das propriedades de assinatura e não deve ser distribuído assim.

## Objetivo e problema

Construir um app local Android que entrega notificações por janelas semanais por app e adia as demais com retorno da notificação original.

## Estado inicial registrado

- A pasta continha o kit `README.md`, `AGENTS.md`, `PROMPT_IMPLEMENTACAO.md` e `.agents/skills/`; não havia `.git`, projeto Flutter/Android nem código de produto para preservar.
- Flutter 3.47.2, Android SDK/API 36 e AVDs API 36 estavam disponíveis; nenhum aparelho físico estava conectado.
- As skills `planejamento` e `analise-bug` e seus modelos já existiam e foram mantidos.

## Requisitos confirmados

- Ver `docs/requirements/REQUIREMENTS.md`; prioridade técnica: fonte semanal Kotlin, listener sem Dart, sem conteúdo persistido, sem rede, permissões explícitas.

## Premissas e decisões

- Usar snooze do sistema condicionado à evidência do protótipo (D001).
- Reapresentar originais individualmente e resumir quantidade na UI (D002).
- Exceção por app para categorias CALL/ALARM; sem ler OTP (D003).
- Usar consulta ampla explicitada (D004), contrato nativo v1 (D005), horário civil local (D006).

## Fora de escopo

- iOS, Play Store, serviço remoto, analytics, leitura de conteúdo para classificar OTP, instalação/atualização silenciosa, publicação de release.
- Prometer exatidão, garantir comportamento em todos os OEMs, ou forjar notificação quando snooze falhar.

## Arquitetura afetada

- Flutter feature-first, Kotlin domínio e listener, armazenamento privado Android, MethodChannel v1, SAF para backup.

## Etapas

1. Scaffold e protótipo: concluído para os cenários observáveis na AVD; limitações abertas registradas.
2. Domínio Kotlin e testes: concluído; validação, normalização, política local e exceções.
3. Persistência e serviço: concluído; JSON local validado, listener, contagem, permissão e hash mínimo.
4. Ponte v1 e Flutter: concluído; status, picker, editor, exceções, privacidade, SAF backup/import.
5. Integração/manifestos/validação: concluído; builds e verificações passaram, sem publicação.

## Critérios de aceite

- [x] As regras/normalização/domínio atendem os casos semanais automatizados.
- [x] App sem intervalo passa; snooze/reentrega permitida e bloqueada observadas na AVD API 36.
- [x] Atualização/ação/grupo observados no protótipo; limites documentados.
- [x] Acesso ausente impede ativação; importação preserva app ausente com aviso; backup não inclui conteúdo.
- [x] Flutter analyze, teste Flutter, testes Kotlin e builds Android debug/release passam.

## Validação

- `flutter analyze`, `flutter test`, `:app:testDebugUnitTest`, builds debug/release e APK do produtor.
- Emulador API 36: notificação sintética de app produtor separado, snooze de curta duração, atualização, ação, grupo e reboot quando viável.
- Hardware físico, API 26, bateria/OEM: registrar como pendente, pois não há dispositivo conectado.

## Riscos e limitações

- Documentação Android não garante ações/grupos/tempo/reboot para todos OEMs; o listener reavalia callback e não forja fallback.
- APK release local usa a chave debug quando propriedades locais de assinatura não foram fornecidas; não distribuir esse artefato.
- AVD API 36 apenas; confirmar compatibilidade de `minSdk 26` em hardware mínimo.
