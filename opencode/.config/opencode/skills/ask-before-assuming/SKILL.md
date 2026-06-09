---
name: ask-before-assuming
description: Use when a task has user-owned ambiguity: public behavior, API compatibility, data, migrations, architecture, dependencies, security, UX, or scope. Ask targeted questions before guessing.
---

# Ask Before Assuming

Use this skill when a decision affects user-facing behavior, public APIs, data shape, persistence, migrations, architecture, dependencies, security, performance, UX, or task scope.

Do not use it for local, reversible, low-risk implementation choices that follow existing project style.

## Rule

Ask before choosing when the decision belongs to the user or materially changes behavior.

Do not ask just because multiple internal implementations are possible.

## Workflow

1. Inspect enough context to identify the real decision.
2. If the choice is local and low-risk, proceed with the smallest correct change.
3. If the choice affects behavior, scope, architecture, data, compatibility, or UX, stop and ask.
4. Prefer the `question` tool.
5. Offer 2-4 concrete options.
6. Put the recommended option first with `(Recommended)`.
7. Continue only after the user answers.

## Question Tool

Ask one focused question per decision. If multiple decisions are independent, ask the blocking one first.

Use this shape:

```json
{
  "questions": [
    {
      "header": "Decision",
      "question": "Which direction should I use?",
      "options": [
        {
          "label": "Minimal patch (Recommended)",
          "description": "Change only what is needed."
        },
        {
          "label": "Small refactor",
          "description": "Clean up nearby code too."
        }
      ],
      "multiple": false
    }
  ]
}
```

If the tool is unavailable, ask the same question in plain text.

## Examples

Ask: global vs project-local, compatibility vs API simplification, minimal fix vs refactor.

Do not ask: local variable names, obvious existing patterns, small reversible internal changes.

## Defaults

When not asking: prefer minimal changes, preserve behavior, follow local style, avoid new dependencies, public API changes, and broad refactors.
