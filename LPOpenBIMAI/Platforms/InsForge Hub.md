---
title: InsForge Hub
tags:
  - platform
  - insforge
  - hub
  - backend
cssclasses:
  - hub-note
aliases:
  - InsForge
  - Backend
---

# ⚡ InsForge — Backend-as-a-Service

> Database + Auth + Storage + AI + Functions + Realtime

## Services

| Service | Mô tả |
|---------|--------|
| **Database** | PostgreSQL + PostgREST API |
| **Auth** | Email/password + OAuth |
| **Storage** | File upload/download |
| **AI** | Chat completions + image generation |
| **Functions** | Serverless edge functions (Deno) |
| **Realtime** | WebSocket pub/sub |

## Dự Án Hiện Tại

| Project | ID | Region |
|---------|---|--------|
| LPOpenBIMAI | `105f7d35-5480-467c-8674-289ce4e91cb4` | — |

## Skills Liên Quan

| Skill | Mô tả |
|-------|--------|
| [[Auto Memory]] | Memory system built on InsForge |
| [[Database Design]] | Schema patterns |
| [[API Patterns]] | REST/GraphQL design |
| [[MCP Builder]] | MCP server building |

## Edge Functions

| Function | Slug | Mô tả |
|----------|------|--------|
| Memory Gateway | `mem-gw-final` | Save/load sessions, GitHub sync |

## Config Files

| File | Đường dẫn |
|------|-----------|
| Memory Config | [[memory-config]] |
| Session Notes | [[session-2026-03-15-antigravity-LPOpenBIMAI]] |
| E2E Guide | [[E2E-Setup-Guide]] |

## 🎯 Coordinator

| Vai trò | Agent | Khi nào |
|---------|-------|---------|
| **Lead** | `backend-specialist` | Mọi InsForge task |
| **Schema** | `database-architect` | Table design, migrations, RLS |
| **Security** | `security-auditor` | Auth flows, RLS policies, API keys |
| **Test** | `test-engineer` | Sau mỗi DB/function change |

> **Routing rule:** `"insforge"` / `"edge function"` / `"db query"` → `backend-specialist`.
> `"schema"` / `"table"` / `"RLS"` → `database-architect`.
> `"auth"` / `"login"` trên InsForge → `security-auditor` + `backend-specialist`.

## Links

- [[Antigravity Kit|← Antigravity Kit]]
- [[AGENT_SWARM|← Agent Swarm MOC]]
- [InsForge GitHub](https://github.com/InsForge/InsForge)
