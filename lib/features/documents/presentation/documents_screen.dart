import 'package:flutter/material.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final List<_DocumentDraft> _documents = <_DocumentDraft>[
    const _DocumentDraft(title: 'Piece importante', type: 'A classer'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addDocument,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _documents.length,
        itemBuilder: (BuildContext context, int index) {
          final _DocumentDraft document = _documents[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(document.title),
              subtitle: Text(document.type),
              trailing: IconButton(
                tooltip: 'Supprimer',
                onPressed: () => _removeDocument(index),
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addDocument() {
    setState(() {
      _documents.add(
        _DocumentDraft(
          title: 'Document ${_documents.length + 1}',
          type: 'Type a definir',
        ),
      );
    });
  }

  void _removeDocument(int index) {
    setState(() {
      _documents.removeAt(index);
    });
  }
}

class _DocumentDraft {
  const _DocumentDraft({required this.title, required this.type});

  final String title;
  final String type;
}
