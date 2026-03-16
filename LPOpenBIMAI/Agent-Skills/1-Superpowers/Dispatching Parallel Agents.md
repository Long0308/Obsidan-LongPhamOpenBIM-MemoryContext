---
title: Dispatching Parallel Agents
tags:
  - agent-skill
  - skill
  - superpowers
  - execution
group: Superpowers
role: Delegate tasks cho specialized agents cháº¡y song song
source: .agent/skills/dispatching-parallel-agents/SKILL.md
---

# Dispatching Parallel Agents

> [!abstract] Vai TrÃ²
> Delegate tasks cho specialized agents vá»›i isolated context. Crafted instructions riÃªng, KHÃ”NG inherit session history. Agents cháº¡y concurrently trÃªn independent problems.

## When to Use

**DÃ¹ng khi:**
- 3+ test files failing vá»›i different root causes
- Multiple subsystems broken independently
- Má»—i problem hiá»ƒu Ä‘Æ°á»£c mÃ  KHÃ”NG cáº§n context tá»« others
- KhÃ´ng cÃ³ shared state giá»¯a investigations

**KHÃ”NG dÃ¹ng khi:**
- Failures related nhau (fix 1 cÃ³ thá»ƒ fix others)
- Cáº§n hiá»ƒu full system state
- Agents sáº½ interfere nhau (edit same files)
- Exploratory debugging (chÆ°a biáº¿t gÃ¬ broken)

## Pattern (4 bÆ°á»›c)

### 1. Identify Independent Domains
Group failures theo what's broken:
- File A tests: Tool approval flow
- File B tests: Batch completion behavior
- File C tests: Abort functionality

### 2. Create Focused Agent Tasks
Má»—i agent nháº­n:
- **Specific scope:** 1 test file hoáº·c subsystem
- **Clear goal:** Make these tests pass
- **Constraints:** Don't change other code
- **Expected output:** Summary of findings + fixes

### 3. Dispatch in Parallel
```
Agent 1 â†’ Fix agent-tool-abort.test.ts
Agent 2 â†’ Fix batch-completion-behavior.test.ts
Agent 3 â†’ Fix tool-approval-race-conditions.test.ts
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
1. Read tests â†’ understand what each verifies
2. Identify root cause
3. Fix by replacing timeouts with event-based waiting

Do NOT just increase timeouts - find the real issue.
Return: Summary of what you found and fixed.
```

## Common Mistakes

| âŒ Wrong | âœ… Right |
|---------|---------|
| "Fix all the tests" (too broad) | "Fix agent-tool-abort.test.ts" (focused) |
| "Fix the race condition" (no context) | Paste error messages + test names |
| No constraints â†’ agent refactors everything | "Do NOT change production code" |
| "Fix it" (vague output) | "Return summary of root cause and changes" |

## Real-World Example

**Scenario:** 6 failures Ã— 3 files sau major refactoring

| Agent | File | Fix |
|-------|------|-----|
| 1 | agent-tool-abort.test.ts | Replaced timeouts â†’ event-based waiting |
| 2 | batch-completion-behavior.test.ts | Fixed event structure bug |
| 3 | tool-approval-race-conditions.test.ts | Added wait for async execution |

**Result:** All fixes independent, no conflicts, full suite green ðŸŸ¢

## Verification After Return

1. **Review each summary** â€” understand changes
2. **Check conflicts** â€” did agents edit same code?
3. **Run full suite** â€” verify all fixes work together
4. **Spot check** â€” agents can make systematic errors

## Connections
- **Alternative to:** [[Parallel Agents]] (orchestration skill)
- **Used with:** [[Executing Plans]]
- **Related:** [[Subagent Driven Dev]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
