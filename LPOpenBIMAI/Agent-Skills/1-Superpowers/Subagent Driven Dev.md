---
title: Subagent Driven Dev
tags:
  - skill
  - superpowers
  - workflow
group: Superpowers
role: Execute plan bằng fresh subagent per task + two-stage review
source: .agent/skills/subagent-driven-development/SKILL.md
---

# Subagent-Driven Development

> [!abstract] Vai Trò
> Dispatch fresh subagent cho mỗi task trong plan, với 2-stage review (spec compliance → code quality) sau mỗi task. Giữ context sạch, iterate nhanh.

> [!tip] Core Principle
> Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

```
Have implementation plan? → YES
Tasks mostly independent? → YES
Stay in this session? → YES → subagent-driven-development
                        NO  → executing-plans (parallel session)
```

**vs. Executing Plans (parallel session):**
- Same session (no context switch)
- Fresh subagent per task (no context pollution)
- Two-stage review after each task
- Faster iteration (no human-in-loop between tasks)

## The Process

1. **Read plan** → extract all tasks with full text, note context, create TodoWrite
2. **Per task:**
   - Dispatch implementer subagent (`implementer-prompt.md`)
   - Implementer asks questions? → Answer, provide context
   - Implementer implements, tests, commits, self-reviews
   - Dispatch **spec reviewer** (`spec-reviewer-prompt.md`)
   - Spec compliant? NO → Implementer fixes → re-review
   - Spec compliant? YES → Dispatch **code quality reviewer** (`code-quality-reviewer-prompt.md`)
   - Quality approved? NO → Implementer fixes → re-review
   - Quality approved? YES → Mark task complete
3. **After all tasks** → Final code reviewer for entire implementation
4. **Use** [[Finishing Dev Branch]] skill

## Model Selection

| Task Type | Model |
|-----------|-------|
| Mechanical (1-2 files, clear specs) | Cheap/fast model |
| Integration (multi-file coordination) | Standard model |
| Architecture, design, review | Most capable model |

**Signals:**
- 1-2 files + complete spec → cheap
- Multiple files + integration → standard
- Design judgment + broad codebase → most capable

## Handling Implementer Status

| Status | Action |
|--------|--------|
| **DONE** | Proceed to spec review |
| **DONE_WITH_CONCERNS** | Read concerns → address if correctness/scope, note if observations |
| **NEEDS_CONTEXT** | Provide missing context → re-dispatch |
| **BLOCKED** | 1) Context problem → provide more. 2) Needs reasoning → capable model. 3) Too large → break down. 4) Plan wrong → escalate to human |

> [!warning] NEVER ignore escalation or force same model to retry without changes.

## Red Flags — NEVER Do

- Start on main/master without consent
- Skip reviews (spec OR quality)
- Proceed with unfixed issues
- Dispatch **parallel** implementation subagents (conflicts!)
- Make subagent read plan file (provide full text instead)
- Skip scene-setting context
- Ignore subagent questions
- Start code quality review BEFORE spec compliance ✅
- Move to next task with open review issues

## If Reviewer Finds Issues

```
Implementer fixes → Reviewer re-reviews → Repeat until approved → Don't skip re-review
```

## Integration

**Required skills:**
- [[Git Worktrees]] — set up isolated workspace BEFORE starting
- [[Writing Plans]] — creates the plan this skill executes
- [[Requesting Code Review]] — template for reviewer subagents
- [[Finishing Dev Branch]] — complete after all tasks

**Subagents should use:**
- [[Test Driven Development]] — TDD for each task

**Alternative:**
- [[Executing Plans]] — parallel session instead of same-session

## Prompt Templates

- `implementer-prompt.md` — dispatch implementer
- `spec-reviewer-prompt.md` — dispatch spec compliance reviewer
- `code-quality-reviewer-prompt.md` — dispatch code quality reviewer

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
