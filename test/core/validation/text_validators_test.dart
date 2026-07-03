import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/core/validation/text_validators.dart';

void main() {
  group('TextValidators', () {
    test('requiredText rejects empty text', () {
      expect(TextValidators.requiredText('  '), 'Champ obligatoire');
      expect(TextValidators.requiredText('ok'), isNull);
    });

    test('optionalEmail validates simple email format', () {
      expect(TextValidators.optionalEmail(null), isNull);
      expect(TextValidators.optionalEmail('bad'), 'Email invalide');
      expect(TextValidators.optionalEmail('test@example.com'), isNull);
    });
  });
}
