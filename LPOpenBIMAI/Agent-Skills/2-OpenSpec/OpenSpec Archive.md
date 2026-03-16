---
title: OpenSpec Archive
tags:
  - skill
  - openspec
  - workflow
group: OpenSpec
role: Archive completed change — verify, sync specs, move to archive
source: .agent/skills/openspec-archive-change/SKILL.md
---

# OpenSpec Archive — Finalize & Archive

> [!abstract] Vai Trò
> Archive completed change: kiểm tra artifact/task completion → sync delta specs → move to archive directory.

## Steps

### 1. Select Change
- If not provided → `openspec list --json` → ask user
- Show only active (not archived) changes
- **NEVER auto-select** — always let user choose

### 2. Check Artifact Completion
```bash
openspec status --change "<name>" --json
```
- If any artifacts NOT `done` → warn + confirm proceed

### 3. Check Task Completion
Read `tasks.md` → count `- [ ]` vs `- [x]`
- Incomplete tasks → warn + confirm proceed
- No tasks file → proceed

### 4. Assess Delta Spec Sync
Check `openspec/changes/<name>/specs/` for delta specs.

**If delta specs exist:**
- Compare deltas with main specs at `openspec/specs/<capability>/spec.md`
- Show combined summary (adds, modifications, removals)
- Prompt: "Sync now (recommended)" or "Archive without syncing"

### 5. Perform Archive
```bash
mkdir -p openspec/changes/archive
mv openspec/changes/<name> openspec/changes/archive/YYYY-MM-DD-<name>
```

- Check target doesn't already exist
- Preserve `.openspec.yaml`

### 6. Display Summary
```
## Archive Complete
Change: <name>
Schema: <schema-name>
Archived to: openspec/changes/archive/YYYY-MM-DD-<name>/
Specs: ✓ Synced (or "No delta specs" or "Sync skipped")
```

## Guardrails
- Always prompt for change selection
- Use artifact graph for completion checking
- Don't block archive on warnings — inform + confirm
- Preserve `.openspec.yaml` when moving
- Show clear summary

## Connections
- **Preceded by:** [[OpenSpec Apply]]
- **Related:** [[OpenSpec Explore]], [[OpenSpec Propose]]

## Nhóm
OpenSpec | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
