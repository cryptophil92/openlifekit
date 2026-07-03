import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/data/snapshot/open_life_snapshot.dart';
import 'package:open_life_kit/data/snapshot/snapshot_codec.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

void main() {
  test('codec encodes JSON', () {
    final OpenLifeSnapshot value = OpenLifeSnapshot(
      profile: const UserProfile(firstName: 'Jane'),
      contacts: const [],
      documents: const [],
      checklists: const [],
      createdAt: DateTime.utc(2026, 1, 1),
    );

    final String encoded = SnapshotCodec.encode(value);
    final Map<String, Object?> decoded = SnapshotCodec.decodeToMap(encoded);

    expect(decoded['schemaVersion'], isNotNull);
    expect(decoded['profile'], isA<Map<String, Object?>>());
  });
}
