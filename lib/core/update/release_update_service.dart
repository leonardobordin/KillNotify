import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_controller.dart';
import '../version/app_release.dart';
import '../../l10n/app_localizations.dart';

enum ReleaseUpdateError { network, invalidResponse }

class ReleaseUpdateException implements Exception {
  const ReleaseUpdateException(this.error);

  final ReleaseUpdateError error;
}

class GitHubRelease {
  const GitHubRelease({
    required this.tagName,
    required this.title,
    required this.body,
    required this.htmlUrl,
    this.apkUrl,
  });

  final String tagName;
  final String title;
  final String body;
  final Uri htmlUrl;
  final Uri? apkUrl;

  String get version => _normalizeVersion(tagName);

  static GitHubRelease fromJson(Map<String, dynamic> json) {
    final tagName = json['tag_name'];
    final htmlUrl = _githubReleaseUrl(json['html_url']);
    if (tagName is! String || tagName.trim().isEmpty || htmlUrl == null) {
      throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
    }

    Uri? apkUrl;
    final assets = json['assets'];
    if (assets is List) {
      for (final asset in assets) {
        if (asset is! Map) continue;
        final name = asset['name'];
        if (name is! String || !name.toLowerCase().endsWith('.apk')) continue;
        apkUrl = _githubReleaseUrl(asset['browser_download_url']);
        if (apkUrl != null) break;
      }
    }

    return GitHubRelease(
      tagName: tagName.trim(),
      title: (json['name'] as String?)?.trim() ?? '',
      body: (json['body'] as String?)?.trim() ?? '',
      htmlUrl: htmlUrl,
      apkUrl: apkUrl,
    );
  }
}

class ReleaseUpdateResult {
  const ReleaseUpdateResult({
    this.release,
    this.error,
    this.noReleasePublished = false,
  });

  final GitHubRelease? release;
  final ReleaseUpdateError? error;
  final bool noReleasePublished;

  bool get hasUpdate => release != null;
}

class GitHubReleaseService {
  static const repository = String.fromEnvironment(
    'GITHUB_REPOSITORY',
    defaultValue: 'leonardobordin/KillNotify',
  );
  static const _timeout = Duration(seconds: 10);

  Future<ReleaseUpdateResult> checkForUpdate() async {
    try {
      final latest = await fetchLatest();
      return ReleaseUpdateResult(
        release: isVersionNewer(latest.version, AppRelease.version)
            ? latest
            : null,
      );
    } on _NoReleasePublished {
      return const ReleaseUpdateResult(noReleasePublished: true);
    } on ReleaseUpdateException catch (error) {
      return ReleaseUpdateResult(error: error.error);
    } on Object {
      return const ReleaseUpdateResult(error: ReleaseUpdateError.network);
    }
  }

  Future<GitHubRelease> fetchLatest() async {
    final client = HttpClient()..connectionTimeout = _timeout;
    try {
      final request = await client
          .getUrl(
            Uri.https('api.github.com', '/repos/$repository/releases/latest'),
          )
          .timeout(_timeout);
      request.headers
        ..set(HttpHeaders.acceptHeader, 'application/vnd.github+json')
        ..set(HttpHeaders.userAgentHeader, 'KillNotify/${AppRelease.version}')
        ..set('X-GitHub-Api-Version', '2022-11-28');

      final response = await request.close().timeout(_timeout);
      if (response.statusCode == HttpStatus.notFound) {
        throw const _NoReleasePublished();
      }
      final bytes = await response
          .fold<List<int>>(<int>[], (result, chunk) {
            if (result.length + chunk.length > 1024 * 1024) {
              throw const ReleaseUpdateException(
                ReleaseUpdateError.invalidResponse,
              );
            }
            return result..addAll(chunk);
          })
          .timeout(_timeout);
      if (response.statusCode != HttpStatus.ok) {
        throw const ReleaseUpdateException(ReleaseUpdateError.network);
      }

      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is! Map<String, dynamic>) {
        throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
      }
      return GitHubRelease.fromJson(decoded);
    } on _NoReleasePublished {
      rethrow;
    } on ReleaseUpdateException {
      rethrow;
    } on TimeoutException {
      throw const ReleaseUpdateException(ReleaseUpdateError.network);
    } on FormatException {
      throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
    } on SocketException {
      throw const ReleaseUpdateException(ReleaseUpdateError.network);
    } finally {
      client.close(force: true);
    }
  }

  Future<bool> openDownload(GitHubRelease release) => launchUrl(
    release.apkUrl ?? release.htmlUrl,
    mode: LaunchMode.externalApplication,
  );

  static bool isVersionNewer(String candidate, String current) =>
      _compareVersions(candidate, current) > 0;

  static int _compareVersions(String first, String second) {
    final firstParts = _versionParts(first);
    final secondParts = _versionParts(second);
    for (var index = 0; index < 3; index++) {
      final comparison = firstParts[index].compareTo(secondParts[index]);
      if (comparison != 0) return comparison;
    }
    return 0;
  }

  static List<int> _versionParts(String value) {
    final match = RegExp(r'^v?(\d+)\.(\d+)\.(\d+)').firstMatch(value.trim());
    if (match == null) {
      throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
    }
    return [
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    ];
  }
}

