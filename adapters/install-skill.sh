#!/bin/bash
# Install a skill from a local path or GitHub URL
# Usage:
#   install-skill.sh <local-folder>
#   install-skill.sh <github-url>  (repo or skills subfolder URL)

set -e

SKILLS_LIB="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_SKILLS="$HOME/.claude/skills"
CATEGORY="claude-code"

mkdir -p "$CLAUDE_SKILLS"

install_local() {
  local src="$1"
  local name
  name=$(basename "$src")

  echo "Installing: $name"
  cp -r "$src" "$SKILLS_LIB/$CATEGORY/$name"
  cp -r "$src" "$CLAUDE_SKILLS/$name"

  cd "$SKILLS_LIB"
  git add "$CATEGORY/$name"
  git commit -m "skill: add $name"
  git push origin main
  echo "✓ $name installed and pushed to GitHub"
}

install_github_repo() {
  local url="$1"
  # Convert GitHub tree URL to clone URL
  local clone_url
  clone_url=$(echo "$url" | sed 's|/tree/main.*||').git

  local tmp
  tmp=$(mktemp -d)
  git clone --depth=1 "$clone_url" "$tmp/repo" 2>/dev/null

  # Detect if URL points to a skills subfolder
  local skills_path="$tmp/repo/skills"
  if [ ! -d "$skills_path" ]; then
    skills_path="$tmp/repo"
  fi

  local count=0
  for skill_dir in "$skills_path"/*/; do
    [ -d "$skill_dir" ] || continue
    local name
    name=$(basename "$skill_dir")
    echo "Installing: $name"
    cp -r "$skill_dir" "$SKILLS_LIB/$CATEGORY/$name"
    cp -r "$skill_dir" "$CLAUDE_SKILLS/$name"
    count=$((count + 1))
  done

  rm -rf "$tmp"

  cd "$SKILLS_LIB"
  git add "$CATEGORY/"
  git commit -m "skill: import $count skills from $(basename "$clone_url" .git)"
  git push origin main
  echo "✓ $count skills installed and pushed to GitHub"
}

if [ -z "$1" ]; then
  echo "Usage: $0 <local-folder | github-url>"
  exit 1
fi

if [[ "$1" == http* ]]; then
  install_github_repo "$1"
else
  install_local "$1"
fi
