# OpenLifeKit

OpenLifeKit is an open source, privacy-first and offline-first mobile application for Android and iOS.

It helps people keep essential everyday and emergency information locally on their phone: emergency profile, important contacts, critical document metadata, expiration reminders, practical checklists, local backup foundations and a shareable card with QR code.

## Product principles

- No mandatory account.
- No mandatory backend.
- No analytics.
- No tracking.
- Local-first storage.
- Offline-first UX.
- Explicit consent before sharing or backing up data.
- No sensitive data in logs.
- Clear path toward local encryption.

## MVP v0.1.0 scope

The first public MVP focuses on a clean, maintainable foundation:

1. Onboarding explaining local data and privacy model.
2. Optional user profile.
3. Shared card with explicit field preferences.
4. Important contacts.
5. Important document metadata with expiration dates.
6. Local reminders.
7. Practical checklists.
8. Local JSON backup and restore with schema versioning.
9. Settings, privacy information and data deletion.

## Current implementation status

- Flutter app shell.
- Material 3 theme.
- GoRouter navigation.
- Onboarding screen.
- Home screen.
- Feature placeholder screens.
- Domain models for profile, contacts, documents, reminders, checklists and shared card preferences.
- Privacy payload filtering helper.
- Initial unit and widget tests.
- GitHub Actions CI.

## Tech stack

Validated target stack:

- Flutter stable
- Dart
- Material 3
- Riverpod
- GoRouter
- Drift / SQLite
- flutter_secure_storage
- qr_flutter
- file_picker
- path_provider
- flutter_local_notifications

The bootstrap keeps `pubspec.yaml` minimal until generated Android/iOS folders and native integrations are added.

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

## Native platform generation

Read [docs/local_setup.md](docs/local_setup.md).

## Local verification

```bash
./scripts/verify.sh
```

## Documentation

- [Product specification](docs/product_spec.md)
- [Architecture](docs/architecture.md)
- [Roadmap](docs/roadmap.md)
- [MVP execution plan](docs/mvp_execution_plan.md)
- [Quality plan](docs/quality_plan.md)
- [Security model](docs/security_model.md)

## Security and privacy

OpenLifeKit is designed to avoid unnecessary data exposure. The MVP does not require an account, backend, analytics or tracking.

Read:

- [Security policy](SECURITY.md)
- [Security model](docs/security_model.md)

## License

Apache License 2.0. See [LICENSE](LICENSE).
