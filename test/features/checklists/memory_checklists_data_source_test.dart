import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/checklists/data/memory_checklists_data_source.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';

void main() {
  group('MemoryChecklistsDataSource', () {
    test('loads initial checklists', () async {
      final MemoryChecklistsDataSource dataSource = MemoryChecklistsDataSource(
        const <Checklist>[
          Checklist(
            id: '1',
            title: 'Travel',
            items: <ChecklistItem>[],
          ),
        ],
      );

      final List<Checklist> checklists = await dataSource.loadChecklists();

      expect(checklists, hasLength(1));
      expect(checklists.single.title, 'Travel');
    });

    test('saves and replaces checklists by id', () async {
      final MemoryChecklistsDataSource dataSource =
          MemoryChecklistsDataSource();

      await dataSource.saveChecklist(
        const Checklist(
          id: '1',
          title: 'Old checklist',
          items: <ChecklistItem>[],
        ),
      );
      await dataSource.saveChecklist(
        const Checklist(
          id: '1',
          title: 'New checklist',
          items: <ChecklistItem>[
            ChecklistItem(id: 'item-1', title: 'Done', isDone: true),
          ],
        ),
      );

      final List<Checklist> checklists = await dataSource.loadChecklists();

      expect(checklists, hasLength(1));
      expect(checklists.single.title, 'New checklist');
      expect(checklists.single.completedCount, 1);
    });
  });
}
