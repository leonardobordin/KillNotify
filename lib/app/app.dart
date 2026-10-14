import 'dart:async';

import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../core/update/release_update_service.dart';
import '../features/apps/apps_page.dart';
import '../features/exceptions/exceptions_page.dart';
import '../features/home/home_page.dart';
import '../features/privacy/privacy_page.dart';
import '../l10n/app_localizations.dart';
import 'app_controller.dart';

class KillNotifyApp extends StatefulWidget {
  const KillNotifyApp({super.key});

  @override
  State<KillNotifyApp> createState() => _KillNotifyAppState();
}

class _KillNotifyAppState extends State<KillNotifyApp> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final snapshot = _controller.snapshot;
        final choice = snapshot?.themeChoice ?? 'system';
        final accentColor = Color(
          snapshot?.accentColor ?? killNotifyAccent.toARGB32(),
        );
        final mode = switch (choice) {
          'light' => ThemeMode.light,
          'dark' || 'amoled' => ThemeMode.dark,
          _ => ThemeMode.system,
        };
        final locale = switch (_controller.languageChoice) {
          'en' => const Locale('en'),
          'pt_BR' => const Locale('pt', 'BR'),
          'es' => const Locale('es'),
          'fr' => const Locale('fr'),
          'de' => const Locale('de'),
          'it' => const Locale('it'),
          'ja' => const Locale('ja'),
          'zh_CN' => const Locale('zh', 'CN'),
          _ => null,
        };
        return MaterialApp(
          title: 'KillNotify',
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('pt', 'BR'),
            Locale('es'),
            Locale('fr'),
            Locale('de'),
            Locale('it'),
            Locale('ja'),
            Locale('zh', 'CN'),
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: AppTheme.light(accentColor: accentColor),
          darkTheme: choice == 'amoled'
              ? AppTheme.amoled(accentColor: accentColor)
              : AppTheme.dark(accentColor: accentColor),
          themeMode: mode,
          home: KillNotifyShell(controller: _controller),
        );
      },
    );
  }
}

class KillNotifyShell extends StatefulWidget {
  const KillNotifyShell({required this.controller, super.key});

  final AppController controller;

  @override
  State<KillNotifyShell> createState() => _KillNotifyShellState();
}

class _KillNotifyShellState extends State<KillNotifyShell> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(
          checkForUpdates(
            context: context,
            controller: widget.controller,
            automatic: true,
          ),
        );
      }
    });
  }

  void _openApps() => setState(() => _selectedIndex = 1);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(controller: widget.controller, onOpenApps: _openApps),
      AppsPage(controller: widget.controller),
      ExceptionsPage(controller: widget.controller),
      PrivacyPage(controller: widget.controller),
    ];
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.tabHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.apps_outlined),
            selectedIcon: Icon(Icons.apps),
            label: AppLocalizations.of(context)!.tabApps,
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule_outlined),
            selectedIcon: Icon(Icons.schedule),
            label: AppLocalizations.of(context)!.tabExceptions,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: AppLocalizations.of(context)!.tabSettings,
          ),
        ],
      ),
    );
  }
}
