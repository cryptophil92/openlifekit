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

  testWidgets('contacts screen adds a contact through the form', (
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

    await tester.enterText(find.bySemanticsLabel('Nom du contact'), 'Jane Doe');
    await tester.enterText(find.bySemanticsLabel('Lien'), 'Soeur');
    await tester.enterText(find.bySemanticsLabel('Telephone'), '0600000000');
    await tester.enterText(find.bySemanticsLabel('Email'), 'jane@example.com');
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('Soeur - 0600000000 - jane@example.com'), findsOneWidget);
  });

  testWidgets('contacts screen validates required name', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ContactsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Champ obligatoire'), findsOneWidget);
    expect(find.text('Nouveau contact'), findsOneWidget);
  });

  testWidgets('contacts screen confirms contact removal', (
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

    expect(find.text('Retirer le contact ?'), findsOneWidget);
    expect(
      find.text('Le contact Contact proche sera retire de la liste locale.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Retirer'));
    await tester.pumpAndSettle();

    expect(find.text('Contact proche'), findsNothing);
    expect(find.text('Aucun contact important.'), findsOneWidget);
  });

  testWidgets('documents screen adds a document through the form', (
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

    await tester.enterText(
      find.bySemanticsLabel('Titre du document'),
      'Passeport Jane',
    );
    await tester.enterText(find.bySemanticsLabel('Reference'), 'AA123456');
    await tester.enterText(find.bySemanticsLabel('Notes'), 'Copie scannee');
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Passeport Jane'), findsOneWidget);
    expect(find.text('other - AA123456 - Copie scannee'), findsOneWidget);
  });

  testWidgets('documents screen validates required title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: DocumentsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Champ obligatoire'), findsOneWidget);
    expect(find.text('Nouveau document'), findsOneWidget);
  });

  testWidgets('documents screen confirms document removal', (
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

    expect(find.text('Retirer le document ?'), findsOneWidget);
    expect(
      find.text('Le document Piece importante sera retire de la liste locale.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Retirer'));
    await tester.pumpAndSettle();

    expect(find.text('Piece importante'), findsNothing);
    expect(find.text('Aucun document important.'), findsOneWidget);
  });

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

    await tester.enterText(find.bySemanticsLabel('Titre du rappel'), 'Rappel 2');
    await tester.tap(find.text('Enregistrer'));
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
