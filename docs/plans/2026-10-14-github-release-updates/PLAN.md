# Plano — Publicação inicial e atualização pelo GitHub

## Estado de retomada

- Fase: concluído
- Etapa atual: commit inicial enviado ao branch `main`
- Concluído: verificador e controles em Configurações; declaração de rede e explicação de privacidade; workflow de release por tag; documentação; APK debug analisado, compilado, instalado e conferido; commit/push inicial ao GitHub
- Pendências: criar/configurar os quatro secrets de assinatura e publicar uma release assinada antes de validar uma atualização real
- Arquivos alterados: código Flutter, manifesto, workflow, README, privacidade, releasing, requisitos, arquitetura, decisões, prompt, AGENTS e plano
- Última validação: `flutter analyze` sem apontamentos; `flutter build apk --debug` passou; Configurações conferido no AVD API 36; `origin/main` corresponde ao commit `a3136226fe4fcd38ef96531a69829112c7b3c369`
- Próxima ação: configurar secrets de assinatura no GitHub e, quando quiser distribuir o primeiro APK, enviar a tag `v1.0.0`

## Objetivo e problema

Publicar o código-fonte KillNotify no repositório vazio do usuário e permitir que o app avise quando uma versão mais nova for publicada em GitHub Releases.

## Requisitos confirmados

- Fazer o primeiro commit local e enviar ao branch `main` de `https://github.com/leonardobordin/KillNotify.git`.
- Seguir o fluxo de KillQR: busca automática diária, busca manual, opção de lembrar depois e opção de desligar checagens.
- Buscar somente a release estável pública, comparar SemVer com a versão instalada e abrir o APK/release no GitHub.
- Não enviar configurações, apps, notificações, credenciais ou telemetria. Informar o acesso de rede na tela Configurações.
- Não instalar APK silenciosamente nem publicar/taguear uma release nesta entrega.
- Preparar workflow futuro de release por tag, assinado somente com secrets configurados pelo proprietário.

## Premissas e decisões

- O GitHub Releases API fornece `tag_name`, notas e `browser_download_url`; não requer token para repositório público.
- O APK será baixado/aberto pelo navegador e a instalação final será confirmada pelo Android. “Automática” aqui cobre detectar e avisar, seguindo o comportamento existente do KillQR.
- Preferência, intervalo e adiamento ficam em `SharedPreferences` local, sem entrar no backup JSON.
- O repositório remoto está vazio e usa `main`; portanto o primeiro push não precisa mesclar histórico existente.
- Para atualizar instalações existentes, todas as releases futuras precisam usar a mesma chave de assinatura. O workflow exige secrets e não será disparado nesta tarefa.

## Fora de escopo

- Instalação silenciosa, alterar permissões de instalação desconhecida em nome do usuário ou abrir o instalador sem ação explícita.
- Publicar uma tag/release ou configurar secrets na conta GitHub.
- Enviar dados do filtro à rede, autenticar GitHub dentro do app ou usar backend.

## Arquitetura afetada

- Flutter: serviço da API GitHub, comparação SemVer, preferências locais, aviso de atualização no início e controles em Configurações.
- Kotlin/Android: declarar permissão normal `INTERNET`; sem mudança no listener ou regra semanal.
- Persistência: armazenar a opção de busca, horário da última consulta e adiamento no aparelho; excluir do backup JSON.
- Integrações: API REST pública de GitHub Releases e navegador externo para `browser_download_url`.
- CI/distribuição: workflow de tag cria APK release assinado e checksum quando os secrets de assinatura estiverem configurados.

## Etapas

1. Adicionar serviço de atualização compatível com `releases/latest`, timeout, validação de URLs/JSON e SemVer.
2. Integrar busca automática diária e manual, com preferências e ações locais em Configurações.
3. Atualizar manifesto, privacidade, README, AGENTS, prompt de implementação e docs de release; criar workflow por tag.
4. Executar `flutter analyze` e build debug; instalar/conferir emulador se disponível.
5. Revisar lista de arquivos para publicação, inicializar Git, criar commit inicial e enviar ao `main` remoto vazio.

## Critérios de aceite

- [x] Com busca automática ligada, consulta no máximo uma vez por 24h e só ao abrir o app.
- [x] Busca manual informa versão atual ou erro sem travar a tela.
- [x] Release mais nova mostra versão/notas; “Lembrar amanhã”, “Não lembrar novamente” e “Baixar atualização” estão implementados.
- [x] Baixar abre o asset APK/release oficial e deixa a confirmação para Android.
- [x] Configuração e horários de filtro não são enviados; somente a chamada pública de atualização alcança GitHub.
- [x] Workflow de tag usa assinatura persistente de secrets; nenhum secret/keystore é incluído nem release publicada agora.
- [x] Commit inicial está em `main` no URL indicado e inclui o projeto, sem arquivos de build/segredos.

## Validação

- `flutter pub get`
- `flutter analyze`
- `flutter build apk --debug`
- Revisar exclusões do `.gitignore` e procurar keystores/propriedades locais antes de `git add`.
- Emulador API 36: app instalado, página Configurações aberta; a opção de busca automática aparece ligada por padrão. O repositório ainda não tem uma release para validar um aviso de atualização real.
- Git remoto: branch `main` atualizado e SHA conferido após push.
- Confirmar SHA do `main` remoto após push.
- Não executar testes automatizados sem pedido explícito.
- Não há release no repositório vazio, então a detecção positiva de uma nova versão só poderá ser validada quando uma release APK for publicada.

## Riscos e limitações

- Atualização substitutiva depende de assinar APKs com a mesma chave; perder/trocar a chave impede instalar por cima.
- Android ou o navegador pode exigir “Permitir desta fonte” e confirmação final de instalação.
- Sem release, o endpoint pode responder 404; a busca automática deve ignorar isso sem popup recorrente e a manual explica que ainda não há versão publicada.
- Workflow de release exige quatro secrets de assinatura adicionados pelo proprietário do repositório após o commit.
- API pública do GitHub pode sofrer indisponibilidade/limite de requisições; o app não deve interromper sua função principal por falha no check.
