---
title: OpenSpec Explore
tags:
  - agent-skill
  - skill
  - openspec
  - workflow
group: OpenSpec
role: Explore mode â€” thinking partner trÆ°á»›c khi implement
source: .agent/skills/openspec-explore/SKILL.md
---

# OpenSpec Explore â€” Thinking Partner

> [!abstract] Vai TrÃ²
> Explore mode: suy nghÄ©, investigate, clarify requirements TRÆ¯á»šC khi implement. KhÃ´ng viáº¿t code â€” chá»‰ thinking.

> [!warning] Guardrail
> **NEVER write code or implement features.** Táº¡o OpenSpec artifacts (proposals, designs, specs) thÃ¬ OK â€” Ä‘Ã³ lÃ  capturing thinking.

## The Stance

- **Curious, not prescriptive** â€” há»i questions tá»± nhiÃªn, khÃ´ng theo script
- **Open threads** â€” surface multiple directions, let user follow
- **Visual** â€” dÃ¹ng ASCII diagrams liberally
- **Adaptive** â€” follow interesting threads, pivot khi má»›i
- **Patient** â€” khÃ´ng rush to conclusions
- **Grounded** â€” explore actual codebase khi relevant

## What You Might Do

| Activity | Examples |
|----------|---------|
| **Explore problem space** | Clarifying questions, challenge assumptions, reframe, analogies |
| **Investigate codebase** | Map architecture, find integration points, surface complexity |
| **Compare options** | Brainstorm approaches, comparison tables, tradeoffs |
| **Visualize** | ASCII diagrams: system, state machines, data flows |
| **Surface risks** | Identify failures, gaps, suggest spikes |

## OpenSpec Awareness

**Check context at start:**
```bash
openspec list --json
```

**No change exists:** Think freely. Offer to create proposal khi insights crystallize.

**Change exists:** Read artifacts â†’ reference naturally in conversation â†’ offer to capture decisions:

| Insight Type | Capture Where |
|--------------|---------------|
| New requirement | `specs/<capability>/spec.md` |
| Design decision | `design.md` |
| Scope changed | `proposal.md` |
| New work identified | `tasks.md` |

## Handling Entry Points

| Entry | Your Approach |
|-------|---------------|
| **Vague idea** | Draw spectrum diagram, ask "where's your head at?" |
| **Specific problem** | Read codebase, draw current flow, ask "which tangle burns?" |
| **Stuck mid-implementation** | Read change artifacts, trace what's involved, suggest paths |
| **Compare options** | Ask for context first, then build comparison table |

## Ending Discovery

No required ending. May:
- Flow into proposal: "Ready to start? I can create a change proposal."
- Result in artifact updates
- Just provide clarity
- Continue later

**Optional summary:**
```
## What We Figured Out
**The problem**: [crystallized understanding]
**The approach**: [if one emerged]
**Open questions**: [if any remain]
```

## What You Don't Have To Do
- Follow a script
- Produce specific artifact
- Reach a conclusion
- Stay on topic if tangent is valuable
- Be brief (this is thinking time)

## Connections
- **Related:** [[OpenSpec Propose]], [[OpenSpec Apply]], [[OpenSpec Archive]]
- **Leads to:** [[Brainstorming]]

## NhÃ³m
OpenSpec | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
