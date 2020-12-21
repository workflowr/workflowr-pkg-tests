#!/bin/bash
set -eux

# Use stretch-backports to install recent libgit2 version required by
# gert
# https://github.com/r-lib/gert/issues/112
# https://packages.debian.org/stretch-backports/libgit2-dev
# https://linuxconfig.org/how-to-install-and-use-debian-backports
debian=`lsb_release --codename | cut -f2`
if [ $debian == 'stretch' ]
then
  echo 'Using stretch-backports to install libgit2-dev'
  echo 'deb http://deb.debian.org/debian stretch-backports main' >> /etc/apt/sources.list
  apt update
  apt install -y -t stretch-backports libgit2-dev
fi

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
