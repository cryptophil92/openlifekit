import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
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
              leading: Icon(Icons.badge_outlined),
              title: Text('Identite'),
              subtitle: Text('Reference, expiration et rappel.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.directions_car_outlined),
              title: Text('Vehicule'),
              subtitle: Text('Assurance, controle technique ou carte grise.'),
            ),
          ),
        ],
      ),
    );
  }
}
