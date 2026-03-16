---
title: Intelligent Routing
tags:
  - skill
  - routing
  - agent-selection
  - core
parent: "[[Agent-Skills]]"
skill-folder: intelligent-routing
group: Cross-cutting
aliases:
  - Intelligent Routing Skill
  - Auto Routing
---

# 🧭 Intelligent Routing

> [!abstract] Mục đích
> Tự động phân tích user request và chọn agent persona phù hợp nhất. Không cần user chỉ định `@agent` — hệ thống tự detect domain và route.

## Khi nào dùng

- **Luôn active** — chạy tự động trước MỌI response
- Embedded trong GEMINI.md → Agent Routing Checklist
- Là TIER 0 rule — không skip được

## Cách hoạt động

```
User Request → Silent Analysis:
  1. Detect domains (Frontend, Backend, Security, DB, Mobile...)
  2. Match keywords → Agent mapping
  3. Select best agent(s)
  4. Announce: 🤖 Applying knowledge of @[agent]...
  5. Load agent persona + frontmatter skills
```

## Agent Mapping

| Domain Detected | Agent Selected | Auto-loaded Skills |
|----------------|----------------|-------------------|
| UI, CSS, React, "trang web" | `frontend-specialist` | frontend-design, react-best-practices |
| API, server, database | `backend-specialist` | api-patterns, database-design |
| Bug, lỗi, không hoạt động | `debugger` | systematic-debugging |
| Security, OWASP, hack | `security-auditor` | vulnerability-scanner |
| Mobile, iOS, Android | `mobile-developer` | mobile-design |
| Plan, roadmap, breakdown | `project-planner` | brainstorming, plan-writing |
| Multi-domain | `orchestrator` | parallel-agents |

## Rules

1. **Silent Analysis** — không verbose "I am analyzing..."
2. **User Override** — nếu user nói `@agent`, dùng agent đó
3. **Mandatory Checklist** — phải pass 4-step checklist trước khi code

## Links

- [[Agent-Skills|← Skills Index]]
- [[Behavioral Modes|🎭 Behavioral Modes]]
- [[GEMINI Rules|📜 GEMINI Rules]]
