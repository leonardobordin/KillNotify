---
name: analise-bug
description: Investigue bugs, regressões, falhas de notificações ou diferenças entre comportamento esperado e observado. Registre fatos e evidências, separe hipóteses da causa confirmada e crie um plano antes de alterar a implementação.
---

# Análise de bug

Use esta skill antes de editar código para corrigir uma falha ou explicar um comportamento inesperado.

## Fluxo

1. Leia a solicitação e examine o repositório, o histórico relevante e os arquivos relacionados antes de pedir dados que possam ser obtidos localmente.
2. Defina o sintoma observável, ambiente, versão do Android, versão do app e passos de reprodução. Se algo importante estiver ausente, registre a lacuna e pergunte apenas quando ela impedir a investigação.
3. Reproduza a falha quando houver ambiente e dados adequados. Não use nem registre conteúdo real de notificações, dados pessoais ou segredos. Use notificações sintéticas.
4. Registre evidências com caminho e linha de código, comando e resultado, log sanitizado ou comportamento observado. Rotule claramente fatos, hipóteses, conclusões e itens ainda não verificados.
5. Considere hipóteses alternativas e registre o teste que distingue cada uma. Não declare causa raiz só porque o código parece plausível.
6. Crie ou atualize os arquivos do caso usando os modelos em assets: diagnóstico, evidências e reprodução quando aplicável.
7. Depois do diagnóstico, escreva um plano de correção separado, com escopo, arquivos prováveis, riscos, critérios de aceite e validação. Não altere o código antes de registrar o plano.
8. Se a pessoa pediu a correção, prossiga após o plano quando a causa e o escopo estiverem claros. Pare para uma pergunta se houver uma decisão de produto relevante, evidências conflitantes ou risco de perda de dados.
9. Valide o comportamento afetado conforme o escopo autorizado. Registre comandos, resultados e limitações; não marque como resolvido algo que não foi verificado.

## Arquivos de trabalho

Use docs/bugs/AAAA-MM-DD-slug/ como pasta do caso. Inclua apenas os arquivos necessários:

- DIAGNOSTICO.md: estado atual, sintoma, ambiente, hipóteses, evidências principais, confiança e próximo passo.
- EVIDENCIAS.md: registro incremental de fatos, testes, resultados e escopo de cada busca.
- REPRODUCAO.md: passos mínimos, resultado esperado e observado, com dados sintéticos.
- PLANO_CORRECAO.md: correção proposta, impacto, critérios de aceite e validação.

Atualize docs/bugs/INDEX.md com o identificador, estado e link do caso. Nunca renumere um identificador em uso. Evidência invalidada deve permanecer registrada com o motivo.

## Retomada e contexto

No início de uma retomada, leia o estado e o próximo passo em DIAGNOSTICO.md e a última entrada de EVIDENCIAS.md. Não confie apenas no resumo da conversa.

Se o contexto estiver grande, prepare a compactação em um ponto seguro: salve arquivos e resultados, atualize a fase, decisões, arquivos alterados, validações e próximo passo. Então ofereça um resumo curto de retomada. Não sugira compactar no meio de uma reprodução ou com evidência ainda só na conversa.

## Modelo

Use assets/BUG_DIAGNOSTICO_TEMPLATE.md e assets/BUG_EVIDENCIAS_TEMPLATE.md. Para correções, use assets/PLANO_CORRECAO_TEMPLATE.md.
