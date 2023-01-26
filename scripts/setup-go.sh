#!/bin/bash

set -eux -o pipefail

source "$(dirname "$0")/common.sh"

### prepare install ###
sudo rm -rf "$XDG_DATA_HOME"/go

### install go ###
#====================================================================
# install version url (https://go.dev/dl/)
#====================================================================
curl -fsSL https://go.dev/dl/go1.19.5.linux-amd64.tar.gz | tar xzf - -C "$XDG_DATA_HOME"

### install go-pkg ###
go install github.com/x-motemen/ghq@latest
