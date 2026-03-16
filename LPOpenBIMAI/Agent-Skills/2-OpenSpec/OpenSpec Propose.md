---
title: OpenSpec Propose
tags:
  - agent-skill
  - skill
  - openspec
  - workflow
group: OpenSpec
role: Táº¡o change proposal vá»›i all artifacts trong 1 step
source: .agent/skills/openspec-propose/SKILL.md
---

# OpenSpec Propose â€” One-Step Change Proposal

> [!abstract] Vai TrÃ²
> Táº¡o change má»›i vá»›i all artifacts (proposal.md, design.md, tasks.md) trong 1 bÆ°á»›c. User mÃ´ táº£ muá»‘n build gÃ¬ â†’ nháº­n proposal hoÃ n chá»‰nh ready for implementation.

## Input

User request cÃ³ tÃªn change (kebab-case) HOáº¶C mÃ´ táº£ muá»‘n build gÃ¬.

Náº¿u khÃ´ng rÃµ â†’ há»i: "What change do you want to work on?"

## Steps

### 1. Clarify Input
Náº¿u chÆ°a rÃµ â†’ há»i user. Tá»« mÃ´ táº£ â†’ derive kebab-case name.

### 2. Create Change Directory
```bash
openspec new change "<name>"
```
â†’ Creates `openspec/changes/<name>/` with `.openspec.yaml`

### 3. Get Build Order
```bash
openspec status --change "<name>" --json
```
â†’ `applyRequires`: artifacts needed before implementation
â†’ `artifacts`: all artifacts with status/dependencies

### 4. Create Artifacts in Sequence

Loop through dependency order:

For each `ready` artifact:
```bash
openspec instructions <artifact-id> --change "<name>" --json
```

Returns: `context`, `rules`, `template`, `instruction`, `outputPath`, `dependencies`

- Read completed dependencies for context
- Create artifact using `template` as structure
- Apply `context` + `rules` as constraints (NOT in output)
- Continue until all `applyRequires` are `done`

### 5. Show Final Status
```bash
openspec status --change "<name>"
```

## Output

- Change name and location
- List of artifacts created
- "All artifacts created! Ready for implementation."
- "Run `/opsx:apply` to start working on tasks."

## Artifact Guidelines

- Follow `instruction` field for each artifact type
- Read dependency artifacts BEFORE creating new ones
- `template` = structure for output file
- `context` + `rules` = constraints for YOU, NOT content for file

> [!warning] Never copy `<context>`, `<rules>`, `<project_context>` blocks into artifacts

## Guardrails
- Create ALL artifacts needed for implementation
- Read dependencies before creating
- If unclear â†’ ask user, but prefer reasonable decisions
- If change exists â†’ ask continue or new
- Verify each artifact file after writing

## Connections
- **Preceded by:** [[OpenSpec Explore]]
- **Followed by:** [[OpenSpec Apply]]
- **Related:** [[OpenSpec Archive]]

## NhÃ³m
OpenSpec | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
