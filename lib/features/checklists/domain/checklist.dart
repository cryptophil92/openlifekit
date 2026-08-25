class Checklist {
  const Checklist({
    required this.id,
    required this.title,
    this.description,
    required this.items,
  });

  final String id;
  final String title;
  final String? description;
  final List<ChecklistItem> items;

  int get completedCount {
    return items.where((ChecklistItem item) => item.isDone).length;
  }

  bool get isComplete {
    return items.isNotEmpty && completedCount == items.length;
  }

  double get progress {
    if (items.isEmpty) {
      return 0;
    }

    return completedCount / items.length;
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'title': title,
      'description': description,
      'items': items.map((ChecklistItem item) => item.toJson()).toList(),
    };
  }

  factory Checklist.fromJson(Map<String, Object?> json) {
    final Object? rawItems = json['items'];
    final List<ChecklistItem> parsedItems = rawItems is List<Object?>
        ? rawItems
            .whereType<Map<String, Object?>>()
            .map(ChecklistItem.fromJson)
            .toList()
        : <ChecklistItem>[];

    return Checklist(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      items: parsedItems,
    );
  }
}

class ChecklistItem {
  const ChecklistItem({
    required this.id,
    required this.title,
    this.notes,
    this.isDone = false,
  });

  final String id;
  final String title;
  final String? notes;
  final bool isDone;

  ChecklistItem copyWith({
    String? id,
    String? title,
    String? notes,
    bool? isDone,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'title': title,
      'notes': notes,
      'isDone': isDone,
    };
  }

  factory ChecklistItem.fromJson(Map<String, Object?> json) {
    return ChecklistItem(
      id: json['id'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      isDone: json['isDone'] as bool? ?? false,
    );
  }
}
