import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/documents/data/documents_data_source.dart';
import 'package:open_life_kit/features/documents/data/memory_documents_data_source.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';

final documentsDataSourceProvider = Provider<DocumentsDataSource>(
  (ref) => MemoryDocumentsDataSource(
    const <ImportantDocument>[
      ImportantDocument(
        id: 'document-important',
        title: 'Piece importante',
        type: DocumentType.other,
        notes: 'A classer',
      ),
    ],
  ),
);

final documentsProvider = FutureProvider<List<ImportantDocument>>((ref) {
  return ref.watch(documentsDataSourceProvider).loadDocuments();
});
