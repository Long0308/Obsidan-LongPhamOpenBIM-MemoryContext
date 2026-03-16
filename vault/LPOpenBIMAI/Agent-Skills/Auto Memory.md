---
tags:
  - skill
  - agent-swarm
  - memory
source: .agent/skills/auto-memory/SKILL.md
---

# Auto Memory

> [!abstract] Skill
> Auto-memory protocol. Session lifecycle management: auto-save to Obsidian + GitHub + Insforge DB. Context window monitoring with self-tracking heuristics.

## Cách hoạt động

### Session Lifecycle
```
SESSION START → Create/load session note
     ↓
PERIODIC (~15 tool calls) → Checkpoint summary
     ↓  
SESSION END → Push GitHub + Sync Insforge DB
```

### Context Window Monitor
- **~60%** (50 tool calls) → Warning text
- **~80%** (80 tool calls) → Auto-checkpoint
- **~95%** (100 tool calls) → Save + suggest new session

### Cách thông báo
Agent tự include alert text trong response — không cần external tool, không vi phạm IDE policy.

## Config

Chỉnh tại → [[memory-config|Memory Configuration]]

## Connections
- **Syncs to:** [[AGENT_SWARM|Agent Swarm MOC]]
- **Uses:** Insforge DB, GitHub API
- **Schedule:** Cron mỗi 2h (editable)

## Memory Integration
- `POST /save-session` → Save session + push GitHub
- `GET /sessions` → List sessions by project/IDE
- `GET /context-stats` → Memory stats
- `POST /sync-github` → Cron-triggered GitHub sync
