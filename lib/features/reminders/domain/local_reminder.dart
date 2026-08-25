enum ReminderType {
  documentExpiration,
  appointment,
  treatment,
  personalTask,
}

class LocalReminder {
  const LocalReminder({
    required this.id,
    required this.title,
    this.body,
    required this.type,
    required this.scheduledAt,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String? body;
  final ReminderType type;
  final DateTime scheduledAt;
  final bool isCompleted;

  bool get isPastDue {
    return !isCompleted && scheduledAt.isBefore(DateTime.now());
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'title': title,
      'body': body,
      'type': type.name,
      'scheduledAt': scheduledAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory LocalReminder.fromJson(Map<String, Object?> json) {
    return LocalReminder(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String?,
      type: ReminderType.values.firstWhere(
        (ReminderType value) => value.name == json['type'],
        orElse: () => ReminderType.personalTask,
      ),
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
