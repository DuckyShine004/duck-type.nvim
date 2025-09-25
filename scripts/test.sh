#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/.."

nvim --headless -u NONE --cmd "set rtp+=$PWD" \
    +"e README.md" \
    +"lua require('duck-type').setup()" \
    +DuckType +qa
