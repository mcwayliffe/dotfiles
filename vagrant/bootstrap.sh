#!/usr/bin/env bash

set -eo pipefail

# Get to the point where we can install other ppas
apt-get update && apt-get -y install software-properties-common

for repo in ppa:ansible/ansible ppa:jonathonf/vim ppa:git-core/ppa; do
  apt-add-repository $repo
done

apt-get update && apt-get -y install ansible git vim zsh

# --- Get latest tmux ---
tmux_version="2.7"
workdir="$(mktemp -d)"

# If we have the OS package, remove it
if apt list --installed 2>/dev/null | grep tmux; then
  apt-get -y purge tmux
fi

# Download newer version from tmux releases
(cd ${workdir}; \
  curl --silent --remote-name --location \
    https://github.com/tmux/tmux/releases/download/${tmux_version}/tmux-${tmux_version}.tar.gz)

tar xf ${workdir}/tmux-${tmux_version}.tar.gz \
  && rm ${workdir}/tmux-${tmux_version}.tar.gz

# Configure and install
(cd ${workdir}/tmux-${tmux_version}; \
  ./configure && make && make install)

# Setup sources
rm -rf /usr/local/src/tmux-* \
  && mv ${workdir}/tmux-${tmux_version} /usr/local/src
