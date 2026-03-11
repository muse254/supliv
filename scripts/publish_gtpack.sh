#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="${ROOT_DIR}/dist"
PACK_PATH="${DIST_DIR}/supliv.gtpack"
PACK_PATH_REL="dist/supliv.gtpack"
REGISTRY="${REGISTRY:-ghcr.io}"
OWNER="${OWNER:-muse254}"
PACKAGE_NAME="${PACKAGE_NAME:-supliv}"
VERSION="${VERSION:-}"
SOURCE_ANNOTATION="${SOURCE_ANNOTATION:-https://github.com/muse254/package-publish}"
REVISION="${REVISION:-$(git -C "${ROOT_DIR}" rev-parse --verify HEAD)}"

if [ -z "${VERSION}" ]; then
  VERSION="$(awk '/^version:/ {print $2; exit}' "${ROOT_DIR}/supliv/pack.yaml")"
fi

if [ ! -f "${PACK_PATH}" ]; then
  echo "Missing ${PACK_PATH}. Run scripts/build_gtpack.sh first." >&2
  exit 1
fi

version_ref="${REGISTRY}/${OWNER}/${PACKAGE_NAME}:${VERSION}"
latest_ref="${REGISTRY}/${OWNER}/${PACKAGE_NAME}:latest"

for ref in "${version_ref}" "${latest_ref}"; do
  echo "Publishing $(basename "${PACK_PATH}") -> ${ref}"
  (
    cd "${ROOT_DIR}"
    oras push "${ref}" \
      --artifact-type application/vnd.greentic.gtpack.v1 \
      --annotation "org.opencontainers.image.title=$(basename "${PACK_PATH}")" \
      --annotation "org.opencontainers.image.revision=${REVISION}" \
      --annotation "org.opencontainers.image.source=${SOURCE_ANNOTATION}" \
      "${PACK_PATH_REL}:application/vnd.greentic.gtpack.layer.v1+tar"
  )
done
