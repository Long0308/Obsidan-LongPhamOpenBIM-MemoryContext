---
title: Subagent Driven Dev
tags:
  - agent-skill
  - skill
  - superpowers
  - workflow
group: Superpowers
role: Execute plan báº±ng fresh subagent per task + two-stage review
source: .agent/skills/subagent-driven-development/SKILL.md
---

# Subagent-Driven Development

> [!abstract] Vai TrÃ²
> Dispatch fresh subagent cho má»—i task trong plan, vá»›i 2-stage review (spec compliance â†’ code quality) sau má»—i task. Giá»¯ context sáº¡ch, iterate nhanh.

> [!tip] Core Principle
> Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

```
Have implementation plan? â†’ YES
Tasks mostly independent? â†’ YES
Stay in this session? â†’ YES â†’ subagent-driven-development
                        NO  â†’ executing-plans (parallel session)
```

**vs. Executing Plans (parallel session):**
- Same session (no context switch)
- Fresh subagent per task (no context pollution)
- Two-stage review after each task
- Faster iteration (no human-in-loop between tasks)

## The Process

1. **Read plan** â†’ extract all tasks with full text, note context, create TodoWrite
2. **Per task:**
   - Dispatch implementer subagent (`implementer-prompt.md`)
   - Implementer asks questions? â†’ Answer, provide context
   - Implementer implements, tests, commits, self-reviews
   - Dispatch **spec reviewer** (`spec-reviewer-prompt.md`)
   - Spec compliant? NO â†’ Implementer fixes â†’ re-review
   - Spec compliant? YES â†’ Dispatch **code quality reviewer** (`code-quality-reviewer-prompt.md`)
   - Quality approved? NO â†’ Implementer fixes â†’ re-review
   - Quality approved? YES â†’ Mark task complete
3. **After all tasks** â†’ Final code reviewer for entire implementation
4. **Use** [[Finishing Dev Branch]] skill

## Model Selection

| Task Type | Model |
|-----------|-------|
| Mechanical (1-2 files, clear specs) | Cheap/fast model |
| Integration (multi-file coordination) | Standard model |
| Architecture, design, review | Most capable model |

**Signals:**
- 1-2 files + complete spec â†’ cheap
- Multiple files + integration â†’ standard
- Design judgment + broad codebase â†’ most capable

## Handling Implementer Status

| Status | Action |
|--------|--------|
| **DONE** | Proceed to spec review |
| **DONE_WITH_CONCERNS** | Read concerns â†’ address if correctness/scope, note if observations |
| **NEEDS_CONTEXT** | Provide missing context â†’ re-dispatch |
| **BLOCKED** | 1) Context problem â†’ provide more. 2) Needs reasoning â†’ capable model. 3) Too large â†’ break down. 4) Plan wrong â†’ escalate to human |

> [!warning] NEVER ignore escalation or force same model to retry without changes.

## Red Flags â€” NEVER Do

- Start on main/master without consent
- Skip reviews (spec OR quality)
- Proceed with unfixed issues
- Dispatch **parallel** implementation subagents (conflicts!)
- Make subagent read plan file (provide full text instead)
- Skip scene-setting context
- Ignore subagent questions
- Start code quality review BEFORE spec compliance âœ…
- Move to next task with open review issues

## If Reviewer Finds Issues

```
Implementer fixes â†’ Reviewer re-reviews â†’ Repeat until approved â†’ Don't skip re-review
```

## Integration

**Required skills:**
- [[Git Worktrees]] â€” set up isolated workspace BEFORE starting
- [[Writing Plans]] â€” creates the plan this skill executes
- [[Requesting Code Review]] â€” template for reviewer subagents
- [[Finishing Dev Branch]] â€” complete after all tasks

**Subagents should use:**
- [[Test Driven Development]] â€” TDD for each task

**Alternative:**
- [[Executing Plans]] â€” parallel session instead of same-session

## Prompt Templates

- `implementer-prompt.md` â€” dispatch implementer
- `spec-reviewer-prompt.md` â€” dispatch spec compliance reviewer
- `code-quality-reviewer-prompt.md` â€” dispatch code quality reviewer

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
