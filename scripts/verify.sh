#!/usr/bin/env bash
set -euo pipefail

flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test

if [ -d android ]; then
  flutter build apk --debug
else
  echo "Android platform folder not generated yet; skipping debug APK build."
fi
