# Skills Library

A universal skill library for AI tools and platforms.

## Structure

```
skills-library/
├── claude-code/     # Skills for Claude Code CLI (.md format)
├── universal/       # Platform-agnostic skills (pure prompt)
└── adapters/        # Scripts to sync/convert skills to each platform
```

## Skill Format

Each skill is a Markdown file with frontmatter:

```markdown
---
name: skill-name
description: One-line description of what this skill does
platforms: [claude-code, dify, openai]
tags: [category, subcategory]
version: 1.0.0
---

# Skill content here
```

## Adding a New Skill

1. Create a `.md` file in the appropriate folder
2. Add frontmatter metadata
3. Update `index.md`
4. Run the relevant adapter script to sync to your platform

## Sync to Claude Code

```bash
bash adapters/to-claude-code.sh
```
