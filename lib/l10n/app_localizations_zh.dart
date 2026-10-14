// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get tabHome => '首页';

  @override
  String get tabApps => '应用';

  @override
  String get tabExceptions => '例外';

  @override
  String get tabSettings => '设置';

  @override
  String get language => '语言';

  @override
  String get systemLanguage => '跟随系统';

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
  String get refreshStatus => '刷新状态';

  @override
  String get refreshAppList => '刷新应用列表';

  @override
  String get notificationsReleasedToday => '今日已显示的通知';

  @override
  String get notificationCountPrivacy => '仅在此设备上计数；不会保存消息内容或操作。';

  @override
  String configuredAppsCount(int count) {
    return '$count 个应用已设置时间表';
  }

  @override
  String get eachAppHasOwnSchedule => '每个应用都可以使用自己的时间表。';

  @override
  String get filterActive => '过滤已开启';

  @override
  String get filterActiveExplanation => 'KillNotify 正在应用已设置的时间表。';

  @override
  String get filterInactive => '过滤未运行';

  @override
  String get listenerNotFollowing => 'KillNotify 尚未监控通知。部分通知可能不会延迟。';

  @override
  String get batterySetupRequired => '请调整电池设置';

  @override
  String get batterySetupExplanation => '允许后台运行后才能开启过滤。';

  @override
  String get schedulesUnavailable => '时间表不可用';

  @override
  String get schedulesUnavailableExplanation => '读取已保存的设置之前，过滤功能将保持关闭。';

  @override
  String get filterDisabled => '过滤已关闭';

  @override
  String get notificationsArriveNormally => '通知会正常送达，不会延迟。';

  @override
  String get accessNeeded => '需要授权';

  @override
  String get notificationAccessNeeded =>
      '要应用时间表，请在 Android 设置中允许 KillNotify 访问通知。';

  @override
  String get openAndroidSettings => '打开 Android 设置';

  @override
  String get activateFilter => '开启过滤';

  @override
  String get filterNeedsBoth => '开启过滤前，请允许访问通知并调整电池设置。';

  @override
  String get filterNeedsAccess => '开启过滤前，请允许访问通知。';

  @override
  String get filterNeedsBattery => '请调整电池设置，以便过滤功能在后台运行。';

  @override
  String get filterAppliesSchedules => '应用为每个应用设置的时间表。';

  @override
  String get restoreBackupForSchedules => '前往设置导入备份以恢复时间表。';

  @override
  String get checkingFilter => '正在检查过滤状态…';

  @override
  String get cannotCheckFilter => '无法检查过滤状态。点击刷新后重试。';

  @override
  String get nextAllowedStart => '下次允许通知的时间';

  @override
  String get nextConfiguredWindow => '下一个计划时段';

  @override
  String get noAppWaiting => '目前没有应用在等待计划时段';

  @override
  String get noSchedulesYet => '尚未设置时间表';

  @override
  String get filterInactiveInformative => '过滤已关闭；此时间仅供参考。';

  @override
  String get timezoneInfo => '时间表使用此设备设置的时区。';

  @override
  String get chooseAppsAndPeriods => '选择应用并设置允许接收通知的时间。';

  @override
  String get androidControlsSnooze =>
      '延迟的通知何时再次显示由 Android 决定。省电模式、设备设置或时钟变化可能影响时间。';

  @override
  String get searchApp => '搜索应用';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get appsListDisclosure =>
      '此列表包含系统应用和没有主屏幕图标的应用。Android 可能无法显示工作资料或某些服务的通知。';

  @override
  String get noSearchMatch => '没有符合搜索条件的应用。';

  @override
  String get systemApp => '系统应用';

  @override
  String get noLauncherIcon => '没有主屏幕图标';

  @override
  String periodsDefined(int count) {
    return '已设置 $count 个时段';
  }

  @override
  String appsWithSchedules(int count) {
    return '$count 个应用已设置时间表';
  }

  @override
  String get uninstalledApps => '未安装的应用';

  @override
  String get schedulesPreserved => '时间表会保留，重新安装应用后将再次生效。';

  @override
  String get appNotFound => '未找到应用';

  @override
  String get removeRule => '删除规则';

  @override
  String packageIdentifier(String packageName) {
    return '软件包：$packageName';
  }

  @override
  String get applySchedulesToApp => '将时间表应用到此应用';

  @override
  String get noSchedulesAllowNormally => '未设置时间表时，通知会正常送达。';

  @override
  String get weeklyPeriods => '每周时段';

  @override
  String get addPeriod => '添加时段';

  @override
  String get noPeriodsForApp => '尚未设置时间表。此应用的通知会正常送达。';

  @override
  String get period24HoursHint => '开始和结束时间相同时，该时段持续 24 小时。';

  @override
  String get removePeriod => '删除时段';

  @override
  String get exceptions => '例外';

  @override
  String get allowCallNotifications => '允许来电通知';

  @override
  String get callsCategoryOnly => '仅当发送通知的应用将其标记为来电时允许。';

  @override
  String get allowAlarmNotifications => '允许闹钟通知';

  @override
  String get alarmsCategoryOnly => '仅当发送通知的应用将其标记为闹钟时允许。';

  @override
  String get saveSchedules => '保存时间表';

  @override
  String get schedulesSaved => '时间表已保存。';

  @override
  String get newPeriod => '新建时段';

  @override
  String get editPeriod => '编辑时段';

  @override
  String get allowedDays => '允许通知的日期';

  @override
  String get selectAtLeastOneDay => '请至少选择一天。';

  @override
  String get startTime => '开始';

  @override
  String get endTime => '结束';

  @override
  String get periodMayCrossMidnight => '时段可以在次日结束。开始和结束时间相同时，持续 24 小时。';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get effectiveSchedule => '实际生效时间';

  @override
  String get overlappingPeriodsGrouped => '重叠或相邻的时段会合并显示。原始时间表仍会保留。';

  @override
  String get saveToPreviewPeriods => '保存后可查看时段合并结果。';

  @override
  String get noSchedulesNotificationsPass => '未设置时间表时，通知会正常送达。';

  @override
  String get temporaryException => '临时例外';

  @override
  String allowUntil(String time) {
    return '允许至 $time';
  }

  @override
  String get noActiveExceptionForApp => '此应用没有启用的例外。';

  @override
  String get oneHour => '1 小时';

  @override
  String get fourHours => '4 小时';

  @override
  String get eightHours => '8 小时';

  @override
  String get twentyFourHours => '24 小时';

  @override
  String get remove => '移除';

  @override
  String get temporaryExceptions => '临时例外';

  @override
  String get temporaryExceptionsExplanation =>
      '临时允许一个或多个应用的通知。例外会根据此设备的时钟在所选时间结束。';

  @override
  String get duration => '时长';

  @override
  String get chooseTime => '选择时间';

  @override
  String selectedAppsCount(int count) {
    return '已选择 $count 个';
  }

  @override
  String get selectResults => '选择搜索结果';

  @override
  String get clear => '清除';

  @override
  String allowAppsTemporarily(int count) {
    return '临时允许 $count 个应用';
  }

  @override
  String get activeTemporaryExceptions => '当前启用的临时例外';

  @override
  String get noTemporaryExceptions => '没有启用的临时例外。';

  @override
  String untilTime(String time) {
    return '截至 $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return '截至 $time · 软件包：$packageName';
  }

  @override
  String get endException => '结束例外';

  @override
  String get chooseFutureTime => '请选择未来的时间。';

  @override
  String exceptionAppliedCount(int count) {
    return '已为 $count 个应用启用临时例外。';
  }

  @override
  String get notificationAccess => '通知访问权限';

  @override
  String get accessGrantedInAndroid => '已在 Android 设置中允许。';

  @override
  String get accessRequiredToFilter => '过滤其他应用的通知需要此权限。';

  @override
  String get automaticUpdates => '自动检查更新';

  @override
  String get automaticUpdatesHint => '每天最多检查一次 GitHub，有新版本时会通知你。';

  @override
  String get checkForUpdateNow => '立即检查更新';

  @override
  String get appearance => '外观';

  @override
  String get theme => '主题';

  @override
  String get followSystem => '跟随系统';

  @override
  String get lightTheme => '浅色';

  @override
  String get darkTheme => '深色';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => '强调色';

  @override
  String get customColor => '自定义';

  @override
  String selectedColor(String color) {
    return '已选：$color';
  }

  @override
  String get localBackup => '本地备份';

  @override
  String get backupDescription => '设置文件包含规则、例外和偏好设置，不包含通知内容、消息或操作。';

  @override
  String get exportSettings => '导出设置';

  @override
  String get importSettings => '导入设置';

  @override
  String get noAccountPrivacy =>
      'KillNotify 不需要账户，也不会发送个人数据。应用通过 GitHub 手动分发，不在 Google Play 上架。';

  @override
  String get importBackupTitle => '导入备份？';

  @override
  String get importBackupWarning => '导入会替换当前设置。应用前会先验证文件。';

  @override
  String get chooseBackupFile => '选择文件';

  @override
  String get backupImported => '备份已导入';

  @override
  String backupMissingApps(String packages) {
    return '备份中的部分应用尚未安装：$packages。其时间表已保留。';
  }

  @override
  String get importedWithoutNotificationAccess => '由于缺少通知访问权限，导入后过滤功能保持关闭。';

  @override
  String get importedWithoutBatteryExemption => '由于未允许后台电池访问，导入后过滤功能保持关闭。';

  @override
  String get backupApplied => '设置已验证并应用。';

  @override
  String get ok => '确定';

  @override
  String get whatAccessMeans => '此权限的用途';

  @override
  String get notificationAccessExplanation =>
      '此权限允许 KillNotify 判断是否延迟通知。应用不会读取或保存标题、文本、联系人或操作，也不会将其发送到其他地方。';

  @override
  String get installedAppsVisibility => '已安装应用的可见范围';

  @override
  String get installedAppsExplanation =>
      '为了让你选择任意已安装的应用，Android 会向 KillNotify 显示此设备上的应用列表。列表仅在本地使用，不会发送。由于应用可以看到更多已安装应用的信息，因此通过 GitHub 手动分发，不在 Google Play 上架。';

  @override
  String get githubUpdatesPrivacy =>
      '启用自动更新后，KillNotify 每天最多查询一次 GitHub 公共发行版 API。GitHub 会收到 IP 地址等常规连接信息；不会发送时间表、已选应用或通知。安装时仍需 Android 确认。';

  @override
  String get callsAlarmsOtpPrivacy =>
      '只有发送应用明确标记时，才能自动允许来电和闹钟。验证码没有通用类别；KillNotify 不会读取消息内容来识别验证码。';

  @override
  String get customColorTitle => '自定义颜色';

  @override
  String get hexColor => 'HEX 颜色';

  @override
  String red(int value) {
    return '红色：$value';
  }

  @override
  String green(int value) {
    return '绿色：$value';
  }

  @override
  String blue(int value) {
    return '蓝色：$value';
  }

  @override
  String get hexColorNeedsSixDigits => '请输入 6 位十六进制数字。';

  @override
  String get apply => '应用';

  @override
  String get backgroundActivityTitle => '允许后台运行';

  @override
  String get batteryExemptionGranted => 'Android 电池后台权限已启用。';

  @override
  String get batteryExemptionNeeded => '开启过滤并在屏幕关闭时监控通知需要此权限。';

  @override
  String get adjustBattery => '调整电池设置';

  @override
  String get batteryHelpSamsung =>
      'Samsung：前往设置 > 电池和设备维护 > 电池 > 后台使用限制 > 从不休眠的应用，将 KillNotify 添加进去。菜单名称可能因版本而异。';

  @override
  String get batteryHelpXiaomi =>
      'Xiaomi：在设置 > 应用 > 权限中开启后台自启动。如有此选项，将 KillNotify 的电池使用设为无限制。菜单因机型而异。';

  @override
  String get batteryHelpHuawei =>
      'Huawei：找到应用启动管理，选择 KillNotify，并允许自动启动、关联启动和后台运行。菜单名称可能因版本而异。';

  @override
  String get batteryHelpRealme =>
      'realme：在设置中找到应用电池管理，并在可用时允许 KillNotify 后台运行和自动启动。';

  @override
  String get batteryHelpOppo =>
      'OPPO/ColorOS：部分省电模式会限制后台应用。请在电池或应用设置中允许 KillNotify 后台运行（如有此选项）。';

  @override
  String get batteryHelpOneplus =>
      'OnePlus：检查设置 > 电池 > 更多设置 > 应用电池管理，确保 KillNotify 的后台运行未受限制；菜单名称可能不同。';

  @override
  String get batteryHelpVivo =>
      'vivo：查找设置 > 应用 > 特殊应用权限 > 自启动，并在可用时允许 KillNotify。';

  @override
  String get batteryHelpMotorola =>
      'Motorola：如果有后台应用管理，请将 KillNotify 设为始终允许。菜单和功能因机型而异。';

  @override
  String get batteryHelpOther =>
      '部分手机有自己的后台应用控制。如果服务仍被中断，请在设备设置中查找 KillNotify 的电池选项。';

  @override
  String get noNeedKeepScreenOpen =>
      '无需让 KillNotify 一直显示在屏幕上。请勿强行停止应用，否则监控会中断，直到 Android 重新连接服务。';

  @override
  String get checkingUpdates => '正在检查更新';

  @override
  String get consultingGithub => '正在检查 GitHub…';

  @override
  String get updateOpenFailed => '无法打开下载页面。';

  @override
  String get noReleasePublished => 'GitHub 尚未发布任何版本。';

  @override
  String get updateCheckFailed => '暂时无法检查更新。';

  @override
  String get alreadyLatestVersion => '你使用的已是最新版本。';

  @override
  String get updateAvailable => '有可用更新';

  @override
  String versionAvailable(String version) {
    return '版本 $version 已发布。';
  }

  @override
  String get releaseNotes => '版本说明';

  @override
  String get updateInstallConfirmation => '下载将在浏览器中打开。Android 会在安装前请求确认。';

  @override
  String get neverRemind => '不再提醒';

  @override
  String get remindTomorrow => '明天提醒';

  @override
  String get downloadUpdate => '下载更新';

  @override
  String get operationNotCompleted => '无法完成此操作。';

  @override
  String get errorAccessRequired => '开启过滤前，请在 Android 设置中允许通知访问权限。';

  @override
  String get errorBatteryRequired => '开启过滤前，请在 Android 电池设置中允许后台运行。';

  @override
  String get errorInvalidBackup => '备份文件无效或无法读取。';

  @override
  String get errorConfigurationUnreadable => '无法读取已保存的设置。';

  @override
  String get errorBusy => '另一个操作正在进行。';

  @override
  String get errorInvalidInput => '部分信息无效，请检查后重试。';

  @override
  String get errorUnsupportedVersion => '此应用版本无法读取该响应。请更新应用后重试。';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get tabHome => '首页';

  @override
  String get tabApps => '应用';

  @override
  String get tabExceptions => '例外';

  @override
  String get tabSettings => '设置';

  @override
  String get language => '语言';

  @override
  String get systemLanguage => '跟随系统';

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
  String get refreshStatus => '刷新状态';

  @override
  String get refreshAppList => '刷新应用列表';

  @override
  String get notificationsReleasedToday => '今日已显示的通知';

  @override
  String get notificationCountPrivacy => '仅在此设备上计数；不会保存消息内容或操作。';

  @override
  String configuredAppsCount(int count) {
    return '$count 个应用已设置时间表';
  }

  @override
  String get eachAppHasOwnSchedule => '每个应用都可以使用自己的时间表。';

  @override
  String get filterActive => '过滤已开启';

  @override
  String get filterActiveExplanation => 'KillNotify 正在应用已设置的时间表。';

  @override
  String get filterInactive => '过滤未运行';

  @override
  String get listenerNotFollowing => 'KillNotify 尚未监控通知。部分通知可能不会延迟。';

  @override
  String get batterySetupRequired => '请调整电池设置';

  @override
  String get batterySetupExplanation => '允许后台运行后才能开启过滤。';

  @override
  String get schedulesUnavailable => '时间表不可用';

  @override
  String get schedulesUnavailableExplanation => '读取已保存的设置之前，过滤功能将保持关闭。';

  @override
  String get filterDisabled => '过滤已关闭';

  @override
  String get notificationsArriveNormally => '通知会正常送达，不会延迟。';

  @override
  String get accessNeeded => '需要授权';

  @override
  String get notificationAccessNeeded =>
      '要应用时间表，请在 Android 设置中允许 KillNotify 访问通知。';

  @override
  String get openAndroidSettings => '打开 Android 设置';

  @override
  String get activateFilter => '开启过滤';

  @override
  String get filterNeedsBoth => '开启过滤前，请允许访问通知并调整电池设置。';

  @override
  String get filterNeedsAccess => '开启过滤前，请允许访问通知。';

  @override
  String get filterNeedsBattery => '请调整电池设置，以便过滤功能在后台运行。';

  @override
  String get filterAppliesSchedules => '应用为每个应用设置的时间表。';

  @override
  String get restoreBackupForSchedules => '前往设置导入备份以恢复时间表。';

  @override
  String get checkingFilter => '正在检查过滤状态…';

  @override
  String get cannotCheckFilter => '无法检查过滤状态。点击刷新后重试。';

  @override
  String get nextAllowedStart => '下次允许通知的时间';

  @override
  String get nextConfiguredWindow => '下一个计划时段';

  @override
  String get noAppWaiting => '目前没有应用在等待计划时段';

  @override
  String get noSchedulesYet => '尚未设置时间表';

  @override
  String get filterInactiveInformative => '过滤已关闭；此时间仅供参考。';

  @override
  String get timezoneInfo => '时间表使用此设备设置的时区。';

  @override
  String get chooseAppsAndPeriods => '选择应用并设置允许接收通知的时间。';

  @override
  String get androidControlsSnooze =>
      '延迟的通知何时再次显示由 Android 决定。省电模式、设备设置或时钟变化可能影响时间。';

  @override
  String get searchApp => '搜索应用';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get appsListDisclosure =>
      '此列表包含系统应用和没有主屏幕图标的应用。Android 可能无法显示工作资料或某些服务的通知。';

  @override
  String get noSearchMatch => '没有符合搜索条件的应用。';

  @override
  String get systemApp => '系统应用';

  @override
  String get noLauncherIcon => '没有主屏幕图标';

  @override
  String periodsDefined(int count) {
    return '已设置 $count 个时段';
  }

  @override
  String appsWithSchedules(int count) {
    return '$count 个应用已设置时间表';
  }

  @override
  String get uninstalledApps => '未安装的应用';

  @override
  String get schedulesPreserved => '时间表会保留，重新安装应用后将再次生效。';

  @override
  String get appNotFound => '未找到应用';

  @override
  String get removeRule => '删除规则';

  @override
  String packageIdentifier(String packageName) {
    return '软件包：$packageName';
  }

  @override
  String get applySchedulesToApp => '将时间表应用到此应用';

  @override
  String get noSchedulesAllowNormally => '未设置时间表时，通知会正常送达。';

  @override
  String get weeklyPeriods => '每周时段';

  @override
  String get addPeriod => '添加时段';

  @override
  String get noPeriodsForApp => '尚未设置时间表。此应用的通知会正常送达。';

  @override
  String get period24HoursHint => '开始和结束时间相同时，该时段持续 24 小时。';

  @override
  String get removePeriod => '删除时段';

  @override
  String get exceptions => '例外';

  @override
  String get allowCallNotifications => '允许来电通知';

  @override
  String get callsCategoryOnly => '仅当发送通知的应用将其标记为来电时允许。';

  @override
  String get allowAlarmNotifications => '允许闹钟通知';

  @override
  String get alarmsCategoryOnly => '仅当发送通知的应用将其标记为闹钟时允许。';

  @override
  String get saveSchedules => '保存时间表';

  @override
  String get schedulesSaved => '时间表已保存。';

  @override
  String get newPeriod => '新建时段';

  @override
  String get editPeriod => '编辑时段';

  @override
  String get allowedDays => '允许通知的日期';

  @override
  String get selectAtLeastOneDay => '请至少选择一天。';

  @override
  String get startTime => '开始';

  @override
  String get endTime => '结束';

  @override
  String get periodMayCrossMidnight => '时段可以在次日结束。开始和结束时间相同时，持续 24 小时。';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get effectiveSchedule => '实际生效时间';

  @override
  String get overlappingPeriodsGrouped => '重叠或相邻的时段会合并显示。原始时间表仍会保留。';

  @override
  String get saveToPreviewPeriods => '保存后可查看时段合并结果。';

  @override
  String get noSchedulesNotificationsPass => '未设置时间表时，通知会正常送达。';

  @override
  String get temporaryException => '临时例外';

  @override
  String allowUntil(String time) {
    return '允许至 $time';
  }

  @override
  String get noActiveExceptionForApp => '此应用没有启用的例外。';

  @override
  String get oneHour => '1 小时';

  @override
  String get fourHours => '4 小时';

  @override
  String get eightHours => '8 小时';

  @override
  String get twentyFourHours => '24 小时';

  @override
  String get remove => '移除';

  @override
  String get temporaryExceptions => '临时例外';

  @override
  String get temporaryExceptionsExplanation =>
      '临时允许一个或多个应用的通知。例外会根据此设备的时钟在所选时间结束。';

  @override
  String get duration => '时长';

  @override
  String get chooseTime => '选择时间';

  @override
  String selectedAppsCount(int count) {
    return '已选择 $count 个';
  }

  @override
  String get selectResults => '选择搜索结果';

  @override
  String get clear => '清除';

  @override
  String allowAppsTemporarily(int count) {
    return '临时允许 $count 个应用';
  }

  @override
  String get activeTemporaryExceptions => '当前启用的临时例外';

  @override
  String get noTemporaryExceptions => '没有启用的临时例外。';

  @override
  String untilTime(String time) {
    return '截至 $time';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return '截至 $time · 软件包：$packageName';
  }

  @override
  String get endException => '结束例外';

  @override
  String get chooseFutureTime => '请选择未来的时间。';

  @override
  String exceptionAppliedCount(int count) {
    return '已为 $count 个应用启用临时例外。';
  }

  @override
  String get notificationAccess => '通知访问权限';

  @override
  String get accessGrantedInAndroid => '已在 Android 设置中允许。';

  @override
  String get accessRequiredToFilter => '过滤其他应用的通知需要此权限。';

  @override
  String get automaticUpdates => '自动检查更新';

  @override
  String get automaticUpdatesHint => '每天最多检查一次 GitHub，有新版本时会通知你。';

  @override
  String get checkForUpdateNow => '立即检查更新';

  @override
  String get appearance => '外观';

  @override
  String get theme => '主题';

  @override
  String get followSystem => '跟随系统';

  @override
  String get lightTheme => '浅色';

  @override
  String get darkTheme => '深色';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => '强调色';

  @override
  String get customColor => '自定义';

  @override
  String selectedColor(String color) {
    return '已选：$color';
  }

  @override
  String get localBackup => '本地备份';

  @override
  String get backupDescription => '设置文件包含规则、例外和偏好设置，不包含通知内容、消息或操作。';

  @override
  String get exportSettings => '导出设置';

  @override
  String get importSettings => '导入设置';

  @override
  String get noAccountPrivacy =>
      'KillNotify 不需要账户，也不会发送个人数据。应用通过 GitHub 手动分发，不在 Google Play 上架。';

  @override
  String get importBackupTitle => '导入备份？';

  @override
  String get importBackupWarning => '导入会替换当前设置。应用前会先验证文件。';

  @override
  String get chooseBackupFile => '选择文件';

  @override
  String get backupImported => '备份已导入';

  @override
  String backupMissingApps(String packages) {
    return '备份中的部分应用尚未安装：$packages。其时间表已保留。';
  }

  @override
  String get importedWithoutNotificationAccess => '由于缺少通知访问权限，导入后过滤功能保持关闭。';

  @override
  String get importedWithoutBatteryExemption => '由于未允许后台电池访问，导入后过滤功能保持关闭。';

  @override
  String get backupApplied => '设置已验证并应用。';

  @override
  String get ok => '确定';

  @override
  String get whatAccessMeans => '此权限的用途';

  @override
  String get notificationAccessExplanation =>
      '此权限允许 KillNotify 判断是否延迟通知。应用不会读取或保存标题、文本、联系人或操作，也不会将其发送到其他地方。';

  @override
  String get installedAppsVisibility => '已安装应用的可见范围';

  @override
  String get installedAppsExplanation =>
      '为了让你选择任意已安装的应用，Android 会向 KillNotify 显示此设备上的应用列表。列表仅在本地使用，不会发送。由于应用可以看到更多已安装应用的信息，因此通过 GitHub 手动分发，不在 Google Play 上架。';

  @override
  String get githubUpdatesPrivacy =>
      '启用自动更新后，KillNotify 每天最多查询一次 GitHub 公共发行版 API。GitHub 会收到 IP 地址等常规连接信息；不会发送时间表、已选应用或通知。安装时仍需 Android 确认。';

  @override
  String get callsAlarmsOtpPrivacy =>
      '只有发送应用明确标记时，才能自动允许来电和闹钟。验证码没有通用类别；KillNotify 不会读取消息内容来识别验证码。';

  @override
  String get customColorTitle => '自定义颜色';

  @override
  String get hexColor => 'HEX 颜色';

  @override
  String red(int value) {
    return '红色：$value';
  }

  @override
  String green(int value) {
    return '绿色：$value';
  }

  @override
  String blue(int value) {
    return '蓝色：$value';
  }

  @override
  String get hexColorNeedsSixDigits => '请输入 6 位十六进制数字。';

  @override
  String get apply => '应用';

  @override
  String get backgroundActivityTitle => '允许后台运行';

  @override
  String get batteryExemptionGranted => 'Android 电池后台权限已启用。';

  @override
  String get batteryExemptionNeeded => '开启过滤并在屏幕关闭时监控通知需要此权限。';

  @override
  String get adjustBattery => '调整电池设置';

  @override
  String get batteryHelpSamsung =>
      'Samsung：前往设置 > 电池和设备维护 > 电池 > 后台使用限制 > 从不休眠的应用，将 KillNotify 添加进去。菜单名称可能因版本而异。';

  @override
  String get batteryHelpXiaomi =>
      'Xiaomi：在设置 > 应用 > 权限中开启后台自启动。如有此选项，将 KillNotify 的电池使用设为无限制。菜单因机型而异。';

  @override
  String get batteryHelpHuawei =>
      'Huawei：找到应用启动管理，选择 KillNotify，并允许自动启动、关联启动和后台运行。菜单名称可能因版本而异。';

  @override
  String get batteryHelpRealme =>
      'realme：在设置中找到应用电池管理，并在可用时允许 KillNotify 后台运行和自动启动。';

  @override
  String get batteryHelpOppo =>
      'OPPO/ColorOS：部分省电模式会限制后台应用。请在电池或应用设置中允许 KillNotify 后台运行（如有此选项）。';

  @override
  String get batteryHelpOneplus =>
      'OnePlus：检查设置 > 电池 > 更多设置 > 应用电池管理，确保 KillNotify 的后台运行未受限制；菜单名称可能不同。';

  @override
  String get batteryHelpVivo =>
      'vivo：查找设置 > 应用 > 特殊应用权限 > 自启动，并在可用时允许 KillNotify。';

  @override
  String get batteryHelpMotorola =>
      'Motorola：如果有后台应用管理，请将 KillNotify 设为始终允许。菜单和功能因机型而异。';

  @override
  String get batteryHelpOther =>
      '部分手机有自己的后台应用控制。如果服务仍被中断，请在设备设置中查找 KillNotify 的电池选项。';

  @override
  String get noNeedKeepScreenOpen =>
      '无需让 KillNotify 一直显示在屏幕上。请勿强行停止应用，否则监控会中断，直到 Android 重新连接服务。';

  @override
  String get checkingUpdates => '正在检查更新';

  @override
  String get consultingGithub => '正在检查 GitHub…';

  @override
  String get updateOpenFailed => '无法打开下载页面。';

  @override
  String get noReleasePublished => 'GitHub 尚未发布任何版本。';

  @override
  String get updateCheckFailed => '暂时无法检查更新。';

  @override
  String get alreadyLatestVersion => '你使用的已是最新版本。';

  @override
  String get updateAvailable => '有可用更新';

  @override
  String versionAvailable(String version) {
    return '版本 $version 已发布。';
  }

  @override
  String get releaseNotes => '版本说明';

  @override
  String get updateInstallConfirmation => '下载将在浏览器中打开。Android 会在安装前请求确认。';

  @override
  String get neverRemind => '不再提醒';

  @override
  String get remindTomorrow => '明天提醒';

  @override
  String get downloadUpdate => '下载更新';

  @override
  String get operationNotCompleted => '无法完成此操作。';

  @override
  String get errorAccessRequired => '开启过滤前，请在 Android 设置中允许通知访问权限。';

  @override
  String get errorBatteryRequired => '开启过滤前，请在 Android 电池设置中允许后台运行。';

  @override
  String get errorInvalidBackup => '备份文件无效或无法读取。';

  @override
  String get errorConfigurationUnreadable => '无法读取已保存的设置。';

  @override
  String get errorBusy => '另一个操作正在进行。';

  @override
  String get errorInvalidInput => '部分信息无效，请检查后重试。';

  @override
  String get errorUnsupportedVersion => '此应用版本无法读取该响应。请更新应用后重试。';
}
