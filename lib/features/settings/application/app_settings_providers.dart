import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/settings/domain/app_settings.dart';

final StateProvider<AppSettings> appSettingsProvider =
    StateProvider<AppSettings>((ref) => const AppSettings());
