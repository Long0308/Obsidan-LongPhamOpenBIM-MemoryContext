---
title: MCP Config
tags:
  - antigravity
  - config
  - mcp
  - memory
parent: "[[Antigravity Kit]]"
aliases:
  - MCP Servers
  - mcp_config.json
---

# 🔌 MCP Config — Server Reference

> [!info] Tổng Quan
> MCP (Model Context Protocol) servers kết nối AI agent với tools bên ngoài. File gốc: `{user_home}/.gemini/antigravity/mcp_config.json`

## Active Servers

| # | Server | Package | Vai trò |
|---|--------|---------|---------|
| 1 | **obsidian-mcp** | `obsidian-mcp` | Read/write Obsidian vault notes |
| 2 | **firecrawl-mcp** | `firecrawl-mcp` | Web scraping + search |
| 3 | **github-mcp-server** | `@modelcontextprotocol/server-github` | Git, PRs, Issues |
| 4 | **supabase-mcp-server** | `@supabase/mcp-server-supabase` | Database + Edge Functions |
| 5 | **StitchMCP** | `mcp-remote` + Google Stitch | UI generation |
| 6 | **revit-api-docs** | `Rvt_Docs_MCP` | Revit API documentation |
| 7 | **mcp-server-for-revit** | `mcp-server-for-revit` | Revit BIM automation |
| 8 | **insforge** | `@insforge/mcp` | InsForge backend services |

## Disabled Servers (sẵn sàng bật)

| Server | Package | Lý do tắt |
|--------|---------|-----------|
| firebase-mcp-server | `firebase-tools` | Chưa dùng Firebase |
| sequential-thinking | `@modelcontextprotocol/server-sequential-thinking` | Dùng khi cần |
| excel | `@negokaz/excel-mcp-server` | Dùng khi cần |
| cloudrun | `@google-cloud/cloud-run-mcp` | Chưa dùng GCP |
| filesystem | `@modelcontextprotocol/server-filesystem` | Dùng khi cần |
| stitch (SSE) | Google Stitch SSE | Thay bằng StitchMCP |

## Đặc Biệt: Superset MCP

| Key | Value |
|-----|-------|
| Server | superset-mcp |
| URL | `http://localhost:8088` |
| Ghi chú | Chỉ dùng trên máy công ty (`philong.pham`) |

> [!note] Machine-Specific
> Superset MCP config trỏ đến `C:\Users\philong.pham\` — chỉ hoạt động trên máy công ty.

## Cách Bật/Tắt Server

1. Mở `{user_home}/.gemini/antigravity/mcp_config.json`
2. Tìm server cần bật → đổi `"disabled": true` → `"disabled": false`
3. Restart Antigravity (IDE)

## Links

- [[GEMINI Rules|← GEMINI Rules]]
- [[Antigravity Kit|← Antigravity Kit]]
- [[AGENT_SWARM|← Agent Swarm MOC]]
