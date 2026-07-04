import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/core/validation/text_validators.dart';
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
          _openReminderForm(context, ref);
        },
        icon: const Icon(Icons.add_alert_outlined),
        label: const Text('Ajouter'),
      ),
      body: state.when(
        data: (List<LocalReminder> items) {
          if (items.isEmpty) {
            return const Center(child: Text('Aucun rappel local.'));
          }

          return ListView.builder(
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (reminder.isPastDue)
                        const Icon(Icons.warning_amber_outlined),
                      IconButton(
                        tooltip: 'Retirer ${reminder.title}',
                        onPressed: () {
                          _confirmRemoveReminder(context, ref, reminder);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text('Erreur de chargement.'),
        ),
      ),
    );
  }

  Future<void> _openReminderForm(BuildContext context, WidgetRef ref) async {
    final _ReminderFormResult? result = await showDialog<_ReminderFormResult>(
      context: context,
      builder: (BuildContext context) => const _ReminderFormDialog(),
    );

    if (result == null) {
      return;
    }

    final List<LocalReminder> items = await ref.read(remindersProvider.future);
    final int nextIndex = items.length + 1;

    await ref.read(remindersDataSourceProvider).saveReminder(
          LocalReminder(
            id: 'reminder-$nextIndex',
            title: result.title,
            body: result.body,
            type: ReminderType.personalTask,
            scheduledAt: DateTime.now().add(const Duration(days: 1)),
          ),
        );

    ref.invalidate(remindersProvider);
  }

  Future<void> _confirmRemoveReminder(
    BuildContext context,
    WidgetRef ref,
    LocalReminder reminder,
  ) async {
    final bool confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Retirer le rappel ?'),
            content: Text(
              'Le rappel ${reminder.title} sera retire de la liste locale.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Annuler'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Retirer'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await _removeReminder(ref, reminder.id);
  }

  Future<void> _removeReminder(WidgetRef ref, String id) async {
    await ref.read(remindersDataSourceProvider).removeReminder(id);
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

class _ReminderFormDialog extends StatefulWidget {
  const _ReminderFormDialog();

  @override
  State<_ReminderFormDialog> createState() => _ReminderFormDialogState();
}

class _ReminderFormDialogState extends State<_ReminderFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouveau rappel'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre du rappel'),
                textInputAction: TextInputAction.next,
                validator: TextValidators.requiredText,
              ),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Detail'),
                minLines: 2,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop(
      _ReminderFormResult(
        title: _titleController.text.trim(),
        body: _emptyToNull(_bodyController.text),
      ),
    );
  }

  String? _emptyToNull(String value) {
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

class _ReminderFormResult {
  const _ReminderFormResult({required this.title, required this.body});

  final String title;
  final String? body;
}
