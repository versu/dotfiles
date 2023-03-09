#! /bin/bash
set -eux

### install Docker Engine ###

# install docker engine
sudo apt update

sudo apt install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

# docker can only be run with root user privileges by default, so add privileges to the user(https://phoenixnap.com/kb/docker-permission-denied)
# sudo gpasswd -a $(whoami) docker
# sudo chmod 666 /var/run/docker.sock

# if vscode-docker extension is used. execute command "sudo chmod 666 /var/run/docker.sock"(TODO: this command must run every docker restart...)
sudo groupadd -f docker
sudo usermod -aG docker $USER
newgrp docker

### install Docker Compose ###

# check install version from https://github.com/docker/compose/releases, and modify install version properly
sudo curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
