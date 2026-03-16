---
group: "Config & Rules"
title: MCP Config
tags:
  - antigravity
  - config
  - mcp
  - memory
  - infrastructure
parent: "[[Antigravity Kit]]"
aliases:
  - MCP Servers
  - mcp_config.json
---
group: "Config & Rules"
# 🔌 MCP Config — Server Reference

> [!info] Tổng Quan
> MCP (Model Context Protocol) servers kết nối AI agent với tools bên ngoài.
> File gốc: `{user_home}/.gemini/antigravity/mcp_config.json`

---
group: "Config & Rules"
## Active Servers

### 1. InsForge (`insforge`)

| Key | Value |
|-----|-------|
| Package | `@insforge/mcp` |
| Vai trò | Backend services — database, auth, storage, edge functions, AI |
| Tools | `run-raw-sql`, `get-table-schema`, `create-function`, `create-deployment`, `bulk-upsert`, bucket management |
| Config | API key via `--api_key`, project linked via `npx @insforge/cli link` |
| Databases | `memories`, `entities`, `sync_log`, `model_quotas` |
| Edge Functions | `mem-gw-final` (Memory Gateway v2.2) |

> [!tip] Vai trò trong hệ thống
> InsForge là **backbone** của toàn bộ memory system. Mọi session save, quota tracking, sync log đều đi qua InsForge.

### 2. GitHub MCP (`github-mcp-server`)

| Key | Value |
|-----|-------|
| Package | `@modelcontextprotocol/server-github` |
| Vai trò | Git operations — PRs, Issues, Code search, commits |
| Tools | `create_pull_request`, `push_files`, `search_code`, `list_commits` |
| Config | `GITHUB_PERSONAL_ACCESS_TOKEN` env var |
| Repos | `Long0308/Obsidan-LongPhamOpenBIM-MemoryContext` |

> [!tip] Vai trò trong hệ thống
> GitHub MCP phục vụ 2 mục đích: (1) code management cho projects, (2) session backup — `mem-gw-final` push session notes lên GitHub qua PAT.

### 3. Firecrawl (`firecrawl-mcp`)

| Key | Value |
|-----|-------|
| Package | `firecrawl-mcp` |
| Vai trò | Web scraping, search, content extraction |
| Tools | `firecrawl_scrape`, `firecrawl_search`, `firecrawl_map`, `firecrawl_agent` |
| Config | `FIRECRAWL_API_KEY` env var |

> [!tip] Vai trò trong hệ thống
> Research agent — khi cần tìm docs, analyze websites, extract data từ URLs.

### 4. Google Stitch (`StitchMCP`)

| Key | Value |
|-----|-------|
| Package | `mcp-remote` → Google Stitch SSE |
| Vai trò | AI-powered UI generation |
| Tools | `generate_screen_from_text`, `edit_screens`, `generate_variants` |
| Config | OAuth via Google Account |

> [!tip] Vai trò trong hệ thống
> Design pipeline — tạo UI mockups và screens từ text prompts. Kết hợp với `stitch-loop` skill để iterative design.

### 5. Revit API Docs (`revit-api-docs`)

| Key | Value |
|-----|-------|
| Package | `Rvt_Docs_MCP` |
| Vai trò | Revit API documentation lookup |
| Tools | `search-docs`, `retrieve-doc`, `retrieve-docs` |
| Config | Local Python server |
| Versions | 2023–2026 |

> [!tip] Vai trò trong hệ thống
> BIM development — tra cứu Revit API classes, methods, properties. Hỗ trợ cho Revit plugin development.

### 6. MCP Server for Revit (`mcp-server-for-revit`)

| Key | Value |
|-----|-------|
| Package | `mcp-server-for-revit` |
| Vai trò | Direct Revit model manipulation |
| Tools | `create_line_based_element`, `create_room`, `create_grid`, `ai_element_filter`, `send_code_to_revit` |
| Config | WebSocket connection to running Revit instance |

> [!tip] Vai trò trong hệ thống
> BIM automation — tạo walls, floors, rooms, grids trực tiếp trong Revit model. Kết hợp với `revit-api-docs` cho AI-assisted BIM development.

---
group: "Config & Rules"
## Disabled Servers

### 7. Firebase (`firebase-mcp-server`)
- Package: `firebase-tools`
- Lý do tắt: Chưa dùng Firebase. Sẵn sàng bật khi cần.

### 8. Sequential Thinking (`sequential-thinking`)
- Package: `@modelcontextprotocol/server-sequential-thinking`
- Lý do tắt: Bật khi cần reasoning phức tạp theo chuỗi.

### 9. Excel (`excel`)
- Package: `@negokaz/excel-mcp-server`
- Lý do tắt: Bật khi cần xử lý Excel files.

### 10. Cloud Run (`cloudrun`)
- Package: `@google-cloud/cloud-run-mcp`
- Lý do tắt: Chưa dùng GCP. Sẵn sàng khi scale.

### 11. Filesystem (`filesystem`)
- Package: `@modelcontextprotocol/server-filesystem`
- Lý do tắt: Redundant — agent đã có file access built-in.

### 12. Stitch SSE (`stitch`)
- Lý do tắt: Thay thế bằng `StitchMCP` (mcp-remote).

---
group: "Config & Rules"
## Đặc Biệt: Superset MCP

| Key | Value |
|-----|-------|
| Server | `superset-mcp` |
| URL | `http://localhost:8088` |
| Machine | Chỉ máy công ty (`C:\Users\philong.pham\`) |

> [!warning] Machine-Specific
> Superset MCP config trỏ đến máy công ty — không hoạt động trên máy cá nhân.

---
group: "Config & Rules"
## Kiến Trúc MCP trong Pipeline

```
User Request
    ↓
Antigravity (GEMINI.md rules)
    ↓
┌─────────────────────────────────────┐
│ MCP Servers (active)                │
│                                     │
│  InsForge ─── memory, DB, deploy    │
│  GitHub ───── git, PRs, backup      │
│  Firecrawl ── research, scrape      │
│  Stitch ───── UI generation         │
│  Revit API ── BIM docs              │
│  Revit MCP ── BIM automation        │
└─────────────────────────────────────┘
    ↓
Output → Memory Save → Dashboard
```

## Cách Bật/Tắt Server

1. Mở `{user_home}/.gemini/antigravity/mcp_config.json`
2. Tìm server cần bật → đổi `"disabled": true` → `"disabled": false`
3. Restart Antigravity (IDE)

## Links

- [[GEMINI Rules|← GEMINI Rules]]
- [[Antigravity Kit|← Antigravity Kit]]
- [[AGENT_SWARM|← Agent Swarm MOC]]
- [[Edge Function v2.2|⚡ Memory Gateway]]
- [[Symbiotic Pipeline|🔄 Symbiotic Pipeline]]
