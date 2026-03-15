---
name: auto-memory
description: >-
  Auto-memory protocol. Triggered at session start and end. Saves session context
  to Obsidian notes + GitHub + Insforge DB. Monitors context window usage.
  Auto-loads past sessions at start. Tracks all conversations per project.
---

# Auto-Memory Skill

> [!IMPORTANT] ENFORCEMENT
> Core rules from this skill are **ALSO embedded in GEMINI.md TIER 0** (`.agent/rules/GEMINI.md`).
> Even if this file is never read, the checkpoint protocol will execute because
> GEMINI.md is always injected into system prompt — survives context truncation.

## Protocol: Session Lifecycle

### 0. AUTO-LOAD (TRƯỚC KHI LÀM BẤT CỨ GÌ)

> **MANDATORY.** Mỗi session mới PHẢI load context cũ trước.

```
1. Detect project name → basename(workspace root folder)
   Example: D:\RevitAPI → "RevitAPI"

2. Detect IDE → from user_information metadata
   antigravity | cursor | claude | codex | gemini

3. Detect conversation_id → from artifact directory or system metadata
   Example: fbdd4deb-df87-4fb4-9ae5-2588142d4237

4. AUTO-LOAD from Insforge DB:
   GET https://4ian5xm8.functions.insforge.app/mem-gw-final/sessions?project={project}
   → Returns last 20 sessions cho project này

5. Read Obsidian session note (nếu có):
   Path: LPOpenBIMAI/Agent-Memory/session-{YYYY-MM-DD}-{ide}-{project}.md

6. Tổng hợp context:
   - Recent decisions từ DB
   - Ongoing tasks từ session note
   - Key entities + relationships
   → Inject vào working memory

7. Log: "🧠 Auto-loaded {n} past sessions for {project}"

8. POST /init-session to signal new conversation:
   POST https://4ian5xm8.functions.insforge.app/mem-gw-final/init-session
   Body: { conversation_id, project, ide, model }
   → Dashboard resets context window to ~2%
   → Log: "🆕 Session initialized on dashboard"
```

**Nếu không có data → start fresh. Không block user.**

### Memory Bank (Update on relevant sessions)

Agent SHOULD update these files khi phát hiện knowledge mới:

| File | When to Update |
|------|---------------|
| `memory-active-context.md` | Every checkpoint — volatile current state |
| `memory-patterns.md` | New reusable pattern discovered |
| `memory-decisions.md` | Significant tech decision made (ADR) |
| `memory-troubleshooting.md` | Bug found + fixed, gotcha identified |

Path: `LPOpenBIMAI/Agent-Memory/memory-*.md`

### 1. SESSION START (sau auto-load)

```
1. Create/update session note:
   Path: LPOpenBIMAI/Agent-Memory/session-{YYYY-MM-DD}-{ide}-{project}.md

2. Mỗi conversation PHẢI được lưu riêng biệt:
   - 1 project = nhiều conversations (nhiều ngày, nhiều IDE)
   - Session note gom theo ngày, liệt kê từng conversation
   - conversation_id dùng để trace

3. Append entry mới vào session note:
   ### Conversation {conversation_id_short} — {HH:MM}
   **Objective:** {user's first prompt summary}

4. SYNC QUOTAS (nếu OS = Windows + Antigravity đang chạy):
   powershell -ExecutionPolicy Bypass -File "d:\10.Obsidan\LPOpenBIMAI\Agent-Memory\sync-quotas.ps1"
   → Fetches real quota from language_server API
   → Syncs to Insforge DB model_quotas table
   → Dashboard auto-updates via PostgREST
   → Log: "📊 Synced {n} model quotas to dashboard"
```

### 2. PERIODIC CHECKPOINT (mỗi ~15 tool calls)

```
Every ~15 tool calls:
1. Estimate context usage (see Context Monitor)
2. If significant work → update session note + POST /save-session
3. Log: "📌 Checkpoint #{n} saved"
```

