#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

day="${1:-}"

./run.sh "${day}"
hyperfine "./out/v2.0.12/clang-drelease/day${day}"
