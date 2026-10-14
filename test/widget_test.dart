import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:killnotify/app/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('com.killnotify/v1');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  setUp(() {
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

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  testWidgets('shows inactive access state and privacy explanation', (
    tester,
  ) async {
    await tester.pumpWidget(const KillNotifyApp());
    await tester.pumpAndSettle();

    expect(find.text('Acesso necessário'), findsOneWidget);
    expect(find.text('Ativar filtro'), findsOneWidget);
    expect(
      find.text(
        'Para aplicar os horários, permita que o KillNotify acompanhe as notificações nas configurações do Android.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Privacidade'));
    await tester.pumpAndSettle();
    expect(find.text('Visibilidade de apps instalados'), findsOneWidget);
    await tester.drag(
      find.byType(ListView).hitTestable().first,
      const Offset(0, -900),
    );
    await tester.pumpAndSettle();
    expect(find.text('Exportar configurações'), findsOneWidget);
  });
}
