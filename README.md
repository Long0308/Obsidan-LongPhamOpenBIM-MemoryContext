# 🧠 Auto-Memory Kit

AI Agent memory system — tự động save/load context xuyên sessions, projects, và machines.

Works with: **Antigravity**, Cursor, Claude Code, Codex, Gemini CLI.

## Quick Install

```powershell
# 1. Clone repo
git clone https://github.com/Long0308/Obsidan-LongPhamOpenBIM-MemoryContext.git

# 2. Run install script
cd Obsidan-LongPhamOpenBIM-MemoryContext
./install.ps1 -WorkspacePath "D:\YourWorkspace"

# Or install globally (all projects):
./install.ps1 -Global
```

**Manual install:**

```powershell
# Copy skill to workspace
xcopy /E skill\  D:\YourWorkspace\.agent\skills\auto-memory\

# Copy config template
copy config\memory-config.md D:\YourWorkspace\LPOpenBIMAI\Agent-Memory\
```

## How It Works

```
 Session Start → 🧠 Auto-load past sessions from DB
      ↓
 Working...    → 📌 Periodic checkpoints (~15 tool calls)
      ↓
 Session End   → 💾 Save to: Obsidian + InsForge DB + GitHub
```

| Feature | Status |
|---------|--------|
| Auto-load context at session start | ✅ |
| Auto-save at session end | ✅ |
| Multi-project support | ✅ |
| Multi-conversation tracking | ✅ |
| GitHub backup (every 2h cron) | ✅ |
| Context window monitoring | ✅ |
| Obsidian session notes | ✅ |

## Architecture

```
┌─ Your Machine ──────────────────────────┐
│  AI IDE ← reads SKILL.md → auto-load    │
│  Obsidian ← session notes + config      │
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

## File Structure

```
├── README.md              ← You are here
├── install.ps1            ← Auto-install script (PowerShell)
├── skill/
│   └── SKILL.md           ← AI agent instructions (core)
├── config/
│   └── memory-config.md   ← Sync settings (editable in Obsidian)
├── schema/
│   └── setup.sql          ← Database schema (run once)
├── functions/
│   └── index.ts           ← Edge function source (4.9KB, Deno)
├── docs/
│   └── E2E-Setup-Guide.md ← Full setup documentation
├── sessions/              ← Auto-saved session data
└── context-snapshots/     ← Cron snapshots (every 2h)
```

## First-Time Backend Setup

> Skip this if you're using the shared InsForge backend.

1. `insforge projects create --name "MemoryContext"`
2. Run `schema/setup.sql` in SQL Editor
3. `insforge functions deploy mem-gw-final --file functions/index.ts`
4. Add secrets: `GITHUB_PAT`, `GITHUB_OWNER`, `GITHUB_REPO`
5. Create cron: `0 */2 * * *` → `/mem-gw-final/sync-github`

## API Endpoints

Base URL: `https://4ian5xm8.functions.insforge.app`

| Method | Path | Usage |
|--------|------|-------|
| GET | `/mem-gw-final/health` | Health check |
| POST | `/mem-gw-final/save-session` | Save → DB + GitHub |
| GET | `/mem-gw-final/sessions?project={p}` | Load sessions |
| GET | `/mem-gw-final/context-stats` | Stats |
| POST | `/mem-gw-final/sync-github` | Cron snapshot |

## Daily Usage

**Mở IDE → bắt đầu làm → agent tự xử lý.** Không cần setup gì thêm.

## License

Private — LongPhamOpenBIM
