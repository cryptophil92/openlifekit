import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/reminders/presentation/reminders_screen.dart';

void main() {
  testWidgets('reminders screen adds a reminder through the form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: RemindersScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Controle document'), findsOneWidget);

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.bySemanticsLabel('Titre du rappel'),
      'Rappel local',
    );
    await tester.enterText(find.bySemanticsLabel('Detail'), 'Detail du rappel');
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Rappel local'), findsOneWidget);
    expect(find.text('Detail du rappel'), findsOneWidget);
  });

  testWidgets('reminders screen validates required title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: RemindersScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Champ obligatoire'), findsOneWidget);
    expect(find.text('Nouveau rappel'), findsOneWidget);
  });

  testWidgets('reminders screen confirms reminder removal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: RemindersScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Controle document'), findsOneWidget);

    await tester.tap(find.byTooltip('Retirer Controle document'));
    await tester.pumpAndSettle();

    expect(find.text('Retirer le rappel ?'), findsOneWidget);
    expect(
      find.text('Le rappel Controle document sera retire de la liste locale.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Retirer'));
    await tester.pumpAndSettle();

    expect(find.text('Controle document'), findsNothing);
    expect(find.text('Aucun rappel local.'), findsOneWidget);
  });
}
