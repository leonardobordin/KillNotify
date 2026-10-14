# Diagnóstico — Diálogos AMOLED e contorno dos campos

## Estado

- ID: 2026-10-13-amoled-dialog-theme
- Fase: correção validada no AVD
- Atualizado em: 2026-10-13
- Próximo passo: nenhum para esta correção; a validação em aparelhos OEM segue fora do ambiente disponível.
- Confiança na causa: alta para o campo sem contorno; alta para o uso das superfícies padrão nos diálogos; fabricante/versão do screenshot não foram informados.

## Sintoma e ambiente

- Esperado: ao escolher AMOLED, caixas de diálogo e seletores seguem o fundo preto do app; campos de texto e seleção têm contorno legível.
- Observado: screenshot enviado mostra a página em AMOLED preta, mas o diálogo “Novo período” usa superfície cinza; o campo de dia não apresenta contorno visível.
- Passos mínimos: selecionar AMOLED; abrir Aplicativos > um app > Adicionar período; observar diálogo, seletor de dia e campos Início/Fim.
- Aparelho e fabricante: screenshot não identifica o aparelho.
- Versão do Android: não informada.
- Versão/build do app: não informada; ribbon de debug visível no screenshot.
- Permissões e estado do NotificationListenerService: não relacionados a este sintoma.
- Apps envolvidos, identificados por package name: KillNotify; app de origem não relacionado.

## Fatos confirmados

- `AppTheme._build` ajusta o fundo da página e dos cartões AMOLED, mas não define `dialogTheme`, `datePickerTheme` ou `timePickerTheme`; os componentes de diálogo usam superfícies padrão do esquema Material.
- `InputDecorationTheme.border` usa `BorderSide.none`, portanto campos sem override local não mostram contorno.
- O código possui diálogos AlertDialog e seletores de data/hora nas telas de regras, privacidade e exceções; o tema global é o ponto comum para corrigir todos.

## Hipóteses

| Hipótese | Estado | Evidência favorável | Evidência contrária | Próximo teste |
|---|---|---|---|---|
| A superfície padrão de AlertDialog/DatePicker/TimePicker não usa preto puro no AMOLED. | Confirmada no desenho do tema; screenshot compatível | AppTheme não configura os temas desses componentes e `surfaceContainerHigh` continua derivado do seed | Fabricante/Android do screenshot não informado | Após a alteração, abrir todos os tipos de diálogo no AVD API 36. |
| O contorno dos campos some por causa do `BorderSide.none` global. | Confirmada no código | `InputDecorationTheme.border` declara explicitamente borda nenhuma | Alguns widgets poderiam ter overrides locais | Revisar todos os campos e conferir focado/desfocado no AVD. |

## Causa raiz

O tema não define superfícies específicas para diálogos e pickers AMOLED, então Material usa os containers padrão do esquema. O estilo global de campos desativa a borda explicitamente. A correção deve configurar ambos os pontos no tema comum.

## Escopo e impacto

- Comportamentos afetados: AlertDialogs, seletor de data, seletor de hora e campos de formulário.
- Comportamentos que não foram investigados: fabricante/versão exata do screenshot e widgets de terceiros.
- Risco de perda, duplicação ou atraso de notificações: nenhum; alteração de apresentação.

## Decisões e pendências

- Decisões confirmadas pela pessoa: subdiálogos devem respeitar AMOLED; campos precisam de contorno visível.
- Perguntas bloqueantes: nenhuma para a correção visual.
- Limitações conhecidas: validação visual no AVD API 36 não substitui checagem em aparelhos OEM.

## Próximo passo

Concluído: `DialogThemeData`, `DatePickerThemeData`, `TimePickerThemeData` e estados de borda foram configurados e validados no AVD API 36. Os três tipos de subjanela ficaram pretos e em pt-BR; os campos mostraram borda em repouso e foco. A inspeção em aparelhos OEM continua pendente.
