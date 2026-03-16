---
title: Parallel Agents
tags:
  - skill
  - orchestration
  - multi-agent
  - workflow
parent: "[[Agent-Skills]]"
skill-folder: parallel-agents
group: Dev Workflow — Superpowers
aliases:
  - Parallel Agents Skill
  - Multi-Agent
---

# 🔀 Parallel Agents

> [!abstract] Mục đích
> Patterns cho multi-agent orchestration. Dùng khi nhiều tasks độc lập có thể chạy song song, hoặc khi cần phân tích đa góc nhìn từ nhiều specialist agents.

## Khi nào dùng

- 2+ tasks độc lập, không share state
- Cần comprehensive analysis từ nhiều perspectives
- Code review từ nhiều agents (security + performance + UX)
- Task lớn có thể chia nhỏ

## So sánh với skills tương tự

| Skill | Khi nào dùng |
|-------|-------------|
| `parallel-agents` | Multi-agent patterns + orchestration logic |
| `dispatching-parallel-agents` | 2+ independent tasks chạy ngay |
| `subagent-driven-development` | Tasks độc lập trong CÙNG session |

## Orchestration Patterns

### Fan-out / Fan-in
```
Orchestrator → spawn N agents (parallel)
            → collect results
            → merge + resolve conflicts
            → deliver unified output
```

### Pipeline
```
Agent A (research) → Agent B (design) → Agent C (implement) → Agent D (test)
```

### Cross-review
```
Feature code → Agent 1 (security review)
             → Agent 2 (performance review)
             → Agent 3 (UX review)
             → Merge all feedback
```

## Rules

1. **Chỉ parallel khi THỰC SỰ independent** — shared state = sequential
2. **Có merge strategy** — conflicting outputs phải được resolve
3. **Timeout handling** — agent chậm không block pipeline

## Links

- [[Agent-Skills|← Skills Index]]
- [[Dispatching Parallel Agents|🚀 Dispatching Parallel Agents]]
- [[Subagent Driven Dev|🏗️ Subagent Driven Dev]]
- [[Orchestrator|🎯 Orchestrator Agent]]
