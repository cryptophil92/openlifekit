enum AppThemePreference {
  useSystem,
  useLight,
  useDark,
}

AppThemePreference appThemePreferenceFromJson(Object? value) {
  if (value is! String) {
    return AppThemePreference.useSystem;
  }

  return AppThemePreference.values.firstWhere(
    (AppThemePreference item) => item.name == value,
    orElse: () => AppThemePreference.useSystem,
  );
}