**🔴 "UPDATE SESSION NOTE" PHẢI LÀM TẤT CẢ CÁC BƯỚC SAU:**
1. **Append rows vào bảng `🗣️ User Query Log`** — mỗi user request kể từ checkpoint trước → 1 dòng `| # | thời gian | query tóm tắt | kết quả |`
2. **Update bảng `📋 Decision Log`** — ghi decision mới (nếu có)
3. **Update section `## Conversations`** — thêm/update conversation hiện tại
4. **POST `/mem-gw-final/save-session`** với `push_github: true`

> ❌ SAI: "update session note" → chỉ ghi vào Conversations
> ✅ ĐÚNG: "update session note" → Query Log + Decision Log + Conversations + POST API

### 3. SESSION END (user nói "xong"/"done"/"bye", hoặc context >85%)

```
1. Update session note với final summary
2. POST /save-session → DB + GitHub push:
   {
     session_id: "{YYYY-MM-DD}",
     ide: "{ide}",
     project: "{project}",
     content: "{full session summary with user queries + decisions}",
     decisions: ["decision1", "decision2"],
     push_github: true
   }
3. Log: "💾 Session saved to Obsidian + GitHub + Insforge"
```

## Multi-Conversation Tracking

Mỗi project lưu TẤT CẢ conversations:

```
memories table:
  - type: "long-term"
  - category: "session"
  - tags: ["session", "{ide}", "{project}"]
  - content: full session summary
  - source: "auto-memory"

Mỗi conversation = 1 row trong memories.
Query: GET /sessions?project={project} → list all.
```

**Session note trong Obsidian gom nhiều conversations theo ngày:**

```markdown
## Conversations

### Conv abc123 — 10:00 — Antigravity
Objective: Deploy auto-memory system
Changes: ...

### Conv def456 — 15:00 — Antigravity
Objective: Fix sync_log + E2E verification
Changes: ...
```

## Context Window Monitor

### Heuristic thresholds:
- ~50 tool calls → WARNING "Context ~60%"
- ~80 tool calls → ALERT "Context ~80%, auto-saving" → POST /save-session → **ASK user: tiếp tục hay mở session mới?**
- ~100 tool calls → CRITICAL "Context ~95%, save + STOP → yêu cầu mở session mới"

### Alert Format

```markdown
> ⚠️ **Context Monitor:** ~{percent}% used ({tool_calls} tool calls)
> Session auto-saved. Consider starting a new session for fresh context.
```

## Session Note Template

```markdown
---
title: "Session {YYYY-MM-DD} — {IDE} — {Project}"
tags: [session, memory, context, agent-swarm, auto-memory]
date: {YYYY-MM-DD}
ide: {ide}
project: {project}
objective: "{main objective}"
---

# 📝 Session: {Objective}

> **Date:** {YYYY-MM-DD} | **IDE:** {IDE} | **Project:** {Project}

## 🗣️ User Query Log

| # | Time | User Query | Result |
|---|------|------------|--------|
| 1 | {HH:MM} | {query summary} | ✅/⏳/❌ |

## 📋 Decision Log

| Decision | Reason | Result |
|----------|--------|--------|
| ... | ... | ... |

## Conversations

### Conv {id_short} — {HH:MM} — {IDE}

**Objective:** {objective}

#### Changes Made
- ...

#### Decisions
- ...

## Links
- [[AGENT_SWARM|MOC]]
- [[Auto Memory|Auto-Memory Skill]]
- [[memory-config|Memory Config]]
```

## API Endpoints

| Method | Path | Usage |
|--------|------|-------|
| GET | `/mem-gw-final/health` | Health check + counts |
| POST | `/mem-gw-final/save-session` | Save session → DB + GitHub |
| GET | `/mem-gw-final/sessions?project={p}` | List sessions (auto-load) |
| GET | `/mem-gw-final/context-stats` | Memory stats + recent syncs |
| POST | `/mem-gw-final/sync-github` | Cron snapshot → GitHub |

Base URL: `https://4ian5xm8.functions.insforge.app`

---

