#!/usr/bin/env bash

set -eo pipefail

# Get to the point where we can install other ppas
apt-get update && apt-get -y install software-properties-common

apt-add-repository ppa:ansible/ansible ppa:jonathonf/vim

apt-get update && apt-get -y install ansible vim
