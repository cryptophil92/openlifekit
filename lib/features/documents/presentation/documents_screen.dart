import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/core/validation/text_validators.dart';
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
          _openDocumentForm(context, ref);
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
                subtitle: Text(_documentDetails(item)),
                trailing: IconButton(
                  tooltip: 'Retirer ${item.title}',
                  onPressed: () {
                    _confirmRemoveDocument(context, ref, item);
                  },
                  icon: const Icon(Icons.close),
                ),
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

  Future<void> _openDocumentForm(BuildContext context, WidgetRef ref) async {
    final _DocumentFormResult? result = await showDialog<_DocumentFormResult>(
      context: context,
      builder: (BuildContext context) => const _DocumentFormDialog(),
    );

    if (result == null) {
      return;
    }

    final List<ImportantDocument> items = await ref.read(
      documentsProvider.future,
    );
    final int nextIndex = items.length + 1;

    await ref.read(documentsDataSourceProvider).saveDocument(
          ImportantDocument(
            id: 'document-$nextIndex',
            title: result.title,
            type: DocumentType.other,
            reference: result.reference,
            notes: result.notes,
          ),
        );

    ref.invalidate(documentsProvider);
  }

  Future<void> _confirmRemoveDocument(
    BuildContext context,
    WidgetRef ref,
    ImportantDocument document,
  ) async {
    final bool confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Retirer le document ?'),
            content: Text(
              'Le document ${document.title} sera retire de la liste locale.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Retirer'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await _removeDocument(ref, document.id);
  }

  Future<void> _removeDocument(WidgetRef ref, String id) async {
    await ref.read(documentsDataSourceProvider).forgetDocument(id);
    ref.invalidate(documentsProvider);
  }

  String _documentDetails(ImportantDocument document) {
    final List<String> details = <String>[
      document.type.name,
      if (_hasValue(document.reference)) document.reference!.trim(),
      if (_hasValue(document.notes)) document.notes!.trim(),
    ];

    return details.join(' - ');
  }

  bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}

class _DocumentFormDialog extends StatefulWidget {
  const _DocumentFormDialog();

  @override
  State<_DocumentFormDialog> createState() => _DocumentFormDialogState();
}

class _DocumentFormDialogState extends State<_DocumentFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _referenceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouveau document'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre du document',
                ),
                textInputAction: TextInputAction.next,
                validator: TextValidators.requiredText,
              ),
              TextFormField(
                controller: _referenceController,
                decoration: const InputDecoration(labelText: 'Reference'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                minLines: 2,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop(
      _DocumentFormResult(
        title: _titleController.text.trim(),
        reference: _emptyToNull(_referenceController.text),
        notes: _emptyToNull(_notesController.text),
      ),
    );
  }

  String? _emptyToNull(String value) {
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class _DocumentFormResult {
  const _DocumentFormResult({
    required this.title,
    required this.reference,
    required this.notes,
  });

  final String title;
  final String? reference;
  final String? notes;
}
