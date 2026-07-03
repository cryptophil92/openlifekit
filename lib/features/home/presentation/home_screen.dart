import 'package:flutter/material.dart';
import 'package:open_life_kit/core/constants/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
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
            'Centralisez vos informations essentielles, sans compte et sans collecte de données.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          _HomeActionCard(
            title: 'Fiche d’urgence',
            description: 'Préparer une fiche lisible et partageable uniquement avec les champs validés.',
            icon: Icons.emergency_outlined,
            onTap: () {},
          ),
          _HomeActionCard(
            title: 'Contacts importants',
            description: 'Famille, médecin, assurance, école, travail ou autre contact utile.',
            icon: Icons.contacts_outlined,
            onTap: () {},
          ),
          _HomeActionCard(
            title: 'Documents critiques',
            description: 'Suivre les références, dates d’expiration et rappels importants.',
            icon: Icons.description_outlined,
            onTap: () {},
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
