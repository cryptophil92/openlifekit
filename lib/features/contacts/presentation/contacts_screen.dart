import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<_ContactDraft> _contacts = <_ContactDraft>[
    const _ContactDraft(name: 'Contact proche', details: 'Telephone a ajouter'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts importants')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPlaceholderContact,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _contacts.length,
        itemBuilder: (BuildContext context, int index) {
          final _ContactDraft contact = _contacts[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(contact.name),
              subtitle: Text(contact.details),
              trailing: IconButton(
                tooltip: 'Supprimer',
                onPressed: () => _removeContact(index),
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addPlaceholderContact() {
    setState(() {
      _contacts.add(
        _ContactDraft(
          name: 'Contact ${_contacts.length + 1}',
          details: 'Details a completer',
        ),
      );
    });
  }

  void _removeContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }
}

class _ContactDraft {
  const _ContactDraft({required this.name, required this.details});

  final String name;
  final String details;
}
