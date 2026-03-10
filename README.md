# package-publish

Minimal example for building a single `.gtpack` and publishing it to GHCR as
`supliv`.

Expected GHCR references:

- `ghcr.io/muse254/supliv:<version>`
- `ghcr.io/muse254/supliv:latest`

The example is self-contained:

- `supliv/pack.yaml` defines the pack.
- `scripts/write_stub_wasm.sh` writes a tiny placeholder WASM binary.
- `scripts/build_gtpack.sh` builds `dist/supliv.gtpack`.
- `scripts/publish_gtpack.sh` publishes it to GHCR with ORAS.
- `.github/workflows/gtpack-publish.yml` wires this into CI.

The `org.opencontainers.image.source` annotation is pinned to:

- `https://github.com/muse254/package-publish`
