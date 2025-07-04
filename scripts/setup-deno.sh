#!/bin/bash

set -eux

source "$(dirname "$0")/common.sh"

export DENO_INSTALL="${DENO_INSTALL:-$XDG_DATA_HOME/deno}"
echo "Installing Deno..."
sudo apt install -y unzip
curl -fsSL https://deno.land/x/install/install.sh | /bin/sh
echo "Install Deno completions..."
# mkdir -p "$XDG_DATA_HOME/zsh/completions"
# "$DENO_INSTALL/bin/deno" completions zsh >"$XDG_DATA_HOME/zsh/completions/_deno"
