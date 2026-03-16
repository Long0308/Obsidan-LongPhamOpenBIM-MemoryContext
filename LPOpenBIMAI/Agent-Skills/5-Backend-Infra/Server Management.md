---
title: Server Management
tags:
  - skill
  - agent-swarm
  - backend
  - devops
group: Backend & Infra
role: Process management, monitoring strategy, scaling decisions
source: .agent/skills/server-management/SKILL.md
---

# Server Management

> [!abstract] Skill
> Server management principles and decision-making. Process management, monitoring strategy, and scaling decisions.

## Triggers
`server, process, monitoring, scaling, PM2, nginx, reverse proxy, load balancer`

## Key Concepts
- **Process management** — PM2, systemd, Docker orchestration
- **Monitoring** — Health checks, metrics, alerting strategies
- **Scaling** — Horizontal vs vertical, auto-scaling triggers
- **Reverse proxy** — Nginx, Caddy, SSL termination
- **Logging** — Structured logs, log rotation, centralized logging

## Connections
- **Used by:** [[DevOps Engineer]], [[Backend Specialist]]
- **Pairs with:** [[Deployment Procedures]], [[Performance Profiling]]
- **Security:** [[Vulnerability Scanner]]

## Nhóm
Backend & Infra | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu server configs, monitoring rules
- `recall()` — Load infrastructure context trước khi scaling/deploy
