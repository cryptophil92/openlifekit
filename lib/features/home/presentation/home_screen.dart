import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_life_kit/core/constants/app_constants.dart';
import 'package:open_life_kit/core/routing/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: <Widget>[
          IconButton(
            tooltip: 'Parametres',
            onPressed: () => context.go(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            'Kit de vie local',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Centralisez vos informations essentielles, sans compte et sans collecte.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          _HomeActionCard(
            title: 'Fiche urgence',
            description: 'Voir les informations utiles en situation urgente.',
            icon: Icons.emergency_outlined,
            onTap: () => context.go(AppRoutes.emergencyCard),
          ),
          _HomeActionCard(
            title: 'Profil',
            description:
                'Renseigner les informations personnelles facultatives.',
            icon: Icons.person_outline,
            onTap: () => context.go(AppRoutes.profile),
          ),
          _HomeActionCard(
            title: 'Contacts importants',
            description:
                'Famille, medecin, assurance, ecole, travail ou autre.',
            icon: Icons.contacts_outlined,
            onTap: () => context.go(AppRoutes.contacts),
          ),
          _HomeActionCard(
            title: 'Documents',
            description: 'Suivre les references et dates importantes.',
            icon: Icons.description_outlined,
            onTap: () => context.go(AppRoutes.documents),
          ),
          _HomeActionCard(
            title: 'Rappels',
            description: 'Voir les echeances locales importantes.',
            icon: Icons.notifications_active_outlined,
            onTap: () => context.go(AppRoutes.reminders),
          ),
          _HomeActionCard(
            title: 'Checklists',
            description:
                'Voyage, papiers perdus, hospitalisation ou tache perso.',
            icon: Icons.checklist_outlined,
            onTap: () => context.go(AppRoutes.checklists),
          ),
        ],
      ),
    );
  }
}

class _HomeActionCard extends StatelessWidget {
  const _HomeActionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
