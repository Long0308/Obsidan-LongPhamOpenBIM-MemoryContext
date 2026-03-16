---
title: Auto Memory
tags:
  - skill
  - agent-swarm
  - memory
  - auto-memory
group: Backend & Infra
role: Session lifecycle — auto-save context to Obsidian + GitHub + Insforge DB
source: .agent/skills/auto-memory/SKILL.md
---

# Auto Memory

> [!abstract] Skill
> Auto-memory protocol. Triggered at session start and end. Saves session context to Obsidian notes + GitHub + Insforge DB. Monitors context window usage.

> [!important] Enforcement
> Core rules are **embedded in GEMINI.md TIER 0** — survives context truncation. Even if this file is never read, the protocol executes.

## Triggers
`auto` — Always-on protocol. No manual activation needed.

## Protocol Summary

### Session Start
1. Detect project name from workspace root
2. Auto-load past sessions: `GET /mem-gw-final/sessions?project={project}`
3. Read Obsidian session note: `Agent-Memory/session-{date}-{ide}-{project}.md`
4. Log: `🧠 Auto-loaded {n} past sessions for {project}`

### Checkpoints (every ~15 tool calls)
- **~50 calls** → `⚠️ Context ~60%`
- **~80 calls** → `🟠 Context ~80%` → auto-save → ASK user
- **~100 calls** → `🔴 Context ~95%` → save + STOP

### Session End
1. Update session note with final summary
2. `POST /mem-gw-final/save-session` with `push_github: true`
3. Log: `💾 Session saved`

## Connections
- **Core for:** ALL agents and skills
- **Storage:** [[InsForge Hub]] (PostgreSQL), GitHub, Obsidian
- **Config:** [[memory-config]]
- **Guides:** [[E2E-Setup-Guide]], [[Gemini Artifacts]]

## API Endpoints

| Method | Path | Usage |
|--------|------|-------|
| GET | `/mem-gw-final/health` | Health check |
| POST | `/mem-gw-final/save-session` | Save session |
| GET | `/mem-gw-final/sessions?project={p}` | List sessions |
| GET | `/mem-gw-final/context-stats` | Memory stats |

Base URL: `https://4ian5xm8.functions.insforge.app`

## Nhóm
Backend & Infra | [[InsForge Hub]] | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Links
- [[Agent-Memory]] — Memory system index
- [[E2E-Guide]] — Full E2E workflow
- [[memory-config]] — Configuration
