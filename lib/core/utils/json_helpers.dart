import 'dart:convert';

String prettyJson(Map<String, Object?> value) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(value);
}
