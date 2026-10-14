// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get tabHome => 'ホーム';

  @override
  String get tabApps => 'アプリ';

  @override
  String get tabExceptions => '例外';

  @override
  String get tabSettings => '設定';

  @override
  String get language => '言語';

  @override
  String get systemLanguage => 'システム設定に従う';

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
  String get refreshStatus => '状態を更新';

  @override
  String get refreshAppList => 'アプリ一覧を更新';

  @override
  String get notificationsReleasedToday => '今日表示した通知';

  @override
  String get notificationCountPrivacy => 'この端末内の件数です。メッセージの内容や操作は保存しません。';

  @override
  String configuredAppsCount(int count) {
    return 'スケジュール設定済みのアプリ $count 個';
  }

  @override
  String get eachAppHasOwnSchedule => 'アプリごとにスケジュールを設定できます。';

  @override
  String get filterActive => 'フィルター有効';

  @override
  String get filterActiveExplanation => 'KillNotify が設定したスケジュールを適用しています。';

  @override
  String get filterInactive => 'フィルター無効';

  @override
  String get listenerNotFollowing =>
      'KillNotify はまだ通知を監視していません。通知が遅延されずに届く場合があります。';

  @override
  String get batterySetupRequired => 'バッテリー設定を変更してください';

  @override
  String get batterySetupExplanation => 'バックグラウンド動作を許可するとフィルターを有効にできます。';

  @override
  String get schedulesUnavailable => 'スケジュールを利用できません';

  @override
  String get schedulesUnavailableExplanation => '保存した設定を読み込めるまでフィルターは無効です。';

  @override
  String get filterDisabled => 'フィルターオフ';

  @override
  String get notificationsArriveNormally => '通知は遅延されず通常どおり届きます。';

  @override
  String get accessNeeded => '権限が必要です';

  @override
  String get notificationAccessNeeded =>
      'スケジュールを適用するには、Android の設定で KillNotify の通知へのアクセスを許可してください。';

  @override
  String get openAndroidSettings => 'Android の設定を開く';

  @override
  String get activateFilter => 'フィルターを有効にする';

  @override
  String get filterNeedsBoth => 'フィルターを有効にする前に、通知へのアクセスを許可し、バッテリー設定を変更してください。';

  @override
  String get filterNeedsAccess => 'フィルターを有効にする前に、通知へのアクセスを許可してください。';

  @override
  String get filterNeedsBattery => 'フィルターをバックグラウンドで動作させるため、バッテリー設定を変更してください。';

  @override
  String get filterAppliesSchedules => '各アプリに設定したスケジュールを適用します。';

  @override
  String get restoreBackupForSchedules => '設定からバックアップをインポートしてスケジュールを復元してください。';

  @override
  String get checkingFilter => 'フィルターを確認しています…';

  @override
  String get cannotCheckFilter => 'フィルターを確認できませんでした。更新をタップして再試行してください。';

  @override
  String get nextAllowedStart => '次に通知を許可する時刻';

  @override
  String get nextConfiguredWindow => '次の予定時間';

  @override
  String get noAppWaiting => '現在、スケジュール待ちのアプリはありません';

  @override
  String get noSchedulesYet => 'スケジュール未設定';

  @override
  String get filterInactiveInformative => 'フィルターはオフです。この時刻は参考情報です。';

  @override
  String get timezoneInfo => 'スケジュールには端末に設定されたタイムゾーンを使用します。';

  @override
  String get chooseAppsAndPeriods => 'アプリを選び、通知を許可する時間を設定してください。';

  @override
  String get androidControlsSnooze =>
      '遅延した通知を再表示するタイミングは Android が決定します。省電力設定、端末の設定、時刻の変更によってタイミングが変わる場合があります。';

  @override
  String get searchApp => 'アプリを検索';

  @override
  String get clearSearch => '検索をクリア';

  @override
  String get appsListDisclosure =>
      'この一覧にはシステムアプリとホーム画面にアイコンがないアプリも含まれます。仕事用プロファイルや一部のサービスの通知は Android が表示できない場合があります。';

  @override
  String get noSearchMatch => '検索に一致するアプリはありません。';

  @override
  String get systemApp => 'システムアプリ';

  @override
  String get noLauncherIcon => 'ホーム画面アイコンなし';

  @override
  String periodsDefined(int count) {
    return '設定済みの時間帯 $count 件';
  }

  @override
  String appsWithSchedules(int count) {
    return 'スケジュール設定済みのアプリ $count 個';
  }

  @override
  String get uninstalledApps => '未インストールのアプリ';

  @override
  String get schedulesPreserved => 'スケジュールは保存され、アプリを再インストールすると再び適用されます。';

  @override
  String get appNotFound => 'アプリが見つかりません';

  @override
  String get removeRule => 'ルールを削除';

  @override
  String packageIdentifier(String packageName) {
    return 'パッケージ: $packageName';
  }

  @override
  String get applySchedulesToApp => 'このアプリにスケジュールを適用';

  @override
  String get noSchedulesAllowNormally => 'スケジュールがない場合、通知は通常どおり届きます。';

  @override
  String get weeklyPeriods => '週間スケジュール';

  @override
  String get addPeriod => '時間帯を追加';

  @override
  String get noPeriodsForApp => 'スケジュール未設定。このアプリの通知は通常どおり届きます。';

  @override
  String get period24HoursHint => '開始時刻と終了時刻が同じ場合、時間帯は 24 時間になります。';

  @override
  String get removePeriod => '時間帯を削除';

  @override
  String get exceptions => '例外';

  @override
  String get allowCallNotifications => '通話の通知を許可';

  @override
  String get callsCategoryOnly => '送信元アプリが通話として通知した場合のみ許可します。';

  @override
  String get allowAlarmNotifications => 'アラームの通知を許可';

  @override
  String get alarmsCategoryOnly => '送信元アプリがアラームとして通知した場合のみ許可します。';

  @override
  String get saveSchedules => 'スケジュールを保存';

  @override
  String get schedulesSaved => 'スケジュールを保存しました。';

  @override
  String get newPeriod => '新しい時間帯';

  @override
  String get editPeriod => '時間帯を編集';

  @override
  String get allowedDays => '通知を許可する曜日';

  @override
  String get selectAtLeastOneDay => '曜日を1つ以上選択してください。';

  @override
  String get startTime => '開始';

  @override
  String get endTime => '終了';

  @override
  String get periodMayCrossMidnight =>
      '時間帯は翌日に終了する場合があります。開始と終了が同じ場合は 24 時間になります。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get add => '追加';

  @override
  String get save => '保存';

  @override
  String get effectiveSchedule => '適用される時間帯';

  @override
  String get overlappingPeriodsGrouped =>
      '重複または連続する時間帯はまとめて表示します。元の設定はそのまま保存されます。';

  @override
  String get saveToPreviewPeriods => '保存すると、時間帯がどのようにまとめられるか確認できます。';

  @override
  String get noSchedulesNotificationsPass => 'スケジュールがない場合、通知は通常どおり届きます。';

  @override
  String get temporaryException => '一時的な例外';

  @override
  String allowUntil(String time) {
    return '$time まで許可';
  }

  @override
  String get noActiveExceptionForApp => 'このアプリに有効な例外はありません。';

  @override
  String get oneHour => '1時間';

  @override
  String get fourHours => '4時間';

  @override
  String get eightHours => '8時間';

  @override
  String get twentyFourHours => '24時間';

  @override
  String get remove => '削除';

  @override
  String get temporaryExceptions => '一時的な例外';

  @override
  String get temporaryExceptionsExplanation =>
      '1つ以上のアプリの通知を一時的に許可します。例外は端末の時計に基づき、選択した時刻に終了します。';

  @override
  String get duration => '期間';

  @override
  String get chooseTime => '時刻を選択';

  @override
  String selectedAppsCount(int count) {
    return '選択中 $count 件';
  }

  @override
  String get selectResults => '検索結果を選択';

  @override
  String get clear => 'クリア';

  @override
  String allowAppsTemporarily(int count) {
    return 'アプリ $count 個を一時的に許可';
  }

  @override
  String get activeTemporaryExceptions => '有効な一時例外';

  @override
  String get noTemporaryExceptions => '有効な一時例外はありません。';

  @override
  String untilTime(String time) {
    return '$time まで';
  }

  @override
  String untilTimeWithIdentifier(String time, String packageName) {
    return '$time まで · パッケージ: $packageName';
  }

  @override
  String get endException => '例外を終了';

  @override
  String get chooseFutureTime => '未来の時刻を選択してください。';

  @override
  String exceptionAppliedCount(int count) {
    return 'アプリ $count 個に一時例外を適用しました。';
  }

  @override
  String get notificationAccess => '通知へのアクセス';

  @override
  String get accessGrantedInAndroid => 'Android の設定で許可されています。';

  @override
  String get accessRequiredToFilter => '他のアプリの通知をフィルターするために必要です。';

  @override
  String get automaticUpdates => 'アップデートを自動確認';

  @override
  String get automaticUpdatesHint => 'GitHub を1日1回まで確認し、新しいバージョンがあればお知らせします。';

  @override
  String get checkForUpdateNow => '今すぐアップデートを確認';

  @override
  String get appearance => '外観';

  @override
  String get theme => 'テーマ';

  @override
  String get followSystem => 'システム設定に従う';

  @override
  String get lightTheme => 'ライト';

  @override
  String get darkTheme => 'ダーク';

  @override
  String get amoledTheme => 'AMOLED';

  @override
  String get accentColor => 'アクセントカラー';

  @override
  String get customColor => 'カスタム';

  @override
  String selectedColor(String color) {
    return '選択中: $color';
  }

  @override
  String get localBackup => 'ローカルバックアップ';

  @override
  String get backupDescription =>
      '設定ファイルにはルール、例外、設定が含まれます。通知の内容、メッセージ、操作は含まれません。';

  @override
  String get exportSettings => '設定をエクスポート';

  @override
  String get importSettings => '設定をインポート';

  @override
  String get noAccountPrivacy =>
      'KillNotify はアカウントを必要とせず、個人データを送信しません。アプリは GitHub から手動で配布され、Google Play では配布されません。';

  @override
  String get importBackupTitle => 'バックアップをインポートしますか？';

  @override
  String get importBackupWarning => 'インポートすると現在の設定が置き換わります。適用前にファイルを検証します。';

  @override
  String get chooseBackupFile => 'ファイルを選択';

  @override
  String get backupImported => 'バックアップをインポートしました';

  @override
  String backupMissingApps(String packages) {
    return 'バックアップに含まれる一部のアプリがインストールされていません: $packages。スケジュールは保存されています。';
  }

  @override
  String get importedWithoutNotificationAccess =>
      '通知へのアクセスがないため、フィルターをオフにしてインポートしました。';

  @override
  String get importedWithoutBatteryExemption =>
      'バックグラウンドでのバッテリー制限を解除していないため、フィルターをオフにしてインポートしました。';

  @override
  String get backupApplied => '設定を検証して適用しました。';

  @override
  String get ok => 'OK';

  @override
  String get whatAccessMeans => 'このアクセスについて';

  @override
  String get notificationAccessExplanation =>
      'このアクセスにより、KillNotify は通知を遅延するか判断できます。タイトル、本文、連絡先、操作を読み取ったり保存したりせず、外部に送信することもありません。';

  @override
  String get installedAppsVisibility => 'インストール済みアプリの表示';

  @override
  String get installedAppsExplanation =>
      'インストール済みのアプリを選べるように、Android はこの端末のアプリ一覧を KillNotify に表示します。一覧は端末内でのみ使用し、送信しません。アプリ情報へのアクセス範囲が広くなるため、Google Play ではなく GitHub から手動で配布しています。';

  @override
  String get githubUpdatesPrivacy =>
      '自動アップデートが有効な場合、KillNotify は GitHub の公開リリース API を1日1回まで確認します。GitHub には IP アドレスなど通常の接続情報が伝わりますが、スケジュール、選択したアプリ、通知は送信しません。インストール時には Android の確認が必要です。';

  @override
  String get callsAlarmsOtpPrivacy =>
      '通話やアラームを自動的に許可できるのは、送信元アプリがその種類を識別した場合のみです。確認コードには共通の通知カテゴリがないため、KillNotify はメッセージの内容を読んで検出しません。';

  @override
  String get customColorTitle => 'カスタムカラー';

  @override
  String get hexColor => 'HEX カラー';

  @override
  String red(int value) {
    return '赤: $value';
  }

  @override
  String green(int value) {
    return '緑: $value';
  }

  @override
  String blue(int value) {
    return '青: $value';
  }

  @override
  String get hexColorNeedsSixDigits => '16進数を6桁入力してください。';

  @override
  String get apply => '適用';

  @override
  String get backgroundActivityTitle => 'バックグラウンド動作を許可';

  @override
  String get batteryExemptionGranted => 'Android のバッテリー制限が解除されています。';

  @override
  String get batteryExemptionNeeded => '画面消灯中もフィルターを有効にして通知を監視するために必要です。';

  @override
  String get adjustBattery => 'バッテリー設定を変更';

  @override
  String get batteryHelpSamsung =>
      'Samsung: 設定 > バッテリーとデバイスケア > バッテリー > バックグラウンドでの使用制限 > スリープ状態にしないアプリに KillNotify を追加してください。メニュー名はバージョンにより異なります。';

  @override
  String get batteryHelpXiaomi =>
      'Xiaomi: 設定 > アプリ > 権限でバックグラウンド自動起動を許可してください。利用できる場合は KillNotify のバッテリー使用を「制限なし」にします。メニューは機種により異なります。';

  @override
  String get batteryHelpHuawei =>
      'Huawei: アプリ起動を開き、KillNotify の自動起動、他のアプリによる起動、バックグラウンド実行を許可してください。メニュー名はバージョンにより異なります。';

  @override
  String get batteryHelpRealme =>
      'realme: 設定でアプリのバッテリー管理を探し、利用できる場合は KillNotify のバックグラウンド動作と自動起動を許可してください。';

  @override
  String get batteryHelpOppo =>
      'OPPO/ColorOS: 省電力モードによってバックグラウンドアプリが制限される場合があります。バッテリーまたはアプリの設定で KillNotify のバックグラウンド動作を許可してください。';

  @override
  String get batteryHelpOneplus =>
      'OnePlus: 設定 > バッテリー > その他の設定 > アプリのバッテリー管理を確認し、KillNotify のバックグラウンド動作が制限されていないことを確認してください。項目名は異なる場合があります。';

  @override
  String get batteryHelpVivo =>
      'vivo: 設定 > アプリ > 特別なアプリアクセス > 自動起動を開き、利用できる場合は KillNotify を許可してください。';

  @override
  String get batteryHelpMotorola =>
      'Motorola: バックグラウンドアプリの管理がある場合、KillNotify を常に許可に設定してください。メニューや機能は機種によって異なります。';

  @override
  String get batteryHelpOther =>
      '一部の端末には独自のバックグラウンドアプリ設定があります。動作が中断される場合は、端末の設定で KillNotify のバッテリー設定を確認してください。';

  @override
  String get noNeedKeepScreenOpen =>
      'KillNotify を画面に表示したままにする必要はありません。「強制停止」は監視を中断し、Android がサービスを再接続するまで動作しなくなります。';

  @override
  String get checkingUpdates => 'アップデートを確認中';

  @override
  String get consultingGithub => 'GitHub を確認しています…';

  @override
  String get updateOpenFailed => 'ダウンロードを開けませんでした。';

  @override
  String get noReleasePublished => 'GitHub に公開されたリリースはまだありません。';

  @override
  String get updateCheckFailed => '現在アップデートを確認できません。';

  @override
  String get alreadyLatestVersion => '最新バージョンを使用しています。';

  @override
  String get updateAvailable => 'アップデートがあります';

  @override
  String versionAvailable(String version) {
    return 'バージョン $version を利用できます。';
  }

  @override
  String get releaseNotes => 'リリースノート';

  @override
  String get updateInstallConfirmation =>
      'ダウンロードはブラウザーで開きます。インストール前に Android の確認が必要です。';

  @override
  String get neverRemind => '今後通知しない';

  @override
  String get remindTomorrow => '明日通知する';

  @override
  String get downloadUpdate => 'アップデートをダウンロード';

  @override
  String get operationNotCompleted => '操作を完了できませんでした。';

  @override
  String get errorAccessRequired =>
      'フィルターを有効にする前に、Android の設定で通知へのアクセスを許可してください。';

  @override
  String get errorBatteryRequired =>
      'フィルターを有効にする前に、Android のバッテリー設定でバックグラウンド動作を許可してください。';

  @override
  String get errorInvalidBackup => 'バックアップファイルが無効か、読み込めませんでした。';

  @override
  String get errorConfigurationUnreadable => '保存した設定を読み込めませんでした。';

  @override
  String get errorBusy => '別の操作がすでに実行中です。';

  @override
  String get errorInvalidInput => '入力に誤りがあります。内容を確認して再試行してください。';

  @override
  String get errorUnsupportedVersion =>
      'このアプリのバージョンでは応答を読み取れません。アプリを更新して再試行してください。';
}
