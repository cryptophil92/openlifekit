class TextValidators {
  const TextValidators._();

  static String? requiredText(String? value,
      {String message = 'Champ obligatoire'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  static String? optionalEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final String trimmed = value.trim();
    if (!trimmed.contains('@') || !trimmed.contains('.')) {
      return 'Email invalide';
    }

    return null;
  }
}
