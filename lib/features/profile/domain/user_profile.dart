class UserProfile {
  const UserProfile({
    this.firstName,
    this.lastName,
    this.birthDate,
    this.countryCode,
    this.languageCode,
    this.bloodType,
    this.allergies,
    this.medications,
    this.medicalNotes,
  });

  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final String? countryCode;
  final String? languageCode;
  final String? bloodType;
  final String? allergies;
  final String? medications;
  final String? medicalNotes;

  String get displayName {
    final List<String> parts = <String>[
      if (firstName != null && firstName!.trim().isNotEmpty) firstName!.trim(),
      if (lastName != null && lastName!.trim().isNotEmpty) lastName!.trim(),
    ];

    return parts.join(' ');
  }

  bool get hasMedicalData {
    return _hasValue(bloodType) ||
        _hasValue(allergies) ||
        _hasValue(medications) ||
        _hasValue(medicalNotes);
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate?.toIso8601String(),
      'countryCode': countryCode,
      'languageCode': languageCode,
      'bloodType': bloodType,
      'allergies': allergies,
      'medications': medications,
      'medicalNotes': medicalNotes,
    };
  }

  factory UserProfile.fromJson(Map<String, Object?> json) {
    return UserProfile(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: _parseDate(json['birthDate']),
      countryCode: json['countryCode'] as String?,
      languageCode: json['languageCode'] as String?,
      bloodType: json['bloodType'] as String?,
      allergies: json['allergies'] as String?,
      medications: json['medications'] as String?,
      medicalNotes: json['medicalNotes'] as String?,
    );
  }

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? countryCode,
    String? languageCode,
    String? bloodType,
    String? allergies,
    String? medications,
    String? medicalNotes,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      countryCode: countryCode ?? this.countryCode,
      languageCode: languageCode ?? this.languageCode,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      medications: medications ?? this.medications,
      medicalNotes: medicalNotes ?? this.medicalNotes,
    );
  }

  static bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static DateTime? _parseDate(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}
