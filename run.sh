#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

day="${1:-}"

./build.sh "${day}"
./out/v2.0.12/clang-drelease/day${day}