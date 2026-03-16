---
title: Receiving Code Review
tags:
  - agent-skill
  - skill
  - superpowers
  - quality
group: Superpowers
role: Xá»­ lÃ½ feedback code review â€” verify trÆ°á»›c khi implement
source: .agent/skills/receiving-code-review/SKILL.md
---

# Receiving Code Review â€” Technical Evaluation, Not Performance

> [!abstract] Vai TrÃ²
> DÃ¹ng khi nháº­n code review feedback. Verify trÆ°á»›c khi implement, há»i trÆ°á»›c khi assume. Technical correctness > social comfort.

## Response Pattern

```
1. READ: Complete feedback, khÃ´ng react
2. UNDERSTAND: Restate requirement báº±ng lá»i mÃ¬nh
3. VERIFY: Check against codebase reality
4. EVALUATE: Technically sound cho THIS codebase?
5. RESPOND: Technical acknowledgment hoáº·c reasoned pushback
6. IMPLEMENT: One item at a time, test each
```

## Forbidden Responses

> [!warning] NEVER say:
> - "You're absolutely right!"
> - "Great point!" / "Excellent feedback!"
> - "Let me implement that now" (trÆ°á»›c verification)
> - "Thanks for catching that!" (ANY gratitude)

**Instead:** Restate technical requirement â†’ push back náº¿u wrong â†’ hoáº·c just start working.

## Handling Unclear Feedback

```
IF any item unclear:
  STOP â€” do not implement anything yet
  ASK clarification on unclear items

âŒ WRONG: Implement items 1,2,3,6 â†’ ask about 4,5 later
âœ… RIGHT: "Understand 1,2,3,6. Need clarification on 4 and 5."
```

## Source-Specific Handling

| Source | Approach |
|--------|----------|
| **Human partner** | Trusted â†’ implement after understanding. No performative agreement. |
| **External reviewer** | Skeptical â†’ verify technically correct cho codebase nÃ y trÆ°á»›c |

### External Reviewer Checklist
1. Technically correct cho THIS codebase?
2. Breaks existing functionality?
3. Reason for current implementation?
4. Works trÃªn all platforms/versions?
5. Reviewer hiá»ƒu full context?

## Implementation Order

```
1. Clarify unclear items FIRST
2. Implement:
   - Blocking issues (breaks, security)
   - Simple fixes (typos, imports)
   - Complex fixes (refactoring, logic)
3. Test each fix individually
4. Verify no regressions
```

## When To Push Back

- Suggestion breaks existing functionality
- Reviewer lacks full context
- Violates YAGNI (unused feature)
- Technically incorrect cho stack nÃ y
- Conflicts vá»›i architectural decisions

## Acknowledging Correct Feedback

```
âœ… "Fixed. [Brief description]"
âœ… "Good catch - [issue]. Fixed in [location]."
âœ… [Just fix it and show in code]

âŒ "You're absolutely right!"
âŒ "Thanks for [anything]"
```

## YAGNI Check

```
IF reviewer suggests "implementing properly":
  grep codebase for actual usage
  IF unused â†’ "This endpoint isn't called. Remove it (YAGNI)?"
  IF used â†’ Then implement properly
```

## Connections
- **Counterpart:** [[Requesting Code Review]]
- **Related:** [[Verification]], [[Clean Code]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
