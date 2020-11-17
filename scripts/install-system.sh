#!/bin/bash
set -eux

apt-get update
apt-get install -y \
  emacs \
  git \
  libcurl4-openssl-dev \
  libsm6 \
  libssl-dev \
  libxml2-dev \
  libxt6 \
  nano \
  netbase \
  qpdf \
  wget \
  zlib1g-dev
