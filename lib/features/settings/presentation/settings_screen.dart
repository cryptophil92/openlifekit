import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parametres')),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.language_outlined),
            title: Text('Langue'),
            subtitle: Text('Francais et anglais.'),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Theme'),
            subtitle: Text('Systeme, clair ou sombre.'),
          ),
          ListTile(
            leading: Icon(Icons.file_upload_outlined),
            title: Text('Sauvegarde locale'),
            subtitle: Text('Import et sauvegarde JSON.'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Open source'),
            subtitle: Text('Licence, contribution et confidentialite.'),
          ),
        ],
      ),
    );
  }
}
