# Module: Validation Review

## Purpose

Review whether the agent verified its work correctly.

## Validation Levels

Use one:

- `none`: no validation
- `weak`: superficial check only
- `partial`: some relevant checks, but important gaps remain
- `strong`: relevant checks passed and final diff was inspected
- `blocked`: validation was impossible; reason was documented

## Checkpoints

- Was a validation command identified before implementation?
- Were tests/build/lint/typecheck run?
- Were failures interpreted correctly?
- Were pre-existing failures separated from introduced failures?
- Was the final diff inspected?
- Was user-visible behavior checked?
- Were unverified assumptions disclosed?

## Common Validation Antipatterns

- No tests after code changes
- Running unrelated tests
- Treating compile success as behavior success
- Ignoring failing tests
- Not checking final diff
- Not checking generated files
- Saying “should work” without evidence
- Hiding validation gaps

## Output

```md
### Validation Finding: ...

Validation level: none / weak / partial / strong / blocked
Evidence: ...
Risk: ...
Better validation:
...
Patch:
```md
...
```
```
