#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/.."

nvim --headless -u NONE \
    --cmd "set rtp^=$PWD" \
    +"lua require('duck-type').setup({ delay = 30, loop = true })" \
    +"e README.md" \
    +DuckType +qa
