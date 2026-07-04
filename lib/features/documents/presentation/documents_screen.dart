import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/documents/application/documents_providers.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ImportantDocument>> state = ref.watch(
      documentsProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addSampleDocument(ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: state.when(
        data: (List<ImportantDocument> items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final ImportantDocument item = items[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(item.title),
                subtitle: Text(item.notes ?? item.type.name),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('Erreur de chargement.'),
        ),
      ),
    );
  }

  Future<void> _addSampleDocument(WidgetRef ref) async {
    final List<ImportantDocument> items = await ref.read(
      documentsProvider.future,
    );
    final int nextIndex = items.length + 1;

    await ref.read(documentsDataSourceProvider).saveDocument(
          ImportantDocument(
            id: 'document-$nextIndex',
            title: 'Document $nextIndex',
            type: DocumentType.other,
            notes: 'Type a definir',
          ),
        );

    ref.invalidate(documentsProvider);
  }
}
