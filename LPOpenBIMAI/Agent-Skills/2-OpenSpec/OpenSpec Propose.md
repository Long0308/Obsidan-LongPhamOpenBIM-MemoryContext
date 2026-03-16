---
title: OpenSpec Propose
tags:
  - skill
  - openspec
  - workflow
group: OpenSpec
role: Tạo change proposal với all artifacts trong 1 step
source: .agent/skills/openspec-propose/SKILL.md
---

# OpenSpec Propose — One-Step Change Proposal

> [!abstract] Vai Trò
> Tạo change mới với all artifacts (proposal.md, design.md, tasks.md) trong 1 bước. User mô tả muốn build gì → nhận proposal hoàn chỉnh ready for implementation.

## Input

User request có tên change (kebab-case) HOẶC mô tả muốn build gì.

Nếu không rõ → hỏi: "What change do you want to work on?"

## Steps

### 1. Clarify Input
Nếu chưa rõ → hỏi user. Từ mô tả → derive kebab-case name.

### 2. Create Change Directory
```bash
openspec new change "<name>"
```
→ Creates `openspec/changes/<name>/` with `.openspec.yaml`

### 3. Get Build Order
```bash
openspec status --change "<name>" --json
```
→ `applyRequires`: artifacts needed before implementation
→ `artifacts`: all artifacts with status/dependencies

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
- If unclear → ask user, but prefer reasonable decisions
- If change exists → ask continue or new
- Verify each artifact file after writing

## Connections
- **Preceded by:** [[OpenSpec Explore]]
- **Followed by:** [[OpenSpec Apply]]
- **Related:** [[OpenSpec Archive]]

## Nhóm
OpenSpec | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
