---
title: Intelligent Routing
tags:
  - agent-skill
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

# ðŸ§­ Intelligent Routing

> [!abstract] Má»¥c Ä‘Ã­ch
> Tá»± Ä‘á»™ng phÃ¢n tÃ­ch user request vÃ  chá»n agent persona phÃ¹ há»£p nháº¥t. KhÃ´ng cáº§n user chá»‰ Ä‘á»‹nh `@agent` â€” há»‡ thá»‘ng tá»± detect domain vÃ  route.

## Khi nÃ o dÃ¹ng

- **LuÃ´n active** â€” cháº¡y tá»± Ä‘á»™ng trÆ°á»›c Má»ŒI response
- Embedded trong GEMINI.md â†’ Agent Routing Checklist
- LÃ  TIER 0 rule â€” khÃ´ng skip Ä‘Æ°á»£c

## CÃ¡ch hoáº¡t Ä‘á»™ng

```
User Request â†’ Silent Analysis:
  1. Detect domains (Frontend, Backend, Security, DB, Mobile...)
  2. Match keywords â†’ Agent mapping
  3. Select best agent(s)
  4. Announce: ðŸ¤– Applying knowledge of @[agent]...
  5. Load agent persona + frontmatter skills
```

## Agent Mapping

| Domain Detected | Agent Selected | Auto-loaded Skills |
|----------------|----------------|-------------------|
| UI, CSS, React, "trang web" | `frontend-specialist` | frontend-design, react-best-practices |
| API, server, database | `backend-specialist` | api-patterns, database-design |
| Bug, lá»—i, khÃ´ng hoáº¡t Ä‘á»™ng | `debugger` | systematic-debugging |
| Security, OWASP, hack | `security-auditor` | vulnerability-scanner |
| Mobile, iOS, Android | `mobile-developer` | mobile-design |
| Plan, roadmap, breakdown | `project-planner` | brainstorming, plan-writing |
| Multi-domain | `orchestrator` | parallel-agents |

## Rules

1. **Silent Analysis** â€” khÃ´ng verbose "I am analyzing..."
2. **User Override** â€” náº¿u user nÃ³i `@agent`, dÃ¹ng agent Ä‘Ã³
3. **Mandatory Checklist** â€” pháº£i pass 4-step checklist trÆ°á»›c khi code

## Links

- [[Agent-Skills|â† Skills Index]]
- [[Behavioral Modes|ðŸŽ­ Behavioral Modes]]
- [[GEMINI Rules|ðŸ“œ GEMINI Rules]]
