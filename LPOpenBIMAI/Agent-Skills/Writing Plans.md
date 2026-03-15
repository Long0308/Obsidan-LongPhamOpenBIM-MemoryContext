---
title: Writing Plans
tags:
  - skill
  - superpowers
  - planning
group: Superpowers
role: Tạo implementation plan chi tiết từ spec/requirements
source: .agent/skills/writing-plans/SKILL.md
---

# Writing Plans — Specs → Implementation Plans

> [!abstract] Vai Trò
> Viết comprehensive implementation plans với giả định engineer KHÔNG có context của codebase. Document mọi thứ cần biết: files nào, code gì, testing thế nào. Bite-sized tasks. DRY. YAGNI. TDD.

**Announce:** "I'm using the writing-plans skill to create the implementation plan."

## Scope Check

Nếu spec cover multiple independent subsystems → suggest tách thành separate plans (mỗi plan = 1 subsystem, self-contained, testable riêng).

## File Structure — Map First

Trước khi define tasks, map out files sẽ tạo/sửa:

- Design units có clear boundaries, well-defined interfaces
- Mỗi file = 1 responsibility
- Prefer smaller, focused files
- Files change together → live together
- Existing codebases → follow patterns hiện tại

## Bite-Sized Task Granularity

Mỗi step = 1 action (2-5 phút):

```
Step 1: Write the failing test
Step 2: Run it → verify FAIL
Step 3: Implement minimal code to pass
Step 4: Run test → verify PASS
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
- [ ] Step 2: Run → verify FAIL
- [ ] Step 3: Write minimal implementation
- [ ] Step 4: Run → verify PASS
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
Write chunk → Dispatch reviewer → Issues? Fix & re-dispatch
→ Approved? → Next chunk (or execution handoff)
```

- Chunk boundaries: `## Chunk N: <name>` (≤1000 lines each)
- Same agent fixes issues (preserves context)
- Max 5 iterations → surface to human

## Execution Handoff

Sau save plan → hỏi user "Ready to execute?"

| Harness | Skill dùng |
|---------|-----------|
| Có subagents (Claude Code...) | **REQUIRED:** [[Subagent Driven Dev]] |
| Không có subagents | [[Executing Plans]] |

Save plans to: `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`

## Connections
- **Input from:** [[Brainstorming]]
- **Executes via:** [[Executing Plans]], [[Subagent Driven Dev]]
- **Related:** [[Git Worktrees]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
