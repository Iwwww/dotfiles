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

Start with `router.md`.

The router decides which review modules are needed.

Only load modules relevant to the audit target.

Avoid loading all logs, all files, or all skills unless the router decides they are necessary.

## Read-only Constraint

This skill is read-only by default.

It may propose patches, but must not directly edit files unless explicitly instructed by the user.
