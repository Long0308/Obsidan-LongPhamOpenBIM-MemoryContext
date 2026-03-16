# 🧠 Auto-Memory Kit — Full Stack

> AI Agent memory system — Obsidian vault powering intelligent agent memory, session tracking, quota monitoring, and multi-agent orchestration.
>
> Works with: **Antigravity**, Cursor, Claude Code, Codex, Gemini CLI.

---

## ⚡ Quick Install

```powershell
# 1. Clone
git clone https://github.com/Long0308/Obsidan-LongPhamOpenBIM-MemoryContext.git
cd Obsidan-LongPhamOpenBIM-MemoryContext

# 2. Install (chọn 1 trong 3)
./install.ps1 -WorkspacePath "D:\YourWorkspace"          # Local workspace
./install.ps1 -WorkspacePath "D:\YourObsidian" -Global   # Global (all projects)
./install.ps1 -VaultOnly -WorkspacePath "D:\YourObsidian" # Vault only (no skill)
```

### Install Script tự động làm gì?

| Step | Hành động | Kết quả |
|------|-----------|---------| 
| 1/4 | Copy Obsidian vault | `LPOpenBIMAI/` → workspace |
| 2/4 | Install SKILL.md | `.agent/skills/auto-memory/` (local) hoặc `~/.agents/skills/` (global) |
| 3/4 | Copy memory-config | `Agent-Memory/memory-config.md` |
| 4/4 | Verify | Check 6 critical files exist |

---

## 📋 Architecture

```
YourWorkspace/
├── .agent/                           # Agent rules + skills
│   ├── GEMINI.md                     # Core AI behavior rules (always-on)
│   ├── ARCHITECTURE.md               # System map
│   ├── SOUL.md                       # AI personality
│   ├── agents/                       # 20 specialist agent profiles
│   │   ├── orchestrator.md           #   Master coordinator
│   │   ├── frontend-specialist.md    #   UI/UX expert
│   │   ├── backend-specialist.md     #   API/DB specialist
│   │   ├── security-auditor.md       #   Security analyzer
│   │   ├── debugger.md               #   Bug hunter
│   │   └── ... (15 more)
│   ├── skills/                       # 64 modular skills
│   │   ├── auto-memory/              #   Session lifecycle ⭐
│   │   ├── intelligent-routing/      #   Auto agent selection
│   │   ├── ui-ux-pro-max/            #   Design intelligence
│   │   ├── clean-code/               #   Code standards
│   │   ├── brainstorming/            #   Discovery protocol
│   │   └── ... (59 more)
│   ├── workflows/                    # Slash commands (/create, /debug, /deploy...)
│   ├── scripts/                      # Automation (checklist.py, verify_all.py)
│   └── memory/                       # Memory gateway code
│
├── .agents/                          # Additional skills (InsForge)
│   └── skills/
│       ├── insforge/                 #   InsForge SDK docs
│       └── insforge-cli/             #   InsForge CLI docs
│
├── LPOpenBIMAI/                      # Obsidian vault
│   ├── Agent-Skills/                 # 64 enriched skill notes
│   │   ├── 1-Superpowers/            #   Core orchestration (16)
│   │   ├── 2-OpenSpec/               #   OpenSpec workflow (6)
│   │   ├── 3-Obsidian/               #   Obsidian tools (5)
│   │   ├── 4-Design-Frontend/        #   UI/UX & design (8)
│   │   ├── 5-Backend-Infra/          #   Backend & infra (8)
│   │   ├── 6-Security-Quality/       #   Security & testing (7)
│   │   ├── 7-Meta/                   #   Cross-cutting (6)
│   │   ├── 8-Additional/             #   Specialized (8)
│   │   ├── Agent-Skills.md           #   📋 MOC
│   │   └── Skills Dashboard.base     #   📊 Dashboard view
│   │
│   ├── Agent-Agents/                 # 23 agent profile notes
│   │   ├── Agent-Agents.md           #   📋 MOC
│   │   └── *.md                      #   Agent profiles
│   │
│   ├── Agent-Memory/                 # Memory system (37 files)
│   │   ├── Agent-Memory.md           #   📋 MOC
│   │   ├── dashboard.html            #   📊 Live monitoring
│   │   ├── sync-quotas.ps1           #   Quota sync script
│   │   ├── 1-Config/                 #   Settings (5 files)
│   │   ├── 2-Patterns/               #   Behavior patterns (6 files)
│   │   ├── 3-Infrastructure/         #   Backend docs (7 files)
│   │   ├── 4-Sessions/               #   Session notes (3 files)
│   │   ├── 5-Guides/                 #   Setup guides (7 files)
│   │   └── assets/                   #   Media files
│   │
│   ├── Agent-Plugins/                # 17 plugin docs
│   │   ├── Agent-Plugins.md          #   📋 MOC
│   │   ├── 1-Visualization/          #   Graph, Canvas (5)
│   │   ├── 2-Editor/                 #   Editor tools (5)
│   │   ├── 3-Navigation/             #   Nav plugins (3)
│   │   └── 4-Productivity/           #   Productivity (2)
│   │
│   ├── Platforms/                    # Platform hub notes
│   ├── Resources/                    # Reference materials
│   │
│   ├── Agent-Swarm.canvas            # 🗺️ Agent relationship map
│   ├── Memory-Graph.canvas           # 🗺️ Memory flow diagram
│   ├── Vault Dashboard.base          # 📊 Full vault view
│   ├── GitHub Dashboard.base         # 📊 GitHub activity
│   └── Session Dashboard.base        # 📊 Session overview
│
├── insforge/                         # Backend (InsForge)
│   ├── functions/
│   │   ├── mem-gw-final/index.ts     #   Edge function v2.2 (deployed)
│   │   ├── quota-api/index.ts        #   Quota API
│   │   └── memory-gateway/           #   Legacy gateway
│   ├── schema.sql                    #   Core DB schema
│   ├── quota-schema.sql              #   Quota tables
│   ├── relationships.sql             #   Graph relationships
│   └── *.sql                         #   Other migrations
│
└── install.ps1                       # Install script
```

