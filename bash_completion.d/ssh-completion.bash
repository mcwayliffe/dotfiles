#!/usr/bin/env bash

_ssh_completion() {
  local named_servers="$( \
    egrep -v '^\d+(\.\d+){3}' $HOME/.ssh/known_hosts \
    | awk -F '[, ]' '{print $1}' )"
  COMPREPLY=($(compgen -W "$named_servers" "${COMP_WORDS[1]}"))
}

builtin complete -F _ssh_completion ssh
