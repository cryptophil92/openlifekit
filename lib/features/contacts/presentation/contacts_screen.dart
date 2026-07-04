import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/core/validation/text_validators.dart';
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
          _openContactForm(context, ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: contacts.when(
        data: (List<ImportantContact> items) => _ContactsList(
          items: items,
          onRemove: (ImportantContact contact) => _confirmRemoveContact(
            context,
            ref,
            contact,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('Impossible de charger les contacts.'),
        ),
      ),
    );
  }

  Future<void> _openContactForm(BuildContext context, WidgetRef ref) async {
    final _ContactFormResult? result = await showDialog<_ContactFormResult>(
      context: context,
      builder: (BuildContext context) => const _ContactFormDialog(),
    );

    if (result == null) {
      return;
    }

    final List<ImportantContact> contacts = await ref.read(
      contactsProvider.future,
    );
    final int nextIndex = contacts.length + 1;

    await ref.read(contactsDataSourceProvider).saveContact(
          ImportantContact(
            id: 'contact-$nextIndex',
            category: ContactCategory.other,
            displayName: result.displayName,
            relationship: result.relationship,
            phone: result.phone,
            email: result.email,
          ),
        );

    ref.invalidate(contactsProvider);
  }

  Future<void> _confirmRemoveContact(
    BuildContext context,
    WidgetRef ref,
    ImportantContact contact,
  ) async {
    final bool confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Retirer le contact ?'),
            content: Text(
              'Le contact ${contact.displayName} sera retire de la liste locale.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Retirer'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await _removeContact(ref, contact.id);
  }

  Future<void> _removeContact(WidgetRef ref, String id) async {
    await ref.read(contactsDataSourceProvider).removeContact(id);
    ref.invalidate(contactsProvider);
  }
}

class _ContactsList extends StatelessWidget {
  const _ContactsList({required this.items, required this.onRemove});

  final List<ImportantContact> items;
  final ValueChanged<ImportantContact> onRemove;

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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (contact.hasQuickAction)
                  const Icon(Icons.phone_forwarded_outlined),
                IconButton(
                  tooltip: 'Retirer ${contact.displayName}',
                  onPressed: () => onRemove(contact),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
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

class _ContactFormDialog extends StatefulWidget {
  const _ContactFormDialog();

  @override
  State<_ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<_ContactFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouveau contact'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du contact',
                ),
                textInputAction: TextInputAction.next,
                validator: TextValidators.requiredText,
              ),
              TextFormField(
                controller: _relationshipController,
                decoration: const InputDecoration(labelText: 'Lien'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telephone'),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: TextValidators.optionalEmail,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop(
      _ContactFormResult(
        displayName: _nameController.text.trim(),
        relationship: _emptyToNull(_relationshipController.text),
        phone: _emptyToNull(_phoneController.text),
        email: _emptyToNull(_emailController.text),
      ),
    );
  }

  String? _emptyToNull(String value) {
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class _ContactFormResult {
  const _ContactFormResult({
    required this.displayName,
    required this.relationship,
    required this.phone,
    required this.email,
  });

  final String displayName;
  final String? relationship;
  final String? phone;
  final String? email;
}
