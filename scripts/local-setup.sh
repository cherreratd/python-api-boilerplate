#!/bin/bash
set -e

function main {
  install_git_hooks
  generate_agent_symlinks
}

function install_git_hooks {
  echo "Installing git hooks..."
  git config core.hooksPath scripts/hooks
}

function generate_agent_symlinks {
  echo "Generating agent symlinks..."
  scripts/generate-claude-symlinks.sh
  scripts/generate-cursor-symlinks.sh
}

main
