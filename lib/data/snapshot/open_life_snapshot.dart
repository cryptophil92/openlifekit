import 'package:open_life_kit/core/constants/app_constants.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';

class OpenLifeSnapshot {
  const OpenLifeSnapshot({
    required this.profile,
    required this.contacts,
    required this.documents,
    required this.checklists,
    required this.createdAt,
  });

  final UserProfile profile;
  final List<ImportantContact> contacts;
  final List<ImportantDocument> documents;
  final List<Checklist> checklists;
  final DateTime createdAt;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'schemaVersion': AppConstants.schemaVersion,
      'createdAt': createdAt.toIso8601String(),
      'profile': profile.toJson(),
      'contacts':
          contacts.map((ImportantContact item) => item.toJson()).toList(),
      'documents':
          documents.map((ImportantDocument item) => item.toJson()).toList(),
      'checklists': checklists.map((Checklist item) => item.toJson()).toList(),
    };
  }
}
