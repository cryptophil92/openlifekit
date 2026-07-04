import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/checklists/data/built_in_checklists.dart';
import 'package:open_life_kit/features/checklists/data/checklists_data_source.dart';
import 'package:open_life_kit/features/checklists/data/memory_checklists_data_source.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';

final checklistsDataSourceProvider = Provider<ChecklistsDataSource>(
  (ref) => MemoryChecklistsDataSource(BuiltInChecklists.all()),
);

final checklistsProvider = FutureProvider<List<Checklist>>((ref) {
  return ref.watch(checklistsDataSourceProvider).loadChecklists();
});
