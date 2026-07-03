# CI status

Latest checked commit: `f8f9240b5d72d35831eaec178217359fde2528b6`.

Status: success.

Validated steps:

- Dependency installation.
- Static analysis.
- Flutter tests.
- Android debug build is skipped until the Android platform folder exists.

Notes:

The bootstrap keeps the dependency list intentionally small. Native integrations are added after Android and iOS folders are generated from a Flutter workstation.
