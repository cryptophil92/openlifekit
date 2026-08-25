import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/settings/application/app_settings_providers.dart';
import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';
import 'package:open_life_kit/features/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('selecting dark theme updates app settings', (
    WidgetTester tester,
  ) async {
    final ProviderContainer container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    expect(container.read(appSettingsProvider).themePreference,
        AppThemePreference.useSystem);

    await tester.tap(find.text('Theme sombre'));
    await tester.pumpAndSettle();

    expect(container.read(appSettingsProvider).themePreference,
        AppThemePreference.useDark);
  });
}
