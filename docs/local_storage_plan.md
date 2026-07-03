# Local storage plan

## Goal

Prepare local-first data access before adding native integrations.

## Current step

The code introduces domain models and small data contracts first. This keeps the app testable before Android and iOS folders are generated.

## MVP entities

- App settings
- User profile
- Important contacts
- Important documents
- Reminders
- Checklists
- Checklist items
- Card preferences

## Implementation sequence

1. Add data contracts.
2. Add temporary local implementations for UI development.
3. Generate Android and iOS platform folders.
4. Add Drift and SQLite in a dedicated pull request.
5. Add migration tests.
6. Add backup tests.
