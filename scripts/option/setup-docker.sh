#!/bin/bash
# 事前準備(インストールに必要なパッケージ導入)
sudo apt update
sudo apt install -y apt-transport-https
 
 # dockerパッケージリポジトリ追加
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 
 # dockerEngineのインストール、確認
sudo apt update
sudo apt install docker-ce
docker version
 
 # docker起動（デーモン起動~コンテナ実行）
sudo service docker start
 
 # docker-compose のインストール、確認
sudo apt install docker-compose -y
doceker-compose version

# sudoなしでDockerコマンドを実行できるようにする
# ref: https://www.lisz-works.com/entry/vscode-remotedev-docker-container
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
