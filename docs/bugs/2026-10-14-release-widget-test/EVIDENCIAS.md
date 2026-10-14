# Evidências — 2026-10-14-release-widget-test

## E001 — Action falha no primeiro teste de widget

- Data/hora: 2026-10-14, execução após push de `v1.0.0`
- Tipo: log sanitizado
- Ambiente: GitHub Actions `Release Android APK`, run `38622743117`, job `Build and publish Android release`, job ID `116054118123`
- Procedimento ou comando: push de tag `v1.0.0`; workflow executa `flutter test`
- Resultado observado: `Bad state: The SharedPreferencesAsyncPlatform instance must be set.`; stack em `lib/app/app_controller.dart:20`, `lib/app/app.dart:27` e `test/widget_test.dart:43`. A expectativa de `Acesso necessário` também não encontrou widget; compilação e publicação ficaram skipped.
- O que prova: o fixture não inicializa SharedPreferencesAsync antes de montar o app; o job para na etapa de testes.
- Escopo da busca e o que ficou de fora: somente o log da execução e o teste correspondente; não houve build release nem teste de instalação.
- Arquivo/linha ou caminho do artefato: [execução da Action](https://github.com/leonardobordin/KillNotify/actions/runs/38622743117), `test/widget_test.dart`, `lib/app/app_controller.dart`
- Estado: válida

## E002 — fixture não registra plataforma de preferências e usa aba antiga

- Data/hora: 2026-10-14
- Tipo: análise de código
- Ambiente: checkout local na tag `v1.0.0`
- Procedimento ou comando: leitura de `test/widget_test.dart`, `lib/app/app_controller.dart`, implementação local de `shared_preferences-2.5.5` e `SharedPreferencesAsyncPlatform`
- Resultado observado: o teste registra apenas o MethodChannel de KillNotify; `SharedPreferencesAsync` exige `SharedPreferencesAsyncPlatform.instance`; a aba atual é `Configurações`, não `Privacidade`.
- O que prova: descreve duas incompatibilidades determinísticas entre o fixture e o contrato UI atual.
- Escopo da busca e o que ficou de fora: análise estática dos caminhos usados pelo teste; validação final aguardando correção e execução local.
- Arquivo/linha ou caminho do artefato: `test/widget_test.dart`; `lib/app/app_controller.dart`; `lib/app/app.dart`
- Estado: válida

## E003 — preferência em memória remove a exceção, mas o locale ainda era inglês

- Data/hora: 2026-10-14
- Tipo: teste
- Ambiente: Flutter local do projeto
- Procedimento ou comando: após injetar `InMemorySharedPreferencesAsync`, executar `flutter test`
- Resultado observado: `SharedPreferencesAsyncPlatform` deixou de lançar; a asserção para Acesso necessário falhou porque o teste alterava `localeTestValue`, mas não a lista `localesTestValue` usada pela resolução de locale do `MaterialApp`.
- O que prova: o mock de preferências corrige o bloqueio inicial e o locale da plataforma também precisa ser fixado explicitamente no teste.
- Escopo da busca e o que ficou de fora: um teste de widget; nenhuma alteração de produção ou dados de notificação.
- Arquivo/linha ou caminho do artefato: `test/widget_test.dart`; `packages/flutter_test/lib/src/window.dart` (getter `locales`)
- Estado: válida

## E004 — conteúdo abaixo da viewport não estava construído ainda

- Data/hora: 2026-10-14
- Tipo: teste
- Ambiente: Flutter local do projeto
- Procedimento ou comando: executar `flutter test` após fixar `localesTestValue` em pt-BR
- Resultado observado: a mensagem Acesso necessário passou; a asserção de Ativar filtro falhou porque a lista inicial, incluindo o cartão alto de bateria, não havia rolado até esse cartão.
- O que prova: a expectativa também precisava levar em conta a viewport e solicitar a rolagem até os elementos antes de verificar/interagir com eles.
- Escopo da busca e o que ficou de fora: primeiro teste de widget em viewport padrão; a próxima execução validará todo o percurso.
- Arquivo/linha ou caminho do artefato: `test/widget_test.dart`; ordem dos cartões em `lib/features/home/home_page.dart`
- Estado: válida

## E005 — expectativa do aviso ficou atrás do scroll no teste

- Data/hora: 2026-10-14
- Tipo: teste
- Ambiente: Flutter local do projeto
- Procedimento ou comando: executar `flutter test` após trocar para `localesTestValue` e adicionar `scrollUntilVisible`
- Resultado observado: a tela em pt-BR passou a exibir Acesso necessário e o teste encontrou o cartão Ativar filtro após rolar; em seguida a expectativa do texto explicativo falhou porque a rolagem já o havia tirado da área visível/lazy-built.
- O que prova: a expectativa do texto precisa ocorrer antes de rolar até o cartão inferior.
- Escopo da busca e o que ficou de fora: somente ordenação das asserções do mesmo teste de widget.
- Arquivo/linha ou caminho do artefato: `test/widget_test.dart`
- Estado: válida

## E006 — fixture atualizado passa localmente

- Data/hora: 2026-10-14
- Tipo: teste
- Ambiente: Flutter local do projeto
- Procedimento ou comando: `flutter test`, `dart format --output=none --set-exit-if-changed lib test` e `flutter analyze`
- Resultado observado: todos os testes passaram; formatação reportou 25 arquivos sem alterações; análise sem problemas.
- O que prova: o fixture simula SharedPreferencesAsync, fixa locale pt-BR e rola até elementos fora da viewport.
- Escopo da busca e o que ficou de fora: validação local; a nova execução da Action e publicação ainda estão pendentes.
- Arquivo/linha ou caminho do artefato: `test/widget_test.dart`; `pubspec.yaml`; run original `38622743117`
- Estado: válida
