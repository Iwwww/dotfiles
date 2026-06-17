# Module: Workflow Review

## Purpose

Review the overall agentic workflow, not just one prompt or one session.

This includes:

- orchestrator behavior
- task memory
- roadmap
- hooks
- autonomous runs
- subagent lifecycle
- validation gates
- final reporting
- context compaction

## Workflow Checkpoints

### 1. Task lifecycle

A robust task should move through:

```text
intake -> exploration -> plan -> implementation -> validation -> final report -> retrospective
```

Flag skipped or merged phases when they caused problems.

### 2. Memory

Check whether the system maintains:

* current objective
* constraints
* known facts
* decisions
* changed files
* validation commands
* open risks
* next actions

### 3. Hooks

Useful hooks may include:

* after tool burst: synthesize findings
* before edit: check target file and rollback plan
* after edit: update changed-files list
* after tests: record result and failure reason
* before final: inspect diff and validation status
* after task: run retrospective

### 4. Gates

Recommended gates:

* Do not implement before root cause or target files are known.
* Do not delegate implementation without scope and validation command.
* Do not final-answer after code changes without diff inspection.
* Do not read large logs without an evidence question.
* Do not continue exploration after enough evidence without synthesis.

## Output

```md
### Workflow Finding: ...

Problem: ...
Evidence: ...
Impact: ...
Workflow patch:

```md
...
```
```
