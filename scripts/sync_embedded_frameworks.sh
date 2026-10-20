#!/bin/bash
# Xcode phase "Sync Embedded Frameworks".
# Leave frameworks that are already next to the project. Fill any missing
# engine from the latest Release. Do not remove a framework that is already here.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
need=0
for name in facelivenesssdk FaceLivenessEngine onnxruntime; do
  bin="$ROOT/${name}.framework/${name}"
  if [ ! -f "$bin" ]; then
    need=1
  fi
done
if [ "$need" -eq 0 ]; then
  exit 0
fi
# Release asset name matches runtime_layout publish for FaceLivenessDetection-iOS.
URL="https://github.com/identixia-IDV/FaceLivenessDetection-iOS/releases/latest/download/facelivenesssdk-ios.zip"
mkdir -p "$ROOT/.identixia"
if curl -fsSL --retry 1 --connect-timeout 8 -o "$ROOT/.identixia/facelivenesssdk-ios.zip" "$URL"; then
  unzip -o -q "$ROOT/.identixia/facelivenesssdk-ios.zip" -d "$ROOT" || true
fi
exit 0
