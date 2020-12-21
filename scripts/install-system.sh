#!/bin/bash
set -eux

# Use PPA to install libgit2 for gert, a dependency of usethis/devtools
# https://github.com/r-lib/gert/issues/107#issuecomment-744465884
add-apt-repository ppa:cran/libgit2
apt-get update
apt-get install -y \
  emacs \
  git \
  libcurl4-openssl-dev \
  libgit2-dev \
  libsm6 \
  libssl-dev \
  libxml2-dev \
  libxt6 \
  nano \
  netbase \
  qpdf \
  wget \
  zlib1g-dev
