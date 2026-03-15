---
title: Database Design
tags:
  - skill
  - agent-swarm
  - backend
  - database
group: Backend & Infra
role: Schema design, indexing, ORM selection, serverless databases
source: .agent/skills/database-design/SKILL.md
---

# Database Design

> [!abstract] Skill
> Database design principles and decision-making. Schema design, indexing strategy, ORM selection, serverless databases.

## Triggers
`database, schema, migration, index, ORM, SQL, PostgreSQL, Supabase, serverless DB`

## Key Concepts
- **Schema design** — Normalization vs denormalization trade-offs
- **Indexing** — B-tree, GIN, partial indexes, covering indexes
- **ORM selection** — Prisma vs Drizzle vs raw SQL decision framework
- **Serverless databases** — Supabase, PlanetScale, Neon patterns
- **Migration strategy** — Version control, rollback safety, zero-downtime

## Connections
- **Used by:** [[Backend Specialist]], [[Database Architect]]
- **Pairs with:** [[API Patterns]], [[Node.js Best Practices]]
- **Quality:** [[Vulnerability Scanner]] (SQL injection prevention)

## Nhóm
Backend & Infra | [[InsForge Hub]] | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu schema decisions, index strategies
- `recall()` — Load current schema context trước khi thêm tables
