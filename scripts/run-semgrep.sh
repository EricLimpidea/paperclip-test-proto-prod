#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CACHE_DIR="$ROOT_DIR/.cache"
PYTHON_USER_BASE="$CACHE_DIR/semgrep-python"
GET_PIP_PATH="$CACHE_DIR/get-pip.py"
PIP_CACHE_DIR="$CACHE_DIR/pip"
SEMGREP_VERSION="${SEMGREP_VERSION:-1.161.0}"

mkdir -p "$CACHE_DIR" "$PIP_CACHE_DIR"

export PATH="$PYTHON_USER_BASE/bin:$PATH"
export PYTHONUSERBASE="$PYTHON_USER_BASE"
export PIP_CACHE_DIR
export PIP_BREAK_SYSTEM_PACKAGES=1
export XDG_CACHE_HOME="$CACHE_DIR"

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required to run Semgrep." >&2
  exit 1
fi

if ! python3 -m pip --version >/dev/null 2>&1; then
  curl -fsSL https://bootstrap.pypa.io/get-pip.py -o "$GET_PIP_PATH"
  python3 "$GET_PIP_PATH" --user
fi

if ! command -v semgrep >/dev/null 2>&1 || [[ "$(semgrep --version 2>/dev/null || true)" != "$SEMGREP_VERSION" ]]; then
  python3 -m pip install --user "semgrep==$SEMGREP_VERSION"
fi

exec semgrep scan --config=auto --error "$@"
