---
title: Brainstorming
tags:
  - skill
  - superpowers
  - planning
group: Superpowers
role: Ý tưởng ban đầu, phân tích requirements trước khi code
source: .agent/skills/brainstorming/SKILL.md
---

# Brainstorming — Ideas Into Designs

> [!abstract] Vai Trò
> PHẢI dùng trước MỌI creative work — tạo features, build components, thêm functionality, sửa behavior. Khám phá intent, requirements, design trước implementation.

> [!caution] HARD GATE
> KHÔNG được invoke bất kỳ implementation skill, viết code, scaffold project, hay thực thi bất kỳ action nào TRƯỚC KHI present design VÀ user đã approve. Áp dụng cho MỌI project bất kể mức độ đơn giản.

## Anti-Pattern: "This Is Too Simple"

Mọi project đều đi qua process này. Todo list, utility function, config change — tất cả. "Simple" projects là nơi unexamined assumptions gây waste nhiều nhất. Design có thể ngắn (vài câu cho project đơn giản), nhưng PHẢI present và get approval.

## Checklist (9 bước bắt buộc)

| # | Bước | Mô tả |
|---|------|--------|
| 1 | Explore project context | Check files, docs, recent commits |
| 2 | Offer visual companion | Nếu topic có visual questions (message riêng!) |
| 3 | Ask clarifying questions | Từng câu một, hiểu purpose/constraints/success |
| 4 | Propose 2-3 approaches | Trade-offs + recommendation |
| 5 | Present design | Theo sections, get approval từng phần |
| 6 | Write design doc | Save to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md` |
| 7 | Spec review loop | Dispatch reviewer subagent (max 5 iterations) |
| 8 | User reviews spec | User approve trước khi proceed |
| 9 | Transition | → Invoke [[Writing Plans]] (ONLY skill) |

## Process — Understanding Ideas

**Hiểu ý tưởng:**
- Check project state trước (files, docs, recent commits)
- Nếu request có multiple independent subsystems → flag ngay, decompose trước
- Hỏi từng câu một (1 question per message)
- Prefer multiple choice khi có thể
- Focus: purpose, constraints, success criteria

**Explore approaches:**
- Propose 2-3 options với trade-offs
- Lead với recommendation + reasoning
- Phong cách conversational

**Present design:**
- Scale sections theo complexity (vài câu if simple, 200-300 words if nuanced)
- Ask sau mỗi section: "looks right so far?"
- Cover: architecture, components, data flow, error handling, testing

## Design Principles

- **Isolation & clarity** — units có 1 purpose, well-defined interfaces, testable independently
- **For each unit** answer: what does it do? how do you use it? what does it depend on?
- **Smaller, focused files** > large files doing too much
- **In existing codebases** — follow existing patterns, don't refactor unrelated things

## After Design → Spec Review Loop

```
Write spec → Dispatch reviewer → Issues? Fix & re-dispatch → Approved?
→ User reviews → Changes? Update & re-review → Approved?
→ Invoke writing-plans skill (ONLY next step)
```

- Max 5 iterations → nếu exceed, surface to human
- Save spec to: `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
- Commit to git

## Key Principles

- **One question at a time** — không overwhelm
- **Multiple choice preferred** — easier to answer
- **YAGNI ruthlessly** — remove unnecessary features
- **Explore alternatives** — always 2-3 approaches
- **Incremental validation** — present → get approval → move on

## Visual Companion

Browser-based tool cho mockups, diagrams, visual options. Chỉ offer khi anticipate visual questions:

> "Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons..."

- **Browser** cho: mockups, wireframes, layout comparisons, architecture diagrams
- **Terminal** cho: requirements questions, conceptual choices, tradeoff lists, scope

## Connections
- **Depends on:** [[Using Superpowers]]
- **Flows to:** [[Writing Plans]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
