---
title: Writing Plans
tags:
  - agent-skill
  - skill
  - superpowers
  - planning
group: Superpowers
role: Táº¡o implementation plan chi tiáº¿t tá»« spec/requirements
source: .agent/skills/writing-plans/SKILL.md
---

# Writing Plans â€” Specs â†’ Implementation Plans

> [!abstract] Vai TrÃ²
> Viáº¿t comprehensive implementation plans vá»›i giáº£ Ä‘á»‹nh engineer KHÃ”NG cÃ³ context cá»§a codebase. Document má»i thá»© cáº§n biáº¿t: files nÃ o, code gÃ¬, testing tháº¿ nÃ o. Bite-sized tasks. DRY. YAGNI. TDD.

**Announce:** "I'm using the writing-plans skill to create the implementation plan."

## Scope Check

Náº¿u spec cover multiple independent subsystems â†’ suggest tÃ¡ch thÃ nh separate plans (má»—i plan = 1 subsystem, self-contained, testable riÃªng).

## File Structure â€” Map First

TrÆ°á»›c khi define tasks, map out files sáº½ táº¡o/sá»­a:

- Design units cÃ³ clear boundaries, well-defined interfaces
- Má»—i file = 1 responsibility
- Prefer smaller, focused files
- Files change together â†’ live together
- Existing codebases â†’ follow patterns hiá»‡n táº¡i

## Bite-Sized Task Granularity

Má»—i step = 1 action (2-5 phÃºt):

```
Step 1: Write the failing test
Step 2: Run it â†’ verify FAIL
Step 3: Implement minimal code to pass
Step 4: Run test â†’ verify PASS
Step 5: Commit
```

## Plan Document Format

````markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED: Use subagent-driven-development
> (if available) or executing-plans to implement.

**Goal:** [One sentence]
**Architecture:** [2-3 sentences]
**Tech Stack:** [Key technologies]

---

### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

- [ ] Step 1: Write failing test
- [ ] Step 2: Run â†’ verify FAIL
- [ ] Step 3: Write minimal implementation
- [ ] Step 4: Run â†’ verify PASS
- [ ] Step 5: Commit
````

## Rules

- Exact file paths ALWAYS
- Complete code in plan (not "add validation")
- Exact commands with expected output
- Reference relevant skills with `@` syntax
- DRY, YAGNI, TDD, frequent commits

## Plan Review Loop

```
Write chunk â†’ Dispatch reviewer â†’ Issues? Fix & re-dispatch
â†’ Approved? â†’ Next chunk (or execution handoff)
```

- Chunk boundaries: `## Chunk N: <name>` (â‰¤1000 lines each)
- Same agent fixes issues (preserves context)
- Max 5 iterations â†’ surface to human

## Execution Handoff

Sau save plan â†’ há»i user "Ready to execute?"

| Harness | Skill dÃ¹ng |
|---------|-----------|
| CÃ³ subagents (Claude Code...) | **REQUIRED:** [[Subagent Driven Dev]] |
| KhÃ´ng cÃ³ subagents | [[Executing Plans]] |

Save plans to: `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`

## Connections
- **Input from:** [[Brainstorming]]
- **Executes via:** [[Executing Plans]], [[Subagent Driven Dev]]
- **Related:** [[Git Worktrees]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
