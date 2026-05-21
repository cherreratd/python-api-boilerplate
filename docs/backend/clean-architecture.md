# 🎯 Clean Architecture

## 💡 Convention

The backend follows Clean Architecture with strict layer separation. The dependency rule is absolute: outer layers depend on inner layers, never the reverse.

```
delivery → use_cases → domain ← infrastructure
```

- **domain** — abstract interfaces (`HelloClient`), domain exceptions, and the `Command`/`CommandHandler`/`CommandResponse` base classes. Zero framework imports.
- **use_cases** — one `CommandHandler` per operation. Orchestrates domain via interfaces injected through the constructor.
- **infrastructure** — concrete implementations of domain interfaces (e.g., `DummyHelloClient`). Framework and library aware.
- **delivery** — FastAPI routers only. Translates HTTP → `Command`, calls the handler, maps `CommandResponse` → HTTP response. No business logic.
- **common** — shared `logger` and `settings`. Allowed everywhere.

**Command pattern:** every operation follows `Command` → `CommandHandler.execute()` → `CommandResponse`. The caller obtains the result via `.message()`. Each `Command` gets a unique `command_id` (uuid1) for log correlation.

**Dependency injection:** FastAPI `Depends` in routers is the only place where abstract interfaces meet concrete implementations. `CommandHandler` receives its dependencies through `__init__` — never instantiated inside handlers.

## 🏆 Benefits

- Domain logic stays framework-agnostic and is independently unit-testable.
- Swapping an infrastructure implementation (e.g., replacing `DummyHelloClient` with a real HTTP client) requires zero changes to `use_cases` or `domain`.
- One `CommandHandler` per operation keeps business logic small and named clearly.

## 👀 Examples

### ✅ Good: CommandHandler depending on a domain interface

```python
class SayHelloCommandHandler(CommandHandler):
    def __init__(self, hello_client: HelloClient, _logger: Logger = logger) -> None:
        self._hello_client = hello_client
        self._logger = _logger

    def execute(self, command: SayHelloCommand) -> SayHelloCommandResponse:
        name = self._hello_client.get(command.name)
        return SayHelloCommandResponse(name)
```

### ❌ Bad: CommandHandler importing a concrete infrastructure class

```python
from src.infrastructure.hello.hello_client import DummyHelloClient

class SayHelloCommandHandler(CommandHandler):
    def __init__(self) -> None:
        self._hello_client = DummyHelloClient()  # breaks dependency rule
```

### ✅ Good: router wiring concrete classes via Depends

```python
async def hello_client() -> DummyHelloClient:
    return DummyHelloClient()

async def say_hello_command_handler(
    client: HelloClient = Depends(hello_client),
) -> CommandHandler:
    return SayHelloCommandHandler(client)
```

### ❌ Bad: business logic inside a router

```python
@hello.get("/hello/{name}")
def get(name: str) -> HelloResponse:
    if name.startswith("Error"):       # business rule leaking into delivery
        raise HTTPException(400, "invalid name")
    return HelloResponse(message=f"Hello, {name}!")
```

## 🧐 Real world examples

- Domain interface: `src/domain/hello_client.py`
- Domain base classes: `src/domain/command.py`
- Use case: `src/use_cases/say_hello_command.py`
- Infrastructure: `src/infrastructure/hello/hello_client.py`
- Router with DI wiring: `src/delivery/api/v1/hello/hello_router.py`

## 🔗 Related agreements

- [Test Doubles](../testing/test-doubles.md)
- [Test Structure](../testing/test-structure.md)
