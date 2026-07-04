import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/reminders/data/memory_reminders_data_source.dart';
import 'package:open_life_kit/features/reminders/domain/local_reminder.dart';

void main() {
  group('MemoryRemindersDataSource', () {
    test('loads initial reminders', () async {
      final DateTime date = DateTime.utc(2026, 1, 1);
      final MemoryRemindersDataSource dataSource = MemoryRemindersDataSource(
        <LocalReminder>[
          LocalReminder(
            id: '1',
            title: 'Renew document',
            type: ReminderType.documentExpiration,
            scheduledAt: date,
          ),
        ],
      );

      final List<LocalReminder> reminders = await dataSource.loadReminders();

      expect(reminders, hasLength(1));
      expect(reminders.single.title, 'Renew document');
    });

    test('saves and replaces reminders by id', () async {
      final DateTime date = DateTime.utc(2026, 1, 1);
      final MemoryRemindersDataSource dataSource = MemoryRemindersDataSource();

      await dataSource.saveReminder(
        LocalReminder(
          id: '1',
          title: 'Old reminder',
          type: ReminderType.personalTask,
          scheduledAt: date,
        ),
      );
      await dataSource.saveReminder(
        LocalReminder(
          id: '1',
          title: 'New reminder',
          type: ReminderType.appointment,
          scheduledAt: date,
        ),
      );

      final List<LocalReminder> reminders = await dataSource.loadReminders();

      expect(reminders, hasLength(1));
      expect(reminders.single.title, 'New reminder');
      expect(reminders.single.type, ReminderType.appointment);
    });

    test('removes reminders by id', () async {
      final DateTime date = DateTime.utc(2026, 1, 1);
      final MemoryRemindersDataSource dataSource = MemoryRemindersDataSource(
        <LocalReminder>[
          LocalReminder(
            id: '1',
            title: 'Reminder one',
            type: ReminderType.personalTask,
            scheduledAt: date,
          ),
          LocalReminder(
            id: '2',
            title: 'Reminder two',
            type: ReminderType.appointment,
            scheduledAt: date,
          ),
        ],
      );

      await dataSource.removeReminder('1');

      final List<LocalReminder> reminders = await dataSource.loadReminders();

      expect(reminders, hasLength(1));
      expect(reminders.single.id, '2');
      expect(reminders.single.title, 'Reminder two');
    });
  });
}
