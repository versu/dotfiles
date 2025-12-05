#!/bin/bash
set -eux
source "$(dirname "$0")/common.sh"

mkdir -p \
  "$XDG_CONFIG_HOME" \
  "$XDG_STATE_HOME"

# -------------------------------------------------------------------------------
# 各種設定ファイルへのシンボリックリンクの作成
# ※方針
# 基本的にはセットアップスクリプト（setup-xx.sh）内で行う(ex. mise, claude-codeなど)
# セットアップスクリプトがない場合（特にセットアップが必要ないもの）はここで行う
# -------------------------------------------------------------------------------

# Git設定
ln -sfv "$REPO_DIR/config/git" "$XDG_CONFIG_HOME/"

# Starship設定
ln -sfv "$REPO_DIR/config/starship" "$XDG_CONFIG_HOME/"

# Zeno設定
ln -sfv "$REPO_DIR/config/zeno" "$XDG_CONFIG_HOME/"

# Zsh設定
ln -sfv "$REPO_DIR/config/zsh" "$XDG_CONFIG_HOME/"
ln -sfv "$XDG_CONFIG_HOME/zsh/.zshenv" "$HOME/.zshenv"
