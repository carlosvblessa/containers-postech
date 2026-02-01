#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CURRENCY="${1:-EUR}"
CONTAINER_NAME="${2:-meu-container}"
IMAGE="app-moeda-distroless:latest"

mkdir -p "${ROOT_DIR}/data"

if "$(command -v docker)" image inspect "${IMAGE}" >/dev/null 2>&1; then
  "$(command -v docker)" image rm -f "${IMAGE}"
fi

if "$(command -v docker)" container inspect "${CONTAINER_NAME}" >/dev/null 2>&1; then
  "$(command -v docker)" rm -f "${CONTAINER_NAME}"
fi

"$(command -v docker)" build -t "${IMAGE}" -f "${ROOT_DIR}/DockerfileDistroless" "${ROOT_DIR}"
"$(command -v docker)" run --rm -d -v "${ROOT_DIR}/data:/app/data" --name "${CONTAINER_NAME}" "${IMAGE}" "${CURRENCY}"
