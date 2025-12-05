#!/bin/bash
set -eux

export CUR_DIR REPO_DIR
CUR_DIR="$(
  cd "$(dirname "$0")" || exit 1
  pwd
)"
REPO_DIR="$(
  cd "$(dirname "$0")/.." || exit 1
  pwd
)"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ========================================
# 色定義
# ========================================
export COLOR_GREEN='\033[0;32m'
export COLOR_YELLOW='\033[0;33m'
export COLOR_BLUE='\033[0;34m'
export COLOR_RED='\033[0;31m'
export COLOR_RESET='\033[0m'

# ========================================
# 色付きメッセージ出力関数
# ========================================

# セクションヘッダーを表示（青、==> 付き）
echo_info() {
  echo -e "${COLOR_BLUE}==> $1${COLOR_RESET}"
}

# 成功メッセージを表示（緑、✓ 付き）
echo_success() {
  echo -e "${COLOR_GREEN}✓ $1${COLOR_RESET}"
}

# スキップメッセージを表示（黄、✓ 付き）
echo_skip() {
  echo -e "${COLOR_YELLOW}✓ $1${COLOR_RESET}"
}

# エラーメッセージを表示（赤、✗ 付き）
echo_error() {
  echo -e "${COLOR_RED}✗ $1${COLOR_RESET}"
}
