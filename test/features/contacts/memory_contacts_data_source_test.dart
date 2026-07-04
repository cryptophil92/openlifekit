import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/contacts/data/memory_contacts_data_source.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';

void main() {
  group('MemoryContactsDataSource', () {
    test('loads initial contacts', () async {
      final MemoryContactsDataSource dataSource = MemoryContactsDataSource(
        const <ImportantContact>[
          ImportantContact(
            id: '1',
            category: ContactCategory.family,
            displayName: 'Jane Doe',
          ),
        ],
      );

      final List<ImportantContact> contacts = await dataSource.loadContacts();

      expect(contacts, hasLength(1));
      expect(contacts.single.displayName, 'Jane Doe');
    });

    test('saves and replaces contacts by id', () async {
      final MemoryContactsDataSource dataSource = MemoryContactsDataSource();

      await dataSource.saveContact(
        const ImportantContact(
          id: '1',
          category: ContactCategory.family,
          displayName: 'Jane Doe',
        ),
      );
      await dataSource.saveContact(
        const ImportantContact(
          id: '1',
          category: ContactCategory.doctor,
          displayName: 'Doctor Doe',
        ),
      );

      final List<ImportantContact> contacts = await dataSource.loadContacts();

      expect(contacts, hasLength(1));
      expect(contacts.single.category, ContactCategory.doctor);
      expect(contacts.single.displayName, 'Doctor Doe');
    });

    test('removes contacts by id', () async {
      final MemoryContactsDataSource dataSource = MemoryContactsDataSource(
        const <ImportantContact>[
          ImportantContact(
            id: '1',
            category: ContactCategory.family,
            displayName: 'Jane Doe',
          ),
          ImportantContact(
            id: '2',
            category: ContactCategory.doctor,
            displayName: 'Doctor Doe',
          ),
        ],
      );

      await dataSource.removeContact('1');

      final List<ImportantContact> contacts = await dataSource.loadContacts();

      expect(contacts, hasLength(1));
      expect(contacts.single.id, '2');
      expect(contacts.single.displayName, 'Doctor Doe');
    });
  });
}
