# Evidências — 2026-10-13-amoled-dialog-theme

Acrescente entradas ao final. Não apague evidência antiga; marque-a como invalidada e explique por quê. Não inclua corpo de notificações ou dados pessoais.

## E001 — Tema global deixa bordas invisíveis

- Data/hora: 2026-10-13
- Tipo: código
- Ambiente: código-fonte local
- Procedimento ou comando: leitura de `lib/core/theme/app_theme.dart` e telas com campos/diálogos.
- Resultado observado: `InputDecorationTheme.border` usa `BorderSide.none`; nenhum tema específico global para AlertDialog, DatePicker ou TimePicker.
- O que prova: causa no tema compartilhado para a falta de contorno e forte causa para as superfícies não AMOLED.
- Escopo da busca e o que ficou de fora: não identifica o sistema/fabricante do screenshot; não revisou componentes externos ao Material.
- Arquivo/linha ou caminho do artefato: `lib/core/theme/app_theme.dart:49`; screenshot anexado pelo usuário.
- Estado: válida

## E002 — Subjanelas AMOLED corrigidas e verificadas

- Data/hora: 2026-10-13
- Tipo: reprodução manual e inspeção visual
- Ambiente: AVD `emulator-5554`, Android 16 / API 36; app debug local; tema AMOLED; localidade do app pt-BR.
- Procedimento ou comando: abrir Aplicativos > app sintético > Adicionar período; abrir Início;Fim; em Exceções temporárias abrir Escolher horário; tocar o campo HEX no diálogo de cor personalizada.
- Resultado observado: AlertDialog, date picker e time picker usam superfícies pretas; seletores estão em português. O campo HEX apresenta contorno normal e contorno colorido reforçado ao focar. Os sete dias cabem em uma linha.
- O que prova: correção dos componentes Material compartilhados na AVD API 36; a escolha Dom/Seg/Ter foi salva e reapareceu como três intervalos nativos, sem alterar a regra Kotlin.
- Escopo da busca e o que ficou de fora: não cobre skins de fabricantes nem dispositivos físicos; nenhuma permissão de listener foi concedida durante a validação.
- Arquivo/linha ou caminho do artefato: capturas temporárias `C:\Temp\killnotify-period-dialog.png`, `C:\Temp\killnotify-time-dialog.png`, `C:\Temp\killnotify-date-dialog.png`, `C:\Temp\killnotify-color-field-focused.png` e `C:\Temp\killnotify-home.png`.
- Estado: válida
