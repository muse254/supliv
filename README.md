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
- `.actrc` and `.github/act/push-main.json` let you simulate the workflow locally with `nektos/act`.

The `org.opencontainers.image.source` annotation is pinned to:

- `https://github.com/muse254/package-publish`

## Local workflow runs with `act`

List the available jobs:

```bash
act -l
```

Simulate the `push` trigger against `main` without publishing:

```bash
act push -e .github/act/push-main.json -j gtpack-publish --dryrun
```

Run the full job locally:

```bash
act push -e .github/act/push-main.json -j gtpack-publish
```

If you want the publish step to authenticate against GHCR during a local run,
provide a token as a GitHub secret:

```bash
act push -e .github/act/push-main.json -j gtpack-publish -s GITHUB_TOKEN=YOUR_TOKEN
```

If `act` fails with `The runs.using key in action.yml must be one of ... got node20`,
your `act` build is too old for the actions used by this workflow. On this machine,
`act 0.2.50` hits that error, so use a newer `act` release before relying on local runs.
