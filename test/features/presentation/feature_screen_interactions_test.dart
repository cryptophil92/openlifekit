import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/checklists/presentation/checklists_screen.dart';
import 'package:open_life_kit/features/contacts/presentation/contacts_screen.dart';
import 'package:open_life_kit/features/documents/presentation/documents_screen.dart';
import 'package:open_life_kit/features/emergency_card/presentation/emergency_card_screen.dart';
import 'package:open_life_kit/features/profile/presentation/profile_screen.dart';
import 'package:open_life_kit/features/reminders/presentation/reminders_screen.dart';

void main() {
  testWidgets('profile screen saves a local profile through the provider', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Jane');
    await tester.tap(find.text('Enregistrer localement'));
    await tester.pumpAndSettle();

    expect(find.text('Profil enregistre localement.'), findsOneWidget);
  });

  testWidgets('emergency card shows provider data and field toggles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: EmergencyCardScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Carte rapide'), findsOneWidget);
    expect(find.text('Contact proche'), findsOneWidget);
    expect(find.text('Champs actifs: 2'), findsOneWidget);

    await tester.tap(find.text('Inclure les notes'));
    await tester.pumpAndSettle();

    expect(find.text('Champs actifs: 3'), findsOneWidget);
    expect(find.text('Aucune note medicale.'), findsOneWidget);
  });

  testWidgets('contacts screen adds a contact through the provider', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ContactsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Contact proche'), findsOneWidget);

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    expect(find.text('Contact 2'), findsOneWidget);
  });

  testWidgets('contacts screen removes a contact through the provider', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ContactsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Contact proche'), findsOneWidget);

    await tester.tap(find.byTooltip('Retirer Contact proche'));
    await tester.pumpAndSettle();

    expect(find.text('Contact proche'), findsNothing);
    expect(find.text('Aucun contact important.'), findsOneWidget);
  });

  testWidgets('documents screen adds a document through the provider', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: DocumentsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Piece importante'), findsOneWidget);

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();

    expect(find.text('Document 2'), findsOneWidget);
  });

  testWidgets('documents screen removes a document through the provider', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: DocumentsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Piece importante'), findsOneWidget);

    await tester.tap(find.byTooltip('Retirer Piece importante'));
    await tester.pumpAndSettle();

    expect(find.text('Piece importante'), findsNothing);
  });

  testWidgets('reminders screen adds a reminder through the provider', (
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

    expect(find.text('Rappel 2'), findsOneWidget);
  });

  testWidgets('checklists screen toggles an item through the provider', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ChecklistsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Depart en voyage'), findsOneWidget);
    expect(find.text('0/3 fait'), findsWidgets);

    await tester.tap(find.text('Depart en voyage'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Verifier les documents'));
    await tester.pumpAndSettle();

    expect(find.text('1/3 fait'), findsOneWidget);
  });
}