Future<void> checkForUpdates({
  required BuildContext context,
  required AppController controller,
  bool automatic = false,
}) async {
  await controller.loadUpdatePreferences();
  if (automatic && !controller.shouldCheckForUpdatesAutomatically) return;
  await controller.markUpdateCheck();
  if (!context.mounted) return;

  final navigator = Navigator.of(context, rootNavigator: true);
  if (!automatic) {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.checkingUpdates),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 14),
              Flexible(
                child: Text(AppLocalizations.of(context)!.consultingGithub),
              ),
            ],
          ),
        ),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  final result = await GitHubReleaseService().checkForUpdate();
  if (!automatic && navigator.mounted && navigator.canPop()) navigator.pop();
  if (!context.mounted) return;

  if (result.hasUpdate) {
    final action = await _showUpdateAvailable(context, result.release!);
    switch (action) {
      case _UpdateAction.download:
        final opened = await GitHubReleaseService().openDownload(
          result.release!,
        );
        if (!opened && context.mounted) {
          _showMessage(context, AppLocalizations.of(context)!.updateOpenFailed);
        }
      case _UpdateAction.later:
        await controller.snoozeUpdateChecks();
      case _UpdateAction.never:
        await controller.setAutomaticUpdateChecks(false);
      case null:
        break;
    }
    return;
  }

  if (automatic) return;
  final l10n = AppLocalizations.of(context)!;
  final message = result.noReleasePublished
      ? l10n.noReleasePublished
      : result.error != null
      ? l10n.updateCheckFailed
      : l10n.alreadyLatestVersion;
  _showMessage(context, message);
}

Future<_UpdateAction?> _showUpdateAvailable(
  BuildContext context,
  GitHubRelease release,
) => showDialog<_UpdateAction>(
  context: context,
  barrierDismissible: false,
  builder: (dialogContext) => AlertDialog(
    title: Text(AppLocalizations.of(dialogContext)!.updateAvailable),
    content: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 460),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(dialogContext)!
                  .versionAvailable(release.version),
            ),
            if (release.title.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                release.title,
                style: Theme.of(dialogContext).textTheme.titleMedium,
              ),
            ],
            if (release.body.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(AppLocalizations.of(dialogContext)!.releaseNotes),
              const SizedBox(height: 4),
              Text(release.body),
            ],
            const SizedBox(height: 12),
            Text(AppLocalizations.of(dialogContext)!.updateInstallConfirmation),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(dialogContext, _UpdateAction.never),
        child: Text(AppLocalizations.of(dialogContext)!.neverRemind),
      ),
      TextButton(
        onPressed: () => Navigator.pop(dialogContext, _UpdateAction.later),
        child: Text(AppLocalizations.of(dialogContext)!.remindTomorrow),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(dialogContext, _UpdateAction.download),
        child: Text(AppLocalizations.of(dialogContext)!.downloadUpdate),
      ),
    ],
  ),
);

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

enum _UpdateAction { download, later, never }

Uri? _githubReleaseUrl(Object? value) {
  if (value is! String) return null;
  final uri = Uri.tryParse(value);
  if (uri == null ||
      uri.scheme != 'https' ||
      uri.host != 'github.com' ||
      !uri.path.startsWith('/leonardobordin/KillNotify/releases/')) {
    return null;
  }
  return uri;
}

String _normalizeVersion(String value) {
  final match = RegExp(r'^v?(\d+\.\d+\.\d+)').firstMatch(value.trim());
  if (match == null) {
    throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
  }
  return match.group(1)!;
}

class _NoReleasePublished implements Exception {
  const _NoReleasePublished();
}
