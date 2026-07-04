import 'package:open_life_kit/features/reminders/data/reminders_data_source.dart';
import 'package:open_life_kit/features/reminders/domain/local_reminder.dart';

class MemoryRemindersDataSource implements RemindersDataSource {
  MemoryRemindersDataSource([
    List<LocalReminder> initialReminders = const <LocalReminder>[],
  ]) {
    for (final LocalReminder reminder in initialReminders) {
      _remindersById[reminder.id] = reminder;
    }
  }

  final Map<String, LocalReminder> _remindersById = <String, LocalReminder>{};

  @override
  Future<List<LocalReminder>> loadReminders() async {
    return List<LocalReminder>.unmodifiable(_remindersById.values);
  }

  @override
  Future<void> saveReminder(LocalReminder reminder) async {
    _remindersById[reminder.id] = reminder;
  }
}
