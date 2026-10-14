# Plano — Automação de release GitHub

## Estado de retomada

- Fase: concluída
- Etapa atual: alterações enviadas ao branch `main`
- Concluído: workflow alinhado ao KillQR, notas versionadas EN/PT-BR, documentação e D020; YAML parseado, `flutter gen-l10n`, formatação e análise passaram; commit `94be33e` enviado
- Pendências: nenhuma nesta alteração; uma publicação requer secrets de assinatura e uma tag criada pelo proprietário
- Arquivos alterados: workflow, changelogs, guia de release, requisitos, arquitetura, decisão D020 e plano
- Última validação: parser YAML aceitou `.github/workflows/release.yml`; `flutter gen-l10n` e `dart format --output=none --set-exit-if-changed lib test` passaram; `flutter analyze` sem problemas. `flutter test` não foi executado localmente; está no workflow para a próxima tag
- Próxima ação: aguardar feedback; nenhuma tag/release foi criada nesta tarefa

## Objetivo e problema

O KillNotify já cria uma GitHub Release ao receber uma tag SemVer, mas o workflow não executa toda a validação do KillQR e usa notas geradas pelo GitHub. Alinhar essas etapas para que uma tag válida publique um APK assinado, checksum e notas versionadas do changelog.

## Requisitos confirmados

- Acionar a automação com tags `vMAJOR.MINOR.PATCH`, como no KillQR.
- Gerar localizações, conferir formatação, analisar e executar testes antes da compilação.
- Exigir os quatro secrets de assinatura documentados do KillNotify; nunca usar a chave debug em uma release enviada.
- Validar a versão da tag contra `pubspec.yaml` e `AppRelease.version`.
- Publicar APK e checksum SHA-256, usando as notas do changelog para a versão.
- Não criar/enviar uma tag nem publicar uma release nesta alteração.

## Premissas e decisões

- Usar o mesmo fluxo de tag do KillQR; KillNotify não tem flavor `github` nem scripts de auditoria de APK, então manter `flutter build apk --release` da configuração atual.
- Usar secrets `KILLNOTIFY_ANDROID_*` documentados, com falha explícita se algum estiver ausente.
- Preparar a seção `1.0.0` no changelog EN/PT-BR para a primeira release; releases posteriores devem adicionar a seção da nova versão antes de criar a tag. Se uma seção correspondente estiver ausente, as notas terão apenas o nome e a versão do app.
- Decisão D020 registra o comportamento; publicação depende de secrets e de uma tag criada pelo proprietário.

## Fora de escopo

- Criar/enviar tags ou publicar uma release agora.
- Criar, ler, trocar ou registrar valores de secrets da conta GitHub.
- Alterar assinatura/chave, política do app, fluxo de atualização no app ou distribuição na Play Store.

## Arquitetura afetada

- GitHub Actions: validação e publicação após push de uma tag versionada.
- Artefatos: APK release assinado e arquivo SHA-256 anexados à GitHub Release.
- Documentação: changelog bilíngue e instruções de preparação/publicação.

## Etapas

1. Atualizar o changelog EN/PT-BR para seções versionadas e adicionar notas de `1.0.0`.
2. Alinhar `.github/workflows/release.yml` com o fluxo do KillQR, preservando nomes e validação dos secrets do KillNotify.
3. Atualizar `docs/RELEASING.md` para explicar as verificações automáticas e a seção obrigatória do changelog.
4. Conferir formato do workflow, `git diff --check`, análise e build compatíveis; registrar, enviar e conferir `origin/main`.

## Critérios de aceite

- [x] Push de tag compatível dispara o workflow; versão divergente ou secret ausente falha antes da publicação.
- [x] Localizações, formatação, análise e testes estão configurados antes do build.
- [x] Release anexa APK assinado, SHA-256 e notas da seção da versão no changelog, ou nome/versão como fallback.
- [x] Guia e changelogs em EN/PT-BR descrevem o processo sem sugerir que uma release já foi publicada.
- [x] Workflow YAML e diff passam nas verificações; commit é enviado ao branch `main`.

## Validação

- Revisar a sintaxe e as expressões GitHub Actions do YAML.
- Executar `flutter gen-l10n`, `dart format --output=none --set-exit-if-changed lib test`, `flutter analyze` e `flutter test` no workflow; build assinado ocorre somente no evento de tag.
- Nesta tarefa, não criar a tag e não publicar a release.

## Riscos e limitações

- Publicação falha se os quatro secrets de assinatura não estiverem configurados no GitHub.
- Uma assinatura diferente impede a atualização por cima de APKs anteriores.
- Sem a seção versionada no changelog, a release recebe apenas um título simples como notas; o guia instrui a incluir notas antes de criar cada tag.
