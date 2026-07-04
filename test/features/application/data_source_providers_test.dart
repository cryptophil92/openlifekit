import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_life_kit/features/checklists/application/checklists_providers.dart';
import 'package:open_life_kit/features/checklists/data/memory_checklists_data_source.dart';
import 'package:open_life_kit/features/checklists/domain/checklist.dart';
import 'package:open_life_kit/features/contacts/application/contacts_providers.dart';
import 'package:open_life_kit/features/contacts/data/memory_contacts_data_source.dart';
import 'package:open_life_kit/features/contacts/domain/important_contact.dart';
import 'package:open_life_kit/features/documents/application/documents_providers.dart';
import 'package:open_life_kit/features/documents/data/memory_documents_data_source.dart';
import 'package:open_life_kit/features/documents/domain/important_document.dart';
import 'package:open_life_kit/features/profile/application/profile_providers.dart';
import 'package:open_life_kit/features/profile/data/memory_profile_data_source.dart';
import 'package:open_life_kit/features/profile/domain/user_profile.dart';
import 'package:open_life_kit/features/reminders/application/reminders_providers.dart';
import 'package:open_life_kit/features/reminders/data/memory_reminders_data_source.dart';
import 'package:open_life_kit/features/reminders/domain/local_reminder.dart';

void main() {
  group('feature data providers', () {
    test('loads contacts from the configured data source', () async {
      final ProviderContainer container = ProviderContainer(
        overrides: <Override>[
          contactsDataSourceProvider.overrideWithValue(
            MemoryContactsDataSource(
              const <ImportantContact>[
                ImportantContact(
                  id: 'contact-1',
                  category: ContactCategory.family,
                  displayName: 'Jane Doe',
                ),
              ],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final List<ImportantContact> contacts = await container.read(
        contactsProvider.future,
      );

      expect(contacts.single.displayName, 'Jane Doe');
    });

    test('loads documents from the configured data source', () async {
      final ProviderContainer container = ProviderContainer(
        overrides: <Override>[
          documentsDataSourceProvider.overrideWithValue(
            MemoryDocumentsDataSource(
              const <ImportantDocument>[
                ImportantDocument(
                  id: 'document-1',
                  title: 'Passeport',
                  type: DocumentType.identity,
                ),
              ],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final List<ImportantDocument> documents = await container.read(
        documentsProvider.future,
      );

      expect(documents.single.title, 'Passeport');
    });

    test('loads checklists from the configured data source', () async {
      final ProviderContainer container = ProviderContainer(
        overrides: <Override>[
          checklistsDataSourceProvider.overrideWithValue(
            MemoryChecklistsDataSource(
              const <Checklist>[
                Checklist(
                  id: 'checklist-1',
                  title: 'Depart',
                  items: <ChecklistItem>[
                    ChecklistItem(id: 'item-1', title: 'Verifier les papiers'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final List<Checklist> checklists = await container.read(
        checklistsProvider.future,
      );

      expect(checklists.single.title, 'Depart');
    });

    test('loads profile from the configured data source', () async {
      final ProviderContainer container = ProviderContainer(
        overrides: <Override>[
          profileDataSourceProvider.overrideWithValue(
            MemoryProfileDataSource(
              const UserProfile(firstName: 'Jane', lastName: 'Doe'),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final UserProfile? profile = await container.read(profileProvider.future);

      expect(profile?.displayName, 'Jane Doe');
    });

    test('loads reminders from the configured data source', () async {
      final DateTime scheduledAt = DateTime(2026, 7, 4, 12);
      final ProviderContainer container = ProviderContainer(
        overrides: <Override>[
          remindersDataSourceProvider.overrideWithValue(
            MemoryRemindersDataSource(
              <LocalReminder>[
                LocalReminder(
                  id: 'reminder-1',
                  title: 'Controle passeport',
                  type: ReminderType.documentExpiration,
                  scheduledAt: scheduledAt,
                ),
              ],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final List<LocalReminder> reminders = await container.read(
        remindersProvider.future,
      );

      expect(reminders.single.title, 'Controle passeport');
    });
  });
}
