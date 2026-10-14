# Caso de teste — Reentrega agendada do Google Chat

Use dados sintéticos no diagnóstico; não registre conteúdo de conversas, contatos ou ações de notificações reais.

## CT-01 — Google Chat, período diário 08:00–17:00

### Cenário

- Aparelho/fabricante: aparelho Android do relato; pendente. AVD disponível: `KillQR_API_36` / API 36, sem Google Chat instalado.
- Versão do Android: Android 16 / API 36 na AVD.
- Versão/build do app: KillNotify `1.0.0+1`, debug local.
- App de origem: Google Chat, package `com.google.android.apps.dynamite`.
- Regra semanal e fuso: domingo a sábado, 08:00 inclusivo–17:00 exclusivo, `America/Sao_Paulo`.
- Estado do acesso às notificações: concedido na AVD; filtro ativo.

### Preparação

1. Confirmar que Google Chat está instalado e que suas notificações estão habilitadas no aparelho real.
2. No KillNotify, selecionar Google Chat e criar um período diário de 08:00 a 17:00 em todos os dias.
3. Conferir que “Filtro ativo” aparece e que não há exceção temporária para o Chat.
4. Anotar a hora local, fuso, versão do Android e fabricante; não copiar texto de mensagem.

### Passos para reproduzir

1. Durante a janela (por exemplo 16:55), usar uma notificação de teste não sensível e confirmar que ela aparece normalmente.
2. Depois das 17:00 (por exemplo 17:05), gerar outra notificação de teste não sensível do Google Chat.
3. Confirmar que o original sai da central de notificações e não é substituído por uma cópia.
4. Não abrir o KillNotify. Às 08:01 do dia seguinte, verificar se o original reapareceu automaticamente uma vez.
5. Abrir o KillNotify depois da verificação e anotar apenas a contagem agregada; não registrar título, texto ou ações.

### Resultado esperado

- Às 17:05, o original fica snoozed e ausente da central.
- Às 08:00 seguintes, o Android chama o listener e o original reaparece automaticamente, sem abrir KillNotify e sem duplicação.
- O contador agregado local aumenta em uma unidade após a reentrega.

### Resultado observado

Relato: notificações são bloqueadas, mas não há recebimento posterior. O aparelho, horário/fuso e callback não foram fornecidos. A AVD não tem Google Chat; **PENDENTE de reprodução real do Google Chat.**

### Resultado sem correção

PENDENTE. O primeiro ensaio sintético foi contaminado por mudança de fuso com o processo ativo; ver E003.

### Resultado com correção

Não aplicável ainda; nenhuma correção foi feita.

## CT-02 — Integração sintética acelerada, mesma janela

1. Usar `dev.killnotify.probe` com a mesma programação 08:00–17:00 e filtro ativo.
2. Após reiniciar KillNotify já em `America/Sao_Paulo`, definir o relógio da AVD para 17:12 e publicar um ID novo com texto fixo sintético.
3. Confirmar ausência na lista ativa e prazo pendente para o próximo dia às 08:00.
4. Avançar o relógio AVD para 05:01. A entrada de calibração anterior, que tinha alvo 05:00 porque o processo fora iniciado sob GMT, voltou ao listener e foi reavaliada; o prazo foi recalculado para 08:00.
5. Avançar para 08:01 sem abrir o KillNotify. Confirmar que as duas originais sintéticas aparecem na lista ativa, as pendências somem e a contagem agregada aumenta em duas unidades.

### Resultado observado CT-02

PASSOU na AVD API 36 com relógio acelerado: o ID novo foi marcado até 08:00; uma notificação de calibração disparou às 05:01, foi snoozed novamente até 08:00; às 08:01, `pendingCount=0`, a contagem agregada era 2 e o produtor apareceu na lista ativa do Android. A tela do KillNotify ficou em segundo plano durante a reentrega.

O AVD não tem Google Chat; CT-02 verifica o caminho do listener e do Android, não o app de origem Google Chat nem a expiração após 15 horas corridas. Ao final, a regra 08:00–17:00 do Chat ficou preservada na AVD; o app segue ausente, o filtro global foi restaurado desativado e o produtor sintético foi removido.
