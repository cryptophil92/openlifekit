import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/contacts/application/contacts_providers.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';
import 'package:open_life_kit/features/profile/application/profile_providers.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

class EmergencyCardScreen extends ConsumerStatefulWidget {
  const EmergencyCardScreen({super.key});

  @override
  ConsumerState<EmergencyCardScreen> createState() => _EmergencyCardScreenState();
}

class _EmergencyCardScreenState extends ConsumerState<EmergencyCardScreen> {
  bool _showName = true;
  bool _showContacts = true;
  bool _showNotes = false;
  bool _hideByDefault = true;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserProfile?> profile = ref.watch(profileProvider);
    final AsyncValue<List<ImportantContact>> contacts = ref.watch(
      contactsProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Fiche partageable')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Carte rapide',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text('Choisissez les champs a inclure.'),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    value: _hideByDefault,
                    onChanged: (bool value) {
                      setState(() => _hideByDefault = value);
                    },
                    title: const Text('Masquer par defaut'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                  value: _showName,
                  onChanged: (bool? value) {
                    setState(() => _showName = value ?? false);
                  },
                  title: const Text('Inclure le nom'),
                ),
                CheckboxListTile(
                  value: _showContacts,
                  onChanged: (bool? value) {
                    setState(() => _showContacts = value ?? false);
                  },
                  title: const Text('Inclure les contacts'),
                ),
                CheckboxListTile(
                  value: _showNotes,
                  onChanged: (bool? value) {
                    setState(() => _showNotes = value ?? false);
                  },
                  title: const Text('Inclure les notes'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.qr_code_2_outlined, size: 96),
                  const SizedBox(height: 8),
                  Text(
                    'QR code prevu',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text('Champs actifs: ${_activeFieldCount()}'),
                  const Divider(height: 32),
                  if (_showName) _ProfilePreview(profile: profile),
                  if (_showContacts) _ContactsPreview(contacts: contacts),
                  if (_showNotes) _NotesPreview(profile: profile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _activeFieldCount() {
    return <bool>[_showName, _showContacts, _showNotes]
        .where((bool value) => value)
        .length;
  }
}

class _ProfilePreview extends StatelessWidget {
  const _ProfilePreview({required this.profile});

  final AsyncValue<UserProfile?> profile;

  @override
  Widget build(BuildContext context) {
    return profile.when(
      data: (UserProfile? value) {
        final String name = value == null || value.displayName.isEmpty
            ? 'Nom non renseigne'
            : value.displayName;
        return _PreviewLine(icon: Icons.person_outline, text: name);
      },
      loading: () => const _PreviewLine(
        icon: Icons.hourglass_empty,
        text: 'Chargement du profil...',
      ),
      error: (Object error, StackTrace stackTrace) => const _PreviewLine(
        icon: Icons.error_outline,
        text: 'Profil indisponible',
      ),
    );
  }
}

class _ContactsPreview extends StatelessWidget {
  const _ContactsPreview({required this.contacts});

  final AsyncValue<List<ImportantContact>> contacts;

  @override
  Widget build(BuildContext context) {
    return contacts.when(
      data: (List<ImportantContact> items) {
        if (items.isEmpty) {
          return const _PreviewLine(
            icon: Icons.contacts_outlined,
            text: 'Aucun contact important',
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final ImportantContact contact in items.take(3))
              _PreviewLine(
                icon: Icons.contacts_outlined,
                text: contact.displayName,
              ),
          ],
        );
      },
      loading: () => const _PreviewLine(
        icon: Icons.hourglass_empty,
        text: 'Chargement des contacts...',
      ),
      error: (Object error, StackTrace stackTrace) => const _PreviewLine(
        icon: Icons.error_outline,
        text: 'Contacts indisponibles',
      ),
    );
  }
}

class _NotesPreview extends StatelessWidget {
  const _NotesPreview({required this.profile});

  final AsyncValue<UserProfile?> profile;

  @override
  Widget build(BuildContext context) {
    return profile.when(
      data: (UserProfile? value) => _PreviewLine(
        icon: Icons.medical_information_outlined,
        text: value?.medicalNotes?.trim().isNotEmpty == true
            ? value!.medicalNotes!.trim()
            : 'Aucune note medicale.',
      ),
      loading: () => const _PreviewLine(
        icon: Icons.hourglass_empty,
        text: 'Chargement des notes...',
      ),
      error: (Object error, StackTrace stackTrace) => const _PreviewLine(
        icon: Icons.error_outline,
        text: 'Notes indisponibles',
      ),
    );
  }
}

class _PreviewLine extends StatelessWidget {
  const _PreviewLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
