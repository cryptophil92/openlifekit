# Error recovery log

## Purpose

Track errors met during bootstrap work and the action taken after retry or correction.

## Resolved items

### Transient GitHub connector 503 errors

Several file updates and creates returned temporary 503 errors. The affected work was retried instead of being abandoned.

Recovered items:

- home navigation test refactor to injected router instances
- in-memory reminders data source
- in-memory checklists data source
- CI verification for commit 4212ac62af18f4330ebc29a207fb260ba1b1a7f1

Status: resolved.

### Home navigation widget test instability

The first navigation test pass was unstable because some Home actions were not visible without scrolling and because tests depended on the global router state.

Corrections:

- deterministic scroll before tapping feature entries
- app router factory added
- router injection added to OpenLifeKitApp
- home navigation tests now use isolated router instances

Status: resolved.

### Settings screen analysis failure

A settings UI update first used radio controls that failed the strict analysis pass.

Correction:

- replaced the radio controls with simple ListTile controls and explicit selected icons

Status: resolved.

### Dependency bootstrap instability

The initial dependency list was too broad for the repository state because Android and iOS platform folders are not generated yet.

Correction:

- kept the current pubspec minimal
- deferred Drift, SQLite, secure storage, file picker, QR and notifications to dedicated steps
- documented the Drift migration sequence

Status: resolved for bootstrap, intentionally deferred for native integration.

## Open items

### Native platform folders

Android and iOS folders still need to be generated from a local Flutter environment.

Status: pending local machine step.

### Durable persistence

Memory data sources are temporary. Drift and SQLite still need to replace them behind existing contracts.

Status: planned.
