FROM debian:12.9-slim@sha256:f70dc8d6a8b6a06824c92471a1a258030836b26b043881358b967bf73de7c5ab

HEALTHCHECK NONE

ENTRYPOINT []

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get install --no-install-recommends -y adduser chktex ghostscript lacheck latexmk latex-make latex-mk texlive texlive-lang-all texlive-latex-extra texlive-bibtex-extra biber texlive-fonts-extra texlive-science && \
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
