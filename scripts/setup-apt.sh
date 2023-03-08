#!/bin/bash

set -eux

sudo apt update && sudo apt upgrade -y

### common ###
sudo apt install -y \
  build-essential \
  zip \
  jq \
  git \
  tree \
  rename

### zsh ###
sudo apt install -y zsh
chsh -s "$(which zsh)"
