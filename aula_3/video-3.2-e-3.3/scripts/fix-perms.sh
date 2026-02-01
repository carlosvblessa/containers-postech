#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

sudo chown -R "$(id -un)":"$(id -gn)" "${ROOT_DIR}/data"
