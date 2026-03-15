---
title: Deployment Procedures
tags:
  - skill
  - agent-swarm
  - backend
  - devops
group: Backend & Infra
role: Safe deployment workflows, rollback strategies, verification
source: .agent/skills/deployment-procedures/SKILL.md
---

# Deployment Procedures

> [!abstract] Skill
> Production deployment principles and decision-making. Safe deployment workflows, rollback strategies, and verification.

## Triggers
`deploy, release, rollback, staging, production, CI/CD, blue-green, canary`

## Key Concepts
- **5-Phase deployment** — Pre-flight → Stage → Canary → Roll → Verify
- **Rollback strategy** — Instant rollback, database migration rollback
- **Blue-green** — Zero-downtime deployment patterns
- **Feature flags** — Gradual rollout, kill switches
- **Verification** — Smoke tests, health checks, monitoring

## Connections
- **Used by:** [[DevOps Engineer]], [[Backend Specialist]]
- **Pairs with:** [[Server Management]], [[Verification]]
- **Precedes:** [[Finishing Dev Branch]]

## Nhóm
Backend & Infra | Cross-platform | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu deployment history, rollback procedures
- `recall()` — Load deployment checklist trước khi release