## Feature #1: 📝 Annotations System (Context Hub Pattern)

> Ghi chú cục bộ persist xuyên sessions — tương tự `chub annotate`.

### Storage
```
Path: LPOpenBIMAI/Agent-Memory/annotations.json
Format: {
  "skill_annotations": {
    "auto-memory": { "note": "...", "updatedAt": "...", "source_session": "conv_id" },
    "brainstorming": { "note": "...", "updatedAt": "...", "source_session": "conv_id" }
  },
  "session_annotations": {
    "session-2026-03-15-antigravity-LPOpenBIMAI": { "note": "...", "updatedAt": "..." }
  }
}
```

### Protocol
1. **When agent discovers gotcha/workaround** → write annotation:
   - Read `annotations.json`
   - Append/update entry for the relevant skill or session
   - Save back to file
   - Log: `📝 Annotation saved for {skill_id}`

2. **When loading a skill** → check annotation:
   - After reading SKILL.md, check `annotations.json` for that skill_id
   - If annotation exists → append to context as `[Agent Note]: {note}`
   - This ensures gotchas are never forgotten

3. **When starting session** → load relevant annotations:
   - During AUTO-LOAD, read all skill annotations
   - Surface ones related to current project/task

### Annotation Guidelines
- Keep notes **concise and actionable** (1-2 sentences max)
- Don't repeat what's already in the SKILL.md
- Focus on: gotchas, workarounds, version quirks, project-specific details
- Example: `"GetUserStatus API requires Content-Type: application/json, not form-data"`

---

## Feature #2: 📦 Progressive Disclosure (Layered Retrieval)

> Load tóm tắt trước, chi tiết sau — tiết kiệm tokens.

### 3-Layer Retrieval
```
Layer 1 — METADATA (always load):
  Session note frontmatter only (title, tags, date, objective)
  → Cost: ~50 tokens per file

Layer 2 — SUMMARY (load on relevance):
  User Query Log table + Decision Log table
  → Cost: ~200-500 tokens

Layer 3 — FULL CONTENT (load on demand):
  Complete session note + conversations
  → Cost: ~2000+ tokens
```

### Protocol
1. **Session Start** → load Layer 1 for last 5 sessions + Layer 2 for most recent
2. **When user references past work** → load Layer 3 for specific session
3. **When searching** → search Layer 1 first, only load deeper if needed
4. **KI System** → read metadata.json summaries first, load artifacts only when needed

### Implementation in AUTO-LOAD
```diff
- 5. Read Obsidian session note (nếu có):
-    Path: LPOpenBIMAI/Agent-Memory/session-{YYYY-MM-DD}-{ide}-{project}.md
+ 5. Progressive Load session notes:
+    a. Read frontmatter only (Layer 1) for last 5 sessions
+    b. Read Query Log + Decision Log (Layer 2) for today's session
+    c. Full content (Layer 3) ONLY when user references specific past work
```

---

## Feature #3: 📊 Feedback Loop (Self-Improving Agent)

> Agent tự đánh giá quality sau mỗi session — tracking skill effectiveness.

### Feedback Data Structure
```json
{
  "session_feedback": [
    {
      "session_id": "session-2026-03-15",
      "conversation_id": "abc123",
      "timestamp": "2026-03-15T23:00:00+07:00",
      "ratings": {
        "overall_quality": "up",
        "context_preservation": "up",
        "skill_effectiveness": {
          "auto-memory": { "rating": "up", "labels": ["helpful"] },
          "brainstorming": { "rating": "down", "labels": ["incomplete"] }
        }
      },
      "notes": "Auto-memory saved correctly but brainstorming gate was skipped"
    }
  ]
}
```

### Protocol
1. **At session end** → agent rates:
   - Overall session quality: `up` or `down`
   - Context preservation: was context maintained through truncation?
   - Each skill used: effective or not?
2. **Labels** (structured): `helpful`, `outdated`, `incomplete`, `confusing`, `effective`, `needs-update`
3. **Storage**: Append to `LPOpenBIMAI/Agent-Memory/feedback.json`
4. **Usage**: At session start, read recent feedback to identify skill trends

