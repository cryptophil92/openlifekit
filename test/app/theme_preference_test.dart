import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/app/app.dart';
import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';

void main() {
  group('themeModeFromPreference', () {
    test('maps system preference', () {
      expect(
        themeModeFromPreference(AppThemePreference.useSystem),
        ThemeMode.system,
      );
    });

    test('maps light preference', () {
      expect(
        themeModeFromPreference(AppThemePreference.useLight),
        ThemeMode.light,
      );
    });

    test('maps dark preference', () {
      expect(
        themeModeFromPreference(AppThemePreference.useDark),
        ThemeMode.dark,
      );
    });
  });
}
