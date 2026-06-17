# Module: Patch Generator

## Purpose

Convert findings into concrete reusable improvements.

Every important finding should produce at least one patch type.

## Patch Types

### 1. Prompt patch

Use for agent instruction changes.

```md
Add to <agent-name>:

...
```

### 2. Skill patch

Use for skill behavior changes.

```md
Add to <skill-name>:

...
```

### 3. Routing patch

Use for delegation or skill activation changes.

```md
Route to <module/agent> when ...
Do not route when ...
```

### 4. Hook patch

Use for lifecycle automation.

```md
After <event>, run:
...
```

### 5. Checklist patch

Use for repeated human/agent checks.

```md
Before final answer:
- ...
- ...
```

### 6. Memory patch

Use for task memory or roadmap updates.

```md
Maintain these fields:
- Current objective:
- Constraints:
- Known facts:
- Changed files:
- Validation:
- Open risks:
```

## Patch Quality Criteria

A good patch is:

* short
* specific
* enforceable
* copy-pastable
* tied to evidence
* not overfit to one incident
* not vague advice

Bad:

```md
Use better context management.
```

Good:

```md
Before reading a fourth file during exploration, write a 5-line synthesis:
Known / Unknown / Next check / Stop condition / Delegation needed.
```

## Output

Group patches by destination:

```md
## Concrete Patches

### AGENTS.md

```md
...
```

### Orchestrator

```md
...
```

### Explorer

```md
...
```

### Implementer

```md
...
```

### Hooks

```md
...
```

### Skills

```md
...
```
```
