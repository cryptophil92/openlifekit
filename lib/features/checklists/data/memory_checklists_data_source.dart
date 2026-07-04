import 'package:open_life_kit/features/checklists/data/checklists_data_source.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';

class MemoryChecklistsDataSource implements ChecklistsDataSource {
  MemoryChecklistsDataSource([
    List<Checklist> initialChecklists = const <Checklist>[],
  ]) {
    for (final Checklist checklist in initialChecklists) {
      _checklistsById[checklist.id] = checklist;
    }
  }

  final Map<String, Checklist> _checklistsById = <String, Checklist>{};

  @override
  Future<List<Checklist>> loadChecklists() async {
    return List<Checklist>.unmodifiable(_checklistsById.values);
  }

  @override
  Future<void> saveChecklist(Checklist checklist) async {
    _checklistsById[checklist.id] = checklist;
  }
}
