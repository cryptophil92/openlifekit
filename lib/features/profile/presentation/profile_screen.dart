import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          _InfoCard(
            title: 'Identite',
            body: 'Nom, date de naissance, pays et langue seront configurables ici.',
            icon: Icons.person_outline,
          ),
          _InfoCard(
            title: 'Informations utiles',
            body: 'Groupe sanguin, allergies, traitements et notes medicales restent facultatifs.',
            icon: Icons.medical_information_outlined,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(body),
      ),
    );
  }
}
