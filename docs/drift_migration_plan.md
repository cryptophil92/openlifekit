# Drift migration plan

## Purpose

Move from temporary in-memory data sources to durable local SQLite storage while keeping the app local-first and offline-first.

## Preconditions

- Android and iOS platform folders generated locally.
- CI remains green with the current minimal dependency set.
- In-memory data source tests are green.

## Migration order

1. Add Drift dependencies and build runner.
2. Add database shell and schema version.
3. Add tables for settings and profile.
4. Add tables for contacts and documents.
5. Add tables for reminders and checklists.
6. Implement Drift-backed data sources behind existing contracts.
7. Keep memory sources for tests where useful.
8. Add migration tests.
9. Add JSON backup import and export tests.

## Tables to prepare

- app_settings
- user_profile
- important_contacts
- important_documents
- local_reminders
- checklists
- checklist_items
- shared_card_preferences

## Rules

- No backend.
- No analytics.
- No sensitive logs.
- Do not store document files in v0.1.
- Keep exported JSON schema versioned.
- Add encryption only in the dedicated security pass after baseline persistence is stable.
