import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/settings/application/app_settings_providers.dart';
import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Parametres')),
      body: ListView(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.language_outlined),
            title: Text('Langue'),
            subtitle: Text('Francais et anglais.'),
          ),
          RadioListTile<AppThemePreference>(
            value: AppThemePreference.useSystem,
            groupValue: settings.themePreference,
            onChanged: (value) => _setTheme(ref, value),
            title: const Text('Theme systeme'),
          ),
          RadioListTile<AppThemePreference>(
            value: AppThemePreference.useLight,
            groupValue: settings.themePreference,
            onChanged: (value) => _setTheme(ref, value),
            title: const Text('Theme clair'),
          ),
          RadioListTile<AppThemePreference>(
            value: AppThemePreference.useDark,
            groupValue: settings.themePreference,
            onChanged: (value) => _setTheme(ref, value),
            title: const Text('Theme sombre'),
          ),
          const ListTile(
            leading: Icon(Icons.file_upload_outlined),
            title: Text('Sauvegarde locale'),
            subtitle: Text('JSON local prevu.'),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Open source'),
            subtitle: Text('Licence Apache 2.0.'),
          ),
        ],
      ),
    );
  }

  void _setTheme(WidgetRef ref, AppThemePreference? value) {
    if (value == null) {
      return;
    }

    final current = ref.read(appSettingsProvider);
    ref.read(appSettingsProvider.notifier).state =
        current.copyWith(themePreference: value);
  }
}
