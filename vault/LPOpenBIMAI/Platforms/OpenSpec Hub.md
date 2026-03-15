---
title: OpenSpec Hub
tags:
  - platform
  - openspec
  - hub
  - spec-driven
cssclasses:
  - hub-note
aliases:
  - OpenSpec
---

# 📋 OpenSpec — Spec-Driven Development

> Agree before you build — [github.com/Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec)

## Workflow

```mermaid
graph LR
    E["🔍 Explore"] --> P["📝 Propose"]
    P --> A["⚡ Apply"]
    A --> AR["📦 Archive"]
```

## Slash Commands

| Command | Skill | Mô tả |
|---------|-------|--------|
| `/opsx:explore` | [[openspec-explore]] | Khảo sát, suy nghĩ |
| `/opsx:propose` | [[openspec-propose]] | Tạo proposal + design + tasks |
| `/opsx:apply` | [[openspec-apply-change]] | Implement tasks |
| `/opsx:archive` | [[openspec-archive-change]] | Archive change |

## Artifacts Per Change

```
openspec/changes/<name>/
├── proposal.md   ← What & Why
├── design.md     ← How  
└── tasks.md      ← Implementation steps
```

## Mapping → Superpowers

| OpenSpec | → | Superpowers |
|---------|---|-------------|
| Explore | → | [[Brainstorming]] |
| Propose | → | [[Writing Plans]] |
| Apply | → | [[Executing Plans]] |
| Archive | → | [[Finishing Dev Branch]] |

## 🎯 Coordinator

| Command | Agent | Vai trò |
|---------|-------|---------|
| `/opsx:explore` | `project-planner` | Research, suy nghĩ yêu cầu |
| `/opsx:propose` | `project-planner` + `security-auditor` | Design + security review |
| `/opsx:apply` | `orchestrator` → multi-agent | Decompose tasks → dispatch |
| `/opsx:archive` | `devops-engineer` | Merge, PR, cleanup |

> **Routing rule:** `"openspec"` / `"propose"` / `"explore change"` → `project-planner`.
> `"apply change"` → `orchestrator` (vì cross-domain).
> `"archive"` → `devops-engineer`.

## Links

- [[Antigravity Kit|← Antigravity Kit]]
- [[AGENT_SWARM|← Agent Swarm MOC]]
- [[OpenSpec Integration]] — CLI reference & setup
