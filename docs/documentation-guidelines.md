# 🎯 Documentation Standard

## 💡 Convention

Every project convention must be documented as a standalone Markdown file inside the `docs/` folder, organized by area (`backend/`, `testing/`, `database/`, etc.). Each document follows a fixed structure with these sections in order: Convention, Benefits, Examples (good and bad), Real world examples, and Related agreements.

The goal is to provide AI agents and developers with self-contained, discoverable references that require no extra context to understand.

## 🏆 Benefits

- AI agents load only the docs relevant to the task at hand, reducing noise.
- Each doc is independently reviewable in PRs, making convention changes easy to track.
- The fixed structure guarantees completeness — no convention is documented without a rationale and a concrete example.

## 👀 Examples

### ✅ Good: standalone convention file with full structure

```markdown
# 🎯 Name of the convention

## 💡 Convention

What the rule is and when it applies.

## 🏆 Benefits

- Why this convention exists.

## 👀 Examples

### ✅ Good: description of a correct example

<code example>

### ❌ Bad: description of an incorrect example

<code example>

## 🧐 Real world examples

- Link to a file in the repo that applies this convention.

## 🔗 Related agreements

- Link to related docs if applicable.
```

### ❌ Bad: convention buried in a monolithic file

```markdown
# Project Guidelines

## Architecture
We use clean architecture...

## Testing
Use doublex for stubs...

## Code style
120 char line length...
```

## 🧐 Real world examples

- `docs/backend/clean-architecture.md`
- `docs/testing/test-doubles.md`

## 🔗 Related agreements

- All docs inside `docs/` must follow this standard.
- Use the `create-doc` skill to generate new docs automatically.
