#!/usr/bin/env bash
set -eo pipefail

# Get to the point where we can install other ppas
apt-get update && apt-get -y install software-properties-common

for repo in ppa:ansible/ansible ppa:jonathonf/vim ppa:git-core/ppa; do
  apt-add-repository $repo
done

apt-get update && apt-get -y install ansible git vim

# --- Get latest tmux ---
# If we have the OS package, remove it
if apt list --installed 2>/dev/null | grep tmux; then
  apt-get -y purge tmux
fi

# Install build dependencies
apt -y install automake build-essential libevent-dev libncurses5-dev pkg-config

# Download the newer version of tmux, if we don't already have it
target_version="2.7"

# If tmux 2 ever gets above 2.9, then this "if" check will be problematic
if ! command -v tmux &>/dev/null \
    || [[ "$(tmux -V | cut -d' ' -f2)" < "$target_version" ]]; then
  echo "Attempting to install tmux version $target_version"
  workdir="$(mktemp -d)"

  cd ${workdir}

  curl --silent --remote-name --location \
      https://github.com/tmux/tmux/releases/download/${target_version}/tmux-${target_version}.tar.gz

  tar xf tmux-${target_version}.tar.gz \
    && rm tmux-${target_version}.tar.gz

  # Configure and install
  cd tmux-${target_version}
  ./configure && make && make install

  # Setup sources
  rm -rf /usr/local/src/tmux-* \
    && mv ${workdir}/tmux-${target_version} /usr/local/src

  cd -
fi

for config_file in vimrc bashrc tmux.conf; do
  ln -sf "/vagrant/$config_file" "/home/vagrant/.$config_file"
done
