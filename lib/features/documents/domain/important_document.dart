enum DocumentType {
  identity,
  health,
  insurance,
  housing,
  vehicle,
  work,
  family,
  other,
}

class ImportantDocument {
  const ImportantDocument({
    required this.id,
    required this.title,
    required this.type,
    this.reference,
    this.expirationDate,
    this.notes,
    this.reminderEnabled = false,
    this.reminderDate,
  });

  final String id;
  final String title;
  final DocumentType type;
  final String? reference;
  final DateTime? expirationDate;
  final String? notes;
  final bool reminderEnabled;
  final DateTime? reminderDate;

  bool get isExpired {
    if (expirationDate == null) {
      return false;
    }

    final DateTime today = DateTime.now();
    final DateTime limit = DateTime(today.year, today.month, today.day);
    return expirationDate!.isBefore(limit);
  }

  bool get hasExpiration => expirationDate != null;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'title': title,
      'type': type.name,
      'reference': reference,
      'expirationDate': expirationDate?.toIso8601String(),
      'notes': notes,
      'reminderEnabled': reminderEnabled,
      'reminderDate': reminderDate?.toIso8601String(),
    };
  }

  factory ImportantDocument.fromJson(Map<String, Object?> json) {
    return ImportantDocument(
      id: json['id'] as String,
      title: json['title'] as String,
      type: DocumentType.values.firstWhere(
        (DocumentType value) => value.name == json['type'],
        orElse: () => DocumentType.other,
      ),
      reference: json['reference'] as String?,
      expirationDate: _parseDate(json['expirationDate']),
      notes: json['notes'] as String?,
      reminderEnabled: json['reminderEnabled'] as bool? ?? false,
      reminderDate: _parseDate(json['reminderDate']),
    );
  }

  static DateTime? _parseDate(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}
