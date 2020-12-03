#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

day="${1:-}"

koka -O2 -c "day${day}.kk"