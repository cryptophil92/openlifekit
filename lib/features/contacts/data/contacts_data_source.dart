import 'package:open_life_kit/features/contacts/domain/important_contact.dart';

abstract class ContactsDataSource {
  Future<List<ImportantContact>> loadContacts();
  Future<void> saveContact(ImportantContact contact);
  Future<void> removeContact(String id);
}
