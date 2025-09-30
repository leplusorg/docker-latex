FROM debian:13.1-slim@sha256:1caf1c703c8f7e15dcf2e7769b35000c764e6f50e4d7401c355fb0248f3ddfdb

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
    # FIXME @TL workaround for amd64 vs arm64 versions
    && if [ "$(\uname -m)" = 'aarch64' ]; then \
      SUFFIX='+b1' ; \
    else \
      SUFFIX='' ; \
    fi \
    && apt-get install --no-install-recommends -y \
    adduser=3.152 \
    aspell-am=0.03-1-5.2 \
    aspell-ar=0.0.20060329-6 \
    aspell-bg=4.1-7.1 \
    aspell-bn=1:0.01.1-1-5 \
    aspell-br=0.50-2-11 \
    aspell-ca=0.20111230b-14 \
    aspell-cs=0.51.0-1.3 \
    aspell-cy=0.50-3-8 \
    aspell-da=1.6.36-17 \
    aspell-de=20161207-15 \
    aspell-doc=0.60.8.1-4 \
    aspell-el=0.50-3-8 \
    aspell-en=2020.12.07-0-1 \
    aspell-eo=3.7-2 \
    aspell-es=1.11-20 \
    aspell-et=1:20030606-32 \
    aspell-eu=3.0.20070215-2 \
    aspell-fa=0.11-0-4 \
    aspell-fo=0.4.2+repack1-5 \
    aspell-fr=0.50-3-9 \
    aspell-ga=0.50-4-6 \
    aspell-gl-minimos=0.5-48 \
    aspell-gu=0.03-0-12 \
    aspell-he=1.0-0-8.1 \
    aspell-hi=0.02-9 \
    aspell-hr=0.51-6.1 \
    aspell-hsb=0.02.0-2 \
    aspell-hu=0.99.4.2-0-5 \
    aspell-hy=0.10.0-0-3.2 \
    aspell-is=0.51.1-0-2 \
    aspell-it=2.4-20070901-0-4 \
    aspell-kk=0.2-3 \
    aspell-kn=0.01-3-3 \
    aspell-ku=0.20-0-8 \
    aspell-lt=1.3.2-3 \
    aspell-lv=0.9.6-12 \
    aspell-ml=0.04-1-10 \
    aspell-mr=0.10-12 \
    aspell-nl=1:2.20.19+1-3 \
    aspell-no=2.2-4 \
    aspell-or=0.03-1-8 \
    aspell-pa=0.01-1-7 \
    aspell-pl=20250101-1 \
    aspell-pt-br=20131030-19 \
    aspell-pt-pt=20220621-1 \
    aspell-pt=1.10 \
    aspell-ro=3.3.10-1 \
    aspell-ru=0.99g5-30 \
    aspell-sk=1:25.2.3-1+2.04+ds.9 \
    aspell-sl=0.60-4.1 \
    aspell-sv=0.51-0-4 \
    aspell-ta=20040424-1-4 \
    aspell-te=0.01-2-7 \
    aspell-tl=0.4-0-22 \
    aspell-uk=1.8.0+dfsg-1 \
    aspell-uz=0.6.0-4 \
    aspell=0.60.8.1-4 \
    biber=2.20-2 \
    chktex=1.7.9-1${SUFFIX} \
    curl=8.14.1-2 \
    ghostscript=10.05.1~dfsg-1 \
    git=1:2.47.3-0+deb13u1 \
    lacheck=1.26-17.1${SUFFIX} \
    latex-make=2.4.3-1 \
    latex-mk=2.1-6 \
    latexmk=1:4.86~ds-1 \
    make=4.4.1-2 \
    pandoc=3.1.11.1+ds-2 \
    python3=3.13.5-1 \
    python3-pip=25.1.1+dfsg-1 \
    texlive-bibtex-extra=2024.20250309-2 \
    texlive-lang-all=2024.20250309-1 \
    texlive-latex-extra=2024.20250309-2 \
    texlive-science=2024.20250309-2 \
    texlive=2024.20250309-1 \
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
