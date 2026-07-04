import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_life_kit/features/contacts/data/contacts_data_source.dart';
import 'package:open_life_kit/features/contacts/data/memory_contacts_data_source.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';

final contactsDataSourceProvider = Provider<ContactsDataSource>(
  (ref) => MemoryContactsDataSource(),
);

final contactsProvider = FutureProvider<List<ImportantContact>>((ref) {
  return ref.watch(contactsDataSourceProvider).loadContacts();
});
