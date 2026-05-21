# 🎯 Test Doubles with doublex

## 💡 Convention

Use `doublex` to create test doubles for domain interfaces in unit tests. The standard pattern is `Mimic(Stub, ConcreteClass)` as a context manager to stub method return values or raised exceptions.

- Use `Mimic(Stub, ConcreteClass)` to stub an interface implementation.
- Configure behavior inside the `with` block before the handler is instantiated.
- Use `expects` (BDD assertions) to verify results and raised exceptions.
- Never use `unittest.mock.MagicMock` or `pytest-mock` — doublex stubs implement the real interface, so type mismatches are caught at stub-creation time.

## 🏆 Benefits

- Stubs created with `Mimic` must conform to the real class's interface — wrong method names or signatures fail immediately.
- `expects` assertions read as specifications: `expect(result).to(equal(...))`.
- Test doubles stay isolated from framework internals; only the domain contract matters.

## 👀 Examples

### ✅ Good: Mimic stub with return value

```python
from doublex import Mimic, Stub
from expects import equal, expect

from src.infrastructure.hello.hello_client import DummyHelloClient
from src.use_cases.say_hello_command import SayHelloCommand, SayHelloCommandHandler

def test_execute() -> None:
    name = "John"
    command = SayHelloCommand(name)
    with Mimic(Stub, DummyHelloClient) as hello_client:
        hello_client.get(name).returns(name)
    handler = SayHelloCommandHandler(hello_client)  # type: ignore

    response = handler.execute(command)

    expect(response.message()).to(equal(f"Hello, {name}!"))
```

### ✅ Good: Mimic stub raising an exception

```python
from expects import raise_error

def test_raise_exception() -> None:
    name = "John"
    command = SayHelloCommand(name)
    with Mimic(Stub, DummyHelloClient) as hello_client:
        hello_client.get(name).raises(SayHelloClientException(name))
    handler = SayHelloCommandHandler(hello_client)  # type: ignore

    expect(lambda: handler.execute(command)).to(
        raise_error(SayHelloCommandHandlerException)
    )
```

### ❌ Bad: using MagicMock directly

```python
from unittest.mock import MagicMock

def test_execute() -> None:
    mock_client = MagicMock()          # no interface enforcement
    mock_client.get.return_value = "John"
    handler = SayHelloCommandHandler(mock_client)
    ...
```

## 🧐 Real world examples

- `tests/unit/use_cases/test_say_hello_command.py`
- `tests/unit/use_cases/test_health_command.py`

## 🔗 Related agreements

- [Test Structure](test-structure.md)
- [Clean Architecture](../backend/clean-architecture.md)
