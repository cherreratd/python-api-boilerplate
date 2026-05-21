# 🎯 Test Structure

## 💡 Convention

Tests are split into three tiers, each with a distinct scope and speed profile. They live in `tests/unit/`, `tests/integration/`, and `tests/acceptance/`. Each tier is run independently via `make test-unit`, `make test-integration`, and `make test-acceptance`.

| Tier | What it tests | External services | Speed |
|------|--------------|-------------------|-------|
| `unit` | `CommandHandler` logic in isolation | None — all dependencies stubbed with doublex | Fast |
| `integration` | Concrete infrastructure implementations | Real external services (DBs, APIs) | Slower |
| `acceptance` | HTTP endpoints end-to-end | None — FastAPI `TestClient` only | Medium |

**Git hook enforcement:**
- Pre-commit: `checks + test-unit` (fast feedback loop).
- Pre-push: `test-integration + test-acceptance` (heavier, runs before sharing code).

**Mirror the `src/` layout:** test files mirror the path of what they test. A unit test for `src/use_cases/say_hello_command.py` lives at `tests/unit/use_cases/test_say_hello_command.py`.

## 🏆 Benefits

- Unit tests run in milliseconds — no waiting on I/O in the edit/test loop.
- Integration tests verify that infrastructure code works against real services, catching driver bugs and schema mismatches.
- Acceptance tests validate the full HTTP contract without requiring a running server process.
- Separate `make` targets let CI run tiers independently and fail fast.

## 👀 Examples

### ✅ Good: unit test stubbing the infrastructure layer

```python
# tests/unit/use_cases/test_say_hello_command.py
class TestSayHelloCommandHandler:
    def test_execute(self) -> None:
        name = "John"
        command = SayHelloCommand(name)
        with Mimic(Stub, DummyHelloClient) as hello_client:
            hello_client.get(name).returns(name)
        handler = SayHelloCommandHandler(hello_client)  # type: ignore

        response = handler.execute(command)

        expect(response.message()).to(equal(f"Hello, {name}!"))
```

### ✅ Good: acceptance test using FastAPI TestClient

```python
# tests/acceptance/delivery/api/test_hello_controller.py
class TestHelloControllerAcceptance:
    @pytest.fixture
    def client(self) -> TestClient:
        return TestClient(app)

    def test_hello_controller(self, client: TestClient) -> None:
        response = client.get(f"{settings.api_v1_prefix}/hello/peter")

        expect(response.status_code).to(equal(OK))
        expect(response.json()).to(equal({"message": "Hello, peter!"}))
```

### ❌ Bad: unit test hitting a real external service

```python
# tests/unit/use_cases/test_say_hello_command.py
def test_execute() -> None:
    # wrong tier — real client belongs in integration tests
    client = DummyHelloClient()
    handler = SayHelloCommandHandler(client)
    ...
```

## 🧐 Real world examples

- `tests/unit/use_cases/test_say_hello_command.py`
- `tests/integration/hello/test_dummy_hello_client_integration.py`
- `tests/acceptance/delivery/api/test_hello_controller.py`

## 🔗 Related agreements

- [Test Doubles](test-doubles.md)
- [Clean Architecture](../backend/clean-architecture.md)
