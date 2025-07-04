#!/bin/bash

set -eux

# npmコマンドの存在確認
if ! command -v npm >/dev/null 2>&1; then
  echo "npmが見つかりません。Node.jsとnpmをインストールしてください。" >&2
  exit 1
fi

npm install -g @anthropic-ai/claude-code