### Vault Stats

| Category | Count | Description |
|----------|-------|-------------|
| 🧩 Skills | 64 | Enriched skill notes in 8 groups (Superpowers→Additional) |
| 🤖 Agents | 23 | AI specialist profiles (+ 20 source `.agent/agents/`) |
| 🧠 Memory | 37 | Config, patterns, infrastructure, sessions, guides |
| 🔌 Plugins | 17 | Plugin docs in 4 categories (Viz, Editor, Nav, Productivity) |
| 📊 Dashboards | 4 | Vault, Skills, GitHub, Session (Obsidian Base views) |
| 🗺️ Canvases | 3 | Agent-Swarm, Memory-Graph, Untitled |
| **Total** | **148** | **E2E verified: 0 duplicates, 0 ghost links, 0 broken wikilinks** |

---

## 🧠 Auto-Memory Protocol

### Data Flow

```
┌─ Your Machine ──────────────────────────────────┐
│                                                  │
│  AI IDE (Antigravity/Cursor/Claude)              │
│    ↓ reads .agent/skills/auto-memory/SKILL.md    │
│    ↓ auto-loads past sessions at start           │
│    ↓ saves checkpoints at 30/60/80/90% context   │
│                                                  │
│  Obsidian Vault (LPOpenBIMAI/)                   │
│    ← Agent-Memory/4-Sessions/ session notes      │
│    ← dashboard.html (live monitoring)            │
│    ← sync-quotas.ps1 (quota sync)                │
│                                                  │
└──────────┬──────────────────────────────────────┘
           │ POST /save-session
           │ GET  /sessions
           │ POST /sync-github
           ▼
┌─ InsForge Cloud ────────────────────────────────┐
│  Edge Function: mem-gw-final v2.2                │
│  ├── /health          → DB status                │
│  ├── /init-session    → Start tracking           │
│  ├── /save-session    → Save + push GitHub       │
│  ├── /sessions        → Load history             │
│  ├── /quotas          → Model usage tracking     │
│  ├── /context-update  → Context window %         │
│  └── /sync-github     → Manual GitHub push       │
│                                                  │
│  PostgreSQL: memories, entities, sync_log, quotas│
└──────────┬──────────────────────────────────────┘
           │ GitHub API
           ▼
┌─ GitHub (Private Repo) ─────────────────────────┐
│  LPOpenBIMAI/Agent-Memory/sessions/              │
│  context-snapshots/                              │
└─────────────────────────────────────────────────┘
```

### Session Lifecycle

| Phase | Trigger | Hành động |
|-------|---------|-----------|
| **Start** | IDE mở workspace | Read SKILL.md → GET /sessions → load 5 gần nhất |
| **30%** | ~30 tool calls | 📌 Checkpoint #1 — save session note to Obsidian |
| **60%** | ~60 tool calls | ⚠️ Warning — POST /save-session + update query log |
| **80%** | ~80 tool calls | 🟠 Auto-save + hỏi user: tiếp tục hay mở session mới? |
| **90%** | ~90 tool calls | 🔴 STOP — save tất cả + yêu cầu session mới |
| **End** | User nói "done/xong" | Save Query Log + Decision Log + POST /save-session (push_github: true) |

### Session Note Format

Mỗi session tự động tạo file: `session-{date}-{ide}-{project}.md`

```markdown
---
date: 2026-03-16
ide: antigravity
project: LPOpenBIMAI
model: claude-sonnet-4.5
---

## 🗣️ User Query Log
| # | Time | Query | Result |
|---|------|-------|--------|
| 1 | 06:46 | "deploy edge function" | ✅ Deployed v2.2 |

## 📋 Decision Log
| Decision | Reason |
|----------|--------|
| Use MCP deploy | CLI INVALID_INPUT bug |

## Conversations
- conv-1074004b: Dashboard Fixes (2026-03-15)
```

