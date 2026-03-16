---
parent: "[[Agent-Memory]]"
group: "Guides & Setup"
title: "Auto-Memory System — E2E Setup Guide"
tags:
  - memory
  - guide
  - e2e
  - agent-swarm
  - auto-memory
type: guide
---
group: "Guides & Setup"
# 🚀 Auto-Memory System — E2E Setup Guide

> Hướng dẫn cài đặt và sử dụng hệ thống Auto-Memory trên **máy mới** hoặc **share cho người khác**.
> Hệ thống sẽ tự lưu + load context xuyên suốt mọi session, mọi project.

---
group: "Guides & Setup"
## Tổng Quan Kiến Trúc

```
┌─ Máy của bạn ─────────────────────────────────────────┐
│                                                         │
│  Antigravity IDE ← đọc SKILL.md → auto-load/save       │
│       ↕                                                 │
│  Obsidian Vault ← session notes + config                │
│                                                         │
└─────────┬───────────────────────────────────────────────┘
          │ HTTP API
          ▼
┌─ InsForge Cloud ──────────────────────────────────────────┐
│  Edge Function: mem-gw-final                              │
│  ├─ POST /save-session  → DB + GitHub push                │
│  ├─ GET  /sessions      → load past sessions              │
│  ├─ GET  /context-stats → memory stats                    │
│  └─ POST /sync-github   → cron snapshot (mỗi 2h)         │
│                                                           │
│  PostgreSQL: memories, entities, relationships, sync_log  │
│  Cron: 0 */2 * * * → auto-snapshot → GitHub               │
└──────────┬────────────────────────────────────────────────┘
           │
           ▼
┌─ GitHub (Private Repo) ───────────────────────────────────┐
│  Long0308/Obsidan-LongPhamOpenBIM-MemoryContext           │
│  ├─ sessions/           ← session saves                   │
│  └─ context-snapshots/  ← cron snapshots (mỗi 2h)        │
└───────────────────────────────────────────────────────────┘
```

---
group: "Guides & Setup"
## Bước 1: Cài Đặt Antigravity

```powershell
# Windows
npm install -g @anthropic-ai/antigravity

# Verify
antigravity --version
```

> [!note] Hỗ trợ IDE khác
> Hệ thống hoạt động với: Antigravity, Cursor, Claude Code, Codex, Gemini CLI.
> Chỉ cần SKILL.md accessible trong workspace.

---
group: "Guides & Setup"
## Bước 2: Clone Obsidian Vault (hoặc tạo mới)

### Nếu đã có vault (sync từ máy khác):
```powershell
# Sync qua OneDrive/Google Drive/Git — Obsidian vault folder
# Vault cần chứa: .agent/skills/auto-memory/SKILL.md
```

### Nếu tạo mới:
```powershell
mkdir D:\10.Obsidan
mkdir D:\10.Obsidan\.agent\skills\auto-memory
mkdir D:\10.Obsidan\LPOpenBIMAI\Agent-Memory
```

---
group: "Guides & Setup"
## Bước 3: Copy SKILL.md

File này là "bộ não" — dạy agent cách auto-load/save.

**Copy file:** `.agent/skills/auto-memory/SKILL.md` vào workspace.

> [!important] Nội dung quan trọng trong SKILL.md
> - **Step 0: AUTO-LOAD** — Agent tự query DB lấy past sessions
> - **Step 1: SESSION START** — Tạo/update session note trong Obsidian
> - **Step 2: CHECKPOINT** — Tự save mỗi ~15 tool calls
> - **Step 3: SESSION END** — Save tất cả vào DB + GitHub
> - **API Endpoints** — Base URL + routes

Nếu muốn global (mọi project đều dùng được):
```powershell
# Copy vào global agent skills
mkdir C:\Users\Admin\.agents\skills\auto-memory
copy .agent\skills\auto-memory\SKILL.md C:\Users\Admin\.agents\skills\auto-memory\
```

---
group: "Guides & Setup"
## Bước 4: Setup Backend (InsForge) — CHỈ LẦN ĐẦU

> [!caution] Nếu dùng chung InsForge project
> Backend đã setup rồi → **bỏ qua bước này**.
> Chỉ cần đảm bảo edge function URL đúng trong SKILL.md.

