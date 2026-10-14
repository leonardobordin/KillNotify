# Plano — Idiomas do app e páginas do GitHub

## Estado de retomada

- Fase: concluída
- Etapa atual: entrega publicada no branch `main`
- Concluído: oito idiomas e fallback do sistema, seletor persistente, textos e datas localizados, README/changelog EN e pt-BR, requisitos/arquitetura/D019 atualizados; análise limpa, APK debug compilado e troca EN↔pt-BR + iniciais D-S-T-Q-Q-S-S conferidas no emulador; commit `8d7047b` enviado ao GitHub
- Pendências: nenhuma
- Arquivos alterados: ARB e Dart em `lib/`, README/changelog, `pubspec`, configuração l10n e documentação
- Última validação: `flutter gen-l10n`, `flutter analyze` sem problemas e `flutter build apk --debug` concluídos; APK instalado no emulador API 36; telas verificadas em inglês e pt-BR e o seletor semanal mostra D-S-T-Q-Q-S-S
- Próxima ação: aguardar eventual feedback do usuário

## Objetivo e problema

O app e a página pública do GitHub estão somente em português, enquanto o KillQR oferece oito idiomas na interface e README em inglês/pt-BR. O usuário confirmou que quer os dois tipos de localização.

## Requisitos confirmados

- Interface em inglês, pt-BR, espanhol, francês, alemão, italiano, japonês e chinês simplificado.
- Seguir o idioma do sistema por padrão e oferecer seletor manual persistente em Configurações.
- Localizar textos de todas as telas, diálogos, datas, erros nativos convertidos e atualização do GitHub.
- README principal em inglês e `README.pt-BR.md`; changelogs em inglês e pt-BR com links recíprocos.
- Preservar arquitetura Kotlin para regra semanal e manter preferência de idioma fora do backup JSON de regras.
- Fazer commit e push das alterações ao `main` de `leonardobordin/KillNotify`.

## Premissas e decisões

- Usar Flutter `gen-l10n` e arquivos ARB, seguindo estrutura semelhante ao KillQR.
- Nomes de idiomas serão exibidos no idioma correspondente (English, Português (Brasil), Español, Français, Deutsch, Italiano, 日本語, 简体中文).
- Seletores Material seguem automaticamente o locale ativo.
- L10n cobre mensagens de erro do MethodChannel por código; não exibir texto português embutido no Kotlin em idiomas não pt-BR.

## Fora de escopo

- Traduzir documentação técnica inteira para todos os oito idiomas; README/changelog terão inglês e pt-BR.
- Alterar lógica do filtro, regras Kotlin, processo de release ou licença.

## Arquitetura afetada

- Flutter: ARB/AppLocalizations, resolução de locale, preferência local, tela Configurações, textos e formatação de datas.
- Kotlin/Android: manter regras e mensagens nativas por código estável; Flutter apresenta a tradução.
- Persistência: idioma em SharedPreferences, fora do backup JSON.
- GitHub: README EN/pt-BR e changelog EN/pt-BR.

## Etapas

1. Catalogar strings e criar locale config + oito ARBs.
2. Migrar todas as telas, widgets comuns, erros e formatação de datas para `AppLocalizations`.
3. Incluir seletor de idioma em Configurações e seguir locale do sistema por padrão.
4. Criar README/changelog EN e pt-BR, conectá-los e atualizar documentação/release.
5. Rodar `flutter gen-l10n`, `flutter analyze`, build debug, conferir idioma em emulador e publicar commits no GitHub.

## Critérios de aceite

- [x] Seletor manual oferece os oito idiomas, persiste e troca toda a interface sem reiniciar.
- [x] Modo sistema segue locale do Android e cai para inglês quando não houver tradução.
- [x] Textos visíveis, diálogos, erros, datas, permissões e updater não ficam misturados em português ao escolher outro idioma.
- [x] README em inglês aponta ao pt-BR e vice-versa; changelogs também têm versões nos dois idiomas.
- [x] `flutter analyze` e build debug passam; branch `main` remoto recebe as mudanças.

## Validação

- `flutter gen-l10n`
- `flutter analyze`
- `flutter build apk --debug`
- Emulador: alternar EN/pt-BR e conferir a tela Início, editor semanal e Configurações.
- Não executar testes automatizados sem solicitação explícita.

## Riscos e limitações

- O inventário inclui muitas mensagens e textos dinâmicos; uma tradução ausente pode deixar tela parcialmente localizada.
- Kotlin ainda pode gerar mensagens antigas em português; a camada Flutter precisa traduzir por código estável.
- README multilíngue não altera a classificação técnica de linguagens do GitHub, que é inferida de arquivos-fonte.
