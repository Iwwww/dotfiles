---
name: agent-improvement
description: Use when reviewing completed/failed agent runs, subagent usage, context management, prompts, skills, workflow rules, validation strategy, hooks, or memory behavior to produce concrete improvement patches.
---

# Universal Agent Improvement Skill

## Purpose

This skill analyzes agentic work and agent instructions.

It can review:

- completed agent sessions
- failed or inefficient runs
- subagent usage
- context management
- prompts
- skills
- agent definitions
- workflow rules
- validation strategy
- hooks and memory behavior

The output must be concrete improvement patches, not generic advice.

## Core Principle

Do not re-solve the original task.

Analyze how the agent system behaved, why it behaved that way, and what instruction, routing, prompt, skill, hook, or workflow changes would improve future runs.

## Default Mode

Start with the embedded Agent Improvement Router below.

The router decides which review modules are needed.

Only load modules relevant to the audit target.

Avoid loading all logs, all files, or all skills unless the router decides they are necessary.

## Read-only Constraint

This skill is read-only by default.

It may propose patches, but must not directly edit files unless explicitly instructed by the user.

# Agent Improvement Router

## Role

You are the main router for agent improvement analysis.

Your job is to classify the review target, select the minimal necessary modules, and produce a compact evidence-based improvement report.

You must not immediately perform a full audit. First determine what kind of audit is needed.

## Supported Audit Targets

Classify the input into one or more target types:

1. `session_review`
   - A completed or failed agent run needs review.

2. `subagent_review`
   - The user wants to analyze delegation, subagent usage, or multi-agent workflow.

3. `context_review`
   - The user wants to analyze context loss, context pollution, stale assumptions, memory issues, or excessive file/log reading.

4. `prompt_review`
   - The user wants to improve a prompt, system instruction, agent instruction, or orchestration prompt.

5. `skill_review`
   - The user wants to analyze a skill file or skill architecture.

6. `workflow_review`
   - The user wants to improve the overall agentic development loop, hooks, task memory, roadmap, validation gates, or autonomous mode.

7. `validation_review`
   - The user wants to analyze testing, verification, CI, build checks, or final confidence.

8. `patch_generation`
   - The user wants concrete edits to prompts, skills, AGENTS.md, hooks, routing rules, or memory files.

## Routing Rules

Use the minimum number of modules.

Examples:

- If reviewing one bad agent run:
  - use `session_review`
  - use `context_review`
  - use `validation_review`
  - use `patch_generation`

- If reviewing subagents:
  - use `subagent_review`
  - use `context_review`
  - use `patch_generation`

- If reviewing a skill file:
  - use `skill_review`
  - use `prompt_review`
  - use `patch_generation`

- If reviewing a whole agent architecture:
  - use `workflow_review`
  - use `subagent_review`
  - use `context_review`
  - use `skill_review`
  - use `patch_generation`

## Evidence Budget

Before reading large inputs, create an evidence plan.

Classify available evidence:

- `primary`: transcript, final diff, tool logs, subagent outputs, prompt/skill text
- `secondary`: memory files, roadmap, TODOs, user comments
- `optional`: full logs, full repo scans, historical sessions

Read primary evidence first.

Do not read full logs unless:
- the failure cannot be explained from primary evidence
- the user specifically requests deep audit
- the log contains the only source of truth

## Output Modes

Choose one:

### Compact mode

Use when the user asks for quick review or the evidence is limited.

Output:
- verdict
- top problems
- top patches

### Standard mode

Use by default.

Output:
- audit target
- evidence used
- findings
- patches
- next checks

### Deep mode

Use only when explicitly requested or when reviewing a full autonomous run.

Output:
- timeline
- module-by-module review
- scoring
- detailed patches
- regression-prevention rules

## Mandatory Reasoning Discipline

Every important claim must be tagged as one of:

- `Evidence`: directly observed
- `Inference`: likely explanation from evidence
- `Recommendation`: proposed change
- `Low confidence`: insufficient evidence

Do not invent missing information.

Do not give generic advice.

Do not praise or blame the agent. Diagnose behavior.

## Final Report Template

```md
# Agent Improvement Review

## Audit Target

...

## Evidence Used

- ...

## Verdict

Process quality: X/10  
Main failure mode: ...  
Most valuable fix: ...

## Findings

### 1. ...

Type: session / context / prompt / skill / subagent / validation / workflow  
Evidence: ...  
Impact: ...  
Recommendation: ...

## Concrete Patches

### Patch 1: ...

```md
...
```

### Patch 2: ...

```md
...
```

## What Not To Change

* ...

## Follow-up Checks

* ...
```
