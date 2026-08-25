import 'package:open_life_kit/core/constants/app_constants.dart';
import 'package:open_life_kit/core/security/privacy_guard.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';
import 'package:open_life_kit/features/emergency_card/domain/emergency_card_preferences.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

class EmergencyPayloadBuilder {
  const EmergencyPayloadBuilder._();

  static Map<String, Object?> build({
    required UserProfile profile,
    required List<ImportantContact> contacts,
    required EmergencyCardPreferences preferences,
  }) {
    final Map<String, Object?> profileSource = <String, Object?>{
      'fullName': profile.displayName,
      'birthDate': profile.birthDate?.toIso8601String(),
      'bloodType': profile.bloodType,
      'allergies': profile.allergies,
      'medications': profile.medications,
      'medicalNotes': profile.medicalNotes,
    };

    return <String, Object?>{
      'schemaVersion': AppConstants.schemaVersion,
      'kind': 'openlifekit.emergency',
      'profile': PrivacyGuard.buildExplicitPayload(
        source: profileSource,
        allowedKeys: preferences.sharedProfileKeys,
      ),
      if (preferences.includeEmergencyContacts)
        'contacts': contacts
            .where((ImportantContact contact) => contact.isEmergencyContact)
            .map((ImportantContact contact) => contact.toJson())
            .toList(growable: false),
    };
  }
}
