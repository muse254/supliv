#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${ROOT_DIR}/supliv/components"
TARGET_FILE="${TARGET_DIR}/stub.wasm"

mkdir -p "${TARGET_DIR}"
printf '%s' 'AGFzbQEAAAA=' | base64 --decode > "${TARGET_FILE}"

echo "Wrote ${TARGET_FILE}"
