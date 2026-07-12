#!/bin/bash
set -euo pipefail
echo "📦 ci_post_clone — Cortex IA OS v4.5"
cd "${CI_PRIMARY_REPOSITORY_PATH:-.}"
chmod +x .xcodecloud/*.sh 2>/dev/null || true
if [[ -f "pubspec.yaml" ]] && command -v flutter >/dev/null 2>&1; then
  flutter pub get
  flutter precache --ios
fi
echo "✅ Clone hooks concluídos."
