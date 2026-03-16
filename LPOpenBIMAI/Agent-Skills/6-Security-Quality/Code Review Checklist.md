---
title: Code Review Checklist
tags:
  - skill
  - agent-swarm
  - quality
group: Security & Quality
role: Code review guidelines — quality, security, best practices
source: .agent/skills/code-review-checklist/SKILL.md
---

# Code Review Checklist

> [!abstract] Skill
> Code review guidelines covering code quality, security, and best practices. Systematic checklist for thorough reviews.

## Triggers
`checklist, code review, PR review, quality gate, review guidelines`

## Key Concepts
- **Quality checks** — Naming, complexity, DRY, SOLID principles
- **Security review** — Input validation, auth checks, data exposure
- **Performance** — N+1 queries, memory leaks, unnecessary renders
- **Maintainability** — Test coverage, documentation, error handling
- **Architecture** — Separation of concerns, dependency direction

## Connections
- **Used by:** [[Test Engineer]], [[Security Auditor]]
- **Pairs with:** [[Requesting Code Review]], [[Receiving Code Review]]
- **Applies:** [[Clean Code]]

## Nhóm
Security & Quality | Cross-platform | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu recurring review findings, team conventions
- `recall()` — Load project-specific review criteria
