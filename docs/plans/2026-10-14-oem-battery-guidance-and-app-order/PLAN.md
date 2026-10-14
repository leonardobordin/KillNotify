# Plano — Orientação de bateria por fabricante e prioridade dos apps habilitados

## Estado de retomada

- Fase: concluído
- Etapa atual: versão atualizada aberta na aba Aplicativos do emulador API 36
- Concluído: pesquisa oficial; instruções OEM e detecção local; ordenação de apps selecionados primeiro; documentação; análise Flutter; build e instalação no emulador
- Pendências: verificar os textos em aparelhos físicos de cada fabricante; esses dispositivos não estão conectados
- Arquivos alterados: Activity Kotlin, cartão de bateria, lista de apps, README, requisitos, arquitetura, decisão D017 e este plano
- Última validação: `flutter analyze` sem apontamentos; build APK debug passou; captura da aba Aplicativos mostra dois apps habilitados no topo e os demais em ordem alfabética
- Próxima ação: revisão da tela no emulador; testar em aparelho OEM quando disponível

## Objetivo e problema

Mostrar caminhos úteis quando outras marcas restringem execução em segundo plano e fazer com que apps já habilitados para o filtro sejam mais fáceis de localizar na lista.

## Requisitos confirmados

- Ampliar instruções para fabricantes com documentação oficial de controles adicionais: Huawei, realme, OPPO, OnePlus, vivo e Motorola, mantendo Samsung e Xiaomi.
- Para marcas sem instruções verificadas, usar orientação genérica e não afirmar que opções do fabricante foram verificadas.
- Apps com `selected=true` devem aparecer antes dos demais; cada grupo fica alfabético e a busca continua funcionando.

## Premissas e decisões

- A isenção `PowerManager.isIgnoringBatteryOptimizations()` permanece o único pré-requisito de bateria que pode ser verificado uniformemente pelo Android.
- Menus e rótulos mudam por modelo, versão e região; textos devem orientar o usuário a procurar as opções sem alegar caminhos universais.
- A ordenação é só de apresentação em Dart; Kotlin e configuração não mudam.

## Fora de escopo

- Alterar permissões nativas, persistência, regras do filtro ou notificações.
- Adicionar gate baseado em configuração OEM impossível de verificar.
- Testes em aparelhos físicos de cada fabricante, não disponíveis nesta estação.

## Arquitetura afetada

- Flutter: orientação por família na tela de bateria; lista de apps ordenada por seleção, rótulo e pacote após aplicar busca.
- Kotlin/Android: detectar Huawei, realme, OnePlus e vivo via `Build.MANUFACTURER`/`Build.BRAND` para escolha de texto; nenhuma leitura remota.
- Persistência: nenhuma alteração.
- Permissões: nenhuma alteração.

## Etapas

1. Implementar o classificador local de marcas e os textos correspondentes.
2. Ordenar apps habilitados primeiro e alfabeticamente dentro do grupo.
3. Atualizar README e arquitetura; executar análise/build e abrir a lista no emulador.

## Critérios de aceite

- [x] Huawei, realme, OPPO, OnePlus, vivo e Motorola recebem instruções correspondentes; Samsung/Xiaomi mantêm as existentes; demais marcas recebem texto genérico.
- [x] `selected=true` aparece primeiro e o restante fica alfabético; busca continua usando o grupo ordenado.
- [x] A ordenação só muda a apresentação Flutter, sem alterar configuração nem depender da ordem do PackageManager.

## Validação

- `flutter analyze` e build APK debug.
- Emulador API 36: conferir a lista de apps com regras existentes.
- Não adicionar nem executar testes automatizados sem pedido do usuário.
- Não há emuladores/aparelhos de marcas OEM conectados; as ramificações de texto foram compiladas, mas não observadas em seus aparelhos reais.

## Riscos e limitações

- Instruções foram inferidas de manuais/FAQs oficiais, mas menus variam por região e versão; UI deve instruir a pesquisar nomes quando caminhos não existirem.
- Não é possível verificar programaticamente autoinício, bloqueio de recentes ou listas OEM; orientação manual não garante serviço contínuo.
- Nem todas as marcas/modelos têm documentação pública uniforme; fallback genérico permanece.
