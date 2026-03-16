---
title: API Patterns
tags:
  - skill
  - agent-swarm
  - backend
group: Backend & Infra
role: API design decisions — REST vs GraphQL vs tRPC, response formats, versioning
source: .agent/skills/api-patterns/SKILL.md
---

# API Patterns

> [!abstract] Skill
> API design principles and decision-making. REST vs GraphQL vs tRPC selection, response formats, versioning, pagination.

## Triggers
`api, endpoint, REST, GraphQL, tRPC, response format, versioning, pagination`

## Key Concepts
- **Protocol selection** — REST vs GraphQL vs tRPC trade-offs
- **Response formats** — Envelope patterns, error shapes, pagination cursors
- **Versioning** — URL vs header vs content negotiation strategies
- **Pagination** — Cursor-based vs offset, infinite scroll patterns
- **Rate limiting** — Throttle design, quota headers

## Connections
- **Used by:** [[Backend Specialist]], [[Database Architect]]
- **Pairs with:** [[Database Design]], [[Node.js Best Practices]]
- **Quality:** [[Testing Patterns]], [[Webapp Testing]]

## Nhóm
Backend & Infra | [[InsForge Hub]] | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu API decisions (protocol, versioning strategy)
- `recall()` — Load project API conventions trước khi thiết kế endpoint mới
