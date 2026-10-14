# Decisões

Acrescente decisões ao final; mudanças devem substituir explicitamente a anterior.

## D001 — Snooze nativo como protótipo de reapresentação

- Estado: confirmada para o MVP no escopo testado; compatibilidade além da AVD segue pendente
- Data: 2026-10-13
- Contexto: o app precisa devolver a notificação original, sem recriar extras e ações.
- Decisão: usar `NotificationListenerService.snoozeNotification`; recalcular política em cada callback de reentrega. API 26 é o mínimo inicial. A AVD API 36 reentregou uma notificação de terceiro sintética, a versão atualizada e uma ação original.
- Alternativas consideradas: cancelar e reconstruir notificação (perde fidelidade/ações); alarmes exatos (permissão/precisão sem necessidade comprovada).
- Efeito: nenhum fallback falso; registrar lacunas quando sistema não satisfizer a experiência. Atualização, ação sintética, pedido de sete dias, grupo e prazos após reboot foram observados apenas em uma AVD API 36. Um ensaio com relógio avançado também observou callback, reavaliação e reentrega sintética às 08:01; ele não esperou 15 horas reais, não testou Google Chat e não cobre aparelhos físicos/OEM.
- Origem: evidência técnica/documentação oficial e premissa confirmada no prompt.

## D002 — Significado de “individualmente, em um resumo”

- Estado: confirmada como interpretação revisável
- Data: 2026-10-13
- Contexto: pedido de reapresentação individual acompanhado de resumo.
- Decisão: cada original reaparece individualmente; a tela mostra uma contagem agregada liberada, sem notificação sintética adicional.
- Alternativas consideradas: criar resumo sintético (duplica sinal e pode perder ações/conteúdo).
- Efeito: persistir somente contadores agregados.
- Origem: premissa expressa no prompt e no README inicial.

## D003 — OTP e categorias de chamadas/alarmes

- Estado: confirmada
- Data: 2026-10-13
- Contexto: metadados Android podem identificar algumas categorias; não há categoria universal OTP.
- Decisão: toggles opcionais por app para `CATEGORY_CALL` e `CATEGORY_ALARM`; não ler conteúdo para localizar OTP.
- Alternativas consideradas: varredura de conteúdo (privacidade, falsos positivos e acesso a dados sem categoria universal).
- Efeito: exceção confiável depende de o app de origem marcar a categoria.
- Origem: premissa de produto e restrição de privacidade.

## D004 — Consulta ampla de apps

- Estado: confirmada para seleção ampla; explicar ao usuário
- Data: 2026-10-13
- Contexto: a pessoa pode escolher qualquer app instalado; inventário arbitrário não é coberto por consultas específicas.
- Decisão: usar `QUERY_ALL_PACKAGES` e manter consultas apenas locais, limitadas à lista e aos metadados de rótulo/ícone.
- Alternativas consideradas: `<queries>` seletivas (não cumpre escolha arbitrária).
- Efeito: exige explicação de visibilidade ampliada na tela de privacidade e distribuição fora da Play Store.
- Origem: requisito confirmado e documentação oficial.

## D005 — Contrato e fonte de verdade

- Estado: confirmada
- Data: 2026-10-13
- Contexto: listeners rodam sem engine Dart ativo.
- Decisão: um `MethodChannel` versão 1 e persistência privada Android compartilhada com o serviço; a regra semanal fica somente em Kotlin.
- Alternativas consideradas: duplicar avaliação semanal no Flutter; serviço que depende de engine Dart.
- Efeito: respostas incluem resultado calculado/normalizado do Kotlin; fronteiras validam versão e payload.
- Origem: requisito de arquitetura.

## D006 — Interpretação de calendário

- Estado: confirmada para implementação, risco de DST documentado
- Data: 2026-10-13
- Contexto: regra acompanha o fuso local do dispositivo.
- Decisão: intervalos definidos por minuto de parede local; mudanças de fuso/relógio recalculam a cada callback/consulta. Lacunas e sobreposições de DST seguem resolução `java.time` e são reavaliadas na reentrega.
- Alternativas consideradas: agendar por UTC (mudaria o horário local esperado).
- Efeito: sem promessa de execução exata; comportamento DST deve constar na interface/documentação.
- Origem: requisito confirmado e APIs de calendário da plataforma.

