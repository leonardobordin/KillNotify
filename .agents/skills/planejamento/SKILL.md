---
name: planejamento
description: Planeje novas funcionalidades, mudanças de arquitetura ou entregas com várias etapas. Inspecione o repositório, registre requisitos e decisões, defina critérios verificáveis e mantenha um plano recuperável antes e durante a implementação.
---

# Planejamento de funcionalidades

Use esta skill quando uma solicitação envolve uma nova funcionalidade, arquitetura, migração ou trabalho que não cabe em uma alteração pequena e local.

## Fluxo

1. Leia a solicitação e inspecione a estrutura, o estado Git, as instruções existentes e o fluxo relacionado. Preserve mudanças preexistentes.
2. Separe requisitos confirmados, inferências, perguntas e restrições. Não pergunte o que o repositório ou a documentação atual já responde.
3. Escreva decisões técnicas e premissas em arquivo antes de iniciar trabalho longo. Pergunte somente quando uma resposta mudar materialmente escopo, privacidade, arquitetura ou comportamento de usuário.
4. Escolha a solução mais simples que atende aos requisitos. Considere Clean Code, SOLID, DRY e YAGNI sem criar camadas, dependências ou opções futuras sem necessidade.
5. Crie um plano verificável usando assets/PLANO_FUNCIONALIDADE_TEMPLATE.md. Inclua etapas pequenas, critérios de aceite, riscos, validação e estado de retomada.
6. Implemente a solicitação já autorizada seguindo o plano. Atualize o plano quando evidências mudarem a abordagem; registre o motivo da mudança.
7. Ao fim de cada etapa, atualize o progresso e o próximo passo. Relate decisões não resolvidas e limitações.

## Artefatos

Use docs/plans/AAAA-MM-DD-slug/PLAN.md para o plano da entrega e docs/decisions/DECISOES.md para decisões que influenciam o produto. Use o modelo da skill como base. Para um ajuste pequeno, não crie uma pasta de planejamento por formalidade; registre apenas o necessário.

Todo plano relevante deve conter: objetivo, requisitos, fora de escopo, decisões, arquitetura afetada, sequência de etapas, critérios de aceite, validação, riscos, estado atual e próximo passo.

## Retomada e compactação

Mantenha no início do plano um estado curto: fase, etapa atual, concluído, pendências, arquivos alterados, última validação e próxima ação. Use esse estado como fonte de retomada após uma nova sessão ou compactação.

Quando a tarefa ficar longa, sugira compactação apenas depois de atualizar o estado e chegar a um ponto seguro. A sugestão deve incluir um resumo de handoff curto e os arquivos que precisam ser relidos. Não repita o plano inteiro no handoff.
