#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-golbin/agent-skills}"
REF="${REF:-main}"
SKILL_PATH="${SKILL_PATH:-skills/prd}"
SKILL_NAME="${SKILL_NAME:-prd}"
DEST_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"
DEST="${DEST_ROOT}/${SKILL_NAME}"

if [[ -e "${DEST}" ]]; then
  echo "Destination already exists: ${DEST}" >&2
  echo "Remove it first or set SKILL_NAME to install under a different name." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

archive_url="https://github.com/${REPO}/archive/refs/heads/${REF}.tar.gz"
curl -fsSL "${archive_url}" | tar -xz -C "${tmp_dir}"

repo_dir="$(find "${tmp_dir}" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
src="${repo_dir}/${SKILL_PATH}"

if [[ ! -f "${src}/SKILL.md" ]]; then
  echo "SKILL.md not found at ${SKILL_PATH} in ${REPO}@${REF}" >&2
  exit 1
fi

mkdir -p "${DEST_ROOT}"
cp -R "${src}" "${DEST}"

echo "Installed ${SKILL_NAME} to ${DEST}"
echo "Restart Codex to pick up new skills."
