import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/contacts/application/contacts_providers.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ImportantContact>> contacts = ref.watch(
      contactsProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts importants')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addPlaceholderContact(ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: contacts.when(
        data: (List<ImportantContact> items) => _ContactsList(items: items),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('Impossible de charger les contacts.'),
        ),
      ),
    );
  }

  Future<void> _addPlaceholderContact(WidgetRef ref) async {
    final List<ImportantContact> contacts = await ref.read(
      contactsProvider.future,
    );
    final int nextIndex = contacts.length + 1;

    await ref.read(contactsDataSourceProvider).saveContact(
          ImportantContact(
            id: 'contact-$nextIndex',
            category: ContactCategory.other,
            displayName: 'Contact $nextIndex',
            phone: 'Telephone a completer',
          ),
        );

    ref.invalidate(contactsProvider);
  }
}

class _ContactsList extends StatelessWidget {
  const _ContactsList({required this.items});

  final List<ImportantContact> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Aucun contact important.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final ImportantContact contact = items[index];

        return Card(
          child: ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(contact.displayName),
            subtitle: Text(_contactDetails(contact)),
            trailing: contact.hasQuickAction
                ? const Icon(Icons.phone_forwarded_outlined)
                : null,
          ),
        );
      },
    );
  }

  String _contactDetails(ImportantContact contact) {
    final List<String> details = <String>[
      if (_hasValue(contact.relationship)) contact.relationship!.trim(),
      if (_hasValue(contact.phone)) contact.phone!.trim(),
      if (_hasValue(contact.email)) contact.email!.trim(),
    ];

    if (details.isEmpty) {
      return 'Details a completer';
    }

    return details.join(' - ');
  }

  bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
