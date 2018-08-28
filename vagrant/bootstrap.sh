#!/usr/bin/env bash

whereami="$( cd "$(dirname ${BASH_SOURCE[0]})" >/dev/null && pwd )"
# Install ansible (with apt instead of pip)
apt-add-repository ppa:ansible/ansible \
  && apt-get update \
  && apt-get -y install software-properties-common ansible \

# Install and configure everything else
ansible-playbook --inventory-file inventory $whereami/workstation.yml