### 4a. Tạo InsForge Project

```powershell
npm install -g insforge-cli
insforge auth login
insforge projects create --name "MemoryContext" --region ap-southeast
```

### 4b. Tạo Database Schema

```sql
-- 4 tables: memories, entities, relationships, sync_log

CREATE TABLE memories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  type TEXT NOT NULL DEFAULT 'short-term',
  category TEXT NOT NULL DEFAULT 'general',
  content TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}',
  importance NUMERIC(3,2) DEFAULT 0.5,
  source TEXT DEFAULT 'manual',
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE entities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  type TEXT NOT NULL,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE relationships (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  source_entity_id UUID REFERENCES entities(id),
  target_entity_id UUID REFERENCES entities(id),
  relationship_type TEXT NOT NULL,
  weight NUMERIC(3,2) DEFAULT 0.5,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE sync_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  operation TEXT NOT NULL,
  table_name TEXT NOT NULL,
  record_id UUID,
  adapter_source TEXT NOT NULL,
  adapter_target TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',
  error_message TEXT,
  source TEXT,
  target TEXT,
  details JSONB,
  synced_at TIMESTAMPTZ DEFAULT now(),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- CHECK constraints
ALTER TABLE sync_log ADD CONSTRAINT sync_log_operation_check
  CHECK (operation = ANY(ARRAY['create','update','delete','sync','save-session','cron-sync']));
ALTER TABLE sync_log ADD CONSTRAINT sync_log_status_check
  CHECK (status = ANY(ARRAY['pending','success','failed']));

-- RLS
ALTER TABLE memories ENABLE ROW LEVEL SECURITY;
ALTER TABLE entities ENABLE ROW LEVEL SECURITY;
ALTER TABLE relationships ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_log ENABLE ROW LEVEL SECURITY;

-- Grants (QUAN TRỌNG — thiếu cái này sẽ insert fail âm thầm)
GRANT SELECT, INSERT, UPDATE ON memories TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE ON entities TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE ON relationships TO anon, authenticated;
GRANT SELECT, INSERT ON sync_log TO anon, authenticated;

-- RLS policies (cho phép public access)
CREATE POLICY "public_all" ON memories FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON entities FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON relationships FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON sync_log FOR ALL USING (true) WITH CHECK (true);

-- Indexes
CREATE INDEX idx_memories_category ON memories(category);
CREATE INDEX idx_memories_tags ON memories USING GIN(tags);
CREATE INDEX idx_memories_type ON memories(type);
CREATE INDEX idx_memories_source ON memories(source);
CREATE INDEX idx_entities_type ON entities(type);
CREATE INDEX idx_entities_name ON entities(name);
CREATE INDEX idx_sync_log_status ON sync_log(status);
CREATE INDEX idx_sync_log_operation ON sync_log(operation);
```

Chạy bằng: `insforge db query "..." --project-id <id>` hoặc paste vào SQL Editor.

### 4c. Deploy Edge Function

```powershell
# Tạo file index.ts tại insforge/functions/mem-gw-final/index.ts
# (source code ở section bên dưới)
insforge functions deploy mem-gw-final --name "Memory Gateway v2"
```

> [!warning] InsForge limit source < 5KB
> Edge function PHẢI dưới 5KB. Code đã minified sẵn.

### 4d. Add Secrets

```powershell
insforge secrets set GITHUB_PAT "ghp_your_token_here"
insforge secrets set GITHUB_OWNER "your-github-username"
insforge secrets set GITHUB_REPO "your-repo-name"
```

### 4e. Setup Cron

```powershell
insforge schedules create \
  --name "auto-memory-sync" \
  --schedule "0 */2 * * *" \
  --url "https://YOUR_ID.functions.insforge.app/mem-gw-final/sync-github" \
  --method POST
```

---
group: "Guides & Setup"
## Bước 5: Tạo GitHub Repo (Private)

```powershell
# Tạo repo private trên GitHub
gh repo create Obsidan-MemoryContext --private

# Hoặc tạo trên github.com
```

---
group: "Guides & Setup"
## Bước 6: Verify E2E