## D007 — Assinatura e distribuição manual

- Estado: confirmada
- Data: 2026-10-13
- Contexto: o projeto prepara APK para distribuição manual, mas nenhum segredo de assinatura foi fornecido e não houve pedido para publicar release.
- Decisão: usar propriedades Gradle locais opcionais para assinatura release; sem elas, o fallback debug serve só para compilação/verificação local. Não criar workflow de publicação nesta entrega.
- Alternativas consideradas: gravar credenciais no repositório (proibido) ou publicar no Play Store (fora do escopo).
- Efeito: releases publicáveis exigem propriedades de assinatura fora do Git e aprovação/tag explícita em trabalho futuro.
- Origem: instrução de distribuição e privacidade do produto.

## D008 — Cor de destaque configurável

- Estado: confirmada
- Data: 2026-10-13
- Contexto: a pessoa quer a seleção de cores disponível no KillQR também no KillNotify.
- Decisão: oferecer seis cores prontas e uma cor personalizada por HEX e canais RGB. Persistir a cor localmente no armazenamento Kotlin, expô-la pelo snapshot e incluí-la opcionalmente no backup schema v1; arquivos antigos assumem `#4F46E5`.
- Alternativas consideradas: persistir somente na interface Flutter (diverge da fonte nativa de configurações) ou aumentar a versão do backup apesar de o novo campo poder ser opcional.
- Efeito: o tema claro, escuro e AMOLED usa a cor como seed/primária e escolhe uma cor de texto com contraste legível.
- Origem: solicitação do usuário e implementação de aparência do KillQR.

## D009 — Ícone original do KillNotify

- Estado: confirmada após revisão final no emulador
- Data: 2026-10-13
- Contexto: após ver duas propostas sem o K, o usuário explicou que quer a mesma composição em que o K se mistura ao QR no KillQR, aqui com o símbolo de notificação.
- Decisão: usar um K central com tratamento angular neon ciano/azul/violeta semelhante ao K do KillQR, integrar o sino no módulo superior esquerdo e acrescentar linhas de notificação no módulo inferior direito, em tile azul-marinho arredondado. Não usar padrão QR, código de barras, moldura de leitura nem o bitmap integral do ícone KillQR.
- Alternativas consideradas: manter somente um sino/relógio (o usuário disse que faltava o K) ou reproduzir o ícone KillQR completo.
- Efeito: reforçar a relação visual entre os apps e trocar os módulos QR/código de barras por elementos de notificação; manter margem de segurança do ícone adaptativo.
- Origem: solicitação do usuário e limite visual registrado no prompt de implementação.

## D010 — Seleção multi-dia de períodos

- Estado: confirmada
- Data: 2026-10-13
- Contexto: a pessoa pediu o seletor curto `D - S - T - Q - Q - S - S` para marcar vários dias de uma vez.
- Decisão: exibir controles circulares multi-seleção na ordem domingo a sábado; fornecer rótulos acessíveis completos; ao salvar, expandir a escolha para um intervalo por dia no contrato Kotlin existente.
- Alternativas consideradas: manter dropdown de dia único ou duplicar lógica semanal em Dart.
- Efeito: engine e armazenamento nativos permanecem por dia; intervalos noturnos/24h continuam iguais.
- Origem: solicitação do usuário e arquitetura Kotlin como fonte única.

## D011 — Superfícies AMOLED e contorno de campos

- Estado: confirmada
- Data: 2026-10-13
- Contexto: screenshot mostra diálogo cinza em tela AMOLED e dropdown sem borda visível.
- Decisão: configurar temas globais de AlertDialog, DatePicker, TimePicker e InputDecoration; usar superfícies pretas em AMOLED e contorno visível em repouso/foco.
- Alternativas consideradas: corrigir apenas o diálogo “Novo período” (deixaria outros diálogos inconsistentes).
- Efeito: todas as subjanelas Material passam a seguir o tema comum.
- Origem: solicitação do usuário e inspeção do tema/fotografia.

## D012 — Keystore local para release

