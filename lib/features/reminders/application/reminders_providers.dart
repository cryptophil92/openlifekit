import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/reminders/data/memory_reminders_data_source.dart';
import 'package:open_life_kit/features/reminders/data/reminders_data_source.dart';
import 'package:open_life_kit/features/reminders/domain/local_reminder.dart';

final remindersDataSourceProvider = Provider<RemindersDataSource>(
  (ref) => MemoryRemindersDataSource(),
);

final remindersProvider = FutureProvider<List<LocalReminder>>((ref) {
  return ref.watch(remindersDataSourceProvider).loadReminders();
});
