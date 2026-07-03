import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/core/security/privacy_guard.dart';

void main() {
  group('PrivacyGuard', () {
    test('keeps only explicitly allowed non-empty fields', () {
      final Map<String, Object?> payload = PrivacyGuard.buildExplicitPayload(
        source: <String, Object?>{
          'fullName': 'Jane Doe',
          'bloodType': 'O+',
          'medicalNotes': '',
          'privateNote': 'Do not share',
          'nullField': null,
        },
        allowedKeys: <String>{
          'fullName',
          'medicalNotes',
          'nullField',
        },
      );

      expect(payload, <String, Object?>{'fullName': 'Jane Doe'});
    });
  });
}
