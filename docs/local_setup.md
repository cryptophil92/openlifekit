# Local setup

## Clone

```bash
git clone https://github.com/cryptophil92/openlifekit.git
cd openlifekit
git checkout develop
```

## Generate native folders

Run this once on a machine with Flutter installed:

```bash
flutter create --org org.openlifekit --project-name open_life_kit --platforms android,ios .
```

## Verify

```bash
flutter pub get
flutter analyze
flutter test
```

## Notes

The repository keeps generated Android and iOS folders out of the first bootstrap until they are generated from a real Flutter workstation.
