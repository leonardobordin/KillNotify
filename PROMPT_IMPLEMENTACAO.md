# Prompt para implementar o KillNotify — filtro de notificações Android

Atue como engenheiro sênior Flutter e Android. Implemente o aplicativo descrito abaixo no repositório fornecido. Antes de alterar código, inspecione o estado e a estrutura do repositório, leia as instruções existentes e valide as limitações das APIs Android com documentação oficial atual. Não invente capacidades de plataforma.

## Objetivo do produto

Criar o KillNotify, um aplicativo Android que permita à pessoa selecionar aplicativos instalados e configurar, para cada aplicativo, períodos semanais em que suas notificações podem ser entregues. Fora desses períodos, o app deve adiar notificações e reapresentá-las automaticamente quando começar o próximo período permitido.

O aplicativo é Android apenas nesta etapa. O código e os APKs são distribuídos pelo GitHub/GitHub Releases; não publicar na Google Play Store. O app não terá conta, backend, sincronização, telemetria, publicidade ou processamento remoto. A única exceção de rede é a busca opcional e documentada pela API pública de releases do GitHub; não transmita dados do app nessa consulta.

## Respostas e regras de produto confirmadas

- A pessoa pode escolher qualquer app instalado; regras de horário são independentes por aplicativo.
- Cada dia da semana pode ter qualquer quantidade de intervalos.
- Um intervalo pode atravessar a meia-noite e pertence ao dia em que começa. Se início e fim forem iguais, representa um período de 24 horas.
- O horário acompanha o fuso local do dispositivo.
- Sobreposições não podem causar duplicação ou lacunas na política efetiva. Preserve os intervalos configurados e normalize/coalesce intervalos sobrepostos ou adjacentes no cálculo; valide dados inválidos e mostre à pessoa o resultado da normalização.
- Sem regra configurada para um app, permitir notificações desse app.
- Quando dentro de um período permitido, entregar imediatamente. Fora dele, calcular o próximo início semanal válido e adiar até lá.
- A pessoa quer receber novamente as notificações originais e preservar as ações originais sempre que o Android permitir. Mantenha somente a versão mais recente de notificações atualizadas.
- A liberação deve reapresentar cada notificação original individualmente. Interpretação inicial de “em um resumo”: exibir no app um resumo da quantidade liberada, sem criar por padrão uma segunda notificação sintética. Registre esta interpretação como decisão revisável.
- Deve existir uma exceção temporária configurável para permitir notificações durante um período escolhido, por app ou seleção de apps.
- Chamadas e alarmes devem poder passar como exceções se identificáveis por metadados do Android. OTP não possui categoria universal; não afirme que é detectado de forma confiável. Comece com exceções configuráveis por app e, se considerar detecção pelo conteúdo, explique privacidade, falsos positivos e solicite uma decisão antes de implementar.
- Se acesso a notificações necessário estiver ausente, não permita ativar o filtro. Mostre o que falta e encaminhe a pessoa para as configurações do Android. Se o acesso for revogado ou o app for encerrado à força, o Android pode voltar a entregar as notificações sem filtro; o app deve indicar estado inativo quando voltar a abrir. Nunca alegue que pode filtrar sem acesso.
- Configurações e metadados ficam no aparelho. A pessoa pode exportar/importar backup de configuração em JSON versionado. Não inclua textos de notificação no backup. Se um pacote do backup não estiver instalado, importe as outras configurações, preserve ou marque a regra ausente conforme arquitetura e exiba aviso não bloqueante; não encerre a importação com erro.
- Não há exigência de execução exatamente no minuto. Não solicite permissão de alarmes exatos sem demonstrar que o requisito não pode ser atendido sem ela.

## Limites e decisões técnicas obrigatórias

