---
title: Red Team Tactics
tags:
  - skill
  - agent-swarm
  - security
group: Security & Quality
role: Red team based on MITRE ATT&CK — attack phases, detection evasion, reporting
source: .agent/skills/red-team-tactics/SKILL.md
---

# Red Team Tactics

> [!abstract] Skill
> Red team tactics principles based on MITRE ATT&CK. Attack phases, detection evasion, reporting.

## Triggers
`red team, penetration test, MITRE ATT&CK, attack simulation, exploit`

## Key Concepts
- **MITRE ATT&CK** — Tactics, techniques, procedures (TTPs)
- **Kill chain** — Recon → Weaponize → Deliver → Exploit → Control
- **Evasion** — Detection bypass, log manipulation, anti-forensics
- **Reporting** — Evidence chain, severity ratings, remediation advice
- **Purple teaming** — Collaborative red+blue team exercises

## Connections
- **Used by:** [[Penetration Tester]], [[Security Auditor]]
- **Pairs with:** [[Vulnerability Scanner]]
- **Defends:** All platform hubs

## Nhóm
Security & Quality | Cross-platform | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]

## Memory Integration
- `store()` — Lưu attack vectors found, exploit paths
- `recall()` — Load previous pentest results
