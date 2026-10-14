// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get tabHome => 'Início';

  @override
  String get tabApps => 'Apps';

  @override
  String get tabExceptions => 'Exceções';

  @override
  String get tabSettings => 'Configurações';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Seguir sistema';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get refreshStatus => 'Atualizar estado';

  @override
  String get refreshAppList => 'Atualizar lista';

  @override
  String get notificationsReleasedToday => 'Notificações liberadas hoje';

  @override
  String get notificationCountPrivacy =>
      'Contagem neste aparelho; mensagens e ações não são salvas.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps com horários',
      one: '$count app com horários',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule =>
      'Cada app pode ter seus próprios horários.';

  @override
  String get filterActive => 'Filtro ativo';

  @override
  String get filterActiveExplanation =>
      'O KillNotify está aplicando os horários configurados.';

  @override
  String get filterInactive => 'Filtro inativo';

  @override
  String get listenerNotFollowing =>
      'O KillNotify ainda não está acompanhando as notificações. Algumas podem chegar sem adiamento.';

  @override
  String get batterySetupRequired => 'Ajuste a bateria para continuar';

  @override
  String get batterySetupExplanation =>
      'Permita a atividade em segundo plano para ativar o filtro.';

  @override
  String get schedulesUnavailable => 'Horários indisponíveis';

  @override
  String get schedulesUnavailableExplanation =>
      'O filtro está desligado até que as configurações salvas possam ser lidas.';

  @override
  String get filterDisabled => 'Filtro desativado';

  @override
  String get notificationsArriveNormally =>
      'As notificações chegam normalmente, sem adiamento.';

  @override
  String get accessNeeded => 'Acesso necessário';

  @override
  String get notificationAccessNeeded =>
      'Para aplicar os horários, permita que o KillNotify acompanhe as notificações nas configurações do Android.';

  @override
  String get openAndroidSettings => 'Abrir configurações do Android';

  @override
  String get activateFilter => 'Ativar filtro';

  @override
  String get filterNeedsBoth =>
      'Libere o acesso às notificações e ajuste a bateria antes de ativar.';

  @override
  String get filterNeedsAccess =>
      'Permita o acesso às notificações antes de ativar.';

  @override
  String get filterNeedsBattery =>
      'Ajuste a bateria para o filtro funcionar em segundo plano.';

  @override
  String get filterAppliesSchedules =>
      'Aplica os horários definidos para cada app.';

  @override
  String get restoreBackupForSchedules =>
      'Importe um backup em Configurações para recuperar seus horários.';

  @override
  String get checkingFilter => 'Verificando o filtro…';

  @override
  String get cannotCheckFilter =>
      'Não foi possível verificar o filtro. Toque em atualizar e tente novamente.';

  @override
  String get nextAllowedStart => 'Próximo início permitido';

  @override
  String get nextConfiguredWindow => 'Próxima janela configurada';

  @override
  String get noAppWaiting => 'Nenhum app aguarda horário agora';

  @override
  String get noSchedulesYet => 'Ainda sem horários configurados';

  @override
  String get filterInactiveInformative =>
      'O filtro está inativo; horário informativo.';

  @override
  String get timezoneInfo =>
      'Os horários seguem o fuso configurado no aparelho.';

  @override
  String get chooseAppsAndPeriods =>
      'Escolha os apps e defina quando as notificações podem chegar.';

  @override
  String get androidControlsSnooze =>
      'O Android controla quando uma notificação adiada volta a aparecer. O horário pode variar por economia de bateria, configurações do aparelho ou mudanças no relógio.';

  @override
  String get searchApp => 'Buscar aplicativo';

  @override
  String get clearSearch => 'Limpar busca';

  @override
  String get appsListDisclosure =>
      'A lista também inclui apps do sistema e apps sem ícone na tela inicial. O Android pode não permitir filtrar notificações de perfis de trabalho ou de alguns serviços.';

  @override
  String get noSearchMatch => 'Nenhum app corresponde à busca.';

  @override
  String get systemApp => 'App do sistema';

  @override
  String get noLauncherIcon => 'Sem ícone na tela inicial';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count períodos definidos',
      one: '$count período definido',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps com horários',
      one: '$count app com horários',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'Apps não instalados';

  @override
  String get schedulesPreserved =>
      'Os horários foram preservados e voltam a valer se o app for instalado novamente.';

  @override
  String get appNotFound => 'App não encontrado';

  @override
  String get removeRule => 'Remover regra';

  @override
  String packageIdentifier(String packageName) {
    return 'Identificador: $packageName';
  }

  @override
  String get applySchedulesToApp => 'Aplicar horários a este app';

  @override
  String get noSchedulesAllowNormally =>
      'Sem horários definidos, as notificações chegam normalmente.';

  @override
  String get weeklyPeriods => 'Períodos semanais';

  @override
  String get addPeriod => 'Adicionar período';

  @override
  String get noPeriodsForApp =>
      'Ainda não há horários. As notificações deste app chegam normalmente.';

  @override
  String get period24HoursHint =>
      'Se início e fim forem iguais, o período dura 24 horas.';

  @override
  String get removePeriod => 'Remover período';

  @override
  String get exceptions => 'Exceções';

  @override
  String get allowCallNotifications => 'Permitir notificações de chamadas';

  @override
  String get callsCategoryOnly =>
      'Só quando o app que enviou a notificação informa que é uma chamada.';

  @override
  String get allowAlarmNotifications => 'Permitir notificações de alarmes';

  @override
  String get alarmsCategoryOnly =>
      'Só quando o app que enviou a notificação informa que é um alarme.';

  @override
  String get saveSchedules => 'Salvar horários';

  @override
  String get schedulesSaved => 'Horários salvos.';

  @override
  String get newPeriod => 'Novo período';

  @override
  String get editPeriod => 'Editar período';

  @override
  String get allowedDays => 'Dias em que as notificações podem chegar';

  @override
  String get selectAtLeastOneDay => 'Selecione pelo menos um dia.';

  @override
  String get startTime => 'Início';

  @override
  String get endTime => 'Fim';

  @override
  String get periodMayCrossMidnight =>
      'O período pode terminar no dia seguinte. Se início e fim forem iguais, ele dura 24 horas.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Adicionar';

  @override
  String get save => 'Salvar';

  @override
  String get effectiveSchedule => 'Horários usados pelo filtro';

  @override
  String get overlappingPeriodsGrouped =>
      'Períodos que se sobrepõem ou se encostam são agrupados. Os horários que você configurou continuam salvos.';

  @override
  String get saveToPreviewPeriods =>
      'Salve para conferir como os períodos serão agrupados.';

  @override
  String get noSchedulesNotificationsPass =>
      'Sem horários definidos, as notificações chegam normalmente.';

  @override
  String get temporaryException => 'Exceção temporária';

  @override
  String allowUntil(String time) {
    return 'Permitir até $time';
  }

  @override
  String get noActiveExceptionForApp => 'Sem exceção ativa para este app.';

  @override
  String get oneHour => '1 hora';

  @override
  String get fourHours => '4 horas';

  @override
  String get eightHours => '8 horas';

  @override
  String get twentyFourHours => '24 horas';

  @override
  String get remove => 'Remover';

  @override
  String get temporaryExceptions => 'Exceções temporárias';

  @override
  String get temporaryExceptionsExplanation =>
      'Permita notificações temporariamente para um ou vários apps. A exceção termina no horário escolhido, conforme o relógio do aparelho.';

  @override
  String get duration => 'Duração';

  @override
  String get chooseTime => 'Escolher horário';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selecionados',
      one: '$count selecionado',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Selecionar resultados';

  @override
  String get clear => 'Limpar';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps',
      one: '$count app',
    );
    return 'Permitir $_temp0 temporariamente';
  }

  @override
  String get activeTemporaryExceptions => 'Permissões temporárias ativas';

  @override
  String get noTemporaryExceptions => 'Nenhuma exceção temporária ativa.';

  @override
  String untilTime(String time) {
    return 'Até $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Até $time · Identificador: $packageName';
  }

  @override
  String get endException => 'Encerrar exceção';

  @override
  String get chooseFutureTime => 'Escolha um horário futuro.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Exceção aplicada a $count apps.',
      one: 'Exceção aplicada a $count app.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Acesso às notificações';

  @override
  String get accessGrantedInAndroid =>
      'Concedido nas configurações do Android.';

  @override
  String get accessRequiredToFilter =>
      'Necessário para filtrar notificações de outros apps.';

  @override
  String get automaticUpdates => 'Buscar atualizações automaticamente';

  @override
  String get automaticUpdatesHint =>
      'Consulta o GitHub no máximo uma vez por dia e avisa quando há uma nova versão.';

  @override
  String get checkForUpdateNow => 'Buscar atualização agora';

  @override
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get followSystem => 'Seguir sistema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Cor de destaque';

  @override
  String get customColor => 'Personalizada';

  @override
  String selectedColor(String color) {
    return 'Selecionada: $color';
  }

  @override
  String get localBackup => 'Backup local';

  @override
  String get backupDescription =>
      'O arquivo de configurações contém regras, exceções e preferências. Não contém conteúdo de notificações, mensagens ou ações.';

  @override
  String get exportSettings => 'Exportar configurações';

  @override
  String get importSettings => 'Importar configurações';

  @override
  String get noAccountPrivacy =>
      'O KillNotify não tem conta nem envia dados pessoais. O app é distribuído manualmente e não está na Play Store.';

  @override
  String get importBackupTitle => 'Importar backup?';

  @override
  String get importBackupWarning =>
      'A importação substitui as configurações atuais. O arquivo será validado antes de aplicar.';

  @override
  String get chooseBackupFile => 'Escolher arquivo';

  @override
  String get backupImported => 'Backup importado';

  @override
  String backupMissingApps(String packages) {
    return 'Alguns apps do backup não estão instalados: $packages. Os horários foram preservados.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'O filtro foi importado desativado porque falta o acesso às notificações.';

  @override
  String get importedWithoutBatteryExemption =>
      'O filtro foi importado desativado porque falta permitir atividade em segundo plano na bateria.';

  @override
  String get backupApplied => 'As configurações foram validadas e aplicadas.';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'O que o acesso significa';

  @override
  String get notificationAccessExplanation =>
      'Esse acesso permite que o KillNotify decida se deve adiar cada notificação. O app não lê nem guarda títulos, textos, contatos ou ações, e não envia essas informações para fora do aparelho.';

  @override
  String get installedAppsVisibility => 'Visibilidade de apps instalados';

  @override
  String get installedAppsExplanation =>
      'Para você poder escolher qualquer app instalado, o Android mostra ao KillNotify a lista de apps do aparelho. Ela é usada localmente e não é enviada para ninguém. Isso dá ao app acesso a mais informações sobre os apps instalados; por esse motivo, a distribuição é manual pelo GitHub, fora da Play Store.';

  @override
  String get githubUpdatesPrivacy =>
      'Com a busca automática ligada, o KillNotify consulta a API pública de releases do GitHub no máximo uma vez por dia. O GitHub recebe metadados normais da conexão, como o endereço IP; regras, apps escolhidos e notificações não são enviados. A instalação continua dependendo da confirmação do Android.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Chamadas e alarmes só podem ser liberados automaticamente quando o próprio app os identifica dessa forma. Códigos de verificação não têm identificação padronizada; o KillNotify não lê o conteúdo das mensagens para detectá-los.';

  @override
  String get customColorTitle => 'Cor personalizada';

  @override
  String get hexColor => 'Cor HEX';

  @override
  String red(int value) {
    return 'Vermelho: $value';
  }

  @override
  String green(int value) {
    return 'Verde: $value';
  }

  @override
  String blue(int value) {
    return 'Azul: $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Informe 6 dígitos hexadecimais.';

  @override
  String get apply => 'Aplicar';

  @override
  String get backgroundActivityTitle => 'Permitir atividade em segundo plano';

  @override
  String get batteryExemptionGranted =>
      'A permissão de bateria do Android está ativa.';

  @override
  String get batteryExemptionNeeded =>
      'Necessário para ativar o filtro e acompanhar as notificações com a tela apagada.';

  @override
  String get adjustBattery => 'Ajustar bateria';

  @override
  String get batteryHelpSamsung =>
      'Em Samsung, adicione o KillNotify em Configurações > Bateria e assistência do aparelho > Bateria > Limites de uso em segundo plano > Apps nunca suspensos. Os nomes podem variar conforme a versão.';

  @override
  String get batteryHelpXiaomi =>
      'Em Xiaomi, ative a Inicialização automática em segundo plano em Configurações > Apps > Permissões. Se houver a opção, escolha Sem restrições em Bateria para o KillNotify. Os nomes variam conforme o modelo.';

  @override
  String get batteryHelpHuawei =>
      'Em Huawei, procure Inicialização de apps, escolha o KillNotify e permita Inicialização automática, Inicialização secundária e Executar em segundo plano. Os nomes variam por versão.';

  @override
  String get batteryHelpRealme =>
      'Em realme, procure Gerenciamento de bateria dos apps nas configurações e permita atividade em segundo plano e inicialização automática para o KillNotify, se essas opções estiverem disponíveis.';

  @override
  String get batteryHelpOppo =>
      'Em OPPO/ColorOS, alguns modos de economia limitam apps em segundo plano. Procure nas configurações de Bateria ou Apps a gestão de bateria do KillNotify e permita a atividade em segundo plano, se disponível.';

  @override
  String get batteryHelpOneplus =>
      'Em OnePlus, confira Configurações > Bateria > Mais configurações > Gerenciamento de bateria de apps. Verifique se a atividade em segundo plano do KillNotify não está restrita; o texto e o caminho podem variar.';

  @override
  String get batteryHelpVivo =>
      'Em vivo, procure Configurações > Apps > Acesso especial a apps > Inicialização automática e permita o KillNotify, se essa opção estiver disponível.';

  @override
  String get batteryHelpMotorola =>
      'Em Motorola, se o aparelho tiver Gerenciar apps em segundo plano, escolha Sempre permitir para o KillNotify. Os nomes e a disponibilidade variam por modelo.';

  @override
  String get batteryHelpOther =>
      'Alguns aparelhos oferecem controles próprios para apps em segundo plano. Se ainda houver interrupções, procure as opções de bateria do KillNotify nas configurações do aparelho.';

  @override
  String get noNeedKeepScreenOpen =>
      'Não é necessário deixar o KillNotify aberto na tela. Evite usar Forçar parada; isso interrompe o acompanhamento até o Android reconectar o serviço.';

  @override
  String get checkingUpdates => 'Buscando atualizações';

  @override
  String get consultingGithub => 'Consultando o GitHub…';

  @override
  String get updateOpenFailed => 'Não foi possível abrir o download.';

  @override
  String get noReleasePublished =>
      'Ainda não há uma versão publicada no GitHub.';

  @override
  String get updateCheckFailed => 'Não foi possível buscar atualizações agora.';

  @override
  String get alreadyLatestVersion =>
      'Você já está usando a versão mais recente.';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String versionAvailable(String version) {
    return 'A versão $version está disponível.';
  }

  @override
  String get releaseNotes => 'Notas da versão';

  @override
  String get updateInstallConfirmation =>
      'O download será aberto no navegador. O Android pedirá confirmação para instalar.';

  @override
  String get neverRemind => 'Não lembrar novamente';

  @override
  String get remindTomorrow => 'Lembrar amanhã';

  @override
  String get downloadUpdate => 'Baixar atualização';

  @override
  String get operationNotCompleted => 'A operação não foi concluída.';

  @override
  String get errorAccessRequired =>
      'Conceda acesso às notificações nas configurações do Android antes de ativar o filtro.';

  @override
  String get errorBatteryRequired =>
      'Permita a atividade em segundo plano nas configurações de bateria antes de ativar o filtro.';

  @override
  String get errorInvalidBackup =>
      'O arquivo de backup é inválido ou não pôde ser lido.';

  @override
  String get errorConfigurationUnreadable =>
      'Não foi possível ler as configurações salvas.';

  @override
  String get errorBusy => 'Outra operação já está em andamento.';

  @override
  String get errorInvalidInput =>
      'Algumas informações são inválidas. Confira os dados e tente novamente.';

  @override
  String get errorUnsupportedVersion =>
      'Esta versão do app não conseguiu ler a resposta. Atualize o app e tente novamente.';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get tabHome => 'Início';

  @override
  String get tabApps => 'Apps';

  @override
  String get tabExceptions => 'Exceções';

  @override
  String get tabSettings => 'Configurações';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Seguir sistema';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get refreshStatus => 'Atualizar estado';

  @override
  String get refreshAppList => 'Atualizar lista';

  @override
  String get notificationsReleasedToday => 'Notificações liberadas hoje';

  @override
  String get notificationCountPrivacy =>
      'Contagem neste aparelho; mensagens e ações não são salvas.';

  @override
  String configuredAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps com horários',
      one: '$count app com horários',
    );
    return '$_temp0';
  }

  @override
  String get eachAppHasOwnSchedule =>
      'Cada app pode ter seus próprios horários.';

  @override
  String get filterActive => 'Filtro ativo';

  @override
  String get filterActiveExplanation =>
      'O KillNotify está aplicando os horários configurados.';

  @override
  String get filterInactive => 'Filtro inativo';

  @override
  String get listenerNotFollowing =>
      'O KillNotify ainda não está acompanhando as notificações. Algumas podem chegar sem adiamento.';

  @override
  String get batterySetupRequired => 'Ajuste a bateria para continuar';

  @override
  String get batterySetupExplanation =>
      'Permita a atividade em segundo plano para ativar o filtro.';

  @override
  String get schedulesUnavailable => 'Horários indisponíveis';

  @override
  String get schedulesUnavailableExplanation =>
      'O filtro está desligado até que as configurações salvas possam ser lidas.';

  @override
  String get filterDisabled => 'Filtro desativado';

  @override
  String get notificationsArriveNormally =>
      'As notificações chegam normalmente, sem adiamento.';

  @override
  String get accessNeeded => 'Acesso necessário';

  @override
  String get notificationAccessNeeded =>
      'Para aplicar os horários, permita que o KillNotify acompanhe as notificações nas configurações do Android.';

  @override
  String get openAndroidSettings => 'Abrir configurações do Android';

  @override
  String get activateFilter => 'Ativar filtro';

  @override
  String get filterNeedsBoth =>
      'Libere o acesso às notificações e ajuste a bateria antes de ativar.';

  @override
  String get filterNeedsAccess =>
      'Permita o acesso às notificações antes de ativar.';

  @override
  String get filterNeedsBattery =>
      'Ajuste a bateria para o filtro funcionar em segundo plano.';

  @override
  String get filterAppliesSchedules =>
      'Aplica os horários definidos para cada app.';

  @override
  String get restoreBackupForSchedules =>
      'Importe um backup em Configurações para recuperar seus horários.';

  @override
  String get checkingFilter => 'Verificando o filtro…';

  @override
  String get cannotCheckFilter =>
      'Não foi possível verificar o filtro. Toque em atualizar e tente novamente.';

  @override
  String get nextAllowedStart => 'Próximo início permitido';

  @override
  String get nextConfiguredWindow => 'Próxima janela configurada';

  @override
  String get noAppWaiting => 'Nenhum app aguarda horário agora';

  @override
  String get noSchedulesYet => 'Ainda sem horários configurados';

  @override
  String get filterInactiveInformative =>
      'O filtro está inativo; horário informativo.';

  @override
  String get timezoneInfo =>
      'Os horários seguem o fuso configurado no aparelho.';

  @override
  String get chooseAppsAndPeriods =>
      'Escolha os apps e defina quando as notificações podem chegar.';

  @override
  String get androidControlsSnooze =>
      'O Android controla quando uma notificação adiada volta a aparecer. O horário pode variar por economia de bateria, configurações do aparelho ou mudanças no relógio.';

  @override
  String get searchApp => 'Buscar aplicativo';

  @override
  String get clearSearch => 'Limpar busca';

  @override
  String get appsListDisclosure =>
      'A lista também inclui apps do sistema e apps sem ícone na tela inicial. O Android pode não permitir filtrar notificações de perfis de trabalho ou de alguns serviços.';

  @override
  String get noSearchMatch => 'Nenhum app corresponde à busca.';

  @override
  String get systemApp => 'App do sistema';

  @override
  String get noLauncherIcon => 'Sem ícone na tela inicial';

  @override
  String periodsDefined(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count períodos definidos',
      one: '$count período definido',
    );
    return '$_temp0';
  }

  @override
  String appsWithSchedules(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps com horários',
      one: '$count app com horários',
    );
    return '$_temp0';
  }

  @override
  String get uninstalledApps => 'Apps não instalados';

  @override
  String get schedulesPreserved =>
      'Os horários foram preservados e voltam a valer se o app for instalado novamente.';

  @override
  String get appNotFound => 'App não encontrado';

  @override
  String get removeRule => 'Remover regra';

  @override
  String packageIdentifier(String packageName) {
    return 'Identificador: $packageName';
  }

  @override
  String get applySchedulesToApp => 'Aplicar horários a este app';

  @override
  String get noSchedulesAllowNormally =>
      'Sem horários definidos, as notificações chegam normalmente.';

  @override
  String get weeklyPeriods => 'Períodos semanais';

  @override
  String get addPeriod => 'Adicionar período';

  @override
  String get noPeriodsForApp =>
      'Ainda não há horários. As notificações deste app chegam normalmente.';

  @override
  String get period24HoursHint =>
      'Se início e fim forem iguais, o período dura 24 horas.';

  @override
  String get removePeriod => 'Remover período';

  @override
  String get exceptions => 'Exceções';

  @override
  String get allowCallNotifications => 'Permitir notificações de chamadas';

  @override
  String get callsCategoryOnly =>
      'Só quando o app que enviou a notificação informa que é uma chamada.';

  @override
  String get allowAlarmNotifications => 'Permitir notificações de alarmes';

  @override
  String get alarmsCategoryOnly =>
      'Só quando o app que enviou a notificação informa que é um alarme.';

  @override
  String get saveSchedules => 'Salvar horários';

  @override
  String get schedulesSaved => 'Horários salvos.';

  @override
  String get newPeriod => 'Novo período';

  @override
  String get editPeriod => 'Editar período';

  @override
  String get allowedDays => 'Dias em que as notificações podem chegar';

  @override
  String get selectAtLeastOneDay => 'Selecione pelo menos um dia.';

  @override
  String get startTime => 'Início';

  @override
  String get endTime => 'Fim';

  @override
  String get periodMayCrossMidnight =>
      'O período pode terminar no dia seguinte. Se início e fim forem iguais, ele dura 24 horas.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Adicionar';

  @override
  String get save => 'Salvar';

  @override
  String get effectiveSchedule => 'Horários usados pelo filtro';

  @override
  String get overlappingPeriodsGrouped =>
      'Períodos que se sobrepõem ou se encostam são agrupados. Os horários que você configurou continuam salvos.';

  @override
  String get saveToPreviewPeriods =>
      'Salve para conferir como os períodos serão agrupados.';

  @override
  String get noSchedulesNotificationsPass =>
      'Sem horários definidos, as notificações chegam normalmente.';

  @override
  String get temporaryException => 'Exceção temporária';

  @override
  String allowUntil(String time) {
    return 'Permitir até $time';
  }

  @override
  String get noActiveExceptionForApp => 'Sem exceção ativa para este app.';

  @override
  String get oneHour => '1 hora';

  @override
  String get fourHours => '4 horas';

  @override
  String get eightHours => '8 horas';

  @override
  String get twentyFourHours => '24 horas';

  @override
  String get remove => 'Remover';

  @override
  String get temporaryExceptions => 'Exceções temporárias';

  @override
  String get temporaryExceptionsExplanation =>
      'Permita notificações temporariamente para um ou vários apps. A exceção termina no horário escolhido, conforme o relógio do aparelho.';

  @override
  String get duration => 'Duração';

  @override
  String get chooseTime => 'Escolher horário';

  @override
  String selectedAppsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count selecionados',
      one: '$count selecionado',
    );
    return '$_temp0';
  }

  @override
  String get selectResults => 'Selecionar resultados';

  @override
  String get clear => 'Limpar';

  @override
  String allowAppsTemporarily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apps',
      one: '$count app',
    );
    return 'Permitir $_temp0 temporariamente';
  }

  @override
  String get activeTemporaryExceptions => 'Permissões temporárias ativas';

  @override
  String get noTemporaryExceptions => 'Nenhuma exceção temporária ativa.';

  @override
  String untilTime(String time) {
    return 'Até $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return 'Até $time · Identificador: $packageName';
  }

  @override
  String get endException => 'Encerrar exceção';

  @override
  String get chooseFutureTime => 'Escolha um horário futuro.';

  @override
  String exceptionAppliedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Exceção aplicada a $count apps.',
      one: 'Exceção aplicada a $count app.',
    );
    return '$_temp0';
  }

  @override
  String get notificationAccess => 'Acesso às notificações';

  @override
  String get accessGrantedInAndroid =>
      'Concedido nas configurações do Android.';

  @override
  String get accessRequiredToFilter =>
      'Necessário para filtrar notificações de outros apps.';

  @override
  String get automaticUpdates => 'Buscar atualizações automaticamente';

  @override
  String get automaticUpdatesHint =>
      'Consulta o GitHub no máximo uma vez por dia e avisa quando há uma nova versão.';

  @override
  String get checkForUpdateNow => 'Buscar atualização agora';

  @override
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get followSystem => 'Seguir sistema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Escuro';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'Cor de destaque';

  @override
  String get customColor => 'Personalizada';

  @override
  String selectedColor(String color) {
    return 'Selecionada: $color';
  }

  @override
  String get localBackup => 'Backup local';

  @override
  String get backupDescription =>
      'O arquivo de configurações contém regras, exceções e preferências. Não contém conteúdo de notificações, mensagens ou ações.';

  @override
  String get exportSettings => 'Exportar configurações';

  @override
  String get importSettings => 'Importar configurações';

  @override
  String get noAccountPrivacy =>
      'O KillNotify não tem conta nem envia dados pessoais. O app é distribuído manualmente e não está na Play Store.';

  @override
  String get importBackupTitle => 'Importar backup?';

  @override
  String get importBackupWarning =>
      'A importação substitui as configurações atuais. O arquivo será validado antes de aplicar.';

  @override
  String get chooseBackupFile => 'Escolher arquivo';

  @override
  String get backupImported => 'Backup importado';

  @override
  String backupMissingApps(String packages) {
    return 'Alguns apps do backup não estão instalados: $packages. Os horários foram preservados.';
  }

  @override
  String get importedWithoutNotificationAccess =>
      'O filtro foi importado desativado porque falta o acesso às notificações.';

  @override
  String get importedWithoutBatteryExemption =>
      'O filtro foi importado desativado porque falta permitir atividade em segundo plano na bateria.';

  @override
  String get backupApplied => 'As configurações foram validadas e aplicadas.';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'O que o acesso significa';

  @override
  String get notificationAccessExplanation =>
      'Esse acesso permite que o KillNotify decida se deve adiar cada notificação. O app não lê nem guarda títulos, textos, contatos ou ações, e não envia essas informações para fora do aparelho.';

  @override
  String get installedAppsVisibility => 'Visibilidade de apps instalados';

  @override
  String get installedAppsExplanation =>
      'Para você poder escolher qualquer app instalado, o Android mostra ao KillNotify a lista de apps do aparelho. Ela é usada localmente e não é enviada para ninguém. Isso dá ao app acesso a mais informações sobre os apps instalados; por esse motivo, a distribuição é manual pelo GitHub, fora da Play Store.';

  @override
  String get githubUpdatesPrivacy =>
      'Com a busca automática ligada, o KillNotify consulta a API pública de releases do GitHub no máximo uma vez por dia. O GitHub recebe metadados normais da conexão, como o endereço IP; regras, apps escolhidos e notificações não são enviados. A instalação continua dependendo da confirmação do Android.';

  @override
  String get callsAlarmsOtpPrivacy =>
      'Chamadas e alarmes só podem ser liberados automaticamente quando o próprio app os identifica dessa forma. Códigos de verificação não têm identificação padronizada; o KillNotify não lê o conteúdo das mensagens para detectá-los.';

  @override
  String get customColorTitle => 'Cor personalizada';

  @override
  String get hexColor => 'Cor HEX';

  @override
  String red(int value) {
    return 'Vermelho: $value';
  }

  @override
  String green(int value) {
    return 'Verde: $value';
  }

  @override
  String blue(int value) {
    return 'Azul: $value';
  }

  @override
  String get hexColorNeedsSixDigits => 'Informe 6 dígitos hexadecimais.';

  @override
  String get apply => 'Aplicar';

  @override
  String get backgroundActivityTitle => 'Permitir atividade em segundo plano';

  @override
  String get batteryExemptionGranted =>
      'A permissão de bateria do Android está ativa.';

  @override
  String get batteryExemptionNeeded =>
      'Necessário para ativar o filtro e acompanhar as notificações com a tela apagada.';

  @override
  String get adjustBattery => 'Ajustar bateria';

  @override
  String get batteryHelpSamsung =>
      'Em Samsung, adicione o KillNotify em Configurações > Bateria e assistência do aparelho > Bateria > Limites de uso em segundo plano > Apps nunca suspensos. Os nomes podem variar conforme a versão.';

  @override
  String get batteryHelpXiaomi =>
      'Em Xiaomi, ative a Inicialização automática em segundo plano em Configurações > Apps > Permissões. Se houver a opção, escolha Sem restrições em Bateria para o KillNotify. Os nomes variam conforme o modelo.';

  @override
  String get batteryHelpHuawei =>
      'Em Huawei, procure Inicialização de apps, escolha o KillNotify e permita Inicialização automática, Inicialização secundária e Executar em segundo plano. Os nomes variam por versão.';

  @override
  String get batteryHelpRealme =>
      'Em realme, procure Gerenciamento de bateria dos apps nas configurações e permita atividade em segundo plano e inicialização automática para o KillNotify, se essas opções estiverem disponíveis.';

  @override
  String get batteryHelpOppo =>
      'Em OPPO/ColorOS, alguns modos de economia limitam apps em segundo plano. Procure nas configurações de Bateria ou Apps a gestão de bateria do KillNotify e permita a atividade em segundo plano, se disponível.';

  @override
  String get batteryHelpOneplus =>
      'Em OnePlus, confira Configurações > Bateria > Mais configurações > Gerenciamento de bateria de apps. Verifique se a atividade em segundo plano do KillNotify não está restrita; o texto e o caminho podem variar.';

  @override
  String get batteryHelpVivo =>
      'Em vivo, procure Configurações > Apps > Acesso especial a apps > Inicialização automática e permita o KillNotify, se essa opção estiver disponível.';

  @override
  String get batteryHelpMotorola =>
      'Em Motorola, se o aparelho tiver Gerenciar apps em segundo plano, escolha Sempre permitir para o KillNotify. Os nomes e a disponibilidade variam por modelo.';

  @override
  String get batteryHelpOther =>
      'Alguns aparelhos oferecem controles próprios para apps em segundo plano. Se ainda houver interrupções, procure as opções de bateria do KillNotify nas configurações do aparelho.';

  @override
  String get noNeedKeepScreenOpen =>
      'Não é necessário deixar o KillNotify aberto na tela. Evite usar Forçar parada; isso interrompe o acompanhamento até o Android reconectar o serviço.';

  @override
  String get checkingUpdates => 'Buscando atualizações';

  @override
  String get consultingGithub => 'Consultando o GitHub…';

  @override
  String get updateOpenFailed => 'Não foi possível abrir o download.';

  @override
  String get noReleasePublished =>
      'Ainda não há uma versão publicada no GitHub.';

  @override
  String get updateCheckFailed => 'Não foi possível buscar atualizações agora.';

  @override
  String get alreadyLatestVersion =>
      'Você já está usando a versão mais recente.';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String versionAvailable(String version) {
    return 'A versão $version está disponível.';
  }

  @override
  String get releaseNotes => 'Notas da versão';

  @override
  String get updateInstallConfirmation =>
      'O download será aberto no navegador. O Android pedirá confirmação para instalar.';

  @override
  String get neverRemind => 'Não lembrar novamente';

  @override
  String get remindTomorrow => 'Lembrar amanhã';

  @override
  String get downloadUpdate => 'Baixar atualização';

  @override
  String get operationNotCompleted => 'A operação não foi concluída.';

  @override
  String get errorAccessRequired =>
      'Conceda acesso às notificações nas configurações do Android antes de ativar o filtro.';

  @override
  String get errorBatteryRequired =>
      'Permita a atividade em segundo plano nas configurações de bateria antes de ativar o filtro.';

  @override
  String get errorInvalidBackup =>
      'O arquivo de backup é inválido ou não pôde ser lido.';

  @override
  String get errorConfigurationUnreadable =>
      'Não foi possível ler as configurações salvas.';

  @override
  String get errorBusy => 'Outra operação já está em andamento.';

  @override
  String get errorInvalidInput =>
      'Algumas informações são inválidas. Confira os dados e tente novamente.';

  @override
  String get errorUnsupportedVersion =>
      'Esta versão do app não conseguiu ler a resposta. Atualize o app e tente novamente.';
}
