import 'package:flutter/material.dart';

class EmergencyCardScreen extends StatefulWidget {
  const EmergencyCardScreen({super.key});

  @override
  State<EmergencyCardScreen> createState() => _EmergencyCardScreenState();
}

class _EmergencyCardScreenState extends State<EmergencyCardScreen> {
  bool _showName = true;
  bool _showGroup = true;
  bool _showNotes = false;
  bool _hideByDefault = true;

  @override
  Widget build(BuildContext context) {
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
                    onChanged: (bool value) => setState(() => _hideByDefault = value),
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
                  onChanged: (bool? value) => setState(() => _showName = value ?? false),
                  title: const Text('Inclure le nom'),
                ),
                CheckboxListTile(
                  value: _showGroup,
                  onChanged: (bool? value) => setState(() => _showGroup = value ?? false),
                  title: const Text('Inclure le groupe'),
                ),
                CheckboxListTile(
                  value: _showNotes,
                  onChanged: (bool? value) => setState(() => _showNotes = value ?? false),
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
                children: <Widget>[
                  const Icon(Icons.qr_code_2_outlined, size: 96),
                  const SizedBox(height: 8),
                  Text(
                    'QR code prevu',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text('Champs actifs: ${_activeFieldCount()}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _activeFieldCount() {
    return <bool>[_showName, _showGroup, _showNotes].where((bool value) => value).length;
  }
}
