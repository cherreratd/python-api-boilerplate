# 🎯 Code Style

## 💡 Convention

The project uses `ruff` for linting and formatting (configured in `ruff.toml`), and `ty` for static type checking. Key rules:

- Line length: **120 characters**.
- All public and private functions must have **explicit type annotations** on arguments and return types (ANN rules).
- `print()` is **banned** — use `logger` from `src/common/logger.py` instead (T20 rule).
- Exceptions re-raised inside `except` blocks must use `raise X from Y` (B904 rule).
- Exceptions must be custom classes, never bare `Exception` (TRY002 rule).

## 🏆 Benefits

- Explicit types make function contracts clear and catch unintended changes at the type level.
- Banning `print()` keeps logs structured and consistent across the app.
- `raise X from Y` preserves the exception chain for debuggability.

## 👀 Examples

### ✅ Good: typed function using logger

```python
from src.common.logger import logger

def get(self, name: str) -> str:
    logger.info(f"Fetching name: {name}")
    return name
```

### ❌ Bad: untyped function with print

```python
def get(self, name):
    print(f"Fetching name: {name}")
    return name
```

### ✅ Good: re-raise preserving exception chain

```python
try:
    name = self._hello_client.get(command.name)
except SayHelloClientException as ex:
    raise SayHelloCommandHandlerException(str(ex)) from ex
```

### ❌ Bad: re-raise losing exception chain

```python
try:
    name = self._hello_client.get(command.name)
except SayHelloClientException as ex:
    raise SayHelloCommandHandlerException(str(ex))
```

## 🧐 Real world examples

- `ruff.toml` — full rule configuration
- `src/use_cases/say_hello_command.py` — typed handler with logger and `raise from`
- `src/infrastructure/hello/hello_client.py` — typed method signatures

## 🔗 Related agreements

- [Clean Architecture](backend/clean-architecture.md)
