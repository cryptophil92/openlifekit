import 'package:open_life_kit/features/checklists/domain/checklist.dart';

abstract class ChecklistsDataSource {
  Future<List<Checklist>> loadChecklists();
  Future<void> saveChecklist(Checklist checklist);
}
