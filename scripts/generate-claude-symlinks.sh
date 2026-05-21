#!/usr/bin/env bash

set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$project_dir/.claude"
ln -sfn "../.agents/skills" "$project_dir/.claude/skills"
echo "Created symlink .claude/skills → .agents/skills"

ln -sfn "AGENTS.md" "$project_dir/CLAUDE.md"
echo "Created symlink CLAUDE.md → AGENTS.md"