---

## 🚀 API Endpoints

Base URL: `https://4ian5xm8.functions.insforge.app`

| Method | Path | Mô tả |
|--------|------|-------|
| GET | `/mem-gw-final/health` | Health check + DB counts |
| POST | `/mem-gw-final/init-session` | Init session mới |
| POST | `/mem-gw-final/save-session` | Save session + optional GitHub push |
| GET | `/mem-gw-final/sessions?project={p}` | Load recent sessions |
| GET | `/mem-gw-final/context-stats` | Memory + entity counts |
| GET | `/mem-gw-final/quotas?project={p}` | Model quota data |
| POST | `/mem-gw-final/quotas` | Upsert quota data |
| POST | `/mem-gw-final/sync-github` | Push sessions to GitHub |

### Ví dụ API Call

```powershell
# Health check
Invoke-RestMethod "https://4ian5xm8.functions.insforge.app/mem-gw-final/health"
# → {status: "ok", v: "2.2", counts: {memories: 56, entities: 6, sync: 23}}

# Save session
Invoke-RestMethod -Uri ".../mem-gw-final/save-session" -Method POST -Body (@{
  content = "Session summary..."
  ide = "antigravity"
  project = "LPOpenBIMAI"
  push_github = $true
} | ConvertTo-Json) -ContentType "application/json"
```

---

## 📊 Dashboard

Live monitoring tại `LPOpenBIMAI/Agent-Memory/dashboard.html`:

- **Sessions** — Lịch sử session + conversation tracking
- **Quotas** — Model quota usage (Gemini, Claude, GPT) + reset timer
- **Context Window** — Theo dõi context sử dụng real-time
- **Sync** — Nút Sync to GitHub
- **DB Stats** — InsForge database counts

```powershell
npx -y http-server LPOpenBIMAI/Agent-Memory -p 8484 -c-1 --cors
# → http://localhost:8484/dashboard.html
```

---

## 👥 Setup Backend Riêng

> Dùng shared InsForge backend? Skip section này.

### Bước 1: InsForge Setup

```powershell
npx -y @insforge/cli link --project-id YOUR_PROJECT_ID
```

### Bước 2: Database Schema

```powershell
npx -y @insforge/cli db query --file schema/setup.sql
```

### Bước 3: Deploy Edge Function

```powershell
# Deploy qua InsForge Dashboard → Functions → Create
# (CLI có bug INVALID_INPUT — dùng MCP hoặc dashboard)
```

### Bước 4: Secrets

```powershell
npx -y @insforge/cli secrets add GITHUB_PAT "ghp_your_token"
npx -y @insforge/cli secrets add GITHUB_OWNER "YourUsername"  
npx -y @insforge/cli secrets add GITHUB_REPO "YourRepo"
```

### Bước 5: Update URLs

Sửa base URL trong:
- `.agent/skills/auto-memory/SKILL.md`
- `LPOpenBIMAI/Agent-Memory/memory-config.md`
- `LPOpenBIMAI/Agent-Memory/dashboard.html`

---

## 🛠 Tech Stack

| Component | Technology |
|-----------|-----------|
| Vault | Obsidian |
| Backend | InsForge (Deno edge functions) |
| Database | PostgreSQL via InsForge |
| AI Agents | Antigravity / Gemini / Claude |
| Sync | GitHub API + InsForge sync_log |
| Scripts | PowerShell |
| Dashboard | HTML/JS (static) |

---

## 🔄 Changelog

### v2.3 — 2026-03-16

- ✅ E2E vault audit: **148 files, 0 duplicates, 0 broken links**
- ✅ Enriched all 64 skill notes with full content + frontmatter tags
- ✅ Skills Dashboard `.base` — filter fixed (`agent-skill` tag)
- ✅ Removed 241 duplicate files across vault
- ✅ Fixed 13 phantom `skill-source` wikilinks
- ✅ Fixed 41 ghost `.md` links → inline code
- ✅ Added 7 missing skills to MOC
- ✅ Connected session notes to Agent-Memory MOC
- ✅ Auto-memory pipeline verified: save-session + GitHub sync working

### v2.2 — 2026-03-16

- ✅ Edge function `mem-gw-final` v2.2 deployed (MCP)
- ✅ Thêm `/quotas` GET/POST + `/sync-github` routes
- ✅ Context tracker: `/context-update` + `/context-status`
- ✅ Dashboard: quota display + sync button + context gauge
- ✅ `sync-quotas.ps1`: fix null default 100→0
- ✅ Auto-memory protocol embedded in GEMINI.md

### v1.0 — 2026-03-15

- Initial release: vault + backend + edge function
- 20 agents, 48 skills, 15 plugins
- Install script (`install.ps1`)

---

## 📄 License

Private repository — LongPhamOpenBIM AI.
