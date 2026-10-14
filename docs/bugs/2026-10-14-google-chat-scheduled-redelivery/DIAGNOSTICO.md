# Diagnóstico — Reentrega após o horário permitido do Google Chat

## Estado

- ID: 2026-10-14-google-chat-scheduled-redelivery
- Fase: reprodução sintética concluída; Google Chat real pendente
- Atualizado em: 2026-10-14
- Próximo passo: repetir CT-01 em aparelho onde Google Chat esteja instalado e possa gerar uma notificação de teste não sensível.
- Confiança na causa: baixa para o relato do Google Chat; alta de que o caminho genérico funcionou na AVD API 36 com horário acelerado.

## Sintoma e ambiente

- Esperado: com o filtro ativo e o acesso concedido, notificações fora dos períodos 08:00–17:00 são adiadas pelo Android e a notificação original volta quando o próximo período permitido começa.
- Observado no aparelho relatado: a pessoa informa que as notificações ficam bloqueadas e não voltam depois. Ainda não há reprodução observada neste caso.
- Passos mínimos: configurar Google Chat em todos os dias, 08:00–17:00, horário local de `America/Sao_Paulo`; publicar uma notificação depois das 17:00; confirmar que sai da central; confirmar que reaparece automaticamente às 08:00 seguintes sem abrir o KillNotify.
- Aparelho e fabricante: sem aparelho físico; AVD `KillQR_API_36` (`emulator-5554`, imagem Google API 36).
- Versão do Android: Android 16 / API 36.
- Versão/build do app: KillNotify 1.0.0+1, debug local.
- Permissões e estado do NotificationListenerService: acesso concedido na AVD; tela inicial mostrou “Filtro ativo”.
- Apps envolvidos: Google Chat (`com.google.android.apps.dynamite`); produtor sintético separado `dev.killnotify.probe`.

## Fatos confirmados

- A regra do Google Chat foi adicionada ao backup de teste com um intervalo 08:00–17:00 para cada dia (`dayIndex` 0–6). A importação informou que o pacote Google Chat não está instalado e preservou seus horários.
- O AVD não tem `com.google.android.apps.dynamite`; portanto, não pode gerar uma notificação real do Google Chat nesta sessão.
- O acesso do listener foi concedido pela tela de configurações Android e o filtro mostrou-se ativo.
- `NotificationFilterService.onNotificationPosted` calcula `nextStartEpochMillis`, salva metadados mínimos e chama `snoozeNotification(key, remainingMillis)`. O callback de reentrega reavalia a janela em `WeeklyScheduleEngine`.
- Para verificar a camada Android sem conteúdo real, foi instalado o produtor sintético `dev.killnotify.probe`; os textos dele são fixos e artificiais.
- A zona da AVD era GMT. Ela foi alterada para `America/Sao_Paulo` enquanto o processo KillNotify já estava ativo. A primeira notificação sintética ficou pendente para 05:00 local, indício de cache de zona no processo de teste; esse resultado foi separado da execução após reinício.
- Após reiniciar KillNotify no fuso `America/Sao_Paulo`, a tela inicial mostrou o próximo início às 08:00. Um segundo ID sintético publicado às 17:12 ficou pendente até 08:00 do dia seguinte.
- Avançando o relógio da AVD para o dia seguinte às 05:01, o listener recebeu o original de calibração e reavaliou a regra, mantendo-o snoozed até 08:00. Às 08:01, as duas entradas sintéticas reapareceram, o número de pendências do produtor caiu para zero e a contagem agregada do KillNotify passou a 2.
- O processo KillNotify ficou em segundo plano durante o avanço até 08:01; não foi aberto para provocar a reentrega. O AVD foi restaurado ao horário atual e a regra sintética do produtor foi removida. A regra 08:00–17:00 do Google Chat permanece configurada, embora o pacote continue ausente.
- Após o teste, as duas regras que já existiam na AVD foram restauradas junto com a nova regra do Google Chat. A regra do produtor foi removida, o acesso especial foi revogado como estava antes da reprodução e o filtro voltou ao estado desativado. O relógio ficou no horário atual de São Paulo.

## Hipóteses

| Hipótese | Estado | Evidência favorável | Evidência contrária | Próximo teste |
|---|---|---|---|---|
| O Android agenda o original e chama `onNotificationPosted` após snooze longo. | Confirmada na AVD API 36 com relógio acelerado; duração real não aguardada | O teste CT-02 reavaliou o original às 05:01 e o reapresentou às 08:01; a contagem aumentou. | Não valida duração natural de 15 horas nem fabricantes físicos. | Repetir em um aparelho com Google Chat instalado; manter a limitação do acelerador temporal. |
| O listener não recebe/reprocessa callback de snooze longo no AVD. | Não reproduzida no CT-02 | O relato é compatível com essa hipótese. | Duas notificações sintéticas foram reapresentadas e o contador confirmou os callbacks na AVD API 36. | Somente necessário se um aparelho real reproduzir a falha. |
| Fuso horário alterado durante a reprodução deixou o processo com zona em cache e calculou alvo errado. | Confirmada para a primeira calibração do harness | O primeiro alvo foi 05:00; após reiniciar o processo, a tela e o segundo alvo indicaram 08:00. | Não explica o relato com fuso estável e precisa ser reproduzida em aparelho real se houver mudança de zona. | Manter o processo reiniciado após mudança de fuso; testar separadamente mudanças ao vivo se forem relevantes. |
| Google Chat não publica a notificação esperada por ajuste de canal, modo Não Perturbe ou política do app. | Não testada | Nenhuma notificação real foi gerada nesta AVD. | Nenhum dado do aparelho do relato está disponível. | Confirmar o estado do Chat e seu canal no aparelho onde o comportamento foi observado. |

## Causa raiz

Não determinada para o Google Chat. No caminho genérico da AVD API 36, o original sintético permaneceu snoozed, foi reavaliado pelo callback e reapareceu às 08:01 sem abrir o KillNotify. Isso não descarta comportamento específico do Chat, de uma versão Android ou de um OEM; não há evidência para corrigir o mecanismo comum agora.

## Escopo e impacto

- Comportamento afetado: retenção e reentrega de notificações depois de 17:00, na abertura 08:00 seguinte.
- Fora da evidência atual: Google Chat real, aparelho físico, versão/OEM do relato, economia de bateria e a expiração natural após 15 horas corridas.
- Risco: perda ou atraso do original se o Android não disparar o callback; nenhuma cópia será criada.

## Decisões e pendências

- Dados reais de conversas não serão enviados, copiados, registrados ou exibidos. A reprodução de integração usa apenas `dev.killnotify.probe`.
- O backup importado no AVD inclui a regra do Chat para preservar o teste, apesar do pacote ausente; não prova o comportamento do Google Chat.
- A reprodução sintética acelerada distingue o mecanismo Android, mas não substitui a confirmação em um aparelho onde Google Chat esteja instalado.

## Próximo passo

Repetir CT-01 em aparelho ou AVD com Google Chat instalado. Não alterar código até a falha ser reproduzida no app de origem ou surgirem evidências novas.
