import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';
import 'package:open_life_kit/features/emergency_card/application/emergency_payload_builder.dart';
import 'package:open_life_kit/features/emergency_card/domain/emergency_card_preferences.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

void main() {
  group('EmergencyPayloadBuilder', () {
    test('keeps only explicitly enabled profile fields', () {
      final Map<String, Object?> payload = EmergencyPayloadBuilder.build(
        profile: const UserProfile(
          firstName: 'Jane',
          lastName: 'Doe',
          bloodType: 'O+',
          medicalNotes: 'Private note',
        ),
        contacts: const <ImportantContact>[],
        preferences: const EmergencyCardPreferences(
          includeFullName: true,
          includeBloodType: false,
          includeMedicalNotes: false,
          includeAllergies: false,
          includeMedications: false,
        ),
      );

      final Object? profile = payload['profile'];
      expect(profile, isA<Map<String, Object?>>());
      expect((profile! as Map<String, Object?>), <String, Object?>{
        'fullName': 'Jane Doe',
      });
    });
  });
}
