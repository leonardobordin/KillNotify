# Requisitos do KillNotify

## Objetivo

Permitir que a pessoa configure períodos semanais de entrega por aplicativo Android e adie fora deles as notificações originais para o próximo início permitido, com regras e dados locais.

## Requisitos confirmados

- Aplicativo Android; Flutter na interface e Kotlin no processamento em segundo plano. Sem iOS, conta, backend, telemetria, publicidade ou Play Store. A única rede permitida é a consulta opcional à API pública de releases do GitHub para atualização.
- Regras independentes por pacote instalado. Sem regra, a notificação passa.
- Cada dia aceita zero ou mais intervalos. Intervalos noturnos pertencem ao dia em que começam; início igual ao fim significa 24 horas.
- A política acompanha o fuso local. A configuração original permanece visível; sobreposições e adjacências são coalescidas apenas na política efetiva, apresentada à pessoa.
- O mecanismo nativo recalcula a regra ao receber cada notificação e em cada reentrega. Uma versão atualizada da mesma notificação deve substituir a versão adiada anterior, sem duplicação observável.
- Fora da janela, usar `NotificationListenerService.snoozeNotification` e deixar o serviço funcionar sem UI ou engine Dart. AVD API 36 observou reentrega de curto prazo, ação original sintética, atualização, grupo e prazos pendentes após reboot. Um ensaio com relógio avançado também observou reavaliação e reentrega sintética às 08:01 depois de publicar após 17:00; não esperou 15 horas reais nem testou Google Chat. Detalhes por cenário estão em `docs/prototype/ANDROID_API36_EMULATOR.md`.
- Dentro da janela, permitir a entrega imediata. Exceções temporárias podem abranger um ou vários apps. Exceções opcionais por app para categorias Android CALL e ALARM; não detectar OTP pelo conteúdo.
- Sem acesso do listener, não ativar o filtro. Ao reabrir o app, indicar acesso ausente/estado pendente e encaminhar às configurações do Android.
- A ativação do filtro exige também que o KillNotify esteja fora da otimização padrão de bateria do Android. Consultar esse estado nativamente, oferecer a tela de confirmação do sistema e desativar o filtro quando a ausência for detectada.
- Em Samsung, Xiaomi, Huawei, realme, OPPO, OnePlus, vivo e Motorola, orientar sobre limites extras de execução em segundo plano conforme documentação oficial. Em outros aparelhos, mostrar orientação genérica. Esses estados não têm consulta Android uniforme e não devem ser apresentados como verificados pelo app; nomes e disponibilidade variam por modelo/versão.
- Não é necessário deixar a tela do KillNotify aberta. Evitar “Forçar parada”; controles do fabricante, encerramento manual e pressão de memória ainda podem interromper o listener.
- Seleção ampla de apps pode requerer `QUERY_ALL_PACKAGES`; explicar esse acesso na tela de privacidade. Apps sem launcher, apps de sistema, perfis de trabalho e aparelhos de pouca memória têm cobertura limitada a validar.
- Guardar localmente regras, pacotes selecionados, hash de chave do sistema pendente e contagem de resumo. Rótulos vêm do PackageManager e não são persistidos. Nunca guardar conteúdo, pessoas, chaves brutas ou tokens de ações.
- Exportar/importar backup JSON versionado com configurações somente. Validar o arquivo inteiro antes de aplicar; app ausente não bloqueia e gera aviso.
- Interface oferece inglês, pt-BR, espanhol, francês, alemão, italiano, japonês e chinês simplificado; segue o idioma do aparelho por padrão e permite escolha manual persistida em Configurações. Inclui início/status, seleção e programação por app, exceções, privacidade e backup. Cor de destaque inicial `#4F46E5`, Material 3 e temas claro/escuro/AMOLED.
- Repositório público apresenta README e changelog em inglês e português do Brasil, com links entre as versões.
- A pessoa pode escolher a cor de destaque entre seis opções e personalizar uma cor por HEX ou canais RGB. A escolha é local, se aplica aos temas do app e acompanha o backup de configurações; backups antigos usam `#4F46E5`.
- Na lista de apps, os que estão habilitados para o filtro (`selected`) aparecem primeiro; cada grupo permanece em ordem alfabética e respeita a busca.
- O editor de períodos permite selecionar vários dias da semana em ordem domingo a sábado (`D-S-T-Q-Q-S-S`) e aplica o mesmo horário a cada dia marcado.
- Diálogos e seletores de data/hora respeitam as superfícies AMOLED; campos de entrada têm contorno visível nos estados de foco e repouso.
- Datas e seletores Material respeitam o idioma selecionado.
- A aba Configurações reúne atalho de acesso às notificações, aparência, privacidade e backup. No Início, o aviso de acesso e o controle “Ativar filtro” aparecem em cartões separados.
- O ícone Android usa o K neon enviado pelo usuário, com sino no alto à esquerda e relógio/linhas de notificação embaixo à direita. Somente as bordas externas pretas, fora do tile neon arredondado, ficam transparentes; o fundo escuro dentro do tile permanece opaco. Adaptativo, legado e monocromático mantêm a mesma composição. Não reutilizar QR, código de barras, moldura de leitura nem o arquivo integral do ícone KillQR.
- Distribuição por GitHub; ainda não há release publicada nesta implementação.
- O GitHub Actions publica automaticamente um APK assinado, checksum SHA-256 e notas do changelog quando uma tag `vMAJOR.MINOR.PATCH` compatível é enviada; exige os secrets de assinatura e passa por geração l10n, formatação, análise e testes.
- Buscar automaticamente uma vez por dia a release estável de `leonardobordin/KillNotify` quando a opção estiver ligada; oferecer busca manual, adiar lembrete e desligar busca automática.
- Comparar a versão semântica da release com o app instalado. Quando houver atualização, mostrar versão e notas, e abrir o APK/release do GitHub por ação da pessoa. A instalação final permanece confirmada pelo Android; nunca instalar silenciosamente.
- A consulta envia apenas a requisição da versão à API pública do GitHub. Não enviar regras, lista de apps, notificações, identificadores ou telemetria; informar que o GitHub recebe metadados normais de conexão, como endereço IP.
- A preferência de atualização e o horário da última consulta ficam locais e fora do backup JSON das regras.

