# LaTeX

A convenient way to run LaTeX on various platform using Docker (latexmk, pdflatex...).

[![Dockerfile](https://img.shields.io/badge/GitHub-Dockerfile-blue)](https://github.com/leplusorg/docker-latex/blob/main/latex/Dockerfile)
[![Docker Build](https://github.com/leplusorg/docker-latex/workflows/Docker/badge.svg)](https://github.com/leplusorg/docker-latex/actions?query=workflow:"Docker")
[![Docker Stars](https://img.shields.io/docker/stars/leplusorg/latex)](https://hub.docker.com/r/leplusorg/latex)
[![Docker Pulls](https://img.shields.io/docker/pulls/leplusorg/latex)](https://hub.docker.com/r/leplusorg/latex)
[![Docker Version](https://img.shields.io/docker/v/leplusorg/latex?sort=semver)](https://hub.docker.com/r/leplusorg/latex)

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

## Request new tool

Please use [this link](https://github.com/leplusorg/docker-latex/issues/new?assignees=thomasleplus&labels=enhancement&template=feature_request.md&title=%5BFEAT%5D) (GitHub account required) to request that a new tool be added to the image. I am always interested in adding new capabilities to these images.
