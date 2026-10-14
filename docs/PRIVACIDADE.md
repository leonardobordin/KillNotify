# Privacidade do KillNotify

O filtro, as regras, os apps escolhidos, exceções e contagens são processados no aparelho. O KillNotify não envia conteúdo ou metadados de notificações, lista de apps, regras, backup, identificadores de dispositivo ou telemetria.

## Atualizações do GitHub

Quando **Buscar atualizações automaticamente** estiver ligado (padrão), o app consulta a API pública do GitHub no máximo uma vez por dia ao ser aberto. A pessoa também pode iniciar uma busca manual ou desligar as buscas automáticas em Configurações. A chamada acessa somente:

```text
https://api.github.com/repos/leonardobordin/KillNotify/releases/latest
```

Como em qualquer conexão HTTPS, o GitHub recebe o endereço IP e os cabeçalhos normais da requisição, incluindo um User-Agent que identifica a versão do app. Nenhuma informação de uso do KillNotify é incluída. A opção de busca, o horário da última verificação e o adiamento de avisos ficam localmente e não são incluídos no backup JSON.

Ao escolher baixar, o app abre o asset APK da release ou a página oficial da release no navegador. O KillNotify não instala APK silenciosamente; o Android e a pessoa confirmam o download e a instalação.

## Permissões relacionadas

- `INTERNET`: usada somente para a busca de releases quando habilitada ou iniciada manualmente.
- `QUERY_ALL_PACKAGES`: permite escolher qualquer app instalado; a consulta permanece local.
- `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`: abre uma confirmação do sistema para permitir atividade em segundo plano.
- Acesso de notificação: concedido pela pessoa nas configurações Android e usado localmente pelo filtro.
