import 'package:open_life_kit/features/settings/domain/app_theme_preference.dart';

class AppSettings {
  const AppSettings({
    this.onboardingDone = false,
    this.localeCode = 'fr',
    this.themePreference = AppThemePreference.useSystem,
  });

  final bool onboardingDone;
  final String localeCode;
  final AppThemePreference themePreference;

  AppSettings copyWith({
    bool? onboardingDone,
    String? localeCode,
    AppThemePreference? themePreference,
  }) {
    return AppSettings(
      onboardingDone: onboardingDone ?? this.onboardingDone,
      localeCode: localeCode ?? this.localeCode,
      themePreference: themePreference ?? this.themePreference,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'onboardingDone': onboardingDone,
      'localeCode': localeCode,
      'themePreference': themePreference.name,
    };
  }

  factory AppSettings.fromJson(Map<String, Object?> json) {
    return AppSettings(
      onboardingDone: json['onboardingDone'] as bool? ?? false,
      localeCode: json['localeCode'] as String? ?? 'fr',
      themePreference: appThemePreferenceFromJson(json['themePreference']),
    );
  }
}
