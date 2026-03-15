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
```

**Nếu không có data → start fresh. Không block user.**

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
```

### 2. PERIODIC CHECKPOINT (mỗi ~15 tool calls)

```
Every ~15 tool calls:
1. Estimate context usage (see Context Monitor)
2. If significant work → update session note + POST /save-session
3. Log: "📌 Checkpoint #{n} saved"
```

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

## Config Location

All settings in: `LPOpenBIMAI/Agent-Memory/memory-config.md`
User can edit directly in Obsidian.
