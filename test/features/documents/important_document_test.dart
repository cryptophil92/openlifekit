import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';

void main() {
  group('ImportantDocument', () {
    test('detects outdated dates', () {
      final ImportantDocument document = ImportantDocument(
        id: 'doc',
        title: 'Document',
        type: DocumentType.other,
        expirationDate: DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(document.isExpired, isTrue);
    });

    test('round trips JSON', () {
      final ImportantDocument document = ImportantDocument(
        id: 'doc-2',
        title: 'Document 2',
        type: DocumentType.other,
        expirationDate: DateTime.utc(2027, 1, 1),
        reminderEnabled: true,
      );

      final ImportantDocument parsed = ImportantDocument.fromJson(document.toJson());

      expect(parsed.id, 'doc-2');
      expect(parsed.type, DocumentType.other);
      expect(parsed.reminderEnabled, isTrue);
    });
  });
}
