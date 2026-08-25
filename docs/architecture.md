# Architecture

OpenLifeKit uses a feature-first Flutter architecture.

## Layers

- `app`: root widget, routing and theme.
- `core`: shared constants, errors, security helpers, services and utilities.
- `data`: local database, repositories and export/import services.
- `features`: product features grouped by domain.
- `l10n`: localization resources.

## Feature structure

```text
features/profile/
├── application/
├── data/
├── domain/
└── presentation/
```

## Rules

- Widgets only handle presentation.
- Business rules live outside widgets.
- Repositories isolate persistence.
- No sensitive data in logs.
- QR/export payloads must pass through explicit consent filtering.
