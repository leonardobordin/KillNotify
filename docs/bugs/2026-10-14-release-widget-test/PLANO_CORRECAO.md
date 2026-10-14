# Plano de correção — 2026-10-14-release-widget-test

## Objetivo

Fazer o teste de widget refletir a interface atual e fornecer uma implementação em memória para as preferências, permitindo que a Action continue até o build assinado da release.

## Base do diagnóstico

- Causa confirmada: `SharedPreferencesAsync` exige que o teste registre `SharedPreferencesAsyncPlatform.instance`.
- Evidências principais: E001 e E002.
- Incertezas restantes: resultado da Action para o novo commit/tag.

## Escopo

- Incluído: ajustar `test/widget_test.dart`, declarar a dependência de interface de plataforma no escopo de teste e registrar o resultado no caso.
- Fora de escopo: alterar `AppController`, o serviço de notificações, a versão/tag, workflow, secrets ou checksum.
- Arquivos/componentes candidatos: `test/widget_test.dart`, `pubspec.yaml`, `pubspec.lock` e os três arquivos deste caso.

## Etapas

1. Configurar `InMemorySharedPreferencesAsync` no `setUp` e remover a implementação no `tearDown`.
2. Fixar o locale de teste em pt-BR e atualizar a asserção de navegação para `Configurações`.
3. Executar `flutter test`, `flutter analyze` e format check; registrar evidências.
4. Enviar a correção e rerodar a tag publicada; confirmar criação da release e assets antes de encerrar.

## Critérios de aceite

- [x] `flutter test` passa localmente no fixture corrigido.
- [ ] A Action conclui `Test`, assinatura, build e publicação para `v1.0.0`.
- [ ] A GitHub Release tem APK assinado, arquivo SHA-256 e notas da seção `1.0.0`.

## Validação

- `flutter test`
- `flutter analyze`
- `dart format --output=none --set-exit-if-changed lib test`
- GitHub Actions: `Release Android APK` para `v1.0.0` e inspeção da release/artifacts publicados.

## Riscos e reversão

- Riscos: revelar valor de assinatura no log ou mudar produção sem necessidade.
- Como detectar: outputs mostram apenas status; segredo nunca é impresso; diff limitado a fixture/dependências.
- Como reverter com segurança: reverter somente o commit da correção; manter os secrets e a tag intactos até remover ou substituir a release conscientemente.

## Estado

- Situação: em andamento
- Próximo passo: enviar correção, mover o ref de `v1.0.0` e confirmar a nova Action.
