# Local storage plan

## Goal

Prepare local-first data access before adding native integrations.

## Current status

The code now has domain models, data source contracts and temporary in-memory data sources. This keeps the app testable before Android and iOS folders are generated.

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

## Implementation sequence

1. Add data contracts.
2. Add temporary local implementations for UI development.
3. Wire feature screens to temporary data sources.
4. Generate Android and iOS platform folders.
5. Add Drift and SQLite in a dedicated pull request.
6. Add migration tests.
7. Add backup tests.

## Drift handoff notes

The in-memory sources are not the final persistence layer. They exist to stabilize feature behavior and tests before native SQLite integration.

The Drift pass should replace each memory source behind the existing contracts instead of changing UI screens directly.
