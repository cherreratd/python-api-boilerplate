# Commands

```bash
make local-setup          # first-time setup: git hooks + dependencies + agent symlinks
source .venv/bin/activate # activate virtual environment

make dev                  # run in development mode (hot reload, OpenAPI enabled)
make run                  # run in production mode (OpenAPI disabled)
make test                 # run all tests (unit + integration + acceptance)
make test-unit            # unit tests only
make test-integration     # integration tests only
make test-acceptance      # acceptance tests only
make watch                # run tests in watch mode
make checks               # lint + format check + type check
make format               # auto-format with ruff
make lint                 # auto-fix lint issues
make coverage             # generate HTML coverage report
make generate-agent-symlinks  # regenerate .claude/skills and .cursor/skills symlinks
make add-package package=XXX      # add runtime dependency
make add-dev-package package=XXX  # add dev dependency
```

Run a single test file:
```bash
pytest tests/unit/use_cases/test_say_hello_command.py -ra -x
```

**Git hooks:** pre-commit runs `checks + test-unit`; pre-push runs `test-integration + test-acceptance`.

**Settings:** all configuration is in `src/common/settings.py` via `pydantic-settings`. Override with environment variables (e.g. `API_V1_PREFIX=/api/v1`). Production mode disables OpenAPI with `OPENAPI_URL=`.

# Architecture

Clean Architecture with strict layer separation. Import direction: `delivery` → `use_cases` → `domain` ← `infrastructure`.

```
src/
  domain/         # Core abstractions — no framework dependencies
  use_cases/      # Business logic (CommandHandlers)
  infrastructure/ # Concrete implementations of domain interfaces
  delivery/       # FastAPI routers — HTTP entry points only
  common/         # Shared logger and settings
main.py           # App factory — wires routers and lifespan
```

**Request flow:** HTTP → `delivery/api/v1/<resource>/<resource>_router.py` → `CommandHandler.execute(Command)` → domain interface → `infrastructure/` implementation.

**Command pattern:** Every operation is `Command` → `CommandHandler` → `CommandResponse` (defined in `src/domain/command.py`). Callers invoke `.message()` on the response.

**Dependency injection:** FastAPI `Depends` wires concrete implementations inside routers — the only place where abstract and concrete meet.

**Domain interfaces:** Defined as abstract classes in `src/domain/`, implemented in `src/infrastructure/`. The current `DummyHelloClient` is the placeholder to replace when integrating a real service.

# Documentation

Detailed conventions with examples live in `docs/`.

**Do NOT read all docs upfront.**

When working on a task, use this map to find and read only the docs relevant to your task:

```
docs/
├── documentation-guidelines.md
├── code-style.md
├── backend/
│   └── clean-architecture.md
└── testing/
    ├── test-doubles.md
    └── test-structure.md
```
