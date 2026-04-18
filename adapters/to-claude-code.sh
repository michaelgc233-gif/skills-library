#!/bin/bash
# Sync skills to Claude Code's global skills directory

SKILLS_DIR="$(dirname "$0")/.."
TARGET_DIR="$HOME/.claude/skills"

mkdir -p "$TARGET_DIR"

echo "Syncing skills to $TARGET_DIR ..."

for file in "$SKILLS_DIR/claude-code"/*.md "$SKILLS_DIR/universal"/*.md; do
  [ -f "$file" ] || continue
  name=$(basename "$file")
  cp "$file" "$TARGET_DIR/$name"
  echo "  ✓ $name"
done

echo "Done."
