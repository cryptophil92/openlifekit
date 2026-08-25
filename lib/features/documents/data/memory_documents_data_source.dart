import 'package:open_life_kit/features/documents/data/documents_data_source.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';

class MemoryDocumentsDataSource implements DocumentsDataSource {
  MemoryDocumentsDataSource([
    List<ImportantDocument> initialDocuments = const <ImportantDocument>[],
  ]) {
    for (final ImportantDocument document in initialDocuments) {
      _items[document.id] = document;
    }
  }

  final Map<String, ImportantDocument> _items = <String, ImportantDocument>{};

  @override
  Future<List<ImportantDocument>> loadDocuments() async {
    return List<ImportantDocument>.unmodifiable(_items.values);
  }

  @override
  Future<void> saveDocument(ImportantDocument document) async {
    _items[document.id] = document;
  }

  @override
  Future<void> forgetDocument(String id) async {
    _items.remove(id);
  }
}
