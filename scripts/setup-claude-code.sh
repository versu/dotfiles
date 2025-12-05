#!/bin/bash
set -eu

source "$(dirname "$0")/common.sh"

# Claude Codeのインストール
echo_info "Claude Codeのインストール確認"
if ! type claude &>/dev/null; then
  echo_info "Claude Codeをインストールします..."
  curl -fsSL https://claude.ai/install.sh | bash
  echo_success "Claude Codeのインストールが完了しました"
else
  echo_skip "Claude Codeは既にインストールされています（スキップ）"
fi

# ------------------------------------------------------------------------------------------------------------------
# 各種設定ファイルへのシンボリックリンクの作成
# ※補足
# シンボリックリンクの作成は claude コマンド実行前に行う必要がある
# claude コマンドを実行すると ~/.claude ディレクトリが自動で作成される
# この状態でシンボリックリンクを作成すると、パーミッションの関係で ~/.claude ではなく ~/.claude/claude にリンクが作成されてしまうため
# ------------------------------------------------------------------------------------------------------------------
echo_info "シンボリックリンクの作成"
ln -sfv "$REPO_DIR/config/claude" "$HOME/.claude"
echo_success "セットアップが完了しました！"
