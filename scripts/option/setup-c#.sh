#! /bin/bash
set -eux

### dotnet ###
curl -O -L -s "https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb"
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update && sudo apt install -y apt-transport-https
sudo apt install -y dotnet-sdk-6.0

### azure cli ###
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

### vscode extensions ###
code --install-extension ms-dotnettools.csharp
