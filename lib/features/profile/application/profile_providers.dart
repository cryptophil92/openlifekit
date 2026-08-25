import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/profile/data/memory_profile_data_source.dart';
import 'package:open_life_kit/features/profile/data/profile_data_source.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

final profileDataSourceProvider = Provider<ProfileDataSource>(
  (ref) => MemoryProfileDataSource(),
);

final profileProvider = FutureProvider<UserProfile?>((ref) {
  return ref.watch(profileDataSourceProvider).loadProfile();
});
