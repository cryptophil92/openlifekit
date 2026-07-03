import 'package:flutter/material.dart';

class ChecklistsScreen extends StatelessWidget {
  const ChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklists')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Creer'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.flight_takeoff_outlined),
              title: Text('Depart en voyage'),
              subtitle: Text('Documents, maison, sante, transport.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.local_hospital_outlined),
              title: Text('Hospitalisation'),
              subtitle: Text('Papiers, contacts, affaires utiles.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.home_repair_service_outlined),
              title: Text('Panne domestique'),
              subtitle: Text('Actions rapides et contacts utiles.'),
            ),
          ),
        ],
      ),
    );
  }
}
