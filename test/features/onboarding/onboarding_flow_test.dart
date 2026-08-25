import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/app/app.dart';
import 'package:open_life_kit/features/settings/application/app_settings_providers.dart';

void main() {
  testWidgets('start button marks onboarding as done and opens home', (
    WidgetTester tester,
  ) async {
    final ProviderContainer container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const OpenLifeKitApp(),
      ),
    );

    expect(find.text('Commencer'), findsOneWidget);

    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    expect(container.read(appSettingsProvider).onboardingDone, isTrue);
    expect(find.text('Kit de vie local'), findsOneWidget);
  });
}
