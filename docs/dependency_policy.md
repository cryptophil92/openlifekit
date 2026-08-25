# Dependency policy

OpenLifeKit keeps dependencies minimal and staged.

## Rules

- Add a dependency only when code uses it.
- Prefer well-maintained packages with active Flutter support.
- Avoid analytics or tracking SDKs.
- Avoid cloud SDKs in the MVP.
- Review native permissions before adding a package.
- Document why each sensitive package is introduced.

## Planned dependencies

The validated target stack includes local storage, secure storage, QR rendering, file picking and local notifications.

These are introduced in dedicated pull requests once the Flutter platform folders exist and CI is stable.
