# FastAPI Boilerplate

Fast starter point for Python APIs using FastAPI, Clean Architecture, and good testing practices.

- Python 3.14.4 managed with [uv](https://docs.astral.sh/uv).
- Dockerfile ready for production.
- GitHub Actions CI on every push to `main`.

## Requirements

Only [uv](https://docs.astral.sh/uv) is required.

Activate the virtual environment manually (`source .venv/bin/activate`) or automatically with [pyautoenv](https://github.com/hsaunders1904/pyautoenv).

## Quick start

```bash
make local-setup   # install git hooks, dependencies, and agent symlinks
source .venv/bin/activate
make dev           # start development server
```

## Commands

Run `make help` to see all available commands. Most common:

```bash
make test          # unit + integration + acceptance
make checks        # lint + format + type check
make coverage      # HTML coverage report
```

## Tools

| Area | Tool |
|---|---|
| Package manager | [uv](https://docs.astral.sh/uv) |
| Web framework | [FastAPI](https://fastapi.tiangolo.com) |
| Testing | [pytest](https://docs.pytest.org) + [expects](https://expects.readthedocs.io) + [doublex](https://pypi.org/project/doublex-expects/) |
| Linting & formatting | [ruff](https://docs.astral.sh/ruff) |
| Type checking | [ty](https://github.com/astral-sh/ty) |

## AI agent tooling

This project is set up for agentic development:

- **`AGENTS.md`** — shared context file read by Claude Code, OpenAI Codex, Cursor, and other agents.
- **`docs/`** — granular convention docs (architecture, testing, code style). Agents load only what's relevant to each task.
- **`.agents/skills/`** — reusable skills (`create-doc`, `kanban-board`, `repo-status`). Linked automatically to each agent's folder by `make local-setup`.
