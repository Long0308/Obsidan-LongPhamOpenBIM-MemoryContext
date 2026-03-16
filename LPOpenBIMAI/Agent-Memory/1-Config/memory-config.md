---
parent: "[[Agent-Memory]]"
group: "Config & Rules"
title: Memory Configuration
tags:
  - memory
  - config
  - agent-swarm
type: config
---
group: "Config & Rules"
# ⚙️ Memory Configuration

> [!tip] Editable
> Chỉnh trực tiếp trong Obsidian. Agent sẽ đọc file này mỗi session start.

## Sync Settings

| Key | Value | Mô tả |
|-----|-------|-------|
| **sync_interval** | `2h` | Tần suất auto-sync (cron: `0 */2 * * *`) |
| **github_repo** | `Long0308/Obsidan-LongPhamOpenBIM-MemoryContext` | GitHub repo target |
| **github_branch** | `main` | Branch để push |
| **insforge_project** | `LongPhamOpenBIM-MemoryContext` | Insforge project ID |
| **context_warn_pct** | `60` | % context → hiện warning |
| **context_alert_pct** | `80` | % context → auto-save checkpoint |
| **context_critical_pct** | `95` | % context → save + suggest new session |

## Session Naming

```
Pattern: session-{YYYY-MM-DD}-{ide}-{project}.md
```

| Variable | Source | Ví dụ |
|----------|--------|-------|
| `{date}` | System date | `2026-03-15` |
| `{ide}` | IDE metadata | `antigravity`, `cursor`, `codex`, `claude`, `gemini` |
| `{project}` | Workspace folder name | `LPOpenBIMAI`, `RevitAPI`, `Gateway` |

## Sync Targets

- [x] **Obsidian** — `Agent-Memory/` (primary, luôn bật)
- [x] **GitHub** — `sessions/` folder trong repo
- [x] **Insforge DB** — `memories` table

## What Gets Saved

| Data | Target | Tần suất |
|------|--------|----------|
| Session notes | Obsidian + GitHub | Mỗi checkpoint + end-of-session |
| Key decisions | Insforge DB | End-of-session |
| Entity updates | Insforge DB | Khi có thay đổi lớn |
| Context snapshots | GitHub | End-of-session |

## Để thay đổi sync interval

1. Sửa `sync_interval` trong bảng trên (vd: `1h`, `4h`, `6h`)
2. Agent sẽ tự update Insforge cron schedule trong session tiếp theo

## Links

- [[AGENT_SWARM|Agent Swarm MOC]]
- [[E2E-Guide|E2E Guide]]
