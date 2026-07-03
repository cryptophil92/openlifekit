#!/usr/bin/env bash
set -euo pipefail

flutter pub get
flutter analyze
flutter test

if [ -d android ]; then
  flutter build apk --debug
else
  echo "Android platform folder not generated yet; skipping debug APK build."
fi
