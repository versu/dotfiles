#!/bin/bash

set -eux

### common ###
code --install-extension eamodio.gitlens
# code --install-extension mhutchie.git-graph
code --install-extension ms-azuretools.vscode-docker
code --install-extension wmaurer.change-case
code --install-extension dotjoshjohnson.xml
code --install-extension christian-kohler.path-intellisense
 
### Python ##
# code --install-extension ms-python.python
 
### C# ###
# code --install-extension ms-dotnettools.csharp

### shell ###
# linter
code --install-extension foxundermoon.shell-format
# formatter
code --install-extension timonwong.shellcheck
