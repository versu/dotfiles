#! /bin/bash
set -eux

# ---------------------------------------------------------
# install dotnet sdk
# 公式のインストールスクリプト（dotnet-install）経由でインストール
# --channel オプションでバージョンを指定
#   Current: 最新の安定版
#   LTS: 最新のLTS版
#   8.0: 特定のバージョンを指定
# ---------------------------------------------------------

curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel Current
