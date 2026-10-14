import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:killnotify/app/app.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('com.killnotify/v1');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    binding.platformDispatcher.localesTestValue = const [Locale('pt', 'BR')];
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'getSnapshot') {
        return <String, Object?>{
          'contractVersion': 1,
          'state': 'needs_access',
          'accessGranted': false,
          'filterEnabled': false,
          'filterActive': false,
          'listenerConnected': false,
          'themeChoice': 'system',
          'zoneId': 'America/Sao_Paulo',
          'checkedAtEpochMillis': 1791910000000,
          'releasedCountToday': 0,
          'appRules': <Object?>[],
          'nextPackageName': null,
          'nextAllowedStartEpochMillis': null,
          'configurationError': null,
        };
      }
      if (call.method == 'listApps') return <Object?>[];
      return null;
    });
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
    SharedPreferencesAsyncPlatform.instance = null;
    binding.platformDispatcher.clearLocalesTestValue();
  });

  testWidgets(
    'shows access state and privacy settings in Brazilian Portuguese',
    (tester) async {
      await tester.pumpWidget(const KillNotifyApp());
      await tester.pumpAndSettle();

      expect(find.text('Acesso necessário'), findsOneWidget);
      expect(
        find.text(
          'Para aplicar os horários, permita que o KillNotify acompanhe as notificações nas configurações do Android.',
        ),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.text('Ativar filtro'),
        240,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Ativar filtro'), findsOneWidget);

      await tester.tap(find.text('Configurações'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Visibilidade de apps instalados'),
        240,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Visibilidade de apps instalados'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Exportar configurações'),
        240,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Exportar configurações'), findsOneWidget);
    },
  );
}
