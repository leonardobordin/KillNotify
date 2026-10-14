# Plano — Pré-requisitos para o filtro em segundo plano

## Estado de retomada

- Fase: concluído
- Etapa atual: APK debug atualizado e aberto no emulador API 36
- Concluído: pesquisa e registros; gate nativo, diálogo Android, estado Flutter, mensagens OEM e tela Configurações; análise Flutter; build debug; instalação e conferência visual no emulador
- Pendências: concessão/revogação do diálogo não foi exercitada; ainda não há aparelho físico Samsung/Xiaomi para validar opções de fabricante
- Arquivos alterados: requisitos, arquitetura, decisão D016, README, plano, manifesto, Activity, serviço nativo, armazenamento de backup, ponte Flutter e cartões Início/Configurações
- Última validação: `flutter analyze` sem apontamentos; `flutter build apk --debug` passou; APK reinstalado e tela inicial conferida na AVD API 36
- Próxima ação: a pessoa pode tocar em “Ajustar bateria” no emulador; só ela confirma a isenção do Android

## Objetivo e problema

Evitar que o filtro seja ativado quando falta o acesso ao listener ou a isenção padrão de otimização de bateria. Orientar sobre controles de segundo plano adicionais em Xiaomi e Samsung.

## Requisitos confirmados

- O listener e a isenção da otimização padrão de bateria são pré-requisitos verificáveis para ligar o filtro.
- Ao voltar ao app ou receber um callback, detectar a isenção revogada e desligar o filtro.
- Oferecer ação que abre a confirmação do sistema para pedir a isenção.
- Mostrar instruções Samsung/Xiaomi sem afirmar que o app consegue verificar as opções do fabricante.
- Não obrigar manter a Activity aberta; orientar a não forçar a parada do app.

## Premissas e decisões

- `PowerManager.isIgnoringBatteryOptimizations()` é a fonte verificável Android. A isenção padrão não elimina restrições extremas.
- O app é distribuído manualmente e fora da Play Store. O uso de `ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` é coerente com a função central de automação de tarefas descrita na documentação Android.
- As opções OEM são instruções de configuração, não gates confirmados por checkbox: não existe API uniforme para consultá-las.
- “Manter app aberto” significa evitar encerrar/forçar parada; a UI pode sair da tela porque o listener é conectado pelo sistema.

## Fora de escopo

- Iniciar um serviço em primeiro plano permanente, mostrar notificação fixa ou manter a tela acesa.
- Verificar automaticamente lista Samsung Nunca suspensos, autoinício ou política Xiaomi.
- Garantir callback sob pressão de memória, encerramento forçado, perfil de trabalho ou políticas proprietárias.
- Publicar uma release.

## Arquitetura afetada

- Flutter: snapshot model, cartão inicial com pré-requisitos, controle desativado e atalho em Configurações; instruções locais Samsung/Xiaomi.
- Kotlin/Android: consultar isenção, pedir tela do sistema, reforçar gate em `setFilterEnabled`, snapshot e callback do listener.
- Persistência: nenhuma configuração nova.
- Permissões: declarar `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` para abrir o diálogo de consentimento.

## Etapas

1. Adicionar estado da isenção e família do fabricante ao snapshot e à ponte `MethodChannel`.
2. Bloquear ativação em Kotlin e desligar configuração se acesso/isenção forem detectados ausentes.
3. Exibir estado, botão do sistema e orientações OEM na tela inicial e Configurações.
4. Compilar e abrir a versão atual no emulador, atualizando o estado de retomada com o resultado.

## Critérios de aceite

- [x] Sem acesso do listener ou isenção de bateria, toggle fica desativado na interface e a operação nativa retorna erro descritivo.
- [x] Ao revogar qualquer pré-requisito, a consulta da Activity ou callback desliga o estado salvo.
- [x] Com os dois pré-requisitos concedidos, o gate nativo permite ativar o filtro.
- [x] Ação de bateria abre confirmação Android; estado é reconsultado ao voltar ao app.
- [x] Samsung/Xiaomi recebem orientação apropriada e a interface esclarece que a Activity não precisa ficar aberta.

## Validação

- `flutter analyze`: passou sem apontamentos.
- `flutter build apk --debug`: passou depois de usar a configuração temporária de loopback documentada em `AGENTS.md`.
- Emulador API 36: APK instalado e tela do pré-requisito exibida. A interface mostra os dois acessos ausentes e deixa o filtro desativado. Não foi concedida a exceção pelo agente; a confirmação fica para a pessoa.
- Testes automatizados e o fluxo interativo de concessão/revogação não foram executados; validação em telefones Samsung/Xiaomi continua pendente.
- Não adicionar nem executar testes automatizados sem pedido do usuário.

## Riscos e limitações

- A lista de isenção Android reduz limitações de Doze/App Standby, mas não impede encerramento sob pressão de memória ou políticas OEM.
- Labels e caminhos de configurações mudam por versão/região.
- Se o app for posteriormente distribuído pela Play Store, revisar política vigente sobre solicitação de isenção direta.
- A ausência de isenção revogada enquanto o app não está em uso só pode ser observada no próximo callback ou consulta da Activity.
