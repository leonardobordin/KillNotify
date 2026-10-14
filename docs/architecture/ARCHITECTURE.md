# Arquitetura

## Estado atual

O MVP usa Flutter feature-first e um serviço nativo Kotlin. O listener compartilha o processo Android do app, persiste no armazenamento privado e nunca inicia nem depende de um engine Dart. A avaliação da semana, normalização, status e próximo início são calculados somente em Kotlin.

## Limites por camada

- `lib/app`: navegação e ciclo de vida da interface.
- `lib/core/native`: cliente do contrato Flutter–Kotlin v1; `lib/core/theme`: Material 3 e temas.
- `lib/l10n`: ARB de oito idiomas; `AppLocalizations` gerado pelo Flutter. A escolha `system`/idioma explícito fica em preferência local, separada das regras e do backup.
- `lib/core/update`: consulta limitada a `GET https://api.github.com/repos/leonardobordin/KillNotify/releases/latest`, comparação semântica de versão, preferência local e abertura do asset/release no navegador. A interface não instala APK diretamente.
- `lib/features`: início/status, seleção e editor de apps, exceções e configurações (acesso, aparência, privacidade e backup). O aviso de acesso na tela inicial fica separado do controle de ativação. A tela de aparência oferece presets de cor e seleção HEX/RGB; o editor de períodos apresenta os dias em uma faixa multi-seleção e expande a escolha para intervalos por dia. Na lista, Dart ordena visualmente os pacotes habilitados (`selected=true`) antes dos demais, com ordem alfabética estável por rótulo/pacote e filtro de busca aplicado antes da exibição. Dart apresenta e edita dados; não decide se uma notificação é permitida.
- `android/app/.../domain/WeeklySchedule.kt`: validação, normalização, janelas efetivas, decisão do momento e próximo início.
- `android/app/.../data/LocalConfigurationStore.kt`: configuração JSON versionada em `SharedPreferences` privado e metadados mínimos das notificações adiadas.
- `android/app/.../NotificationFilterService.kt`: `NotificationListenerService` que aplica a regra e usa o snooze Android.
- `InstalledAppCatalog.kt`: lista instalada via PackageManager e `QUERY_ALL_PACKAGES`.
- `android/notification-probe`: app separado com conteúdo sintético, somente para verificar a integração. Não é empacotado no APK principal.

## Contrato Flutter–Kotlin

Canal: `com.killnotify/v1`; a resposta de `getSnapshot` traz `contractVersion: 1`. Mapas, pacote, tipos, limites e versão são validados no Kotlin. A regra e os horários efetivos sempre vêm do nativo.

| Método | Entrada principal | Resposta |
|---|---|---|
| `getSnapshot` | nenhuma | versão, estado de acesso ao listener/isenção de bateria/serviço, família do fabricante, tema, cor de destaque ARGB, contagem do dia, regras, janelas efetivas e próximo início |
| `listApps` | nenhuma | pacote, rótulo, app do sistema e disponibilidade de tela inicial |
| `saveAppRule` | pacote, seleção, intervalos `{dayIndex,startMinute,endMinute}`, exceções de categoria e prazo temporário | snapshot |
| `removeAppRule` | pacote | snapshot |
| `setFilterEnabled` | `enabled` | snapshot; ativar sem acesso retorna `access_required`; sem isenção da otimização padrão de bateria retorna `battery_optimization_required` |
| `setTemporaryException` | pacotes e `untilEpochMillis` ou null | snapshot |
| `setCategoryExceptions` | pacote e booleanos `allowCalls`/`allowAlarms` | snapshot |
| `setThemeChoice` | `system`, `light`, `dark` ou `amoled` | snapshot |
| `setAccentColor` | `accentColor` ARGB opaca em inteiro | valida e persiste a cor; retorna snapshot |
| `openNotificationAccessSettings` | nenhuma | abre Settings Android |
| `requestBatteryOptimizationExemption` | nenhuma | abre a confirmação Android para colocar o app na lista de exceções de bateria |
| `exportBackup` / `importBackup` | nenhuma; SAF escolhe o documento | exportação cancelável; importação retorna pacotes ausentes e situação do acesso |

