import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts importants')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.family_restroom_outlined),
              title: Text('Famille'),
              subtitle: Text('Contact familial ou proche aidant.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.local_hospital_outlined),
              title: Text('Medecin'),
              subtitle: Text('Contact medical utile.'),
            ),
          ),
        ],
      ),
    );
  }
}
