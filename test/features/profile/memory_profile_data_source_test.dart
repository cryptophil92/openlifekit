import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/profile/data/memory_profile_data_source.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

void main() {
  group('MemoryProfileDataSource', () {
    test('returns null when no profile exists', () async {
      final MemoryProfileDataSource dataSource = MemoryProfileDataSource();

      final UserProfile? profile = await dataSource.loadProfile();

      expect(profile, isNull);
    });

    test('loads initial profile', () async {
      final MemoryProfileDataSource dataSource = MemoryProfileDataSource(
        const UserProfile(firstName: 'Jane'),
      );

      final UserProfile? profile = await dataSource.loadProfile();

      expect(profile?.firstName, 'Jane');
    });

    test('saves profile', () async {
      final MemoryProfileDataSource dataSource = MemoryProfileDataSource();

      await dataSource.saveProfile(const UserProfile(firstName: 'Jane'));

      final UserProfile? profile = await dataSource.loadProfile();

      expect(profile?.displayName, 'Jane');
    });
  });
}
