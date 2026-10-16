#!/usr/bin/env bash
set -euo pipefail

ROOT="$HOME/.agents/skills/fde-mental-map"

if [ ! -f "$ROOT/SKILL.md" ]; then
  echo "MISSING: $ROOT/SKILL.md" >&2
  exit 1
fi
if ! grep -q '^name: fde-mental-map$' "$ROOT/SKILL.md"; then
  echo "INVALID: skill name must be fde-mental-map" >&2
  exit 1
fi
if ! grep -q '^description:' "$ROOT/SKILL.md"; then
  echo "INVALID: no description field" >&2
  exit 1
fi
for f in visual-first-onboarding.md error-report-translator.md mental-model-method.md glossary.md map-examples.md troubleshooting.md; do
  if [ ! -f "$ROOT/references/$f" ]; then
    echo "MISSING: $ROOT/references/$f" >&2
    exit 1
  fi
done

echo "PASS: Skill files and main YAML keys are present."
echo "This is a file-level check. Explicitly invoke \$fde-mental-map in Codex to verify discovery."