1. Use Flutter para interface e Kotlin para os componentes Android que observam e adiam notificações. O serviço de notificação deve operar sem depender de UI Flutter ou de um engine Dart ativo.
2. Mantenha Kotlin como fonte única da regra semanal usada em background. Não duplique a lógica de decisão em Dart; a UI consulta estado calculado pelo lado Android.
3. Use NotificationListenerService com consentimento explícito nas configurações Android. Faça um protótipo técnico antes de construir o produto completo para verificar snoozeNotification com notificações de terceiros, intervalos longos, atualizações da notificação enquanto adiada, ações originais, agrupamento e comportamento em modos de economia de bateria e diferentes fabricantes.
4. O callback de reentrega deve recalcular a regra. Se a notificação reaparecer antes de uma janela válida, adie-a novamente para o próximo início, sem duplicar a versão mantida.
5. Se o snooze do sistema não cumprir um requisito em determinada versão, não esconda a falha criando uma cópia falsa silenciosamente. Registre o limite e apresente uma alternativa que explique se ações originais, agrupamento ou sons serão perdidos.
6. Recomendação inicial de minSdk: API 26 (Android 8.0), porque NotificationListenerService.snoozeNotification está disponível a partir dessa API e o projeto KillQR já adota API 26. Verifique a compatibilidade em aparelhos reais. A documentação Android registra que notification listeners não podem receber acesso em aparelhos de pouca memória que executem Android Q ou anterior; documente ou ajuste minSdk se isso for inaceitável.
7. A seleção de qualquer app instalado pode exigir QUERY_ALL_PACKAGES quando a visibilidade normal e declarações específicas não bastam. Android 11+ filtra apps instalados por padrão. Use a menor visibilidade possível que ainda cumpra a seleção ampla, explique isso na tela de privacidade e não publique na Play Store neste escopo.
8. Use armazenamento local acessível pelo serviço nativo, de modo que regras sobrevivam ao fechamento da tela e reinicializações. Não armazene o corpo das notificações; persistir apenas os metadados mínimos necessários para estado/diagnóstico.
9. Use uma ponte Flutter–Kotlin estreita, validada e documentada. Prefira contrato tipado; se escolher MethodChannel, documente nomes de métodos, payloads, erros e versão do contrato.
10. Para tarefas agendadas, prefira o próprio snooze do sistema se o protótipo comprovar o comportamento. Use WorkManager para reconciliação adiável, não como promessa de disparo exato. Atualize estado após reboot, mudança de fuso e mudança manual do relógio.

## Arquitetura e padrões

Use organização feature-first em Flutter e limites claros no código Kotlin:

- Flutter: app, navegação e apresentação de horários, apps, permissões e estado.
- Kotlin domain: modelo de programação semanal, normalização de intervalos, avaliação de permissão atual e cálculo do próximo intervalo.
- Kotlin application: processar notificação, salvar programação, aplicar exceção temporária, reconciliar após mudança de horário e consultar status.
- Kotlin data/platform: persistência local, NotificationListenerService, AlarmManager/WorkManager somente quando necessários e APIs de pacote Android.

Adote Clean Code, SOLID, DRY e YAGNI de forma pragmática. Não crie abstrações sem consumidor real, dependências sem justificativa nem camada Flutter que reimplemente o mecanismo Android. Preserve o estilo do repositório existente; se estiver vazio, explique a estrutura escolhida antes de gerar boilerplate amplo.

## Interface visual

Use como referência visual o KillQR público: https://github.com/leonardobordin/KillQR. O tema em lib/core/theme/app_theme.dart usa #4F46E5 como cor de destaque, Material 3 e ColorScheme.fromSeed com variante fidelity, além de temas do sistema, claro, escuro e AMOLED. Adote #4F46E5 como cor inicial e garanta contraste legível. O nome do produto é KillNotify. Por orientação posterior do usuário, o ícone do KillNotify usa um K central com tratamento neon semelhante ao K do KillQR, um sino no módulo superior esquerdo e linhas de notificação no módulo inferior direito. Não reutilize QR, código de barras, moldura de leitura nem o arquivo integral do ícone KillQR.

Interface inicial em português do Brasil. Proponha telas simples: início/status e próximo intervalo, seleção de aplicativos com busca, editor semanal por aplicativo, exceções temporárias, configurações de privacidade e exportar/importar backup. Não acrescente histórico de conteúdo de notificações.

## Arquivos de instrução e workflows Codex

Crie na raiz do repositório um AGENTS.md conciso com visão do produto, arquitetura, limites Android, privacidade, comandos reais do projeto e gatilhos para as skills. Não replique documentos inteiros em AGENTS.md.

Skills de repositório do Codex devem ficar em .agents/skills/<nome>/SKILL.md. Crie:

- .agents/skills/analise-bug/SKILL.md: para investigar primeiro, reproduzir com dados sintéticos, registrar evidências e hipóteses antes de editar, criar plano separado e validar a correção.
- .agents/skills/planejamento/SKILL.md: para analisar solicitações de funcionalidade/arquitetura, registrar requisitos, premissas e decisões, criar um plano e manter o estado de retomada.

Use frontmatter com name e description precisos. Mantenha a skill principal focada e ponha modelos e referências em assets/ ou references/. Não crie skills em .codex/skills nem arquivos de configuração não documentados. A documentação OpenAI atual mapeia instruções de projeto para AGENTS.md e skills de repositório para .agents/skills.

