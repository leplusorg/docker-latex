FROM debian:12.10-slim@sha256:4b50eb66f977b4062683ff434ef18ac191da862dbe966961bc11990cf5791a8d

HEALTHCHECK NONE

ENTRYPOINT []

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y \
    adduser=3.134 \
    biber=2.18-1 \
    chktex=1.7.8-1 \
    ghostscript=10.0.0~dfsg-11+deb12u7 \
    lacheck=1.26-17 \
    latex-make=2.4.3-1 \
    latex-mk=2.1-3 \
    latexmk=1:4.79-1 \
    python3=3.11.2-1+b1 \
    python3-pip=23.0.1+dfsg-1 \
    texlive-bibtex-extra=2022.20230122-4 \
    texlive-lang-all=2022.20230122-1 \
    texlive-latex-extra=2022.20230122-4 \
    texlive-science=2022.20230122-4 \
    texlive=2022.20230122-3 \
    && IFS=$'\n\t' \
    && if apt-get -s upgrade | grep -q -e '^Inst ' ; then \
      apt-get -s upgrade | grep -e '^Inst ' ; \
      exit 1 ; \
    fi \
    # Removing documentation packages *after* installing them is kind of hacky,
    # but it only adds some overhead while building the image.
    && apt-get --purge remove -y .\*-doc$ \
    # Remove more unnecessary stuff
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /var/log/* /var/cache/ldconfig/aux-cache

RUN adduser \
  --home "${USER_HOME}" \
  --uid "${USER_ID}" \
  --gecos "${USER_GECOS}" \
  --disabled-password \
  "${USER_NAME}"

USER "${USER_NAME}"

ENV HOME="${USER_HOME}"

WORKDIR "${HOME}"
