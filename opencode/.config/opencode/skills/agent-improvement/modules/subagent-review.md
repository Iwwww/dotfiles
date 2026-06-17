# Module: Subagent Review

## Purpose

Analyze whether subagents were used correctly.

This module applies both when subagents were used and when they should have been used but were not.

## Subagent Usage Criteria

### Explorer

Use when:
- repo area is unknown
- broad read-only investigation is needed
- multiple files need to be mapped
- the main agent risks polluting context with exploration

Do not use when:
- the target file is already known
- the task is a tiny local edit
- the question can be answered from existing context

### Implementer

Use when:
- the change is narrow and well-specified
- target files are known
- expected behavior is clear
- validation command is known

Do not use when:
- root cause is unknown
- requirements are unstable
- implementation requires ongoing architectural decisions

### Tester / Verifier

Use when:
- code was changed
- behavior must be confirmed
- previous attempts failed
- user-visible behavior matters
- regression risk exists

Do not use when:
- no executable validation exists
- the change is purely textual and obvious

### Ideation

Use when:
- the main agent is stuck
- multiple strategies are plausible
- the current plan is looping
- architectural tradeoffs are unclear

Do not use when:
- the next action is obvious
- implementation has already started and scope is stable

## Evaluation

For each subagent call, check:

- Was the role appropriate?
- Was the input specific enough?
- Did it have the right permissions?
- Did it duplicate main-agent work?
- Did it reduce or increase context load?
- Was its output integrated?
- Was its output verified?

## Classifications

Use one:

- `useful`
- `partially useful`
- `unnecessary`
- `harmful`
- `missing but recommended`

## Common Delegation Antipatterns

- Delegating vague tasks
- Asking multiple subagents the same broad question
- Using Implementer before root cause is known
- Using Explorer after target files are already known
- Ignoring subagent results
- Letting subagents mutate files without scope boundaries
- No verifier after implementation
- Treating subagent output as truth without checking

## Output

```md
### Subagent Finding: ...

Subagent: ...
Classification: ...
Evidence: ...
Impact: ...
Better delegation rule: ...

Suggested rule patch:

```md
...
```
```
