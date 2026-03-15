---
title: InsForge SDK
tags:
  - skill
  - agent-swarm
  - backend
  - insforge
group: Backend & Infra
role: Frontend code with InsForge — database queries, auth, storage, AI, real-time
source: .agents/skills/insforge/SKILL.md
---

# InsForge SDK

> [!abstract] Skill
> Frontend SDK patterns for InsForge. Database queries, authentication, file uploads, AI features, real-time messaging from client code.

## Triggers
`insforge, @insforge/sdk, database query, auth flow, file upload, real-time, AI chat`

## Key Concepts
- **Database** — Query, insert, update, delete with `@insforge/sdk`
- **Authentication** — Login, signup, OAuth, password reset flows
- **Storage** — File upload/download, bucket management
- **AI features** — Chat completions, image generation
- **Real-time** — WebSocket channels, subscriptions
- **RLS policies** — Row-level security from frontend perspective

## Connections
- **Used by:** [[Backend Specialist]], [[Frontend Specialist]]
- **Pairs with:** [[InsForge CLI]], [[Database Design]], [[API Patterns]]
- **Platform:** [[InsForge Hub]]

## Nhóm
Backend & Infra | [[InsForge Hub]] | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu InsForge project config, table schemas
- `recall()` — Load project InsForge setup trước khi code
