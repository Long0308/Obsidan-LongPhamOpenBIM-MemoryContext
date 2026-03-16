---
parent: "[[Agent-Memory]]"
group: "Infrastructure"
title: "Context Hub Analysis — Andrew Ng"
tags:
  - ai-agent
  - memory
  - context-hub
  - architecture
  - reference
aliases:
  - Context Hub
  - chub
created: 2026-03-15
source: https://github.com/andrewyng/context-hub
---
group: "Infrastructure"
# 🔗 Context Hub — Phân Tích & Ứng Dụng

> **Context Hub** (by Andrew Ng / AI Suite) — CLI + MCP server cung cấp curated docs cho coding agents, với khả năng **tự học** qua annotations và feedback.  
> **NPM:** `@aisuite/chub` | **License:** MIT | ⭐ 5.8K

## Kiến trúc chính

```
Agent → chub search "query"    ← tìm docs/skills
      → chub get id --lang py  ← fetch docs (incremental)
      → [Sử dụng docs để code]
      → chub annotate id "note" ← ghi chú cho lần sau
      → chub feedback id up     ← rating cho tác giả
```

### MCP Server (5 tools)

| Tool | Chức năng | Mapping trong hệ thống ta |
|------|-----------|--------------------------|
| `chub_search` | Tìm kiếm docs/skills theo query | KI system search, skill discovery |
| `chub_get` | Fetch docs theo ID + language | `view_file` SKILL.md, session note |
| `chub_list` | Liệt kê tất cả entries | `list_dir` skills/, knowledge/ |
| `chub_annotate` | Ghi chú cục bộ gắn vào docs | ❌ **THIẾU** — ta chưa có |
| `chub_feedback` | Rating up/down gửi cho tác giả | ❌ **THIẾU** — ta chưa có |

### Lib Modules

| Module | Chức năng | Ta có? |
|--------|-----------|--------|
| `annotations.js` | Local notes persist qua sessions | ❌ Cần thêm |
| `cache.js` | Cache docs locally + incremental fetch | 🟡 Có cache KI nhưng không incremental |
| `config.js` | Config JSON (CDN, telemetry, cache dir) | ✅ GEMINI.md + user_rules |
| `identity.js` | Hashed machine UUID (anonymous) | ✅ installationId từ API |
| `telemetry.js` | PostHog analytics + feedback API | ❌ Cần thêm |
| `registry.js` | Registry tất cả docs/skills | ✅ `.agent/skills/` + KI system |
| `build.js` | Build/copy docs vào local cache | ❌ Không cần (dùng filesystem) |

---
group: "Infrastructure"
## 6 Pattern có thể áp dụng

### 1. 📝 Annotations — Ghi chú cục bộ xuyên sessions

**Context Hub cách làm:**
```bash
chub annotate stripe/api "Needs raw body for webhook verification"
# Next session → annotation tự động hiện khi chub get
```

**Áp dụng cho hệ thống ta:**
- Thêm `annotations/` folder trong `Agent-Memory/`
- Mỗi file = 1 annotation: `{skill-id}.json` chứa `{ note, updatedAt, source_session }`
- Auto-memory protocol tự đọc annotations liên quan khi load session
- Khi agent phát hiện gotcha/workaround → tự ghi annotation

### 2. 📊 Feedback Loop — Self-Improving Agent

**Context Hub cách làm:**
- Agent rate `up/down` + structured labels
- Labels: `accurate`, `outdated`, `incomplete`, `wrong-examples`...
- Data gửi về tác giả → cải thiện docs

**Áp dụng cho hệ thống ta:**
- Thêm `/feedback` endpoint vào `mem-gw-final` API
- Sau mỗi session, agent rate session quality
- Labels cho skills: `useful`, `outdated`, `needs-update`, `confusing`
- Track skill effectiveness qua thời gian

### 3. 📦 Incremental Fetch — Tiết kiệm tokens

**Context Hub cách làm:**
- `--file` = fetch 1 file cụ thể
- `--full` = fetch toàn bộ
- Mặc định chỉ fetch entry point

**Áp dụng cho hệ thống ta:**
- KI và session notes hiện load toàn bộ → lãng phí tokens
- **Progressive Disclosure:** Load summary trước → load chi tiết khi cần
- Session note có 3 layer: metadata → summary → full content
- SKILL.md nên có INDEX section → agent chỉ đọc section liên quan

### 4. 🤖 MCP Server cho Memory

**Context Hub cách làm:**
- Expose tất cả operations qua MCP protocol
- Agent gọi tools trực tiếp thay vì CLI commands

**Áp dụng cho hệ thống ta:**
- Xây MCP server cho auto-memory system
- Tools: `mem_search`, `mem_save`, `mem_annotate`, `mem_get_session`
- Resources: `mem://sessions`, `mem://annotations`, `mem://quotas`
- Agent tương tác trực tiếp thay vì POST API

### 5. 🆔 SKILL.md Pattern — Agent Workflow 5 bước

**Context Hub cách làm:**
```
Step 1: Search → Step 2: Fetch → Step 3: Use → Step 4: Annotate → Step 5: Feedback
```

**Áp dụng cho auto-memory:**
```
Step 1: Load sessions   → Step 2: Init session  → Step 3: Work
Step 4: Checkpoint save → Step 5: End session + Annotate + Feedback
```

### 6. 🔐 Citations — Truy xuất observations theo ID

**Context Hub cách làm:**
- Mỗi doc có ID duy nhất (`stripe/api`, `openai/chat`)
- Annotations gắn vào ID cụ thể

**Áp dụng cho hệ thống ta:**
- Session IDs: `session-{date}-{ide}-{project}`
- Observation IDs: `obs-{n}` trong mỗi session
- Link trực tiếp: `obsidian://open?vault=10.Obsidan&file=session-2026-03-15...`

---
group: "Infrastructure"
## So sánh tổng thể

```
  Hệ thống hiện tại (Auto-Memory)       Context Hub (Andrew Ng)
  ──────────────────────────────         ───────────────────────
  ✅ Session notes persist               ✅ Annotations persist
  ✅ KI system (semantic memory)         ✅ Curated docs registry
  ✅ Skills/workflows (procedural)       ✅ Skills fetching
  ✅ GitHub + Obsidian storage           ✅ CLI + CDN storage
  ❌ No annotations per-skill            ✅ Local annotations
  ❌ No feedback/rating system           ✅ Upvote/downvote docs
  ❌ No incremental loading              ✅ Incremental fetch
  ❌ No MCP server for memory            ✅ MCP server exposure
  🟡 Heuristic context tracking          ❌ No context tracking
  ✅ Dashboard UI                        ❌ No dashboard
  ✅ Live quota monitoring               ❌ No quota system
```

---
group: "Infrastructure"
## Links

- [[Memory Types trong Agentic Systems|← Memory Types]]
- [[AI Agent Resources|AI Agent Resources]]
- [[E2E-Setup-Guide|E2E Setup Guide]]
- [Context Hub GitHub](https://github.com/andrewyng/context-hub)
