---
title: Architecture
tags:
  - skill
  - agent-swarm
  - planning
group: Backend & Infra
role: Architectural decision-making — requirements analysis, trade-off evaluation, ADR
source: .agent/skills/architecture/SKILL.md
---

# Architecture

> [!abstract] Skill
> Architectural decision-making framework. Requirements analysis, trade-off evaluation, ADR documentation.

## Triggers
`architecture, system design, ADR, trade-off, scalability, monolith, microservice`

## Key Concepts
- **ADR (Architecture Decision Records)** — Document why, not just what
- **Trade-off analysis** — CAP theorem, consistency vs availability
- **Pattern selection** — Monolith vs microservices vs serverless
- **Dependency analysis** — Coupling, cohesion, boundary context
- **Evolution strategy** — Strangler fig, incremental migration

## Connections
- **Used by:** [[Backend Specialist]], [[Orchestrator]], [[Project Planner]]
- **Pairs with:** [[Database Design]], [[API Patterns]], [[Deployment Procedures]]
- **Precedes:** [[Writing Plans]]

## Nhóm
Backend & Infra | Cross-platform | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu ADRs và architectural decisions
- `recall()` — Load kiến trúc hiện tại trước khi đề xuất thay đổi
