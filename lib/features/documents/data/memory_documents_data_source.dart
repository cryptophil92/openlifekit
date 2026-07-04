import 'package:open_life_kit/features/documents/data/documents_data_source.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';

class MemoryDocumentsDataSource implements DocumentsDataSource {
  MemoryDocumentsDataSource([
    List<ImportantDocument> initialDocuments = const <ImportantDocument>[],
  ]) {
    for (final ImportantDocument document in initialDocuments) {
      _documentsById[document.id] = document;
    }
  }

  final Map<String, ImportantDocument> _documentsById = <String, ImportantDocument>{};

  @override
  Future<List<ImportantDocument>> loadDocuments() async {
    return List<ImportantDocument>.unmodifiable(_documentsById.values);
  }

  @override
  Future<void> saveDocument(ImportantDocument document) async {
    _documentsById[document.id] = document;
  }
}
