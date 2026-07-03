# OpenLifeKit

OpenLifeKit is an open source, privacy-first and offline-first mobile application for Android and iOS.

It helps people keep essential everyday and emergency information locally on their phone: emergency profile, important contacts, critical document metadata, expiration reminders, practical checklists, secure export/import foundations and a shareable emergency card with QR code.

## Product principles

- No mandatory account.
- No mandatory backend.
- No analytics.
- No tracking.
- Local-first storage.
- Offline-first UX.
- Explicit consent before sharing or exporting data.
- No sensitive data in logs.
- Clear path toward local encryption.

## MVP v0.1.0 scope

The first public MVP focuses on a clean, maintainable foundation:

1. Onboarding explaining local data and privacy model.
2. Optional user profile.
3. Emergency card with explicit field-sharing preferences.
4. Important contacts.
5. Important document metadata with expiration dates.
6. Local reminders.
7. Practical checklists.
8. Local JSON export/import with schema versioning.
9. Settings, privacy information and data deletion.

## Tech stack

- Flutter stable
- Dart
- Material 3
- Riverpod
- GoRouter
- Drift / SQLite
- flutter_secure_storage
- intl
- qr_flutter
- flutter_local_notifications

## Repository structure

```text
lib/
├── app/
├── core/
├── data/
├── features/
└── l10n/

test/
integration_test/
docs/
.github/
```

## Getting started

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Local verification

```bash
./scripts/verify.sh
```

## Security and privacy

OpenLifeKit is designed to avoid unnecessary data exposure. The MVP does not require an account, backend, analytics or tracking.

Read:

- [Security policy](SECURITY.md)
- [Security model](docs/security_model.md)

## Roadmap

See [docs/roadmap.md](docs/roadmap.md).

## License

Apache License 2.0. See [LICENSE](LICENSE).
