# LaTeX image

Build context for the `leplusorg/latex` container image. See the
[root readme](../README.md) for what the image does and how to run it.

## Files

- `Dockerfile` — the image definition. System packages come from the base
  distribution's package manager and are pinned to exact versions here.
- `docker-compose.test.yml` — the smoke test run in CI against the built image:
  the `sut` service checks that the container runs as the non-root user (UID
  1000) and that each bundled tool starts.

This image has no package manifest: everything in it comes from the base
distribution's package manager, at the versions pinned in the `Dockerfile`.
