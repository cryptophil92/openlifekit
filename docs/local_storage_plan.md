# Local storage plan

## Goal

Prepare local-first data access before adding durable native storage.

## Current status

The code now has domain models, data source contracts, temporary in-memory data sources and Riverpod providers for feature data access.

Android is generated and committed. iOS remains a macOS/Xcode step.

## MVP entities

- App settings
- User profile
- Important contacts
- Important documents
- Reminders
- Checklists
- Checklist items
- Card preferences

## Completed bootstrap storage work

- Data contracts for profile, contacts, documents, reminders and checklists.
- In-memory data source for contacts.
- In-memory data source for documents.
- In-memory data source for reminders.
- In-memory data source for checklists.
- In-memory data source for profile.
- Unit tests for each in-memory data source.
- Riverpod feature data providers.
- Provider override tests for contacts, documents, checklists, profile and reminders.

## Implementation sequence

1. Add data contracts. Done.
2. Add temporary local implementations for UI development. Done.
3. Generate Android platform folder. Done.
4. Wire feature screens to temporary data sources.
5. Generate iOS platform folder from a Mac.
6. Add Drift and SQLite in a dedicated pull request.
7. Add migration tests.
8. Add backup tests.

## Drift handoff notes

The in-memory sources are not the final persistence layer. They exist to stabilize feature behavior and tests before native SQLite integration.

The Drift pass should replace each memory source behind the existing contracts instead of changing UI screens directly.