Erros estáveis incluem `invalid_argument`, `unsupported_version`, `access_required`, `battery_optimization_required`, `configuration_unreadable`, `invalid_backup`, `busy` e `platform_error`. O backup tem limite de 1 MiB e só é aplicado depois de validar o JSON inteiro.

## Fluxo de notificação

1. Ignore o próprio pacote e consulte a configuração nativa.
2. Se o filtro estiver desativado, sem acesso, sem regra ou sem intervalo selecionado, deixe o sistema entregar.
3. Verifique exceção temporária e categorias Android CALL/ALARM configuradas para aquele app.
4. Avalie o horário com `ZoneId.systemDefault()`. Dentro da janela, passe imediatamente. Fora, calcule o próximo início e chame `snoozeNotification(key, durationMs)`.
5. Persistir apenas SHA-256 da chave do sistema, nome do pacote e prazo. Nunca ler corpo/extras, persistir chave bruta ou recriar notificação.
6. No callback de reentrega, recalcular. Enquanto ainda estiver fora da janela, snoozar novamente; quando passar, remover metadado e somar uma unidade à contagem local do dia.

O app não cria notificação sintética de resumo. A tela exibe uma contagem agregada de reentregas observadas.

## Regras semanais e fuso

Dia 0 é segunda-feira; tempos são minutos de parede local. Início é inclusivo e fim exclusivo. Início igual ao fim significa 24h. Intervalos são divididos no limite semanal, ordenados e coalescidos se sobrepostos ou adjacentes; a configuração original permanece intacta. A resposta nativa fornece segmentos por dia para a interface.

Em transição de horário de verão, `LocalDateTime.atZone` avança horários inexistentes para o horário válido seguinte e usa o offset anterior para horários repetidos. Cada consulta/callback recalcula no fuso atual. O Android controla o snooze já solicitado: se relógio/fuso mudar, o app mostra um status atualizado ao abrir e recalcula no próximo callback, mas não há API pública de unsnooze para forçar a reentrega antes do prazo original. Uma abertura local antecipada pode, portanto, sofrer atraso até o callback do sistema.

## Persistência e backup

`configuration_v1` guarda regra, seleção, categoria, prazo, tema e cor de destaque. O backup inclui a cor em `accentColor`; esse campo é opcional ao importar schema v1 existente e assume `#4F46E5` quando ausente. `pending_snoozed_metadata_v1` guarda somente hash/pacote/prazo; a contagem do dia também fica local. Nenhum desses metadados temporários vai para o backup. Pacotes ausentes são preservados e avisados. Se o backup pedir filtro ativo mas o acesso ao listener ou a isenção de bateria estiver ausente, a importação mantém o filtro desligado e informa o pré-requisito pendente.

A preferência de idioma e as preferências do verificador do GitHub ficam no armazenamento local do Flutter e não são incluídas no backup versionado das regras.

O tema Material 3 usa a cor de destaque escolhida como seed e cor primária, calculando primeiro plano com contraste. O ícone adaptativo usa o raster K/sino/relógio enviado pelo usuário; o alpha externo revela o fundo do launcher, enquanto o interior escuro do tile permanece opaco. O asset legado usa a mesma imagem redimensionada, e o ícone monocromático vetorial conserva K, sino, relógio e linhas. A marca não muda com a cor escolhida no app.

