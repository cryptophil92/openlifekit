class PrivacyGuard {
  const PrivacyGuard._();

  static Map<String, Object?> buildExplicitPayload({
    required Map<String, Object?> source,
    required Set<String> allowedKeys,
  }) {
    final Map<String, Object?> payload = <String, Object?>{};

    for (final String key in allowedKeys) {
      if (!source.containsKey(key)) {
        continue;
      }

      final Object? value = source[key];
      if (value == null) {
        continue;
      }

      if (value is String && value.trim().isEmpty) {
        continue;
      }

      payload[key] = value;
    }

    return Map<String, Object?>.unmodifiable(payload);
  }
}
