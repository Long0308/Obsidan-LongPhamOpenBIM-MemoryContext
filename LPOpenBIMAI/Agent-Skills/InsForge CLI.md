---
title: InsForge CLI
tags:
  - skill
  - agent-swarm
  - backend
  - insforge
  - devops
group: Backend & Infra
role: Backend infrastructure — tables, SQL, edge functions, storage, deployment
source: .agents/skills/insforge-cli/SKILL.md
---

# InsForge CLI

> [!abstract] Skill
> Backend infrastructure management via InsForge CLI. Creating tables, running SQL, deploying edge functions, managing storage buckets, secrets, cron jobs.

## Triggers
`insforge-cli, create table, deploy function, storage bucket, edge function, cron, secrets`

## Key Concepts
- **Database management** — Create/alter tables, run migrations via SQL
- **Edge Functions** — Deploy serverless functions, manage secrets
- **Storage** — Create buckets, configure access policies
- **Frontend hosting** — Deploy static sites
- **Cron jobs** — Scheduled tasks, recurring operations
- **Logs & backups** — View logs, export/import databases

## Connections
- **Used by:** [[Backend Specialist]], [[DevOps Engineer]]
- **Pairs with:** [[InsForge SDK]], [[Database Design]], [[Deployment Procedures]]
- **Platform:** [[InsForge Hub]]

## Nhóm
Backend & Infra | [[InsForge Hub]] | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu deployment configs, function names
- `recall()` — Load InsForge project state trước khi deploy