`AppTheme` centraliza `DialogThemeData`, `DatePickerThemeData`, `TimePickerThemeData`, menus e bordas de `InputDecorationTheme`; a variante AMOLED força os fundos de diálogo a preto. O `MaterialApp` carrega `AppLocalizations` para inglês, pt-BR, espanhol, francês, alemão, italiano, japonês e chinês simplificado; segue o locale do sistema por padrão e aceita uma escolha local em Configurações. A seleção semanal exibe uma inicial localizada de cada dia; ela é somente de apresentação: `AppRulePage` salva um `ScheduleInterval` para cada índice Kotlin correspondente (UI domingo→sábado; modelo nativo segunda=0 a domingo=6).

## Plataforma e validação

- `minSdk 26`, pois `snoozeNotification` foi introduzido na API 26. No manifesto, o listener usa `BIND_NOTIFICATION_LISTENER_SERVICE` e `exported=false`.
- `QUERY_ALL_PACKAGES` atende seleção ampla; a tela de privacidade informa o efeito. Rótulos são lidos localmente.
- `INTERNET` é usada somente pelo verificador opcional de releases do GitHub; não solicitamos `POST_NOTIFICATIONS` nem alarmes exatos e não publicamos na Play Store.
- A API latest release é consultada no máximo uma vez a cada 24 horas quando a busca automática estiver ligada, além de uma busca manual. Preferência e timestamp não entram no backup JSON. A requisição contém User-Agent com versão do app e GitHub recebe o IP normal da conexão; nenhum dado do filtro é enviado.
- A ação de baixar abre `browser_download_url` do APK, ou a página oficial da release se o APK não estiver anexado. O navegador/Android controla o download e exige confirmação/ajuste de origem desconhecida conforme o aparelho; o app não instala silenciosamente.
- Sem WorkManager: o próprio snooze Android aciona a reentrega; não há promessa de minuto exato.
- Ao revogar acesso, o listener desativa a configuração quando recebe disconnect; `getSnapshot` também verifica Settings e desativa antes de exibir estado. A ativação exige ainda `PowerManager.isIgnoringBatteryOptimizations(packageName)`; ausência detectada pela Activity ou no callback desliga o filtro. Um botão abre a confirmação do sistema para solicitar a exceção.
- A família do fabricante é reduzida localmente a Samsung, Xiaomi, Huawei, realme, OPPO, OnePlus, vivo, Motorola ou outros apenas para apresentar instruções. O Android não oferece API uniforme para consultar listas de suspensão, autoinício ou restrições de segundo plano do fabricante; essas orientações são manuais e não são condições que o app afirma ter confirmado.
- O `NotificationListenerService` é conectado pelo sistema; não é necessário manter a Activity na tela. A otimização padrão e orientações de fabricante reduzem interrupções, mas não impedem toda pressão de memória, encerramento manual ou política OEM. “Forçar parada” impede callbacks até o sistema reconectar o listener.
- Forçar parada impede filtragem até o sistema reconectar o listener; a tela informa estado aguardando/inativo.
- Android documenta que listeners não recebem acesso em aparelhos de pouca memória com Android Q ou anterior e que work profiles podem ignorar/filtrar listeners. Cobertura real permanece pendente.

## Evidência do protótipo

Resultados por cenário e API/dispositivo estão em [ANDROID_API36_EMULATOR.md](../prototype/ANDROID_API36_EMULATOR.md). O protótipo observou snooze de 10 s, versão atualizada, ação original, prazo de sete dias, grupo e entradas pendentes após reboot em uma AVD API 36. Em um ensaio acelerado 17:12→08:01, o callback de uma notificação sintética foi recebido, reavaliado às 05:01 e reapresentado às 08:01; o relógio avançou artificialmente, então não prova uma espera real de 15 horas nem comportamento específico do Google Chat. Não foram validados aparelho físico, Doze, OEM, API 26 real nem a chegada final do prazo após reboot.

Documentação consultada: [NotificationListenerService](https://developer.android.com/reference/android/service/notification/NotificationListenerService), [visibilidade de pacotes](https://developer.android.com/training/package-visibility/declaring) e [notification listeners em work profiles](https://developer.android.com/work/managed-profiles#listen_for_notifications).
