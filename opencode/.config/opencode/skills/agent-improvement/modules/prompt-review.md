# Module: Prompt Review

## Purpose

Review prompts, system instructions, agent instructions, and task prompts.

The goal is to find why the prompt causes weak agent behavior and propose better instructions.

## Good Prompt Criteria

A good agent prompt defines:

- role
- scope
- allowed actions
- forbidden actions
- input expectations
- output format
- success criteria
- routing/delegation rules
- validation requirements
- context budget rules
- uncertainty behavior
- stop conditions

## Prompt Antipatterns

Flag these:

### 1. Vague role

Bad:
```md
You are a helpful coding agent.
```

Better:

```md
You are a read-only repository explorer. You identify relevant files, architecture, and likely root causes. You must not edit files.
```

### 2. No stop condition

The prompt tells the agent what to do but not when to stop.

### 3. No evidence discipline

The prompt allows unsupported conclusions.

### 4. Too many responsibilities

One prompt combines exploration, implementation, testing, documentation, and architecture.

### 5. No output contract

The prompt does not specify the shape of the result.

### 6. No context budget

The prompt encourages reading everything.

### 7. No validation gate

The prompt does not require tests, builds, diff inspection, or confidence labeling.

### 8. No delegation boundary

The prompt does not say when to use or avoid subagents.

### 9. Conflicting instructions

The prompt contains rules that fight each other.

### 10. Overfit instructions

The prompt only works for one repo, one bug, or one tool.

## Review Method

For every prompt issue:

* quote or summarize the problematic instruction
* explain the behavior it likely causes
* propose a replacement
* keep patches short

## Output

```md
### Prompt Finding: ...

Problem: ...
Likely behavior caused: ...
Replacement:

```md
...
```
```
