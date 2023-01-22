#!/bin/bash
set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.sh"

/bin/bash "$CUR_DIR/setup-apt.sh"
/bin/bash "$CUR_DIR/setup-vscode.sh"
/bin/bash "$CUR_DIR/setup-links.sh"
/bin/bash "$CUR_DIR/setup-deno.sh"
/bin/bash "$CUR_DIR/setup-zinit.sh"
