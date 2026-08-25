import 'dart:convert';

import 'package:open_life_kit/data/snapshot/open_life_snapshot.dart';

class SnapshotCodec {
  const SnapshotCodec._();

  static String encode(OpenLifeSnapshot snapshot) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(snapshot.toJson());
  }

  static Map<String, Object?> decodeToMap(String value) {
    final Object? decoded = jsonDecode(value);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Invalid snapshot format');
    }

    return decoded;
  }
}
