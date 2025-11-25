#!/usr/bin/env bash
# Creates a local Python virtual environment in .venv and installs project dependencies
# Usage: bash ./setup_venv.sh

set -euo pipefail

section() {
  echo
  echo "=== $1 ==="
}

# Find a usable python executable
PY=""
if command -v python3 >/dev/null 2>&1; then
  PY="python3"
elif command -v python >/dev/null 2>&1; then
  PY="python"
fi

section "Checking Python"
if [[ -z "$PY" ]]; then
  echo "Error: Python is not installed or not on PATH. Install Python 3.8+ from https://www.python.org/downloads/ and try again." >&2
  exit 1
fi

PY_VER=$($PY -c 'import sys; print(sys.version.split()[0])' || true)
if [[ -z "${PY_VER}" ]]; then
  echo "Error: Unable to run Python interpreter." >&2
  exit 1
fi
printf "Python found: %s\n" "$PY_VER"

section "Creating virtual environment at .venv"
if [[ ! -d .venv ]]; then
  "$PY" -m venv .venv
  echo "Created .venv"
else
  echo ".venv already exists, reusing it"
fi

VENV_PY=".venv/bin/python"
if [[ ! -x "$VENV_PY" ]]; then
  echo "Error: Virtual environment looks corrupt. Delete the .venv folder and run this script again." >&2
  exit 1
fi

section "Upgrading pip and installing dependencies"
"$VENV_PY" -m pip install --upgrade pip
if [[ -f requirements.txt ]]; then
  "$VENV_PY" -m pip install -r requirements.txt
else
  echo "No requirements.txt found; skipping dependency installation"
fi

section "Done"
echo "Activate the environment with:"
echo "source .venv/bin/activate"
