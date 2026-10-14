# Reprodução — 2026-10-13-amoled-dialog-theme

Use dados sintéticos e um aparelho de teste. Não copie notificações reais, contatos, mensagens, tokens de ações nem prints com conteúdo pessoal.

## Cenário

- Aparelho/fabricante: AVD `KillQR_API_36` para validação; screenshot original não identifica o aparelho.
- Versão do Android: AVD Android 16 / API 36.
- Versão/build do app: build local atual.
- App de origem de teste: não aplicável.
- Regra semanal e fuso: não aplicável.
- Estado do acesso às notificações: não aplicável.

## Preparação

1. Selecionar AMOLED em Privacidade e backup > Aparência.
2. Abrir Aplicativos, selecionar um app e escolher Adicionar período.

## Passos para reproduzir

1. Inspecionar o fundo, contorno e contraste do diálogo Novo período.
2. Abrir os seletores Início e Fim.
3. Conferir também um AlertDialog de Privacidade e o seletor de data na tela Exceções.

## Resultado esperado

Superfícies AMOLED pretas nos diálogos e campos com borda perceptível em estados normal, focado e erro.

## Resultado observado antes da correção

O screenshot fornecido mostra diálogo cinza contra a página preta e campo de seleção sem contorno.

## Resultado sem correção

REPRODUZIDO NO SCREENSHOT — detalhes de aparelho/versão pendentes.

## Resultado com correção

VALIDADO NO AVD API 36. AlertDialog, seletor de data e seletor de hora ficaram com fundo preto e rótulos pt-BR. O campo de cor mostrou borda em repouso e foco. O teste manual não cobre aparelhos OEM.

## Observações

Não envolve notificações nem dados pessoais.
