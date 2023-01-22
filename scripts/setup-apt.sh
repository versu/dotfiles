#!/bin/bash

set -eux

sudo apt update && sudo apt upgrade -y

### common ###
sudo apt install -y \
  build-essential \
  python3-pip \
  zip \
  jq \
  git \
  fzf \
  tree

### zsh ###
sudo apt install -y zsh
chsh "$(which zsh)"