## Planejamento, decisões e bugs em Markdown

Antes de trabalho significativo, crie docs/requirements/REQUIREMENTS.md, docs/architecture/ARCHITECTURE.md e docs/decisions/DECISOES.md. Crie um modelo de plano em docs/templates/PLANO_FUNCIONALIDADE.md e um plano inicial em docs/plans/ para o MVP.

Para bugs, crie docs/bugs/INDEX.md e modelos de registro. Cada caso deve permitir retomar o estado sem depender da conversa e separar: sintoma, ambiente, reprodução, fatos/evidências, hipóteses, causa confirmada ou pendente, impacto, plano de correção, critérios de aceite, validação e próximo passo. Não registre conteúdo real de notificações.

Implemente na skill de bug a sequência diagnóstico → registro de achados → plano de correção → correção, quando solicitada → validação. Nunca altere código durante a fase de diagnóstico. A skill deve sugerir compactação de contexto apenas após salvar o estado em arquivos e em ponto seguro; o handoff deve conter fase, decisões, evidências, arquivos alterados, validação e próxima ação.

Inclua modelos Markdown para diagnóstico de bug, evidências, reprodução, plano de correção, plano de funcionalidade e registro de decisões. Não abra um conjunto grande de documentos sem relação com a tarefa; leia-os conforme necessário.

## Distribuição GitHub

Prepare a documentação para compilar e instalar o APK manualmente. A busca automática de atualizações consulta GitHub Releases, mas abrir o APK e confirmar a instalação continuam sob controle da pessoa e do Android; nunca instale silenciosamente. Se criar workflow de release, publique apenas mediante tag aprovada, anexe APK e checksum SHA-256 e documente os secrets de assinatura necessários. Segredos nunca entram no Git. Não execute publicação de release durante o desenvolvimento.

## Processo de implementação

1. Inspecione o repositório e registre seu estado inicial; preserve alterações preexistentes.
2. Escreva requisitos, arquitetura, decisões e plano antes da implementação ampla.
3. Faça primeiro o protótipo da integração de notificações e documente resultados por API/aparelho.
4. Só então implemente regras semanais, persistência, seleção de apps, ponte, interface, exceções e backup.
5. Atualize os documentos quando a implementação ou a evidência mudar uma decisão.
6. Execute as verificações automatizadas e smoke tests pertinentes ao código. Para a integração de notificações, valide em dispositivo/emulador com notificações sintéticas e informe claramente o que não foi possível testar.
7. Revise os manifestos, permissões, dependências e arquivos de release. Não declare preservação de ações ou precisão de horário sem evidência.

## Critérios de aceite mínimos

- Regras distintas por app e por dia; múltiplos intervalos, intervalos noturnos, intervalo de 24 horas e intervalos sobrepostos tratados de forma previsível.
- App sem regra permite notificações.
- Notificação fora da janela é adiada e reapresentada ao próximo início válido; a versão atualizada substitui a anterior sem duplicação observável.
- Notificação dentro da janela passa sem atraso.
- Exceções temporárias expiram corretamente e chamadas/alarmes reconhecíveis passam conforme a configuração documentada.
- Revogação do acesso é detectada na próxima oportunidade e o app apresenta o estado inativo sem alegar que o filtro segue funcionando.
- Exportação e importação local de configurações funcionam; pacote ausente gera aviso não bloqueante.
- Nenhum corpo de notificação aparece em logs, backup, analytics ou rede.
- Regras funcionam após fechamento/reabertura, reboot e mudança de fuso/relógio dentro das limitações documentadas.

## Itens para registrar como decisão ou risco aberto

- A frase “individualmente, em um resumo” usa a interpretação registrada em README.md: cada original volta individualmente e a tela mostra contagem; confirmar caso isso não corresponda à intenção.
- OTP não tem categoria universal. Proponha exceção por app como padrão; não leia conteúdo para identificar código sem apresentar a decisão de privacidade e falsos positivos.
- Apps de sistema e apps sem launcher podem precisar de tratamento especial na lista de seleção. Liste a cobertura real e permita procurar aplicativos disponíveis; não prometa controlar notificações que o Android não expõe.
- NotificationListenerService tem limitações por versão, perfil de trabalho e aparelhos de pouca memória. Registre qualquer comportamento não suportado.

Entregue ao final um resumo em português com arquitetura, arquivos criados, decisões, verificações executadas, resultados em Android e limitações conhecidas.
