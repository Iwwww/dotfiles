# Module: Context Review

## Purpose

Analyze context loss, context pollution, stale assumptions, and memory failures.

## Context Failure Types

### Context loss

The agent forgot or ignored:

- user constraints
- previous findings
- selected approach
- current objective
- known errors
- established file locations
- decisions already made

### Context pollution

The agent added unnecessary material to working context:

- huge logs
- irrelevant files
- repeated file contents
- broad search results
- obsolete hypotheses
- long subagent outputs
- copied documentation without synthesis

### Stale assumption

The agent kept acting on an assumption after evidence contradicted it.

### Missing synthesis

The agent gathered information but did not compress it into a usable state.

### Bad memory update

The agent failed to update task memory, roadmap, decision log, or current status.

## Context Hygiene Rules

Prefer this pattern:

```md
After every exploration burst, write a short synthesis:

Known:
- ...

Unknown:
- ...

Next check:
- ...

Stop condition:
- ...
```

Before reading more large files, ask:

* What exact question will this file answer?
* Is there a cheaper search?
* Have I already read equivalent evidence?
* Should this be delegated to Explorer?
* Should current findings be compressed first?

## Common Context Antipatterns

* Reading logs before defining the question
* Reading many files without a synthesis checkpoint
* Carrying forward old guesses
* Keeping multiple competing hypotheses without pruning
* Re-reading the same files
* Mixing unrelated project context into the current task
* Passing too much context to subagents
* Passing too little context to subagents

## Output

```md
### Context Finding: ...

Failure type: context loss / pollution / stale assumption / missing synthesis / bad memory update
Evidence: ...
Impact: ...
Fix:
...
Instruction patch:
```md
...
```
```
