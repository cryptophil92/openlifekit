# Quality plan

## Baseline checks

The default verification command is:

```bash
flutter pub get
flutter analyze
flutter test
```

## Rules

- Keep the app buildable on every pull request.
- Add tests for domain models and privacy-critical services.
- Keep widgets focused on UI.
- Avoid logging personal data.
- Keep dependency additions small and justified.

## MVP test targets

- Onboarding routing.
- Profile model serialization.
- Contact model serialization.
- Document date logic.
- Checklist progress.
- Shared card payload filtering.
- Backup schema versioning.
