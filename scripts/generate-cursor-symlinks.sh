#!/usr/bin/env bash

set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$project_dir/.cursor"
ln -sfn "../.agents/skills" "$project_dir/.cursor/skills"
echo "Created symlink .cursor/skills → .agents/skills"
