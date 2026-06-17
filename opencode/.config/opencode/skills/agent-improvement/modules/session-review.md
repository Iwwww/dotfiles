# Module: Session Review

## Purpose

Review one completed or failed agent session.

Do not solve the task again. Analyze the process.

## Checkpoints

### 1. Goal alignment

Check:

- Did the agent preserve the user's original goal?
- Did the agent respect constraints?
- Did it drift into side tasks?
- Did it ask unnecessary questions?
- Did it stop too early?
- Did it continue after the task was already solved?

### 2. Planning

Check:

- Was there a clear initial plan?
- Was the plan updated after evidence changed?
- Did the agent separate exploration, implementation, and validation?
- Did it define success criteria?
- Did it choose the smallest safe change?

### 3. Execution

Check:

- Did the agent inspect the right files first?
- Did it use targeted search?
- Did it avoid repeated failed attempts?
- Did it avoid broad changes when narrow changes were enough?
- Did it preserve rollback ability?

### 4. Finalization

Check:

- Did the agent inspect the final diff?
- Did it run relevant validation?
- Did it clearly state what changed?
- Did it honestly state what was not verified?

## Common Session Antipatterns

- Solving before understanding
- Repeated exploration without synthesis
- Repeated command failure without new hypothesis
- Over-reading files
- Editing too many files for a narrow issue
- No final diff check
- No validation
- Generic final answer
- Confusing progress log with actual result

## Output

Return only high-impact findings.

For each finding:

```md
### Finding: ...

Type: session
Evidence: ...
Impact: ...
Better behavior: ...
Patch candidate: ...
```
