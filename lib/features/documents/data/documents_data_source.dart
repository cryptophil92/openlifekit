import 'package:open_life_kit/features/documents/domain/important_document.dart';

abstract class DocumentsDataSource {
  Future<List<ImportantDocument>> loadDocuments();
  Future<void> saveDocument(ImportantDocument document);
  Future<void> forgetDocument(String id);
}
