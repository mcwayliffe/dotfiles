FROM ubuntu:16.04

RUN apt-get -y update && apt-get install -y vim \
  zsh \
  git \
  tmux \
  python

# Make sure to mount your ssh credentials with
# `docker run -it -v ~/.ssh:/root/.ssh buntu /bin/zsh`
RUN mkdir -p /root/.ssh
