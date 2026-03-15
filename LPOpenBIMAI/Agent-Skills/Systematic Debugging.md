---
title: Systematic Debugging
tags:
  - skill
  - superpowers
  - debugging
group: Superpowers
role: Debug có hệ thống — tìm root cause trước khi fix
source: .agent/skills/systematic-debugging/SKILL.md
---

# Systematic Debugging — Root Cause First

> [!abstract] Vai Trò
> Dùng khi gặp BẤT KỲ bug, test failure, hoặc unexpected behavior. PHẢI dùng TRƯỚC KHI propose fixes.

> [!caution] The Iron Law
> ```
> NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
> ```
> Chưa xong Phase 1 → KHÔNG ĐƯỢC propose fixes.

## When to Use

Mọi technical issue: test failures, bugs, unexpected behavior, performance, build failures, integration issues.

**ĐẶC BIỆT khi:**
- Under time pressure (emergency = guessing tempting)
- "Just one quick fix" seems obvious
- Đã try multiple fixes rồi
- Chưa fully understand issue

## Four Phases (PHẢI theo thứ tự)

### Phase 1: Root Cause Investigation

1. **Read Error Messages** — đọc hết, kể cả stack traces
2. **Reproduce** — trigger reliably? Exact steps? Every time?
3. **Check Recent Changes** — git diff, new deps, config changes
4. **Gather Evidence** (multi-component systems) — log data ở mỗi component boundary → run 1 lần → xem WHERE it breaks
5. **Trace Data Flow** — where does bad value originate? Keep tracing up until source

### Phase 2: Pattern Analysis

1. **Find Working Examples** — code tương tự đang hoạt động ở đâu?
2. **Compare Against References** — đọc TOÀN BỘ reference, không skim
3. **Identify Differences** — list EVERY difference
4. **Understand Dependencies** — components, settings, config, env

### Phase 3: Hypothesis and Testing

1. **Form Single Hypothesis** — "I think X because Y" (viết ra)
2. **Test Minimally** — SMALLEST possible change, 1 variable mỗi lần
3. **Verify** — Worked? → Phase 4. Didn't? → NEW hypothesis (không pile thêm fixes)

### Phase 4: Implementation

1. **Create Failing Test** — simplest reproduction
2. **Implement Single Fix** — root cause only, NO "while I'm here" improvements
3. **Verify Fix** — test passes? No regressions?
4. **If Fix Doesn't Work** — <3 tries: return Phase 1. **≥3 tries: QUESTION ARCHITECTURE**

> [!warning] 3+ Fixes Failed = Architectural Problem
> Pattern: mỗi fix reveals new shared state/coupling ở chỗ khác.
> → STOP. Question fundamentals. Discuss with human partner.

## Red Flags — STOP & Follow Process

- "Quick fix for now"
- "Just try changing X"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "Pattern says X but I'll adapt differently"
- "One more fix attempt" (khi đã try 2+)

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple" | Simple bugs có root causes too |
| "Emergency, no time" | Systematic = FASTER than thrashing |
| "Try this first" | First fix sets the pattern |
| "Multiple fixes saves time" | Can't isolate what worked |
| "I see the problem" | Seeing symptoms ≠ understanding cause |

## Quick Reference

| Phase | Activities | Success |
|-------|-----------|---------|
| 1. Root Cause | Read errors, reproduce, check changes | Understand WHAT + WHY |
| 2. Pattern | Find working examples, compare | Identify differences |
| 3. Hypothesis | Form theory, test minimally | Confirmed or new |
| 4. Implementation | Create test, fix, verify | Bug resolved ✅ |

## Supporting Techniques

- `root-cause-tracing.md` — trace bugs backward
- `defense-in-depth.md` — add validation multi-layer
- `condition-based-waiting.md` — replace timeouts with condition polling

## Connections
- **Related:** [[Test Driven Development]], [[Verification]]
- **Used by:** [[Executing Plans]], [[Subagent Driven Dev]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
