#!/usr/bin/env bash

set -eo pipefail

# Get to the point where we can install other ppas
apt-get update && apt-get -y install software-properties-common

for repo in ppa:ansible/ansible ppa:jonathonf/vim; do
  apt-add-repository $repo
done

apt-get update && apt-get -y install ansible vim
