# Diagnóstico — teste de widget bloqueia a release `v1.0.0`

## Estado

- ID: 2026-10-14-release-widget-test
- Fase: validação remota
- Atualizado em: 2026-10-14
- Próximo passo: enviar a correção, mover `v1.0.0` para o commit corrigido e confirmar a publicação da release
- Confiança na causa: alta — o log da Action aponta a construção de `SharedPreferencesAsync` sem plataforma, e o setup atual do teste só simula o MethodChannel nativo

## Sintoma e ambiente

- Esperado: teste de widget passa e libera as etapas de assinatura, build e publicação da release.
- Observado: workflow `Release Android APK`, execução `38622743117`, falhou na etapa `Test`; assinatura, build e publicação foram ignorados.
- Passos mínimos: enviar `v1.0.0`; executar `flutter test` no job GitHub Actions.
- Ambiente: GitHub Actions, Ubuntu 24.04.5, Flutter 3.47.2, app na tag `v1.0.0` (commit `7042803ddcb1860a06b334b3abf8c0429a11e41e`).
- Aparelho/Android/notificações: não aplicável; falha ocorre no teste Flutter antes de compilar APK.

## Fatos confirmados

- O teste `test/widget_test.dart` instala um mock de `MethodChannel('com.killnotify/v1')`, mas não define `SharedPreferencesAsyncPlatform.instance`.
- `AppController` cria `SharedPreferencesAsync` durante a inicialização. A plataforma compartilhada lança `Bad state: The SharedPreferencesAsyncPlatform instance must be set.` quando o teste monta `KillNotifyApp`.
- O teste ainda procura a aba `Privacidade`; a interface atual renomeou essa aba para `Configurações`.
- O app foi compilado e conferido no emulador API 36 anteriormente; esta falha não indica problema no filtro de notificações.

## Hipóteses

| Hipótese | Estado | Evidência favorável | Evidência contrária | Próximo teste |
|---|---|---|---|---|
| Falta de mock para preferências causa a falha primária. | Confirmada | Log da execução e `SharedPreferencesAsync` em `app_controller.dart` | Nenhuma | Instalar backend em memória no `setUp` e rerodar o teste |
| As expectativas do widget estão desatualizadas após as localizações. | Confirmada no código; não foi alcançada no log | O teste procura `Privacidade`, mas a navegação usa `Configurações` | A primeira exceção interrompe o fluxo antes dessa asserção | Fixar locale pt-BR e atualizar o rótulo esperado |

## Causa raiz

O teste usa o plugin `shared_preferences` sem inicializar sua implementação de plataforma em memória. A exceção ocorre ao criar `AppController`, impedindo que a tela apareça e fazendo a expectativa seguinte também falhar. Além disso, a asserção do nome da aba está obsoleta após a localização/renomeação.

## Escopo e impacto

- Afetado: `flutter test` na Action que publica releases.
- Não investigado: build assinado, checksum e upload, pois essas etapas foram corretamente ignoradas após a falha de teste.
- Risco de notificações: nenhum; o app de produção e a regra Kotlin não foram alterados.

## Decisões e pendências

- Decisões confirmadas pela pessoa: concluir a publicação automática preparada.
- Perguntas bloqueantes: nenhuma.
- Limitações conhecidas: os secrets estão configurados; a tag foi enviada, mas a primeira Action falhou nos testes e não criou a GitHub Release.

## Próximo passo

Corrigir o fixture/expectativas de `test/widget_test.dart`, enviar o commit, atualizar o ref da tag `v1.0.0` e acompanhar a nova execução da Action.
