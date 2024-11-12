FROM debian:12.8-slim@sha256:ca3372ce30b03a591ec573ea975ad8b0ecaf0eb17a354416741f8001bbcae33d

HEALTHCHECK NONE

ENTRYPOINT []

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get install --no-install-recommends -y adduser chktex ghostscript lacheck latexmk latex-make latex-mk texlive texlive-lang-all texlive-latex-extra && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

RUN adduser \
  --home "${USER_HOME}" \
  --uid "${USER_ID}" \
  --gecos "${USER_GECOS}" \
  --disabled-password \
  "${USER_NAME}"

ENV HOME="${USER_HOME}"

USER "${USER_NAME}"

WORKDIR "${HOME}"
