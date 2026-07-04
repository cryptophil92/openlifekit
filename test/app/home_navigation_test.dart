import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_life_kit/app/app.dart';
import 'package:open_life_kit/app/router.dart';

void main() {
  final List<_NavigationCase> cases = <_NavigationCase>[
    const _NavigationCase(
      sourceText: 'Profil',
      destinationText: 'Informations facultatives',
    ),
    const _NavigationCase(
      sourceText: 'Fiche urgence',
      destinationText: 'Carte rapide',
    ),
    const _NavigationCase(
      sourceText: 'Contacts importants',
      destinationText: 'Contact proche',
    ),
    const _NavigationCase(
      sourceText: 'Documents',
      destinationText: 'Piece importante',
    ),
    const _NavigationCase(
      sourceText: 'Rappels',
      destinationText: 'Controle document',
    ),
    const _NavigationCase(
      sourceText: 'Checklists',
      destinationText: 'Depart en voyage',
    ),
  ];

  for (final _NavigationCase item in cases) {
    testWidgets('home opens ${item.sourceText}', (WidgetTester tester) async {
      final GoRouter router = buildAppRouter();
      await tester.pumpWidget(
        ProviderScope(child: OpenLifeKitApp(router: router)),
      );

      await tester.tap(find.text('Commencer'));
      await tester.pumpAndSettle();

      final finder = find.text(item.sourceText);
      await tester.scrollUntilVisible(finder, 300);
      await tester.tap(finder);
      await tester.pumpAndSettle();

      expect(find.text(item.destinationText), findsOneWidget);
    });
  }

  testWidgets('home opens settings from app bar', (WidgetTester tester) async {
    final GoRouter router = buildAppRouter();
    await tester.pumpWidget(
      ProviderScope(child: OpenLifeKitApp(router: router)),
    );

    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Parametres'));
    await tester.pumpAndSettle();

    expect(find.text('Theme systeme'), findsOneWidget);
  });
}

class _NavigationCase {
  const _NavigationCase({
    required this.sourceText,
    required this.destinationText,
  });

  final String sourceText;
  final String destinationText;
}