---

## Feature #4: ⏱️ Quota Reset Timer

> Hiển thị countdown reset từ `resetTime` trong GetUserStatus API.

### Data Source
```
API: POST https://127.0.0.1:{port}/exa.language_server_pb.LanguageServerService/GetUserStatus
Response → models[].resetTime = epoch seconds khi quota reset
```

### Dashboard Integration
```javascript
// In dashboard.html — add timer card
function updateResetTimer(resetTime) {
  const now = Math.floor(Date.now() / 1000);
  const remaining = resetTime - now;
  const hours = Math.floor(remaining / 3600);
  const mins = Math.floor((remaining % 3600) / 60);
  document.getElementById('reset-timer').textContent = `${hours}h ${mins}m`;
}
```

### Sync via `sync-quotas.ps1`
- Script already fetches `resetTime` from API
- Store in `model_quotas.reset_time` column
- Dashboard reads via PostgREST `GET /model_quotas?select=*`

---

## Feature #5: 🏷️ Conversation Title Auto-Detect

> Tự động lấy title từ system metadata — không cần user nhập.

### Sources (Priority Order)
1. **System Metadata** — `conversation_summaries` injected at each step
   - Contains conversation IDs + titles + summaries
   - Available to agent at every turn
2. **TaskName** — from `task_boundary` calls
   - Agent sets this → can capture for session title
3. **User's first prompt** — summary of initial request

### Protocol
```
Session Start:
1. Check conversation_summaries for current conversation_id
2. If title found → use as conversation entry title
3. If not → use TaskName from first task_boundary call
4. Fallback → summarize user's first prompt (max 6 words)

Session Note Format:
  ### Conv {id_short} — {HH:MM} — "{title}"
  **Objective:** {from conversation_summaries.summary or user first prompt}
```

---

## Feature #6: 🔌 MCP Bypass Pattern

> Khi không thể xây dựng full MCP server, sử dụng bypass qua scripts + API.

### Current Bypass (Working)
```
Agent ─POST→ mem-gw-final API ─→ Insforge DB ─→ GitHub Push
Agent ─Run→ sync-quotas.ps1 ─→ Language Server API ─→ DB
Agent ─Read/Write→ annotations.json (local file)
Agent ─Read/Write→ feedback.json (local file)
```

### Future MCP Server (Planned)
```
MCP Server: auto-memory-mcp
Tools:
  mem_save_session  → POST /save-session
  mem_load_sessions → GET /sessions?project=...
  mem_annotate      → read/write annotations.json
  mem_feedback      → append to feedback.json
  mem_get_quotas    → run sync-quotas.ps1
  mem_search        → search across sessions + KIs

Resources:
  mem://sessions    → list all sessions
  mem://annotations → all annotations
  mem://quotas      → current quota data
```

### Bypass Implementation
Khi MCP server chưa có, agent sử dụng trực tiếp:
1. **File I/O** → read/write `.json` files trong Agent-Memory/
2. **HTTP calls** → POST/GET to mem-gw-final API via `run_command curl`
3. **PowerShell** → `sync-quotas.ps1` for live data
4. **Task boundary** → capture TaskName for conversation titles

---

## Feature #7: 🔗 Citations (Observation IDs)

> Reference past observations bằng unique ID.

### ID Format
```
Session ID:  session-{YYYY-MM-DD}-{ide}-{project}
Conv ID:     conv-{short_hash}
Decision ID: dec-{n} (within session)
Query ID:    q-{n} (within session)
```

### Cross-Reference
- Session notes link to decisions: `See [[session-2026-03-15-antigravity-LPOpenBIMAI#dec-3]]`
- Annotations reference sessions: `"source_session": "conv-abc123"`
- Feedback references skills: `"skill": "auto-memory"`

---

## Config Location

All settings in: `LPOpenBIMAI/Agent-Memory/memory-config.md`
User can edit directly in Obsidian.