- Estado: confirmada para esta máquina
- Data: 2026-10-13
- Contexto: a pessoa solicitou um APK release assinado. Nesta máquina, o keystore persistente e as quatro propriedades Gradle locais já estavam configurados.
- Decisão: reutilizar essa chave Android fora do projeto, guardar as propriedades apenas em `~/.gradle/gradle.properties` e não publicar nem mostrar a senha.
- Alternativas consideradas: continuar assinando release com a chave debug ou armazenar keystore/segredo no repositório.
- Efeito: o APK `app-release.apk` foi validado com o certificado `CN=KillNotify Release, OU=Android, O=KillNotify`. Builds futuros nesta máquina usam a mesma chave; ela precisa ser preservada para manter a identidade de assinatura.
- Origem: solicitação explícita de assinatura release e instruções de segurança do repositório.

## D013 — Aba Configurações

- Estado: confirmada
- Data: 2026-10-13
- Contexto: a tela chamada “Privacidade” também reúne tema, cores e acesso especial às notificações.
- Decisão: nomear a aba e a tela como “Configurações”, com ícone de engrenagem; manter nessa tela o acesso, aparência, privacidade e backup. Na tela inicial, separar o cartão de permissão do cartão “Ativar filtro”.
- Alternativas consideradas: deixar “Privacidade” como nome geral apesar das opções de aparência e acesso.
- Efeito: o rótulo da navegação corresponde melhor ao conjunto de tarefas disponíveis.
- Origem: solicitação do usuário.

## D014 — Localidade pt-BR em toda a interface

- Estado: confirmada
- Data: 2026-10-13
- Contexto: o seletor Material de hora aparecia em inglês porque a localidade do emulador era herdada pelo app.
- Decisão: fixar `pt_BR` no `MaterialApp` e incluir `flutter_localizations` para localizar seletores e componentes Material.
- Alternativas consideradas: deixar cada aparelho definir os rótulos da interface e dos diálogos.
- Efeito: seletores de data/hora permanecem em português do Brasil em aparelhos configurados em outro idioma.
- Origem: requisito de interface pt-BR e inspeção visual no AVD.

## D015 — Ícone K neon com relógio e alpha externo

- Estado: confirmada
- Data: 2026-10-14
- Contexto: a pessoa enviou a composição K/sino/relógio e pediu que as bordas pretas externas fossem transparentes.
- Decisão: preservar o desenho fornecido, tornar transparente apenas a área externa ao tile neon arredondado e manter opaco o fundo escuro dentro dele. Usar o raster como foreground adaptativo e gerar os tamanhos legados a partir dele; atualizar a variante monocromática com o relógio.
- Alternativas consideradas: remover todo o preto (apagaria o mostrador e o fundo interno do tile) ou conservar o fundo quadrado externo.
- Efeito: cantos externos exibem transparência no launcher; K, sino, relógio e linhas permanecem alinhados em todas as variantes do ícone.
- Origem: imagem fornecida e solicitação do usuário.

## D016 — Exceção de bateria como pré-requisito do filtro

- Estado: confirmada como requisito funcional; detalhes do sistema adotados conforme API pública
- Data: 2026-10-14
- Contexto: o usuário relatou encerramentos/restrições de segundo plano em Xiaomi e Samsung e pediu que bateria e acesso ao listener sejam pré-requisitos.
- Decisão: além do `NotificationListenerService`, exigir que `PowerManager.isIgnoringBatteryOptimizations(packageName)` seja verdadeiro para ativar o filtro. Pedir a exceção com confirmação do sistema e desligar o filtro quando a falta for detectada por `getSnapshot` ou callback. Exibir instruções locais para “Nunca suspensos” em Samsung e autoinício/“Sem restrições” em Xiaomi.
- Alternativas consideradas: confiar apenas no texto da interface (a chamada nativa ainda poderia ativar); marcar manualmente ajustes OEM não consultáveis como se tivessem sido verificados; exigir que a Activity permaneça aberta (não é o modelo do `NotificationListenerService`).
- Efeito: o app consegue verificar e bloquear a isenção padrão Android. Controles de fabricante permanecem recomendações, pois não há API pública uniforme que permita confirmar esse estado. Manter a tela aberta não é requisito; evitar forçar a parada. A isenção não garante imunidade a pressão de memória nem a controles OEM.
- Origem: pedido do usuário e documentação oficial Android, Samsung e Xiaomi. A documentação Android classifica automação de tarefas como caso aceitável para solicitação da isenção; a distribuição do produto segue manual e fora da Play Store.

