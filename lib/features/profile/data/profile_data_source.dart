import 'package:open_life_kit/features/profile/domain/user_profile.dart';

abstract class ProfileDataSource {
  Future<UserProfile?> loadProfile();
  Future<void> saveProfile(UserProfile profile);
}
