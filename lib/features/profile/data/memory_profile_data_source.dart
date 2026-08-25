import 'package:open_life_kit/features/profile/data/profile_data_source.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

class MemoryProfileDataSource implements ProfileDataSource {
  MemoryProfileDataSource([UserProfile? initialProfile])
      : _profile = initialProfile;

  UserProfile? _profile;

  @override
  Future<UserProfile?> loadProfile() async {
    return _profile;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    _profile = profile;
  }
}
