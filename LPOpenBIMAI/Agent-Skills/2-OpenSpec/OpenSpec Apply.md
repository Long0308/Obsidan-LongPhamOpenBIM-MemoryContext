---
title: OpenSpec Apply
tags:
  - agent-skill
  - skill
  - openspec
  - workflow
group: OpenSpec
role: Implement tasks tá»« OpenSpec change â€” loop through tasks
source: .agent/skills/openspec-apply-change/SKILL.md
---

# OpenSpec Apply â€” Implement Tasks

> [!abstract] Vai TrÃ²
> Implement tasks tá»« má»™t OpenSpec change. Loop qua tasks cho Ä‘áº¿n khi done hoáº·c blocked.

## Steps

### 1. Select Change
- Name provided â†’ use it
- Infer from context
- Auto-select náº¿u chá»‰ 1 active change
- Ambiguous â†’ `openspec list --json` â†’ ask user

Announce: "Using change: `<name>`"

### 2. Check Status
```bash
openspec status --change "<name>" --json
```
â†’ `schemaName`, artifact statuses

### 3. Get Apply Instructions
```bash
openspec instructions apply --change "<name>" --json
```
â†’ Context files, progress, task list, dynamic instruction

**Handle states:**
- `blocked` â†’ suggest continue-change
- `all_done` â†’ suggest archive
- Otherwise â†’ implement

### 4. Read Context Files
Read files from `contextFiles` in apply output (varies by schema)

### 5. Show Progress
- Schema in use
- "N/M tasks complete"
- Remaining tasks
- Dynamic instruction

### 6. Implement Tasks (Loop)

For each pending task:
1. Show which task
2. Make code changes (minimal, focused)
3. Mark complete: `- [ ]` â†’ `- [x]`
4. Continue to next

**Pause if:**
- Task unclear â†’ ask
- Design issue â†’ suggest updating artifacts
- Error/blocker â†’ report + wait
- User interrupts

### 7. Show Status On Completion/Pause

**Complete:**
```
## Implementation Complete
Change: <name> | Progress: 7/7 âœ“
All tasks complete! Ready to archive.
```

**Paused:**
```
## Implementation Paused
Progress: 4/7 | Issue: <description>
Options: 1. ... 2. ... 3. Other approach
```

## Guardrails
- Keep going until done or blocked
- Read context files BEFORE starting
- Pause on ambiguity â€” don't guess
- Keep changes minimal per task
- Update checkbox immediately after each task
- Supports fluid workflow (not phase-locked)

## Connections
- **Preceded by:** [[OpenSpec Propose]]
- **Followed by:** [[OpenSpec Archive]]
- **Related:** [[OpenSpec Explore]]

## NhÃ³m
OpenSpec | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
