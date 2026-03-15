# 🧠 Auto-Memory Kit — Full Stack

AI Agent memory system — toàn bộ dự án, clone về là chạy.

Works with: **Antigravity**, Cursor, Claude Code, Codex, Gemini CLI.

## Quick Install

```powershell
# 1. Clone
git clone https://github.com/Long0308/Obsidan-LongPhamOpenBIM-MemoryContext.git
cd Obsidan-LongPhamOpenBIM-MemoryContext

# 2. Install (chọn 1 trong 2)
./install.ps1 -WorkspacePath "D:\YourWorkspace"          # Local workspace
./install.ps1 -WorkspacePath "D:\YourObsidian" -Global   # Global (all projects)
```

## What's Included

```
├── README.md                     ← You are here
├── install.ps1                   ← Auto-install script
├── skill/SKILL.md                ← AI agent protocol
├── config/memory-config.md       ← Sync settings
├── schema/setup.sql              ← Database schema
├── functions/index.ts            ← Edge function (4.9KB)
├── docs/E2E-Setup-Guide.md       ← Full documentation
│
├── vault/LPOpenBIMAI/            ← 🗂️ FULL OBSIDIAN VAULT
│   ├── AGENT_SWARM.md            ← MOC (Map of Content)
│   ├── System-Guide.md           ← System architecture guide
│   ├── E2E-Guide.md              ← E2E setup reference
│   ├── Agent-Swarm.canvas        ← Visual agent graph
│   ├── Memory-Graph.canvas       ← Memory relationship graph
│   ├── Agent-Agents/             ← 20 AI agent profiles
│   │   ├── Orchestrator.md
│   │   ├── Frontend Specialist.md
│   │   ├── Backend Specialist.md
│   │   ├── Debugger.md
│   │   └── ... (20 agents total)
│   ├── Agent-Skills/             ← 48 skill cards
│   │   ├── Auto Memory.md
│   │   ├── Clean Code.md
│   │   ├── Brainstorming.md
│   │   └── ... (48 skills total)
│   ├── Agent-Plugins/            ← 15 Obsidian plugins
│   ├── Agent-Memory/             ← Memory system files
│   │   ├── memory-config.md
│   │   ├── E2E-Setup-Guide.md
│   │   ├── context-rules.md
│   │   ├── patterns.md
│   │   ├── preferences.md
│   │   ├── people.md
│   │   └── tech-stack.md
│   └── .obsidian/                ← Vault settings (graph colors, etc.)
│
├── sessions/                     ← Auto-saved session data
└── context-snapshots/            ← Cron snapshots
```

**Total: 116 files** — toàn bộ vault + backend + edge function.

## Architecture

```
┌─ Your Machine ──────────────────────────┐
│  AI IDE ← reads SKILL.md → auto-load    │
│  Obsidian ← vault/LPOpenBIMAI/          │
└──────────┬──────────────────────────────┘
           │ HTTP API
           ▼
┌─ InsForge Cloud ────────────────────────┐
│  Edge Function: mem-gw-final            │
│  PostgreSQL: memories, entities, ...    │
│  Cron: snapshot → GitHub every 2h       │
└──────────┬──────────────────────────────┘
           ▼
┌─ GitHub (Private) ──────────────────────┐
│  sessions/ + context-snapshots/         │
└─────────────────────────────────────────┘
```

## API Endpoints

Base URL: `https://4ian5xm8.functions.insforge.app`

| Method | Path | Usage |
|--------|------|-------|
| GET | `/mem-gw-final/health` | Health check |
| POST | `/mem-gw-final/save-session` | Save → DB + GitHub |
| GET | `/mem-gw-final/sessions?project={p}` | Load sessions |
| GET | `/mem-gw-final/context-stats` | Stats |
| POST | `/mem-gw-final/sync-github` | Cron snapshot |

## Backend Setup (First Time Only)

> Skip if using shared InsForge backend.

See [docs/E2E-Setup-Guide.md](docs/E2E-Setup-Guide.md)

## 👥 For Other Users (Setup Your Own Backend)

Repo này dùng InsForge + GitHub PAT của Long. Để setup backend riêng:

👉 **[docs/SETUP-FOR-OTHERS.md](docs/SETUP-FOR-OTHERS.md)** — Hướng dẫn step-by-step

Tóm tắt:
1. Tạo InsForge account + project
2. Run `schema/setup.sql`
3. Deploy `functions/index.ts`
4. Tạo GitHub repo + PAT → add secrets
5. Setup cron schedule
6. Update URL trong `SKILL.md` + `memory-config.md`

## License

Private — LongPhamOpenBIM
