#!/bin/bash
# ~/.claude/skills is a symlink to skills-library/claude-code/
# No copy needed — just verify the symlink exists, create it if missing.

TARGET="$HOME/.claude/skills"
SOURCE="$(cd "$(dirname "$0")/../claude-code" && pwd)"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "✓ ~/.claude/skills already linked to $SOURCE"
else
  rm -rf "$TARGET"
  ln -s "$SOURCE" "$TARGET"
  echo "✓ Linked ~/.claude/skills -> $SOURCE"
fi
