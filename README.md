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
├── .agent/                        # Agent rules + skills (always-on)
│   ├── rules/GEMINI.md            # Core AI behavior rules
│   ├── agents/                    # 9 specialist agent profiles
│   └── skills/                    # 53 modular skills
│       ├── auto-memory/           # Session lifecycle protocol ⭐
│       ├── intelligent-routing/   # Auto agent selection
│       ├── ui-ux-pro-max/         # Design intelligence
│       └── ...
│
├── LPOpenBIMAI/                   # Main Obsidian vault (148 files)
│   ├── Agent-Skills/              # 64 enriched skill notes
│   │   ├── 1-Superpowers/         #   Core orchestration skills (16)
│   │   ├── 2-OpenSpec/            #   OpenSpec workflow skills (6)
│   │   ├── 3-Obsidian/            #   Obsidian integration (5)
│   │   ├── 4-Design-Frontend/     #   UI/UX & design skills (8)
│   │   ├── 5-Backend-Infra/       #   Backend & infrastructure (8)
│   │   ├── 6-Security-Quality/    #   Security & testing (7)
│   │   ├── 7-Meta/                #   Cross-cutting skills (6)
│   │   ├── 8-Additional/          #   Specialized skills (8)
│   │   ├── Agent-Skills.md        #   📋 MOC (Map of Content)
│   │   └── Skills Dashboard.base  #   📊 Obsidian Base view
│   │
│   ├── Agent-Agents/              # 23 AI agent profiles
│   │   ├── Agent-Agents.md        #   📋 MOC
│   │   ├── orchestrator.md        #   Master coordinator
│   │   ├── frontend-specialist.md #   UI/UX expert
│   │   └── ...
│   │
│   ├── Agent-Memory/              # Memory system (29 files)
│   │   ├── Agent-Memory.md        #   📋 MOC
│   │   ├── dashboard.html         #   📊 Live monitoring
│   │   ├── 4-Sessions/            #   Session notes
│   │   ├── memory-config.md       #   Sync settings
│   │   └── sync-quotas.ps1        #   Quota sync script
│   │
│   ├── Agent-Plugins/             # 16 plugin configs
│   ├── Platforms/                 # 6 platform integration hubs
│   └── Resources/                 # 7 reference materials
│
├── insforge/                      # Backend (InsForge)
│   ├── functions/
│   │   ├── mem-gw-final/          # Edge function v2.2
│   │   └── quota-api/             # Quota API
│   └── *.sql                      # Schema definitions
│
└── install.ps1                    # Install script
```

### Vault Stats

| Category | Count | Description |
|----------|-------|-------------|
| 🧩 Skills | 64 | Enriched skill cards with triggers, connections, group tags |
| 🤖 Agents | 23 | AI specialist profiles (Orchestrator, Frontend, Backend...) |
| 🧠 Memory | 29 | Session notes, config, patterns, guides, dashboards |
| 🔌 Plugins | 16 | Obsidian plugin configs with usage guides |
| 🗺️ Platforms | 6 | Integration hubs (InsForge, Obsidian, OpenSpec...) |
| 📚 Resources | 7 | Reference materials, prompt libraries, workflows |
| **Total** | **148** | **All files verified: 0 duplicates, 0 broken links** |

---

## 🧠 Auto-Memory Protocol

### Hoạt động như thế nào?

```
┌─ Your Machine ──────────────────────────┐
│  AI IDE ← reads SKILL.md → auto-load    │
│  Obsidian ← LPOpenBIMAI/ vault          │
└──────────┬──────────────────────────────┘
           │ HTTP API
           ▼
┌─ InsForge Cloud ────────────────────────┐
│  Edge Function: mem-gw-final v2.2       │
│  PostgreSQL: memories, entities, ...    │
│  Cron: snapshot → GitHub every 2h       │
└──────────┬──────────────────────────────┘
           ▼
┌─ GitHub (Private) ──────────────────────┐
│  sessions/ + context-snapshots/         │
└─────────────────────────────────────────┘
```

### Session Lifecycle

| Phase | Trigger | Hành động |
|-------|---------|-----------| 
| **Start** | IDE mở workspace | Load 5 sessions gần nhất, init session mới |
| **30% context** | ~30 tool calls | Checkpoint #1 — save session note |
| **60% context** | ~60 tool calls | ⚠️ Warning — save + log |
| **80% context** | ~80 tool calls | 🟠 Auto-save + hỏi user tiếp hay mới |
| **90% context** | ~90 tool calls | 🔴 STOP — save + yêu cầu session mới |
| **End** | User nói "done" | Save Query Log + Decision Log + push GitHub |

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
