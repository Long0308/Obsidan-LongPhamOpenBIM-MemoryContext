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
| 1/4 | Copy Obsidian vault | `vault/LPOpenBIMAI/` → workspace |
| 2/4 | Install SKILL.md | `.agent/skills/auto-memory/` (local) hoặc `~/.agents/skills/` (global) |
| 3/4 | Copy memory-config | `LPOpenBIMAI/Agent-Memory/memory-config.md` |
| 4/4 | Verify | Check 6 critical files exist |

### Sau khi install

1. Mở workspace trong **Obsidian** (vault = `LPOpenBIMAI/`)
2. Mở workspace trong **Antigravity** (hoặc IDE khác)
3. Bắt đầu làm việc — agent tự động load memory

---

## 📋 Architecture

```
YourWorkspace/
├── .agent/                    # Agent rules + skills (always-on)
│   ├── rules/GEMINI.md        # Core AI behavior rules
│   └── skills/                # 50+ modular skills
│       ├── auto-memory/       # Session lifecycle protocol ⭐
│       ├── intelligent-routing/ # Auto agent selection
│       └── ...
├── LPOpenBIMAI/               # Main Obsidian vault
│   ├── Agent-Memory/          # Memory system
│   │   ├── dashboard.html     # 📊 Live monitoring dashboard
│   │   ├── sync-quotas.ps1    # Quota sync script
│   │   ├── memory-config.md   # Sync settings
│   │   ├── patterns.md        # User behavior patterns
│   │   └── session notes      # Per-session context
│   ├── Agent-Agents/          # 20 AI agent profiles
│   ├── Agent-Skills/          # 58 skill documentation notes
│   ├── Agent-Plugins/         # 15 plugin documentation
│   ├── Platforms/             # Platform integration hubs
│   └── Resources/             # Reference materials
├── insforge/                  # Backend (InsForge)
│   ├── functions/
│   │   ├── mem-gw-final/      # Edge function v2.2 (deployed)
│   │   └── quota-api/         # Quota API
│   └── *.sql                  # Schema definitions
└── install.ps1                # Install script
```

### Vault Stats

| Category | Count | Description |
|----------|-------|-------------|
| 🤖 Agents | 20 | AI specialist profiles (Orchestrator, Frontend, Backend...) |
| 🧩 Skills | 58 | Skill cards with triggers, connections, memory hooks |
| 🔌 Plugins | 15 | Obsidian plugin configs with usage guides |
| 🧠 Memory | 7 | Memory system files (config, patterns, context) |
| 📊 Dashboards | 3 | Obsidian Base views (Vault, Skills, Plugins) |
| 🗺️ Canvases | 3 | Visual graphs (Agent-Swarm, Memory-Graph) |

---

## 🧠 Auto-Memory Protocol

### Hoạt động như thế nào?

```
┌─ Your Machine ──────────────────────────┐
│  AI IDE ← reads SKILL.md → auto-load    │
│  Obsidian ← vault/LPOpenBIMAI/          │
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
model: gemini-2.5-pro
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
| POST | `/mem-gw-final/init-session` | Init session mới (conversation_id, ide, project) |
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
- **Context Window** — Theo dõi context sử dụng
- **Sync** — Nút Sync to GitHub
- **DB Stats** — InsForge database counts

Mở dashboard:
```powershell
npx -y http-server LPOpenBIMAI/Agent-Memory -p 8484 -c-1 --cors
# → http://localhost:8484/dashboard.html
```

---

## 👥 Setup Backend Riêng

> Dùng shared InsForge backend? Skip section này.

### Bước 1: InsForge Setup

```powershell
# Tạo project trên insforge.dev
npx -y @insforge/cli link --project-id YOUR_PROJECT_ID
```

### Bước 2: Database Schema

```powershell
# Chạy SQL schema
npx -y @insforge/cli db query --file schema/setup.sql
```

### Bước 3: Deploy Edge Function

```powershell
# Deploy (MCP recommended vì CLI có bug INVALID_INPUT)
# Hoặc qua InsForge Dashboard → Functions → Create
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

👉 Chi tiết: [docs/E2E-Setup-Guide.md](docs/E2E-Setup-Guide.md) | [docs/SETUP-FOR-OTHERS.md](docs/SETUP-FOR-OTHERS.md)

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

### v2.2 — 2026-03-16

- ✅ Edge function `mem-gw-final` v2.2 deployed (MCP)
- ✅ Thêm `/quotas` GET/POST + `/sync-github` routes
- ✅ Fix TypeScript `never[]` type errors
- ✅ Minified to 4998 bytes
- ✅ Dashboard: fix quota display + sync button
- ✅ `sync-quotas.ps1`: fix null default 100→0
- ✅ 50+ skill notes enriched
- ✅ Auto-memory protocol embedded in GEMINI.md
- ✅ Git init + full vault push (305 files)

### v1.0 — 2026-03-15

- Initial release: vault + backend + edge function
- 20 agents, 48 skills, 15 plugins
- Install script (`install.ps1`)

---

## 📄 License

Private repository — LongPhamOpenBIM AI.
