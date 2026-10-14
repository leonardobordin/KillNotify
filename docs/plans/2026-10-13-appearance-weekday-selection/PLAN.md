# Plano — Aparência e seleção de dias

## Estado de retomada

- Fase: implementação e validação concluídas
- Etapa concluída: tema AMOLED, contornos, seletor semanal, textos/localidade, organização da aba Configurações e APK release assinado.
- Concluído: `flutter analyze`; build debug; instalação e inspeção no AVD API 36; build release; verificação do certificado e SHA-256.
- Resultado manual: data/hora aparecem em português sobre fundo preto AMOLED; campo HEX mostrou borda em repouso e foco; D-S-T-Q-Q-S-S permaneceu em uma linha e salvar Dom/Seg/Ter gerou intervalos nativos distintos. A regra sintética usada na verificação foi removida do AVD após a conferência.
- Assinatura: keystore e 4 propriedades já estavam configurados fora do projeto e foram reutilizados; o certificado do APK release é `CN=KillNotify Release, OU=Android, O=KillNotify`.
- Artefatos: `build/app/outputs/flutter-apk/app-debug.apk`, `build/app/outputs/flutter-apk/app-release.apk` e o checksum `.sha256`; screenshots de conferência em `C:\Temp`.
- Próxima ação: nenhuma. Não foi feita publicação.

## Objetivo e problema

Fazer as subjanelas respeitarem AMOLED, tornar bordas dos campos visíveis, permitir escolher dias em grupo e gerar o APK release com uma chave local persistente.

A interface permanece em pt-BR; a navegação usa “Configurações”, com o aviso de permissão separado do controle “Ativar filtro”.

## Requisitos confirmados

- AlertDialogs, seletores de data e hora usam superfícies pretas no tema AMOLED.
- Campos de formulário mostram contorno legível em repouso, foco e erro.
- O editor oferece sete opções D-S-T-Q-Q-S-S, ordenadas domingo a sábado, selecionáveis em conjunto; acessibilidade anuncia o nome completo de cada dia.
- Um período escolhido para vários dias é salvo como intervalos por dia; horários noturnos e intervalos de 24 horas mantêm semântica atual.
- APK release usa uma chave de assinatura local não armazenada nem publicada no repositório; a mesma chave permanece estável para builds futuros.

## Decisões

- Preservar o engine Kotlin e o formato nativo por dia; expandir a seleção de dias no Flutter antes de salvar.
- Criar/usar o keystore em diretório do usuário e guardar propriedades somente em `~/.gradle/gradle.properties`; nunca imprimir ou gravar a senha no projeto.

## Fora de escopo

- Publicar o APK no GitHub ou em uma loja.
- Alterar regras de entrega, algoritmo semanal ou permissões Android.

## Etapas

1. Corrigir tema compartilhado e contornos; validar diálogos no AMOLED.
2. Substituir o Dropdown de dia por chips multi-seleção e expandir cada período para intervalos nativos por dia.
3. Criar/configurar keystore local, compilar release, verificar assinatura e checksum.
4. Recompilar debug, conferir fluxo no emulador e atualizar documentação.

## Critérios de aceite

- [x] AlertDialog, date picker e time picker têm fundo AMOLED preto.
- [x] Campos mostram contorno visível em repouso e foco.
- [x] Os sete dias aparecem em uma linha na ordem D, S, T, Q, Q, S, S; tooltips/screen reader distinguem as letras repetidas.
- [x] Salvar mantém horários corretos para cada dia selecionado, sem alterar cálculo Kotlin.
- [x] APK release é assinado pelo keystore local persistente; nenhuma senha/keystore entra no repositório.
- [x] A aba Configurações reúne permissão, aparência, privacidade e backup; o Início mostra permissão e ativação em cartões separados.
- [x] Seletores Material continuam em português do Brasil independentemente do idioma configurado no AVD.

## Validação

- [x] `flutter analyze` e `flutter build apk --debug`.
- [x] `flutter build apk --release` e `apksigner verify --print-certs`; certificado release identificado.
- [x] AVD API 36: diálogo, seletores de data/hora e campo de cor em AMOLED; foco/contorno; escolher Dom/Seg/Ter; salvar e conferir intervalos separados.
- [x] AVD API 36: aba “Configurações” e cartões de acesso/ativação visualmente separados.

## Riscos e limitações

- Letras repetidas (S e Q) precisam de rótulos acessíveis.
- O keystore local precisa ser preservado fora do repositório; builds futuros dependem dele.
- A validação AVD não cobre estilos OEM de widgets do sistema.

## Acompanhamento posterior — Ícone K com relógio e transparência

- Data: 2026-10-14
- Pedido: usar a imagem enviada com K, sino e relógio e tornar transparentes apenas as bordas pretas externas.
- Concluído: o exterior do tile tem alpha transparente; o fundo escuro interno permanece opaco. As variantes adaptativa, legacy e monocromática foram alinhadas.
- Validação: alpha do canto superior esquerdo é 0; launcher icon visto na tela de informações do app no AVD API 36; `flutter build apk --debug` e `flutter build apk --release` concluídos; `apksigner` confirmou o certificado `CN=KillNotify Release, OU=Android, O=KillNotify`.
- APK atualizado: `build/app/outputs/flutter-apk/app-release.apk`; SHA-256 `75af8c9ab6ddeb43616c87b901eb7d8c6cc3c3d01ddbad43adf73ed2aa6a83c8`.
- Limitação: máscaras de launchers de fabricantes físicos não foram verificadas.
