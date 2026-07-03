enum ContactCategory {
  family,
  doctor,
  insurance,
  school,
  work,
  other,
}

class ImportantContact {
  const ImportantContact({
    required this.id,
    required this.category,
    required this.displayName,
    this.relationship,
    this.phone,
    this.email,
    this.address,
    this.notes,
    this.isEmergencyContact = false,
  });

  final String id;
  final ContactCategory category;
  final String displayName;
  final String? relationship;
  final String? phone;
  final String? email;
  final String? address;
  final String? notes;
  final bool isEmergencyContact;

  bool get hasQuickAction {
    return _hasValue(phone) || _hasValue(email);
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'category': category.name,
      'displayName': displayName,
      'relationship': relationship,
      'phone': phone,
      'email': email,
      'address': address,
      'notes': notes,
      'isEmergencyContact': isEmergencyContact,
    };
  }

  factory ImportantContact.fromJson(Map<String, Object?> json) {
    return ImportantContact(
      id: json['id'] as String,
      category: ContactCategory.values.firstWhere(
        (ContactCategory value) => value.name == json['category'],
        orElse: () => ContactCategory.other,
      ),
      displayName: json['displayName'] as String,
      relationship: json['relationship'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      notes: json['notes'] as String?,
      isEmergencyContact: json['isEmergencyContact'] as bool? ?? false,
    );
  }

  static bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
