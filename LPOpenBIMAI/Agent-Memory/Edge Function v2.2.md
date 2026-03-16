---
title: Edge Function v2.2
tags:
  - memory
  - backend
  - insforge
  - edge-function
aliases:
  - mem-gw-final
  - Memory Gateway
---

# 🚀 Edge Function — `mem-gw-final` v2.2

> Edge function chính của hệ thống memory, deployed trên InsForge Deno runtime.

## Thông tin

| Thuộc tính | Giá trị |
|------------|---------|
| **Slug** | `mem-gw-final` |
| **Version** | 2.2 |
| **Size** | 4998 bytes (giới hạn 5000) |
| **Status** | ✅ Active |
| **ID** | `2fff76fe-c92a-4e86-b247-a07c01f746ff` |
| **Created** | 2026-03-16 |
| **Base URL** | `https://4ian5xm8.functions.insforge.app` |

## API Routes

| Route | Method | Mô tả |
|-------|--------|-------|
| `/health` | GET | Health check — trả về version + DB counts |
| `/init-session` | POST | Khởi tạo session mới (conversation_id, ide, project) |
| `/save-session` | POST | Lưu session + optional GitHub push (`push_github: true`) |
| `/sessions` | GET | Danh sách sessions gần nhất (filter by `?project=`) |
| `/context-stats` | GET | Đếm memories + entities |
| `/quotas` | GET | Lấy quota data theo project |
| `/quotas` | POST | Upsert quota data từ agent |
| `/sync-github` | POST | Push sessions lên GitHub |

## Key Functions

### `gp(path, content)` — GitHub Push Helper
Đẩy file lên GitHub repo qua REST API. Tự detect SHA nếu file đã tồn tại (update thay vì create).

### Save Session Flow
```
POST /save-session
  → Insert vào memories table (importance: 0.9)
  → Nếu có decisions[] → insert riêng (importance: 0.85)
  → Nếu push_github: true → gọi gp() push lên GitHub
  → Log vào sync_log table
```

## Database Tables

| Table | Mô tả |
|-------|-------|
| `memories` | Session data, decisions, general memories |
| `entities` | Named entities extracted from sessions |
| `model_quotas` | AI model quota tracking |
| `sync_log` | Sync history (DB ↔ GitHub) |

## Environment Secrets

| Secret | Mô tả |
|--------|-------|
| `INSFORGE_BASE_URL` | InsForge API URL |
| `ANON_KEY` | Anonymous JWT token |
| `GITHUB_PAT` | GitHub Personal Access Token |
| `GITHUB_OWNER` | GitHub username (default: `Long0308`) |
| `GITHUB_REPO` | GitHub repo name |

## Deploy History

| Version | Date | Thay đổi |
|---------|------|----------|
| v2.2 | 2026-03-16 | + `/quotas` GET/POST, `/sync-github`, fix TS type errors |
| v2.0 | 2026-03-15 | + `/sessions`, `/context-stats`, `save-session` |
| v1.0 | 2026-03-15 | Initial: health, init-session |

## Source Code

File: `insforge/functions/mem-gw-final/index.ts` (4998 bytes, minified)

> [!NOTE]
> CLI deploy có bug INVALID_INPUT. Dùng **InsForge MCP `create-function`** tool để deploy.

## Links

- [[Agent-Memory|← Memory System]]
- [[E2E-Setup-Guide|E2E Setup Guide]]
- [[InsForge Hub|InsForge →]]
- [[QUOTA-API-README|Quota API]]
- [[Memory Context Monitor|Dashboard]]
