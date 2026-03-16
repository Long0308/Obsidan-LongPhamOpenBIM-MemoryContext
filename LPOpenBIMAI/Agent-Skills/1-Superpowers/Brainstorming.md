---
title: Brainstorming
tags:
  - agent-skill
  - skill
  - superpowers
  - planning
group: Superpowers
role: Ã tÆ°á»Ÿng ban Ä‘áº§u, phÃ¢n tÃ­ch requirements trÆ°á»›c khi code
source: .agent/skills/brainstorming/SKILL.md
---

# Brainstorming â€” Ideas Into Designs

> [!abstract] Vai TrÃ²
> PHáº¢I dÃ¹ng trÆ°á»›c Má»ŒI creative work â€” táº¡o features, build components, thÃªm functionality, sá»­a behavior. KhÃ¡m phÃ¡ intent, requirements, design trÆ°á»›c implementation.

> [!caution] HARD GATE
> KHÃ”NG Ä‘Æ°á»£c invoke báº¥t ká»³ implementation skill, viáº¿t code, scaffold project, hay thá»±c thi báº¥t ká»³ action nÃ o TRÆ¯á»šC KHI present design VÃ€ user Ä‘Ã£ approve. Ãp dá»¥ng cho Má»ŒI project báº¥t ká»ƒ má»©c Ä‘á»™ Ä‘Æ¡n giáº£n.

## Anti-Pattern: "This Is Too Simple"

Má»i project Ä‘á»u Ä‘i qua process nÃ y. Todo list, utility function, config change â€” táº¥t cáº£. "Simple" projects lÃ  nÆ¡i unexamined assumptions gÃ¢y waste nhiá»u nháº¥t. Design cÃ³ thá»ƒ ngáº¯n (vÃ i cÃ¢u cho project Ä‘Æ¡n giáº£n), nhÆ°ng PHáº¢I present vÃ  get approval.

## Checklist (9 bÆ°á»›c báº¯t buá»™c)

| # | BÆ°á»›c | MÃ´ táº£ |
|---|------|--------|
| 1 | Explore project context | Check files, docs, recent commits |
| 2 | Offer visual companion | Náº¿u topic cÃ³ visual questions (message riÃªng!) |
| 3 | Ask clarifying questions | Tá»«ng cÃ¢u má»™t, hiá»ƒu purpose/constraints/success |
| 4 | Propose 2-3 approaches | Trade-offs + recommendation |
| 5 | Present design | Theo sections, get approval tá»«ng pháº§n |
| 6 | Write design doc | Save to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md` |
| 7 | Spec review loop | Dispatch reviewer subagent (max 5 iterations) |
| 8 | User reviews spec | User approve trÆ°á»›c khi proceed |
| 9 | Transition | â†’ Invoke [[Writing Plans]] (ONLY skill) |

## Process â€” Understanding Ideas

**Hiá»ƒu Ã½ tÆ°á»Ÿng:**
- Check project state trÆ°á»›c (files, docs, recent commits)
- Náº¿u request cÃ³ multiple independent subsystems â†’ flag ngay, decompose trÆ°á»›c
- Há»i tá»«ng cÃ¢u má»™t (1 question per message)
- Prefer multiple choice khi cÃ³ thá»ƒ
- Focus: purpose, constraints, success criteria

**Explore approaches:**
- Propose 2-3 options vá»›i trade-offs
- Lead vá»›i recommendation + reasoning
- Phong cÃ¡ch conversational

**Present design:**
- Scale sections theo complexity (vÃ i cÃ¢u if simple, 200-300 words if nuanced)
- Ask sau má»—i section: "looks right so far?"
- Cover: architecture, components, data flow, error handling, testing

## Design Principles

- **Isolation & clarity** â€” units cÃ³ 1 purpose, well-defined interfaces, testable independently
- **For each unit** answer: what does it do? how do you use it? what does it depend on?
- **Smaller, focused files** > large files doing too much
- **In existing codebases** â€” follow existing patterns, don't refactor unrelated things

## After Design â†’ Spec Review Loop

```
Write spec â†’ Dispatch reviewer â†’ Issues? Fix & re-dispatch â†’ Approved?
â†’ User reviews â†’ Changes? Update & re-review â†’ Approved?
â†’ Invoke writing-plans skill (ONLY next step)
```

- Max 5 iterations â†’ náº¿u exceed, surface to human
- Save spec to: `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
- Commit to git

## Key Principles

- **One question at a time** â€” khÃ´ng overwhelm
- **Multiple choice preferred** â€” easier to answer
- **YAGNI ruthlessly** â€” remove unnecessary features
- **Explore alternatives** â€” always 2-3 approaches
- **Incremental validation** â€” present â†’ get approval â†’ move on

## Visual Companion

Browser-based tool cho mockups, diagrams, visual options. Chá»‰ offer khi anticipate visual questions:

> "Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons..."

- **Browser** cho: mockups, wireframes, layout comparisons, architecture diagrams
- **Terminal** cho: requirements questions, conceptual choices, tradeoff lists, scope

## Connections
- **Depends on:** [[Using Superpowers]]
- **Flows to:** [[Writing Plans]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
