#!/usr/bin/env bash
set -euo pipefail

# Safe, local installation of the personal Codex skill.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/skills/fde-mental-map"
TARGET_PARENT="$HOME/.agents/skills"
TARGET_DIR="$TARGET_PARENT/fde-mental-map"

if [ ! -f "$SOURCE_DIR/SKILL.md" ]; then
  echo "Cannot find $SOURCE_DIR/SKILL.md" >&2
  exit 1
fi

if [ -e "$TARGET_DIR" ]; then
  echo "Already exists: $TARGET_DIR" >&2
  echo "Refusing to overwrite. Compare or back up your existing skill before updating." >&2
  exit 2
fi

mkdir -p "$TARGET_PARENT"
cp -R "$SOURCE_DIR" "$TARGET_DIR"
echo "Installed at $TARGET_DIR"
echo "Restart or refresh Codex, then invoke: \$fde-mental-map"
