---
title: Dispatching Parallel Agents
tags:
  - skill
  - superpowers
  - execution
group: Superpowers
role: Delegate tasks cho specialized agents chạy song song
source: .agent/skills/dispatching-parallel-agents/SKILL.md
---

# Dispatching Parallel Agents

> [!abstract] Vai Trò
> Delegate tasks cho specialized agents với isolated context. Crafted instructions riêng, KHÔNG inherit session history. Agents chạy concurrently trên independent problems.

## When to Use

**Dùng khi:**
- 3+ test files failing với different root causes
- Multiple subsystems broken independently
- Mỗi problem hiểu được mà KHÔNG cần context từ others
- Không có shared state giữa investigations

**KHÔNG dùng khi:**
- Failures related nhau (fix 1 có thể fix others)
- Cần hiểu full system state
- Agents sẽ interfere nhau (edit same files)
- Exploratory debugging (chưa biết gì broken)

## Pattern (4 bước)

### 1. Identify Independent Domains
Group failures theo what's broken:
- File A tests: Tool approval flow
- File B tests: Batch completion behavior
- File C tests: Abort functionality

### 2. Create Focused Agent Tasks
Mỗi agent nhận:
- **Specific scope:** 1 test file hoặc subsystem
- **Clear goal:** Make these tests pass
- **Constraints:** Don't change other code
- **Expected output:** Summary of findings + fixes

### 3. Dispatch in Parallel
```
Agent 1 → Fix agent-tool-abort.test.ts
Agent 2 → Fix batch-completion-behavior.test.ts
Agent 3 → Fix tool-approval-race-conditions.test.ts
// All three run concurrently
```

### 4. Review and Integrate
- Read each summary
- Verify fixes don't conflict
- Run full test suite
- Integrate all changes

## Agent Prompt Structure

Good prompts = **Focused + Self-contained + Specific output:**

```markdown
Fix the 3 failing tests in src/agents/agent-tool-abort.test.ts:

1. "should abort tool with partial output capture" - expects 'interrupted at'
2. "should handle mixed completed and aborted tools" - fast tool aborted
3. "should properly track pendingToolCount" - expects 3, gets 0

These are timing/race condition issues. Your task:
1. Read tests → understand what each verifies
2. Identify root cause
3. Fix by replacing timeouts with event-based waiting

Do NOT just increase timeouts - find the real issue.
Return: Summary of what you found and fixed.
```

## Common Mistakes

| ❌ Wrong | ✅ Right |
|---------|---------|
| "Fix all the tests" (too broad) | "Fix agent-tool-abort.test.ts" (focused) |
| "Fix the race condition" (no context) | Paste error messages + test names |
| No constraints → agent refactors everything | "Do NOT change production code" |
| "Fix it" (vague output) | "Return summary of root cause and changes" |

## Real-World Example

**Scenario:** 6 failures × 3 files sau major refactoring

| Agent | File | Fix |
|-------|------|-----|
| 1 | agent-tool-abort.test.ts | Replaced timeouts → event-based waiting |
| 2 | batch-completion-behavior.test.ts | Fixed event structure bug |
| 3 | tool-approval-race-conditions.test.ts | Added wait for async execution |

**Result:** All fixes independent, no conflicts, full suite green 🟢

## Verification After Return

1. **Review each summary** — understand changes
2. **Check conflicts** — did agents edit same code?
3. **Run full suite** — verify all fixes work together
4. **Spot check** — agents can make systematic errors

## Connections
- **Alternative to:** [[Parallel Agents]] (orchestration skill)
- **Used with:** [[Executing Plans]]
- **Related:** [[Subagent Driven Dev]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
