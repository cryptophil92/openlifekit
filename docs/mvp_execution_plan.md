# MVP execution plan

## Current bootstrap

The repository is buildable with a minimal dependency set.

Android is generated and committed. The current app shell has routing, theme, onboarding, placeholder feature screens, domain models, data contracts, temporary memory data sources and Riverpod providers.

## Next implementation order

1. Wire feature screens to the temporary data providers.
2. Add profile edit form.
3. Add contact list and forms.
4. Add document metadata list and forms.
5. Add reminder scheduling adapter.
6. Add checklist templates and custom checklists.
7. Add JSON backup and restore.
8. Add QR display with explicit fields.
9. Generate and validate iOS from a macOS/Xcode workstation.
10. Harden security and accessibility.

## Deferred native integrations

- Drift storage code generation.
- Native local notifications.
- Secure storage.
- File picker.
- QR rendering.

These remain part of the validated stack, but are added after the provider wiring and baseline UI behavior are stable.
