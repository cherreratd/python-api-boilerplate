---
name: create-doc
description: Create or improve a convention doc based on the current conversation. Use this when a new pattern or decision has been established and should be persisted in docs/.
---

Based on the current conversation, create a new or improve an existing convention document inside `docs/`.

## Steps

1. Identify the convention, pattern, or decision that emerged from the conversation.
2. Check if a relevant doc already exists in `docs/` (organized by area: `backend/`, `testing/`, `database/`, etc.).
   - If it exists: improve it while preserving the required structure.
   - If it does not exist: create a new file in the appropriate subfolder.
3. Read `docs/documentation-guidelines.md` and follow its structure exactly. Every document MUST include these sections in order:

```
# 🎯 Name of the convention

## 💡 Convention
## 🏆 Benefits
## 👀 Examples (with ✅ Good and ❌ Bad subsections)
## 🧐 Real world examples
## 🔗 Related agreements
```

4. Ask the user to confirm the target file path before writing.
5. Update the docs map in `AGENTS.md` if a new file was created.

## Rules

- One convention per file — never bundle multiple conventions into one doc.
- Place the file in the correct area subfolder (`backend/`, `testing/`, `database/`, etc.).
- Include concrete ✅ Good and ❌ Bad code examples with Python code blocks.
- Link to real files in the codebase in the "Real world examples" section.
- Use the `src/` layout to find canonical examples of the convention being documented.
