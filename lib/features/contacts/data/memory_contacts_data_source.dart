import 'package:open_life_kit/features/contacts/data/contacts_data_source.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';

class MemoryContactsDataSource implements ContactsDataSource {
  MemoryContactsDataSource([List<ImportantContact> initialContacts = const <ImportantContact>[]]) {
    for (final ImportantContact contact in initialContacts) {
      _contactsById[contact.id] = contact;
    }
  }

  final Map<String, ImportantContact> _contactsById = <String, ImportantContact>{};

  @override
  Future<List<ImportantContact>> loadContacts() async {
    return List<ImportantContact>.unmodifiable(_contactsById.values);
  }

  @override
  Future<void> saveContact(ImportantContact contact) async {
    _contactsById[contact.id] = contact;
  }
}
