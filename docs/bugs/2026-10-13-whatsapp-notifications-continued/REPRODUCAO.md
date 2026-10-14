# Reprodução — 2026-10-13-whatsapp-notifications-continued

Use dados sintéticos e um aparelho de teste. Não copie notificações reais, contatos, mensagens, tokens de ações nem prints com conteúdo pessoal.

## Cenário

- Aparelho/fabricante: não informado; sem aparelho físico conectado nesta sessão.
- Versão do Android: desconhecida no relato; AVD disponível Android 16 / API 36.
- Versão/build do app: não informado no relato.
- App de origem de teste: WhatsApp no relato; indisponível na AVD.
- Regra semanal e fuso: não informado. “Horário de agora” não distingue período permitido de bloqueio esperado.
- Estado do acesso às notificações: não informado no aparelho do relato; ausente na AVD disponível.

## Preparação

1. Obter a programação exata e o estado apresentado pela tela inicial no aparelho do relato.
2. Se a causa continuar incerta, usar um produtor sintético separado no mesmo aparelho com o acesso de notificações concedido.

## Passos para reproduzir

1. Selecionar o WhatsApp e ativar o filtro.
2. Configurar os períodos semanais conforme o caso relatado e registrar se o instante do teste está dentro ou fora deles.
3. Enviar uma notificação de teste sem conteúdo pessoal e observar se aparece imediatamente ou é adiada.

## Resultado esperado

Dentro de um período permitido, a notificação chega. Fora de todos os períodos, se o filtro estiver ativo, a regra do app selecionada e o acesso concedido, ela é adiada até a próxima abertura permitida.

## Resultado observado

O relato informa que notificações continuaram chegando durante o horário de teste; não há horário exato nem confirmação de que esse instante estava fora de todas as janelas permitidas.

## Resultado sem correção

PENDENTE — a AVD disponível não tem WhatsApp nem acesso do listener configurado (ver E002).

## Resultado com correção

PENDENTE — nenhuma correção foi proposta ou aplicada.

## Observações

Não usar mensagens reais para reproduzir. Fabricante, economia de bateria, acesso revogado e exceção temporária ainda não foram verificados.
