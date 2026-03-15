---
title: Receiving Code Review
tags:
  - skill
  - superpowers
  - quality
group: Superpowers
role: Xử lý feedback code review — verify trước khi implement
source: .agent/skills/receiving-code-review/SKILL.md
---

# Receiving Code Review — Technical Evaluation, Not Performance

> [!abstract] Vai Trò
> Dùng khi nhận code review feedback. Verify trước khi implement, hỏi trước khi assume. Technical correctness > social comfort.

## Response Pattern

```
1. READ: Complete feedback, không react
2. UNDERSTAND: Restate requirement bằng lời mình
3. VERIFY: Check against codebase reality
4. EVALUATE: Technically sound cho THIS codebase?
5. RESPOND: Technical acknowledgment hoặc reasoned pushback
6. IMPLEMENT: One item at a time, test each
```

## Forbidden Responses

> [!warning] NEVER say:
> - "You're absolutely right!"
> - "Great point!" / "Excellent feedback!"
> - "Let me implement that now" (trước verification)
> - "Thanks for catching that!" (ANY gratitude)

**Instead:** Restate technical requirement → push back nếu wrong → hoặc just start working.

## Handling Unclear Feedback

```
IF any item unclear:
  STOP — do not implement anything yet
  ASK clarification on unclear items

❌ WRONG: Implement items 1,2,3,6 → ask about 4,5 later
✅ RIGHT: "Understand 1,2,3,6. Need clarification on 4 and 5."
```

## Source-Specific Handling

| Source | Approach |
|--------|----------|
| **Human partner** | Trusted → implement after understanding. No performative agreement. |
| **External reviewer** | Skeptical → verify technically correct cho codebase này trước |

### External Reviewer Checklist
1. Technically correct cho THIS codebase?
2. Breaks existing functionality?
3. Reason for current implementation?
4. Works trên all platforms/versions?
5. Reviewer hiểu full context?

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
- Technically incorrect cho stack này
- Conflicts với architectural decisions

## Acknowledging Correct Feedback

```
✅ "Fixed. [Brief description]"
✅ "Good catch - [issue]. Fixed in [location]."
✅ [Just fix it and show in code]

❌ "You're absolutely right!"
❌ "Thanks for [anything]"
```

## YAGNI Check

```
IF reviewer suggests "implementing properly":
  grep codebase for actual usage
  IF unused → "This endpoint isn't called. Remove it (YAGNI)?"
  IF used → Then implement properly
```

## Connections
- **Counterpart:** [[Requesting Code Review]]
- **Related:** [[Verification]], [[Clean Code]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
