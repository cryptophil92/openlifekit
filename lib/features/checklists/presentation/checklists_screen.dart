import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/checklists/application/checklists_providers.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';

class ChecklistsScreen extends ConsumerWidget {
  const ChecklistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Checklist>> state = ref.watch(checklistsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checklists')),
      body: state.when(
        data: (List<Checklist> items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final Checklist checklist = items[index];
            return Card(
              child: ExpansionTile(
                leading: const Icon(Icons.checklist_outlined),
                title: Text(checklist.title),
                subtitle: Text('${checklist.completedCount}/${checklist.items.length} fait'),
                children: <Widget>[
                  for (final ChecklistItem item in checklist.items)
                    CheckboxListTile(
                      value: item.isDone,
                      title: Text(item.title),
                      onChanged: null,
                    ),
                ],
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
}
