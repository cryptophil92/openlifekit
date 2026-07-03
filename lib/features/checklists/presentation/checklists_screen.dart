import 'package:flutter/material.dart';
import 'package:open_life_kit/features/checklists/data/built_in_checklists.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';

class ChecklistsScreen extends StatefulWidget {
  const ChecklistsScreen({super.key});

  @override
  State<ChecklistsScreen> createState() => _ChecklistsScreenState();
}

class _ChecklistsScreenState extends State<ChecklistsScreen> {
  late List<Checklist> _checklists;

  @override
  void initState() {
    super.initState();
    _checklists = BuiltInChecklists.all();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklists')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCustomChecklist,
        icon: const Icon(Icons.add),
        label: const Text('Creer'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _checklists.length,
        itemBuilder: (BuildContext context, int index) {
          final Checklist checklist = _checklists[index];
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
                    onChanged: (bool? value) => _toggleItem(
                      checklistIndex: index,
                      itemId: item.id,
                      isDone: value ?? false,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _toggleItem({
    required int checklistIndex,
    required String itemId,
    required bool isDone,
  }) {
    setState(() {
      final Checklist checklist = _checklists[checklistIndex];
      final List<ChecklistItem> updatedItems = checklist.items
          .map(
            (ChecklistItem item) => item.id == itemId
                ? item.copyWith(isDone: isDone)
                : item,
          )
          .toList(growable: false);

      _checklists = <Checklist>[
        ..._checklists.take(checklistIndex),
        Checklist(
          id: checklist.id,
          title: checklist.title,
          description: checklist.description,
          items: updatedItems,
        ),
        ..._checklists.skip(checklistIndex + 1),
      ];
    });
  }

  void _addCustomChecklist() {
    setState(() {
      _checklists = <Checklist>[
        ..._checklists,
        Checklist(
          id: 'custom-${_checklists.length + 1}',
          title: 'Checklist ${_checklists.length + 1}',
          items: const <ChecklistItem>[
            ChecklistItem(id: 'custom-item', title: 'Element a completer'),
          ],
        ),
      ];
    });
  }
}