## D017 — Orientações adicionais por fabricante e ordenação dos apps selecionados

- Estado: confirmada
- Data: 2026-10-14
- Contexto: o usuário pediu verificar outras marcas com controles de bateria em segundo plano e colocar apps habilitados primeiro na lista.
- Decisão: detectar localmente famílias Samsung, Xiaomi/Redmi/POCO, Huawei, realme, OPPO, OnePlus, vivo e Motorola para mostrar instruções específicas baseadas em documentos oficiais; outras marcas recebem um roteiro genérico. A exceção padrão de bateria do Android continua sendo o único controle de fabricante consultável que bloqueia ativação. Ordenar os apps habilitados para o filtro (`selected=true`) no topo da lista, e ordenar alfabeticamente cada grupo por rótulo e pacote; aplicar a busca aos resultados antes da exibição.
- Alternativas consideradas: afirmar que o app confirma controles OEM sem API pública; aplicar uma instrução específica a todas as versões da mesma marca; ordenar por habilitado sem desempate alfabético.
- Efeito: as instruções cobrem controles de suspensão/autoinício observados em múltiplos fabricantes, com aviso de que menus mudam por modelo/versão. A ordenação altera somente apresentação Flutter, sem mudar regras Kotlin ou persistência.
- Origem: pedido do usuário, documentação oficial dos fabricantes e requisito de lista previsível.
- Fontes oficiais consultadas: [Samsung](https://www.samsung.com/us/support/answer/ANS10003442/), [Xiaomi](https://www.mi.com/global/support/faq/details/KA-507608/), [Huawei](https://consumer.huawei.com/en/support/content/en-us15850065/), [realme](https://www.realme.com/in/support/kw/doc/2068398), [OPPO](https://support.oppo.com/in/answer/?aid=2239893), [OnePlus](https://service.oneplus.com/content/dam/support/user-manuals/common/OnePlus_Nord_CE4_Lite_User_Manual.pdf), [vivo](https://in-exstatic-vivofs.vivo.com/gdHFRinHEMrj3yPG/1736324435975/fa46b9bfabcff339da339aa9b9be4e15.pdf) e [Motorola](https://en-us.support.motorola.com/app/answers/detail/a_id/159435/~/tips-to-extend-the-battery-life).

## D018 — Consulta e distribuição de atualizações pelo GitHub

- Estado: confirmada
- Data: 2026-10-14
- Contexto: o usuário pediu publicar KillNotify no repositório GitHub indicado e adaptar a busca de atualizações ao padrão do KillQR.
- Decisão: consultar `GET /repos/leonardobordin/KillNotify/releases/latest` quando a preferência local estiver habilitada, no máximo uma vez por 24 horas ao abrir o app, e também sob ação manual. Comparar versão SemVer, exibir notas e permitir baixar/abrir release, lembrar depois ou desativar checagens. Persistir apenas preferência, última verificação e adiamento no aparelho, fora do backup JSON. O botão abre o asset APK ou página da release no GitHub; o navegador/Android realiza a instalação com confirmação do usuário. Criar workflow de release por tag sem executá-lo agora.
- Alternativas consideradas: consultar o GitHub em cada abertura; download/instalação silenciosa; armazenar token de GitHub; enviar telemetria ou dados do app.
- Efeito: o app passa a solicitar `INTERNET` apenas para consulta pública de releases. O GitHub recebe metadados da conexão (incluindo IP e User-Agent com versão), mas não recebe regras, apps configurados ou dados de notificações. Publicar um APK para testes/updates requer uma release assinada com a mesma chave permanente; a primeira versão será enviada como código ao branch `main`, sem criar release/tag nesta etapa.
- Origem: pedido explícito do usuário, estrutura de atualização do KillQR, API pública de releases do GitHub e limite de instalação de APK no Android.
