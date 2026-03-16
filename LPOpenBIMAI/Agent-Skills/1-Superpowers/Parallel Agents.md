---
title: Parallel Agents
tags:
  - agent-skill
  - skill
  - orchestration
  - multi-agent
  - workflow
parent: "[[Agent-Skills]]"
skill-folder: parallel-agents
group: Dev Workflow â€” Superpowers
aliases:
  - Parallel Agents Skill
  - Multi-Agent
---

# ðŸ”€ Parallel Agents

> [!abstract] Má»¥c Ä‘Ã­ch
> Patterns cho multi-agent orchestration. DÃ¹ng khi nhiá»u tasks Ä‘á»™c láº­p cÃ³ thá»ƒ cháº¡y song song, hoáº·c khi cáº§n phÃ¢n tÃ­ch Ä‘a gÃ³c nhÃ¬n tá»« nhiá»u specialist agents.

## Khi nÃ o dÃ¹ng

- 2+ tasks Ä‘á»™c láº­p, khÃ´ng share state
- Cáº§n comprehensive analysis tá»« nhiá»u perspectives
- Code review tá»« nhiá»u agents (security + performance + UX)
- Task lá»›n cÃ³ thá»ƒ chia nhá»

## So sÃ¡nh vá»›i skills tÆ°Æ¡ng tá»±

| Skill | Khi nÃ o dÃ¹ng |
|-------|-------------|
| `parallel-agents` | Multi-agent patterns + orchestration logic |
| `dispatching-parallel-agents` | 2+ independent tasks cháº¡y ngay |
| `subagent-driven-development` | Tasks Ä‘á»™c láº­p trong CÃ™NG session |

## Orchestration Patterns

### Fan-out / Fan-in
```
Orchestrator â†’ spawn N agents (parallel)
            â†’ collect results
            â†’ merge + resolve conflicts
            â†’ deliver unified output
```

### Pipeline
```
Agent A (research) â†’ Agent B (design) â†’ Agent C (implement) â†’ Agent D (test)
```

### Cross-review
```
Feature code â†’ Agent 1 (security review)
             â†’ Agent 2 (performance review)
             â†’ Agent 3 (UX review)
             â†’ Merge all feedback
```

## Rules

1. **Chá»‰ parallel khi THá»°C Sá»° independent** â€” shared state = sequential
2. **CÃ³ merge strategy** â€” conflicting outputs pháº£i Ä‘Æ°á»£c resolve
3. **Timeout handling** â€” agent cháº­m khÃ´ng block pipeline

## Links

- [[Agent-Skills|â† Skills Index]]
- [[Dispatching Parallel Agents|ðŸš€ Dispatching Parallel Agents]]
- [[Subagent Driven Dev|ðŸ—ï¸ Subagent Driven Dev]]
- [[Orchestrator|ðŸŽ¯ Orchestrator Agent]]
