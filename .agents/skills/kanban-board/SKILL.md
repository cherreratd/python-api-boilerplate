---
name: kanban-board
description: Manage the project kanban board. List, read, and close GitHub issues. Use this when the user asks about pending tasks, wants to pick up an issue, or has finished work on one.
user-invokable: true
---

# Kanban Board

Uses `gh` CLI — the repo is auto-detected from the git remote, so no hardcoded reference is needed.

## Commands

List open issues:
```bash
gh issue list
```

View a specific issue:
```bash
gh issue view <number>
```

Close an issue with a summary comment:
```bash
gh issue close <number> --comment "Done: <brief summary>"
```

## Behavior

### Without arguments

List all open issues and show a summary to the user grouped by label (feature, bug, chore).

### With an issue number as argument (e.g. `/kanban-board 12`)

1. **Read** the issue with `gh issue view <number>`.
2. **Analyze** the description, acceptance criteria, and labels.
3. **Present an implementation plan** to the user:
   - What the issue asks for.
   - Which layers are affected (domain / use_cases / infrastructure / delivery).
   - Potential risks or open questions.

### After completing work on an issue

Close the issue with a comment summarizing what was done:
```bash
gh issue close <number> --comment "Done: <brief summary>"
```
