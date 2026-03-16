---
title: Plan Writing
tags:
  - skill
  - planning
  - architecture
  - task-management
parent: "[[Agent-Skills]]"
skill-folder: plan-writing
group: Architecture & Planning
aliases:
  - Plan Writing Skill
---

# 📝 Plan Writing

> [!abstract] Mục đích
> Viết task plan có structure rõ ràng với breakdown, dependencies, và verification criteria. Dùng TRƯỚC KHI code cho mọi feature, refactor, hoặc multi-step work.

## Khi nào dùng

- Trước khi implement feature (GEMINI.md TIER 1 rule)
- Multi-file changes
- Complex refactoring
- Bất kỳ task nào cần > 1 step

## So sánh `plan-writing` vs `writing-plans`

| Skill | Focus |
|-------|-------|
| `plan-writing` | Task planning, breakdown, verification criteria |
| `writing-plans` | Multi-step task specs từ requirements/specs |

Cả hai bổ sung nhau — `plan-writing` cho breakdown, `writing-plans` cho spec-to-plan conversion.

## Output Format

```markdown
# {Task Name}

## Goal
Mô tả ngắn: làm gì, tại sao

## Tasks
- [ ] Task 1 — description
  - [ ] Sub-task 1a
  - [ ] Sub-task 1b
- [ ] Task 2 — description (depends on Task 1)
- [ ] Task 3 — description (independent)

## Dependencies
Task 2 → Task 1 (blocking)
Task 3 → none (can parallel)

## Verification
- [ ] Unit tests pass
- [ ] E2E tests pass
- [ ] Screenshots match design
```

## Rules

1. **Breakdown nhỏ nhất có thể** — 1 task = 1 commit
2. **Dependencies rõ ràng** — task nào block task nào
3. **Verification criteria** — mỗi task phải có criteria "done"

## Links

- [[Agent-Skills|← Skills Index]]
- [[Writing Plans|✍️ Writing Plans]]
- [[Brainstorming|🧠 Brainstorming]]
- [[Executing Plans|⚡ Executing Plans]]
