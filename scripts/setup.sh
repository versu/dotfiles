#!/bin/bash
set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

/bin/bash "$CUR_DIR/setup-apt.bash"
/bin/bash "$CUR_DIR/setup-vscode.bash"
/bin/bash "$CUR_DIR/setup-links.bash"
/bin/bash "$CUR_DIR/setup-deno.bash"
/bin/bash "$CUR_DIR/setup-zinit.bash"
