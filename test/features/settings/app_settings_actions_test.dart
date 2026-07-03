import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/settings/application/app_settings_actions.dart';
import 'package:open_life_kit/features/settings/domain/app_settings.dart';
import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';

void main() {
  group('AppSettingsActions', () {
    test('marks intro as accepted', () {
      const AppSettings initial = AppSettings();

      final AppSettings result = AppSettingsActions.withIntroAccepted(initial);

      expect(result.onboardingDone, isTrue);
      expect(result.localeCode, initial.localeCode);
    });

    test('changes theme without changing other settings', () {
      const AppSettings initial = AppSettings(onboardingDone: true);

      final AppSettings result = AppSettingsActions.withTheme(
        initial,
        AppThemePreference.useDark,
      );

      expect(result.onboardingDone, isTrue);
      expect(result.themePreference, AppThemePreference.useDark);
    });
  });
}
