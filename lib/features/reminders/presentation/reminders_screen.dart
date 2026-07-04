import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/reminders/application/reminders_providers.dart';
import 'package:open_life_kit/features/reminders/domain/local_reminder.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<LocalReminder>> state = ref.watch(remindersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rappels')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addReminder(ref);
        },
        icon: const Icon(Icons.add_alert_outlined),
        label: const Text('Ajouter'),
      ),
      body: state.when(
        data: (List<LocalReminder> items) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final LocalReminder reminder = items[index];
            return Card(
              child: ListTile(
                leading: Icon(
                  reminder.isCompleted
                      ? Icons.check_circle_outline
                      : Icons.notifications_active_outlined,
                ),
                title: Text(reminder.title),
                subtitle: Text(reminder.body ?? _typeLabel(reminder.type)),
                trailing: reminder.isPastDue
                    ? const Icon(Icons.warning_amber_outlined)
                    : null,
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('Erreur de chargement.'),
        ),
      ),
    );
  }

  Future<void> _addReminder(WidgetRef ref) async {
    final List<LocalReminder> items = await ref.read(remindersProvider.future);
    final int nextIndex = items.length + 1;

    await ref.read(remindersDataSourceProvider).saveReminder(
          LocalReminder(
            id: 'reminder-$nextIndex',
            title: 'Rappel $nextIndex',
            body: 'Detail a completer',
            type: ReminderType.personalTask,
            scheduledAt: DateTime.now().add(const Duration(days: 1)),
          ),
        );

    ref.invalidate(remindersProvider);
  }

  String _typeLabel(ReminderType type) {
    switch (type) {
      case ReminderType.documentExpiration:
        return 'Document';
      case ReminderType.appointment:
        return 'Rendez-vous';
      case ReminderType.treatment:
        return 'Traitement';
      case ReminderType.personalTask:
        return 'Tache personnelle';
    }
  }
}
