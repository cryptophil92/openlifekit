import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/profile/application/profile_providers.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool _loadedInitialProfile = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserProfile?> profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: profile.when(
        data: (UserProfile? value) {
          _loadProfileOnce(value);
          return _ProfileForm(
            formKey: _formKey,
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            countryController: _countryController,
            notesController: _notesController,
            onSave: _saveProfile,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('Erreur de chargement.'),
        ),
      ),
    );
  }

  void _loadProfileOnce(UserProfile? profile) {
    if (_loadedInitialProfile || profile == null) {
      return;
    }

    _firstNameController.text = profile.firstName ?? '';
    _lastNameController.text = profile.lastName ?? '';
    _countryController.text = profile.countryCode ?? '';
    _notesController.text = profile.medicalNotes ?? '';
    _loadedInitialProfile = true;
  }

  Future<void> _saveProfile() async {
    final UserProfile profile = UserProfile(
      firstName: _emptyToNull(_firstNameController.text),
      lastName: _emptyToNull(_lastNameController.text),
      countryCode: _emptyToNull(_countryController.text),
      medicalNotes: _emptyToNull(_notesController.text),
    );

    await ref.read(profileDataSourceProvider).saveProfile(profile);
    ref.invalidate(profileProvider);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil enregistre localement.')),
    );
  }

  String? _emptyToNull(String value) {
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class _ProfileForm extends StatelessWidget {
  const _ProfileForm({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.countryController,
    required this.notesController,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController countryController;
  final TextEditingController notesController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            'Informations facultatives',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              labelText: 'Prenom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: lastNameController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: countryController,
            decoration: const InputDecoration(
              labelText: 'Pays',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: notesController,
            decoration: const InputDecoration(
              labelText: 'Notes utiles',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Enregistrer localement'),
          ),
        ],
      ),
    );
  }
}