## Critérios de aceite

- Regras independentes por app/dia, múltiplos intervalos, intervalos noturnos, 24 horas, sobrepostos/adjacentes, inválidos e semanais sem lacunas de normalização.
- App sem regra passa; uma regra permite na janela e calcula o próximo início fora dela.
- Reentrega recalcula a política. Atualização v2 de uma notificação sintética foi reapresentada no emulador; OEMs permanecem pendentes. Falhas do sistema são limitações, sem cópia sintética silenciosa.
- Exceções expiram com base no relógio do dispositivo; categorias só passam quando fornecidas nos metadados Android.
- Permissão ausente impede ativação e é detectada ao retornar ao app.
- Acesso ao listener e exceção padrão de bateria são condições nativas necessárias para ativar. Se qualquer uma for revogada, a próxima verificação do app ou callback do listener desliga o filtro.
- Apps selecionados para o filtro aparecem antes dos demais na lista, preservando ordem alfabética dentro dos grupos.
- A busca automática de atualização respeita a preferência, ocorre no máximo uma vez a cada 24 horas quando o app abre e também pode ser iniciada manualmente.
- Aviso de atualização permite abrir o APK/release, adiar por um dia ou desativar avisos; não há instalação silenciosa.
- Backup versionado valida antes de substituir configuração; pacotes ausentes são preservados com aviso não bloqueante.
- Cor de destaque pronta ou personalizada persiste ao reabrir, atualiza os temas e sobrevive a exportação/importação de backup.
- Um período multi-dia persiste como intervalos nativos por dia, preservando semântica noturna/24h.
- Subjanelas no tema AMOLED usam fundo preto e campos com contorno legível.
- A navegação chama de “Configurações” a tela de acesso, aparência, privacidade e backup; a interface oferece inglês, pt-BR, espanhol, francês, alemão, italiano, japonês e chinês simplificado, seguindo o idioma do sistema ou a preferência local.
- Todos os fluxos visíveis (início, apps, editor, exceções, configurações, diálogos, mensagens de erro e atualização) respeitam o idioma escolhido.
- Ícone original aparece como ícone adaptativo Android com margem segura para as máscaras do launcher.
- Nenhum corpo de notificação aparece em logs, backups, telemetria ou rede.
- Automatizações unitárias e build são verificados; o relatório distingue resultados no emulador de dispositivos físicos/OEM não testados.

## Limitações e questões abertas

- `snoozeNotification` começou na API 26. Teste manual em AVD API 36 observou ação sintética funcional, três entradas de grupo snoozed e quatro prazos pendentes após reboot; não observou a chegada final de grupo/reboot nem prova OEM.
- Não há aparelho físico conectado. Os emuladores instalados são API 36; não há matriz de fabricante ou versão disponível nesta sessão.
- Horários inexistentes/repetidos em mudanças de horário de verão seguem `java.time`. Depois de uma mudança de fuso/relógio, a tela e os próximos callbacks recalculam; o Android não oferece API pública para retirar um snooze pendente e forçar reavaliação antes do prazo já enviado.
- O app não consegue filtrar sem o acesso especial nem controlar notificações não expostas pelo Android.
