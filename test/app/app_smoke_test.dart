import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/app/app.dart';

void main() {
  testWidgets('renders onboarding first', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: OpenLifeKitApp()));

    expect(find.text('OpenLifeKit'), findsOneWidget);
    expect(find.text('Commencer'), findsOneWidget);
  });
}
