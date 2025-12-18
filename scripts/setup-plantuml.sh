#!/bin/bash
set -eux

# -----------------------------------------------------------------
# plant uml
# graphviz: PlantUMLの動作要件。javaも必要だが、これはmiseでインストールする
# fonts-noto-cjk: デフォルトだとプレビュー表示時に文字がおかしいのでフォントをインストール
# -----------------------------------------------------------------
sudo apt install -y \
  graphviz \
  fonts-noto-cjk

# VSCodeのPlantUML拡張機能のインストール
code --install-extension jebbs.plantuml
