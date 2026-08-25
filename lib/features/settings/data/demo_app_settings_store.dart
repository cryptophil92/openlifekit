import 'package:open_life_kit/features/settings/domain/app_settings.dart';

class DemoAppSettingsStore {
  AppSettings value = const AppSettings();

  Future<AppSettings> load() async => value;

  Future<void> save(AppSettings next) async {
    value = next;
  }
}
