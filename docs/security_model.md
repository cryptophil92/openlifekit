# Security model

## Scope

OpenLifeKit stores sensitive life and emergency data locally on the user's device.

## Data categories

- Identity and profile data.
- Medical notes, allergies and treatments.
- Emergency contacts.
- Important document metadata.
- Reminder and checklist data.
- Exported JSON files created by the user.

## Design principles

- No mandatory account.
- No mandatory backend.
- No analytics.
- No tracking.
- No sensitive data in logs.
- Explicit consent before QR sharing or export.
- Complete local data deletion must be available.

## MVP v0.1.0 limitations

The initial MVP stores data in the app sandbox. Full database encryption is planned for v0.2.0.

JSON export in v0.1.0 is not encrypted and must be preceded by a clear warning.

## Main threats

- Lost or stolen phone.
- User exports data to an unsafe location.
- QR code contains more data than expected.
- Screenshots or shoulder surfing in emergency mode.

## Mitigations

- QR payload is built from explicitly selected fields only.
- Empty/null fields are excluded.
- Export screen must warn the user before writing data to files.
- Data deletion must be confirmed.
- Encryption is prioritized after MVP foundation.
