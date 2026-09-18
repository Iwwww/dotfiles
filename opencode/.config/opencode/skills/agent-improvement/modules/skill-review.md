# Module: Skill Review

## Purpose

Review skill files and skill architecture.

A skill is not just a prompt. It is an operational procedure that an agent can reliably apply.

## Good Skill Criteria

A good skill should have:

1. Clear purpose
2. Clear activation conditions
3. Non-activation conditions
4. Minimal required inputs
5. Step-by-step procedure
6. Evidence discipline
7. Output contract
8. Stop conditions
9. Failure handling
10. Context budget
11. Examples
12. Boundaries with other skills
13. Patch/update mechanism

## Skill Antipatterns

### 1. Monolithic skill

One skill handles too many unrelated situations.

Fix:
- split into modules
- add a router
- load only relevant modules

### 2. No trigger rules

The agent does not know when to use the skill.

Fix:
```md
Use this skill when ...
Do not use this skill when ...
```

### 3. No input contract

The skill assumes all evidence is available.

Fix:

```md
Required inputs:
- ...
Optional inputs:
- ...
If missing:
- mark as low-confidence
```

### 4. No output schema

The agent produces inconsistent reports.

Fix:

* define a strict report format
* define severity/confidence labels

### 5. Generic advice generator

The skill outputs abstract advice.

Fix:

* require concrete patches
* require evidence
* require copy-pastable instruction changes

### 6. Excessive context consumption

The skill asks to read everything.

Fix:

* evidence budget
* progressive loading
* primary/secondary/optional evidence

### 7. No stop condition

The skill keeps analyzing forever.

Fix:

```md
Stop after the top 5 high-impact findings unless the user requests deep mode.
```

### 8. No relation to other skills

The skill conflicts with existing agents or duplicates them.

Fix:

* define boundaries
* define routing
* define escalation

### 9. No regression prevention

The skill finds problems but does not prevent recurrence.

Fix:

* convert findings into rules, hooks, checklists, or tests

## Output

```md
### Skill Finding: ...

Antipattern: ...
Evidence: ...
Why it matters: ...
Patch:

```md
...
```
```
