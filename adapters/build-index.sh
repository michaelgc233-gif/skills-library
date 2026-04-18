#!/bin/bash
# Auto-generate index.md from all skill frontmatter

SKILLS_DIR="$(dirname "$0")/.."
INDEX="$SKILLS_DIR/index.md"

echo "# Skills Index" > "$INDEX"
echo "" >> "$INDEX"
echo "| Name | Description | Platforms | Tags |" >> "$INDEX"
echo "|------|-------------|-----------|------|" >> "$INDEX"

for file in "$SKILLS_DIR/claude-code"/*.md "$SKILLS_DIR/universal"/*.md; do
  [ -f "$file" ] || continue
  name=$(grep '^name:' "$file" | head -1 | sed 's/name: //')
  desc=$(grep '^description:' "$file" | head -1 | sed 's/description: //')
  platforms=$(grep '^platforms:' "$file" | head -1 | sed 's/platforms: //')
  tags=$(grep '^tags:' "$file" | head -1 | sed 's/tags: //')
  echo "| $name | $desc | $platforms | $tags |" >> "$INDEX"
done

echo "" >> "$INDEX"
echo "<!-- Auto-updated by adapters/build-index.sh -->" >> "$INDEX"
echo "Index rebuilt."
