import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/documents/data/memory_documents_data_source.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';

void main() {
  group('MemoryDocumentsDataSource', () {
    test('loads initial documents', () async {
      final MemoryDocumentsDataSource dataSource = MemoryDocumentsDataSource(
        const <ImportantDocument>[
          ImportantDocument(
            id: '1',
            title: 'Passport',
            type: DocumentType.identity,
          ),
        ],
      );

      final List<ImportantDocument> documents = await dataSource.loadDocuments();

      expect(documents, hasLength(1));
      expect(documents.single.title, 'Passport');
    });

    test('saves and replaces documents by id', () async {
      final MemoryDocumentsDataSource dataSource = MemoryDocumentsDataSource();

      await dataSource.saveDocument(
        const ImportantDocument(
          id: '1',
          title: 'Old document',
          type: DocumentType.other,
        ),
      );
      await dataSource.saveDocument(
        const ImportantDocument(
          id: '1',
          title: 'New document',
          type: DocumentType.work,
        ),
      );

      final List<ImportantDocument> documents = await dataSource.loadDocuments();

      expect(documents, hasLength(1));
      expect(documents.single.title, 'New document');
      expect(documents.single.type, DocumentType.work);
    });

    test('forgets documents by id', () async {
      final MemoryDocumentsDataSource dataSource = MemoryDocumentsDataSource(
        const <ImportantDocument>[
          ImportantDocument(
            id: '1',
            title: 'Passport',
            type: DocumentType.identity,
          ),
          ImportantDocument(
            id: '2',
            title: 'Insurance',
            type: DocumentType.insurance,
          ),
        ],
      );

      await dataSource.forgetDocument('1');

      final List<ImportantDocument> documents = await dataSource.loadDocuments();

      expect(documents, hasLength(1));
      expect(documents.single.id, '2');
      expect(documents.single.title, 'Insurance');
    });
  });
}
