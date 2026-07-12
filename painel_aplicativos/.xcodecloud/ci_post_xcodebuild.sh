#!/bin/bash
set -euo pipefail
echo "🤖 Inicializando auditoria automatizada do Cortex OS..."
cd "${CI_PRIMARY_REPOSITORY_PATH:-.}"
SCHEME="${CI_XCODE_SCHEME:-Runner}"
WORKSPACE_PATH=""
PROJECT_PATH=""
if [[ -d "ios/Runner.xcworkspace" ]]; then WORKSPACE_PATH="ios/Runner.xcworkspace"; SCHEME="${CI_XCODE_SCHEME:-Runner}"
elif [[ -f "ios/Runner.xcodeproj/project.pbxproj" ]]; then PROJECT_PATH="ios/Runner.xcodeproj"; SCHEME="${CI_XCODE_SCHEME:-Runner}"
elif [[ -f "CortexIAOS.xcodeproj/project.pbxproj" ]]; then PROJECT_PATH="CortexIAOS.xcodeproj"; SCHEME="${CI_XCODE_SCHEME:-CortexIAOS}"
fi
DESTINATION="${CI_TEST_DESTINATION:-platform=iOS Simulator,name=iPhone 16}"
echo "Scheme=$SCHEME Workspace=$WORKSPACE_PATH Project=$PROJECT_PATH"
if command -v grep >/dev/null 2>&1; then
  if grep -RInE --exclude-dir=.git --exclude-dir=build --exclude-dir=.dart_tool --exclude='ci_post_xcodebuild.sh' \
    -e 'ghp_[A-Za-z0-9]{36}' -e '-----BEGIN (RSA |OPENSSH )?PRIVATE KEY-----' . 2>/dev/null; then
    echo "❌ Segredo detectado"; exit 1
  fi
  echo "✅ Varredura de segredos OK"
fi
if [[ -n "$WORKSPACE_PATH" ]]; then
  xcodebuild test -workspace "$WORKSPACE_PATH" -scheme "$SCHEME" -destination "$DESTINATION" -quiet
elif [[ -n "$PROJECT_PATH" ]]; then
  xcodebuild test -project "$PROJECT_PATH" -scheme "$SCHEME" -destination "$DESTINATION" -quiet
else
  echo "⚠️ Sem projeto Xcode — skip tests"; exit 0
fi
echo "✅ Sucesso — pronto para TestFlight"
