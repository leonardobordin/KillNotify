# Índice de investigações de bugs

Investigações devem usar dados sintéticos e os modelos em `.agents/skills/analise-bug/assets/`. Não registrar conteúdo de notificações, tokens de ação, contatos ou dados pessoais.

| Caso | Estado | Sintoma | Registro |
|---|---|---|---|
| 2026-10-13-whatsapp-notifications-continued | AVD sintética passou; relato WhatsApp aguarda estado/aparelho | Notificações do WhatsApp continuaram chegando durante o horário indicado | [Diagnóstico](2026-10-13-whatsapp-notifications-continued/DIAGNOSTICO.md) |
| 2026-10-13-amoled-dialog-theme | Corrigido e validado no AVD API 36; OEM pendente | Diálogo cinza em AMOLED e campos sem contorno visível | [Diagnóstico](2026-10-13-amoled-dialog-theme/DIAGNOSTICO.md) |
| 2026-10-14-google-chat-scheduled-redelivery | Integração sintética passou no AVD API 36; Google Chat real pendente | Notificações adiadas após 17:00 não parecem voltar às 08:00 | [Diagnóstico](2026-10-14-google-chat-scheduled-redelivery/DIAGNOSTICO.md) |
| 2026-10-14-release-widget-test | Teste local passa; release v1.0.0 aguarda nova Action | Teste de widget sem backend SharedPreferencesAsync bloqueou a primeira publicação automática | [Diagnóstico](2026-10-14-release-widget-test/DIAGNOSTICO.md) |
