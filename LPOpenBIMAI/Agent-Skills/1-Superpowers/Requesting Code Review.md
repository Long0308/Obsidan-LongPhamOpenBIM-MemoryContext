---
title: Requesting Code Review
tags:
  - agent-skill
  - skill
  - superpowers
  - quality
group: Superpowers
role: Request code review tá»« subagent trÆ°á»›c khi merge
source: .agent/skills/requesting-code-review/SKILL.md
---

# Requesting Code Review

> [!abstract] Vai TrÃ²
> Dispatch code-reviewer subagent Ä‘á»ƒ catch issues trÆ°á»›c khi cascade. Reviewer nháº­n crafted context cho evaluation â€” KHÃ”NG inherit session history.

## When to Request

**Mandatory:**
- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request (3 Steps)

### 1. Get git SHAs
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

### 2. Dispatch code-reviewer subagent
Fill template táº¡i `code-reviewer.md` vá»›i:
- `{WHAT_WAS_IMPLEMENTED}` â€” what you just built
- `{PLAN_OR_REQUIREMENTS}` â€” what it should do
- `{BASE_SHA}` â€” starting commit
- `{HEAD_SHA}` â€” ending commit

### 3. Act on feedback

| Priority | Action |
|----------|--------|
| **Critical** | Fix immediately |
| **Important** | Fix before proceeding |
| **Minor** | Note for later |
| **Wrong** | Push back with reasoning |

## Integration with Workflows

| Workflow | Review timing |
|----------|--------------|
| **Subagent-Driven Dev** | After EACH task |
| **Executing Plans** | After each batch (3 tasks) |
| **Ad-Hoc Dev** | Before merge / when stuck |

## Red Flags

- Skip review vÃ¬ "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

## Connections
- **Counterpart:** [[Receiving Code Review]]
- **Used by:** [[Subagent Driven Dev]], [[Executing Plans]]
- **Related:** [[Finishing Dev Branch]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
