# MVP execution plan

## Current bootstrap

The repository is intentionally kept buildable with a minimal dependency set.

The Flutter UI shell, navigation, domain models and tests are introduced first. Heavy native integrations are added once Android and iOS folders are generated on a Flutter workstation.

## Next implementation order

1. Complete onboarding state.
2. Add local storage layer.
3. Add profile edit form.
4. Add contact list and forms.
5. Add document metadata list and forms.
6. Add reminder scheduling adapter.
7. Add checklist templates and custom checklists.
8. Add JSON backup and restore.
9. Add QR display with explicit fields.
10. Harden security and accessibility.

## Deferred native integrations

- Drift storage code generation.
- Native local notifications.
- Secure storage.
- File picker.
- QR rendering.

These remain part of the validated stack, but are added after CI is green and platform folders exist.
