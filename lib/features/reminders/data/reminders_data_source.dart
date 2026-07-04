import 'package:open_life_kit/features/reminders/domain/local_reminder.dart';

abstract class RemindersDataSource {
  Future<List<LocalReminder>> loadReminders();
  Future<void> saveReminder(LocalReminder reminder);
  Future<void> removeReminder(String id);
}
