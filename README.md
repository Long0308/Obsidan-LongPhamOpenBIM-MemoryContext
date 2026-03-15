# 🧠 LPOpenBIM AI — Obsidian Agent Memory System

> **An AI cofounding workspace** — Obsidian vault powering intelligent agent memory, session tracking, quota monitoring, and multi-agent orchestration.

## 📋 Architecture

```
d:\10.Obsidan/
├── .agent/                    # Agent rules + skills (always-on)
│   ├── rules/GEMINI.md        # Core AI behavior rules
│   └── skills/                # 50+ modular skills
│       ├── auto-memory/       # Session lifecycle protocol
│       ├── intelligent-routing/ # Auto agent selection
│       └── ...
├── LPOpenBIMAI/               # Main Obsidian vault
│   ├── Agent-Memory/          # Memory system
│   │   ├── dashboard.html     # Live monitoring dashboard
│   │   ├── sync-quotas.ps1    # Quota sync script
│   │   └── session notes      # Per-session context
│   ├── Agent-Skills/          # 50+ skill documentation notes
│   ├── Agent-Plugins/         # Plugin documentation
│   ├── Agent-Agents/          # Agent profiles
│   ├── Platforms/             # Platform hubs
│   └── Resources/             # Reference materials
└── insforge/                  # Backend (InsForge)
    ├── functions/
    │   ├── mem-gw-final/      # Edge function v2.2 (deployed)
    │   ├── memory-gateway/    # Full version (reference)
    │   └── quota-api/         # Quota API
    └── *.sql                  # Schema definitions
```

## 🚀 Edge Function `mem-gw-final` v2.2

**URL:** `https://4ian5xm8.functions.insforge.app/mem-gw-final/`

| Route | Method | Description |
|-------|--------|-------------|
| `/health` | GET | Status + DB counts |
| `/init-session` | POST | Initialize session with conversation ID |
| `/save-session` | POST | Save session + optional GitHub push |
| `/sessions` | GET | List recent sessions (filter by project) |
| `/context-stats` | GET | Memory + entity counts |
| `/quotas` | GET | Model quota data |
| `/quotas` | POST | Upsert quota data from agent |
| `/sync-github` | POST | Push sessions to GitHub |

## 📊 Dashboard

Live monitoring at `LPOpenBIMAI/Agent-Memory/dashboard.html`:
- Session history & conversation tracking
- Model quota usage (Gemini, Claude, GPT)
- Context window monitoring
- Sync to GitHub button
- InsForge DB stats

## 🔄 Changes Log — 2026-03-15 Evening Session

### Edge Function
- ✅ Deployed `mem-gw-final` v2.2 via InsForge MCP
- ✅ Added `gp()` GitHub push helper
- ✅ Added `/sync-github` POST route
- ✅ Added `/quotas` GET/POST routes
- ✅ Fixed TypeScript `never[]` type errors → `any[]`
- ✅ Minified to 4998 bytes (under 5000 limit)

### Dashboard
- ✅ Fixed `loadQuotas()` to fetch from edge function `/quotas`
- ✅ Correct remaining percentage display

### Scripts
- ✅ Fixed `sync-quotas.ps1` null `remainingFraction` default (100→0)

### Obsidian Vault
- ✅ Enriched 50+ Agent-Skills notes with triggers, connections, groups
- ✅ Created 4 OpenSpec skill notes
- ✅ Updated Agent-Plugins documentation
- ✅ Created Platform hub notes
- ✅ Updated GEMINI.md with auto-memory enforcement protocol
- ✅ Updated auto-memory SKILL.md with progressive load + annotations

### Agent System
- ✅ Auto-memory protocol embedded in GEMINI.md (survives context truncation)
- ✅ 4-threshold context monitoring (30/60/80/90% tool calls)
- ✅ Session note format: Query Log + Decision Log + Conversations
- ✅ Intelligent routing via `.agent/skills/intelligent-routing/`

## 🛠 Tech Stack

| Component | Technology |
|-----------|-----------|
| Vault | Obsidian |
| Backend | InsForge (Deno edge functions) |
| Database | PostgreSQL via InsForge |
| AI Agents | Antigravity / Gemini / Claude |
| Sync | GitHub API + InsForge sync_log |
| Scripts | PowerShell |

## 📄 License

Private repository — LongPhamOpenBIM AI.
