import 'package:open_life_kit/features/settings/domain/app_settings.dart';

abstract class AppSettingsStore {
  Future<AppSettings> load();
  Future<void> store(AppSettings settings);
  Future<void> reset();
}
