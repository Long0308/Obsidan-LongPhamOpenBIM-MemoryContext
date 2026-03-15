---
title: OpenSpec Apply
tags:
  - skill
  - openspec
  - workflow
group: OpenSpec
role: Implement tasks từ OpenSpec change — loop through tasks
source: .agent/skills/openspec-apply-change/SKILL.md
---

# OpenSpec Apply — Implement Tasks

> [!abstract] Vai Trò
> Implement tasks từ một OpenSpec change. Loop qua tasks cho đến khi done hoặc blocked.

## Steps

### 1. Select Change
- Name provided → use it
- Infer from context
- Auto-select nếu chỉ 1 active change
- Ambiguous → `openspec list --json` → ask user

Announce: "Using change: `<name>`"

### 2. Check Status
```bash
openspec status --change "<name>" --json
```
→ `schemaName`, artifact statuses

### 3. Get Apply Instructions
```bash
openspec instructions apply --change "<name>" --json
```
→ Context files, progress, task list, dynamic instruction

**Handle states:**
- `blocked` → suggest continue-change
- `all_done` → suggest archive
- Otherwise → implement

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
3. Mark complete: `- [ ]` → `- [x]`
4. Continue to next

**Pause if:**
- Task unclear → ask
- Design issue → suggest updating artifacts
- Error/blocker → report + wait
- User interrupts

### 7. Show Status On Completion/Pause

**Complete:**
```
## Implementation Complete
Change: <name> | Progress: 7/7 ✓
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
- Pause on ambiguity — don't guess
- Keep changes minimal per task
- Update checkbox immediately after each task
- Supports fluid workflow (not phase-locked)

## Connections
- **Preceded by:** [[OpenSpec Propose]]
- **Followed by:** [[OpenSpec Archive]]
- **Related:** [[OpenSpec Explore]]

## Nhóm
OpenSpec | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
