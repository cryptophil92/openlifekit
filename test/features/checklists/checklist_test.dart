import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';

void main() {
  group('Checklist', () {
    test('computes progress', () {
      const Checklist checklist = Checklist(
        id: 'travel',
        title: 'Travel',
        items: <ChecklistItem>[
          ChecklistItem(id: '1', title: 'Passport', isDone: true),
          ChecklistItem(id: '2', title: 'Tickets'),
        ],
      );

      expect(checklist.completedCount, 1);
      expect(checklist.progress, 0.5);
      expect(checklist.isComplete, isFalse);
    });
  });
}
