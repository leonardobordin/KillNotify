<p align="center">
  <img src="android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png" alt="KillNotify app icon" width="168">
</p>

<h1 align="center">KillNotify</h1>

<p align="center">
  <strong>Choose when notifications from each Android app may appear.</strong><br>
  Create weekly schedules and temporary exceptions while keeping settings on your device.
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillNotify/actions/workflows/release.yml"><img src="https://github.com/leonardobordin/KillNotify/actions/workflows/release.yml/badge.svg" alt="Release workflow status"></a>
  <a href="https://github.com/leonardobordin/KillNotify/releases"><img src="https://img.shields.io/github/v/release/leonardobordin/KillNotify?display_name=tag" alt="Latest release"></a>
  <a href="https://developer.android.com/about/versions/oreo"><img src="https://img.shields.io/badge/Android-API%2026%2B-3DDC84?logo=android&logoColor=white" alt="Android API 26 or newer"></a>
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillNotify/releases">Releases</a> ·
  <a href="#features">Features</a> ·
  <a href="#build-from-source">Build from source</a> ·
  <a href="#privacy-and-permissions">Privacy</a>
</p>

<p align="center">
  <a href="README.md">English</a> ·
  <a href="README.pt-BR.md">Português (Brasil)</a>
</p>

<p align="center">
  <a href="CHANGELOG.md">Changelog</a> ·
  <a href="CHANGELOG.pt-BR.md">Registro de alterações</a>
</p>

## Overview

KillNotify is a local Android app that lets you choose when notifications from other apps may appear. Flutter provides the interface; a Kotlin notification listener evaluates the weekly rules in the background.

The app has no account, backend, synchronization, telemetry or advertising. Its only network connection is the optional check for updates through GitHub's public releases API. It does not send schedules, app selections or notifications. APKs are distributed manually through GitHub and are not published on Google Play.

## Features

- Set weekly notification windows independently for each installed app.
- Allow call or alarm notifications when the sending app identifies their category.
- Temporarily allow notifications for selected apps.
- Choose among eight interface languages: English, Brazilian Portuguese, Spanish, French, German, Italian, Japanese and Simplified Chinese. By default, the app follows the device language.
- Choose a light, dark or AMOLED theme and select a highlight color.
- Export and import a versioned JSON backup containing settings only.
- Optionally check GitHub for updates, at most once a day. Android asks for confirmation before installing an APK.

## Download

Open [GitHub Releases](https://github.com/leonardobordin/KillNotify/releases) to see available APKs. No release has been published yet. When one is available, download the APK and confirm installation in Android. For updates, the app opens the download in your browser; Android still asks you to confirm installation.

## Build from source

Requirements: Flutter 3.47+, Android SDK API 36 and JDK 17. The minimum Android API level is 26. From the project root in PowerShell:

```powershell
flutter pub get
flutter analyze
flutter test
cd android
.\gradlew.bat --no-daemon :app:testDebugUnitTest
cd ..
flutter build apk --debug
```

The debug APK is written to `build/app/outputs/flutter-apk/app-debug.apk`. Install it with:

```powershell
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

The synthetic notification probe is a separate development app and is not included in KillNotify:

```powershell
cd android
.\gradlew.bat --no-daemon :notification-probe:assembleDebug
```

The probe APK is written to `build/notification-probe/outputs/apk/debug/notification-probe-debug.apk`.

On this Windows setup, Gradle may fail with `Unable to establish loopback connection` if its temporary NIO socket path is unavailable. Create `C:\Temp` and set this variable in the current PowerShell session before running Gradle:

```powershell
$env:JAVA_TOOL_OPTIONS='-Djdk.net.unixdomain.tmpdir=C:/Temp'
```

## Use and limitations

1. In Android settings, grant KillNotify special access to notifications.
2. Allow background activity in the Android battery prompt. The filter cannot be enabled without notification access and this battery exemption.
3. Some manufacturers provide additional background controls. Samsung may have **Never sleeping apps**; Xiaomi may have **Background autostart** and **No restrictions**; Huawei may have **App launch** controls; realme and OPPO/ColorOS may have app battery management; OnePlus, vivo and Motorola offer similar controls on some models. Menu names and options vary by device and version. KillNotify cannot verify manufacturer-specific settings.
4. You do not need to keep KillNotify open on screen. Avoid **Force stop**, which prevents Android from delivering service callbacks until it reconnects the service.
5. Choose apps, set days and times, then turn on the filter. Apps without a schedule allow notifications normally.
6. Android reschedules the original notification with `snoozeNotification`, and KillNotify evaluates it again when Android calls the service. Delivery time is not exact and can vary with battery saving, device settings or clock changes.
7. Calls and alarms can be allowed automatically only when the sending app provides the corresponding Android category. Verification codes are not detected from message content.
8. To let you choose any installed app, the manifest uses `QUERY_ALL_PACKAGES`. The list is read locally and is not transmitted.
9. The versioned backup contains settings only. Missing app packages are retained and reported during import.

Notification listeners have platform limitations on some low-memory devices running Android Q or earlier and in work profiles. Android can revoke the battery exemption, and it does not override every manufacturer power policy. Behavior after time-zone or clock changes and notification grouping should be checked on physical devices. The filter turns off if a detectable prerequisite is revoked.

## Privacy and permissions

KillNotify does not read or save notification titles, text, contacts or actions. It does not send notification content or settings to a server. The notification access allows the app to decide whether to delay a notification; the app list is visible locally so you can choose installed apps. See [the privacy details in Settings](docs/PRIVACIDADE.md) (Portuguese) and the [architecture](docs/architecture/ARCHITECTURE.md) for more information.

When automatic updates are enabled, the app requests `https://api.github.com/repos/leonardobordin/KillNotify/releases/latest` at most once a day. GitHub receives ordinary connection metadata, such as the IP address and a User-Agent containing the app version. Update preferences stay on the device and are not included in the settings backup.

## Releases and signing

Do not distribute an APK signed with the debug key. To create a distributable release, configure the Gradle properties `killnotifyReleaseKeystore`, `killnotifyReleaseStorePassword`, `killnotifyReleaseKeyAlias` and `killnotifyReleaseKeyPassword` outside the repository (for example, in `~/.gradle/gradle.properties`). The release workflow requires its signing secrets and publishes an APK plus a SHA-256 checksum when a matching `vMAJOR.MINOR.PATCH` tag is pushed. Read the [release guide](docs/RELEASING.md) (Portuguese). No release has been published yet.

## Project notes

The MVP includes per-app weekly schedules, exceptions, installed-app selection, local permission status and a versioned JSON backup. The `snoozeNotification` behavior was observed in an Android API 36 emulator; this does not guarantee identical behavior across devices, profiles or manufacturers. The weekly rule evaluation, validation and next-window calculation are implemented in Kotlin; Flutter displays the results through `com.killnotify/v1`.

See the [requirements](docs/requirements/REQUIREMENTS.md), [architecture](docs/architecture/ARCHITECTURE.md), [decisions](docs/decisions/DECISOES.md), [Android API 36 probe notes](docs/prototype/ANDROID_API36_EMULATOR.md) and [multilingual app plan](docs/plans/2026-10-14-multilingual-app-and-github/PLAN.md) (technical docs are currently Portuguese).
