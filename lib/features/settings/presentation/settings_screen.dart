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
          _ThemeTile(
            title: 'Theme systeme',
            selected: settings.themePreference == AppThemePreference.useSystem,
            onTap: () => _setTheme(ref, AppThemePreference.useSystem),
          ),
          _ThemeTile(
            title: 'Theme clair',
            selected: settings.themePreference == AppThemePreference.useLight,
            onTap: () => _setTheme(ref, AppThemePreference.useLight),
          ),
          _ThemeTile(
            title: 'Theme sombre',
            selected: settings.themePreference == AppThemePreference.useDark,
            onTap: () => _setTheme(ref, AppThemePreference.useDark),
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

  void _setTheme(WidgetRef ref, AppThemePreference value) {
    final current = ref.read(appSettingsProvider);
    ref.read(appSettingsProvider.notifier).state =
        current.copyWith(themePreference: value);
  }
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(selected ? Icons.check_circle : Icons.circle_outlined),
      title: Text(title),
      onTap: onTap,
    );
  }
}
