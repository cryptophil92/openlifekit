class EmergencyCardPreferences {
  const EmergencyCardPreferences({
    this.includeFullName = true,
    this.includeBirthDate = false,
    this.includeBloodType = true,
    this.includeAllergies = true,
    this.includeMedications = true,
    this.includeMedicalNotes = false,
    this.includeEmergencyContacts = true,
    this.hideSensitiveByDefault = true,
  });

  final bool includeFullName;
  final bool includeBirthDate;
  final bool includeBloodType;
  final bool includeAllergies;
  final bool includeMedications;
  final bool includeMedicalNotes;
  final bool includeEmergencyContacts;
  final bool hideSensitiveByDefault;

  Set<String> get sharedProfileKeys {
    return <String>{
      if (includeFullName) 'fullName',
      if (includeBirthDate) 'birthDate',
      if (includeBloodType) 'bloodType',
      if (includeAllergies) 'allergies',
      if (includeMedications) 'medications',
      if (includeMedicalNotes) 'medicalNotes',
    };
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'includeFullName': includeFullName,
      'includeBirthDate': includeBirthDate,
      'includeBloodType': includeBloodType,
      'includeAllergies': includeAllergies,
      'includeMedications': includeMedications,
      'includeMedicalNotes': includeMedicalNotes,
      'includeEmergencyContacts': includeEmergencyContacts,
      'hideSensitiveByDefault': hideSensitiveByDefault,
    };
  }

  factory EmergencyCardPreferences.fromJson(Map<String, Object?> json) {
    return EmergencyCardPreferences(
      includeFullName: json['includeFullName'] as bool? ?? true,
      includeBirthDate: json['includeBirthDate'] as bool? ?? false,
      includeBloodType: json['includeBloodType'] as bool? ?? true,
      includeAllergies: json['includeAllergies'] as bool? ?? true,
      includeMedications: json['includeMedications'] as bool? ?? true,
      includeMedicalNotes: json['includeMedicalNotes'] as bool? ?? false,
      includeEmergencyContacts: json['includeEmergencyContacts'] as bool? ?? true,
      hideSensitiveByDefault: json['hideSensitiveByDefault'] as bool? ?? true,
    );
  }
}
