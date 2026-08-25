import 'package:open_life_kit/features/settings/domain/app_settings.dart';
import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';

class AppSettingsActions {
  const AppSettingsActions._();

  static AppSettings withIntroAccepted(AppSettings current) {
    return current.copyWith(onboardingDone: true);
  }

  static AppSettings withTheme(
    AppSettings current,
    AppThemePreference preference,
  ) {
    return current.copyWith(themePreference: preference);
  }
}
