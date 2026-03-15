---
title: MCP Builder
tags:
  - skill
  - agent-swarm
  - backend
  - mcp
group: Backend & Infra
role: MCP server building — tool design, resource patterns, best practices
source: .agent/skills/mcp-builder/SKILL.md
---

# MCP Builder

> [!abstract] Skill
> MCP (Model Context Protocol) server building principles. Tool design, resource patterns, best practices.

## Triggers
`MCP, model context protocol, tool design, MCP server, resources, prompts`

## Key Concepts
- **Tool design** — Input schemas, error handling, idempotency
- **Resource patterns** — URI templates, dynamic resources, subscriptions
- **Server lifecycle** — Initialization, capabilities, shutdown
- **Transport** — stdio vs SSE vs WebSocket
- **Best practices** — Security, rate limiting, caching

## Connections
- **Used by:** [[Backend Specialist]], [[Orchestrator]]
- **Pairs with:** [[API Patterns]], [[Node.js Best Practices]]
- **Infra:** [[Server Management]], [[Deployment Procedures]]

## Nhóm
Backend & Infra | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu MCP server configs, tool definitions
- `recall()` — Load existing MCP patterns khi build server mới
