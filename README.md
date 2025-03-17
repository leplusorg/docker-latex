# LaTeX

A convenient way to run LaTeX on various platform using Docker (latexmk, pdflatex...).

[![Dockerfile](https://img.shields.io/badge/GitHub-Dockerfile-blue)](latex/Dockerfile)
[![Docker Build](https://github.com/leplusorg/docker-latex/workflows/Docker/badge.svg)](https://github.com/leplusorg/docker-latex/actions?query=workflow:"Docker")
[![Docker Stars](https://img.shields.io/docker/stars/leplusorg/latex)](https://hub.docker.com/r/leplusorg/latex)
[![Docker Pulls](https://img.shields.io/docker/pulls/leplusorg/latex)](https://hub.docker.com/r/leplusorg/latex)
[![Docker Version](https://img.shields.io/docker/v/leplusorg/latex?sort=semver)](https://hub.docker.com/r/leplusorg/latex)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/10068/badge)](https://bestpractices.coreinfrastructure.org/projects/10068)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/leplusorg/docker-latex/badge)](https://securityscorecards.dev/viewer/?uri=github.com/leplusorg/docker-latex)

## Example

Assuming that you have a file `foo.tex` in your current working directory that you want to convert into a PDF `foo.pdf`:

**Mac/Linux**

```bash
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/tmp" leplusorg/latex latexmk -outdir=/tmp -pdf /tmp/foo.tex
```

**Windows**

In `cmd`:

```batch
docker run --rm -t --net=none -v "%cd%:/tmp" leplusorg/latex latexmk -outdir=/tmp -pdf /tmp/foo.tex
```

In PowerShell:

```pwsh
docker run --rm -t --net=none -v "${PWD}:/tmp" leplusorg/latex latexmk -outdir=/tmp -pdf /tmp/foo.tex
```

## Help

To know more command-line options of `latexmk`:

```bash
docker run --rm --net=none leplusorg/latex latexmk -h
```

## texlive vs texlive-full

Version 1 of this image was using the
[texlive-full](https://packages.debian.org/search?keywords=texlive-full&searchon=names&exact=1&suite=all&section=all)
debian package to include as much TeX Live packages pre-installed as
possible. But the resulting docker image was over 4 GB making it slow
to download and breaking some CI/CD disk limits (including the free
tier of GitHub Actions that I use). To keep the image usable by as many
people as possible, I decided with version 2 and above to switch
to the default
[texlive](https://packages.debian.org/search?keywords=texlive&searchon=names&exact=1&suite=all&section=all)
package.

If you need more TeX Live packages, you have the following options:

- use version 1 of this docker image (i.e. `leplusorg/latex:1.0.0@sha256:af368a8fda9fea612eb5f54025e0c0735c4d4a3ff67b0853e9e8a804a6a24d64`).
- use the image this fork is based on (i.e. `aergus/latex:latest`).

## Debian vs Alpine

By default these images are based on the Debian Linux distribution
and follow the same release cycle as the parent
[debian docker images](https://hub.docker.com/_/debian). But there is
also an Alpine Linux variant of these images for people who prefer
smaller images. The images are tagged with prefix `alpine` and follow
the same release cycle as the parent
[alpine docker images](https://hub.docker.com/_/alpine). Note that
although the risk might be low, Alpine Linux is using an alternative
implementation of the C standard library called Musl which is smaller
but might behave differently from the more widely used GNU C
library. Hopefully Alpine's TeX package maintainers are thoroughly
testing the ports but if you encounter any weird behavior with the
`alpine` variant, we recommend trying the latest `debian` variant to
see if the issue persists.

## Software Bill of Materials (SBOM)

To get the SBOM for the latest image (in SPDX JSON format), use the
following command:

```bash
docker buildx imagetools inspect leplusorg/latex --format '{{ json (index .SBOM "linux/amd64").SPDX }}'
```

Replace `linux/amd64` by the desired platform (`linux/amd64`, `linux/arm64` etc.).

### Sigstore

[Sigstore](https://docs.sigstore.dev) is trying to improve supply
chain security by allowing you to verify the origin of an
artifcat. You can verify that the jar that you use was actually
produced by this repository. This means that if you verify the
signature of the ristretto jar, you can trust the integrity of the
whole supply chain from code source, to CI/CD build, to distribution
on Maven Central or whever you got the jar from.

You can use the following command to verify the latest image using its
sigstore signature attestation:

```bash
cosign verify leplusorg/latex --certificate-identity-regexp 'https://github\.com/leplusorg/docker-latex/\.github/workflows/.+' --certificate-oidc-issuer 'https://token.actions.githubusercontent.com'
```

The output should look something like this:

```text
Verification for index.docker.io/leplusorg/xml:main --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates

[{"critical":...
```

For instructions on how to install `cosign`, please read this [documentation](https://docs.sigstore.dev/cosign/system_config/installation/).

## Request new tool

Please use [this link](https://github.com/leplusorg/docker-latex/issues/new?assignees=thomasleplus&labels=enhancement&template=feature_request.md&title=%5BFEAT%5D) (GitHub account required) to request that a new tool be added to the image. I am always interested in adding new capabilities to these images.