```powershell
# 1. Health check
Invoke-RestMethod -Uri "https://YOUR_ID.functions.insforge.app/mem-gw-final/health"

# Expected: { status: "ok", v: "2.0", counts: {...} }

# 2. Save test session
$body = @{
  session_id = "2026-03-15-test"
  ide = "antigravity"
  project = "TestProject"
  content = "Test session content"
  decisions = @("Test decision 1")
  push_github = $true
} | ConvertTo-Json

Invoke-RestMethod -Uri "https://YOUR_ID.functions.insforge.app/mem-gw-final/save-session" `
  -Method POST -Body $body -ContentType "application/json"

# Expected: { status: "saved", memory_id: "...", github: "pushed" }

# 3. Load sessions
Invoke-RestMethod -Uri "https://YOUR_ID.functions.insforge.app/mem-gw-final/sessions?project=TestProject"

# Expected: { sessions: [...], count: 1 }
```

---
group: "Guides & Setup"
## Sử Dụng Hàng Ngày

### Mở Antigravity → Bắt đầu làm việc

Bạn **KHÔNG CẦN LÀM GÌ**. Agent tự động:

```
1. 🧠 Auto-load context từ DB (SKILL.md Step 0)
2. 📝 Tạo/update session note trong Obsidian
3. 📌 Checkpoint mỗi ~15 tool calls
4. 💾 Save khi kết thúc → DB + GitHub + Obsidian
```

### Muốn agent load context thủ công?

```
Prompt: "Load context cho project RevitAPI"
→ Agent sẽ GET /sessions?project=RevitAPI
```

### Chuyển project?

```
Prompt: "Bây giờ tôi muốn chuyển sang project Gateway"
→ Agent tự detect project mới, auto-load sessions cho Gateway
```

### Xem lại sessions cũ?

Mở Obsidian → `Agent-Memory/session-{date}-{ide}-{project}.md`

---
group: "Guides & Setup"
## File Cần Share/Copy cho Máy Mới

| # | File/Folder | Bắt buộc? | Ghi chú |
|---|-------------|-----------|---------|
| 1 | `.agent/skills/auto-memory/SKILL.md` | ✅ YES | Bộ não của hệ thống |
| 2 | `LPOpenBIMAI/Agent-Memory/memory-config.md` | ✅ YES | Config sync |
| 3 | `insforge/functions/memory-gateway/index.ts` | ⚠️ Nếu deploy mới | Edge function source |
| 4 | GitHub PAT token | ✅ YES | Add vào InsForge Secrets |
| 5 | InsForge project URL | ✅ YES | Có trong SKILL.md |
| 6 | Session notes (`Agent-Memory/session-*.md`) | Optional | Sync qua Obsidian vault |

---
group: "Guides & Setup"
## Thông Tin Kết Nối (Production)

| Key | Value |
|-----|-------|
| InsForge Project ID | `105f7d35-5480-467c-8674-289ce4e91cb4` |
| Function URL | `https://4ian5xm8.functions.insforge.app/mem-gw-final` |
| GitHub Repo | `Long0308/Obsidan-LongPhamOpenBIM-MemoryContext` (private) |
| Cron ID | `c86c044a` (0 */2 * * *) |

---
group: "Guides & Setup"
## Edge Function Source Code (v2, minified — 4.9KB)

> [!tip] File gốc
> `insforge/functions/memory-gateway/index.ts`

Xem source: [[index.ts]] hoặc mở file trực tiếp.

---
group: "Guides & Setup"
## Troubleshooting

| Vấn đề | Nguyên nhân | Fix |
|---------|-------------|-----|
| sync_log trống | CHECK constraint chặn operation | Expand constraint (xem SQL ở Bước 4b) |
| INVALID_INPUT deploy | Source > 5KB | Minify code, bỏ comments |
| CLI INTERNAL_ERROR | Windows libuv bug | Dùng PowerShell `Invoke-RestMethod` thay CLI |
| GitHub "pushed" nhưng 404 | Repo private, check PAT scope | PAT cần `repo` scope |
| Agent không auto-load | SKILL.md không accessible | Check path trong `.agent/skills/` |

## Links

- [[Auto Memory|SKILL.md]]
- [[memory-config|Config]]
- [[AGENT_SWARM|MOC]]
- [[E2E-Guide|E2E Guide]]
