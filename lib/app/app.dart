import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_life_kit/app/router.dart';
import 'package:open_life_kit/app/theme.dart';
import 'package:open_life_kit/core/constants/app_constants.dart';
import 'package:open_life_kit/features/settings/application/app_settings_providers.dart';
import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';

class OpenLifeKitApp extends ConsumerWidget {
  const OpenLifeKitApp({super.key, GoRouter? router}) : _router = router;

  final GoRouter? _router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: _router ?? appRouter,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: themeModeFromPreference(settings.themePreference),
      supportedLocales: const <Locale>[
        Locale('fr'),
        Locale('en'),
      ],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}

ThemeMode themeModeFromPreference(AppThemePreference preference) {
  switch (preference) {
    case AppThemePreference.useLight:
      return ThemeMode.light;
    case AppThemePreference.useDark:
      return ThemeMode.dark;
    case AppThemePreference.useSystem:
      return ThemeMode.system;
  }
}
