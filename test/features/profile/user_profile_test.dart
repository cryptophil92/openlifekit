import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

void main() {
  group('UserProfile', () {
    test('builds a trimmed display name', () {
      const UserProfile profile = UserProfile(
        firstName: ' Jane ',
        lastName: ' Doe ',
      );

      expect(profile.displayName, 'Jane Doe');
    });

    test('round trips JSON', () {
      final UserProfile profile = UserProfile(
        firstName: 'Jane',
        lastName: 'Doe',
        birthDate: DateTime.utc(1990, 1, 2),
        bloodType: 'O+',
      );

      final UserProfile parsed = UserProfile.fromJson(profile.toJson());

      expect(parsed.displayName, 'Jane Doe');
      expect(parsed.birthDate, DateTime.utc(1990, 1, 2));
      expect(parsed.bloodType, 'O+');
    });
  });
}
