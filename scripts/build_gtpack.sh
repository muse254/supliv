#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="${ROOT_DIR}/dist"
PACK_DIR="${ROOT_DIR}/supliv"
PACK_BIN="${PACK_BIN:-greentic-pack}"

command -v "${PACK_BIN}" >/dev/null 2>&1 || {
  echo "greentic-pack is required" >&2
  exit 1
}

"${ROOT_DIR}/scripts/write_stub_wasm.sh"

mkdir -p "${DIST_DIR}"

"${PACK_BIN}" build \
  --allow-pack-schema \
  --in "${PACK_DIR}" \
  --gtpack-out "${DIST_DIR}/supliv.gtpack"

echo "PACK	supliv	$(awk '/^version:/ {print $2; exit}' "${PACK_DIR}/pack.yaml")	${DIST_DIR}/supliv.gtpack"
