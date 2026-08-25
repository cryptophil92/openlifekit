# Contributing

Thank you for considering a contribution to OpenLifeKit.

## Development setup

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Contribution rules

- Keep privacy-first defaults.
- Do not add analytics or tracking.
- Do not log sensitive user data.
- Keep business logic outside widgets.
- Add tests for models, repositories and critical services.
- Keep dependencies minimal and justified.

## Branches

- `main`: stable public branch.
- `develop`: integration branch.
- `feature/*`: feature work.
- `release/*`: release preparation.

## Commit style

Use clear conventional-style commits when possible:

- `chore:`
- `feat:`
- `fix:`
- `docs:`
- `test:`
- `refactor:`
- `ci:`
