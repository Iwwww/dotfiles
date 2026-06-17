# Evidence Model

Every non-obvious finding must separate evidence from inference.

## Labels

### Evidence

Something directly visible in the transcript, diff, logs, prompt, skill, or tool output.

### Inference

A likely explanation based on evidence.

### Recommendation

A proposed improvement.

### Low confidence

The evidence is incomplete.

## Required Format

```md
Evidence:
- ...

Inference:
- ...

Recommendation:
- ...
```

## Rules

* Do not invent evidence.
* Do not infer intent when behavior is enough.
* Do not claim a subagent was unnecessary unless the task could clearly be done cheaper without it.
* Do not claim a missing subagent was needed unless it would reduce risk, context, or repeated work.
* Mark uncertain claims as low-confidence.
