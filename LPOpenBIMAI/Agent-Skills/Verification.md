---
title: Verification
tags:
  - skill
  - superpowers
  - quality
group: Superpowers
role: Verify trước khi claim completion — evidence before assertions
source: .agent/skills/verification-before-completion/SKILL.md
---

# Verification Before Completion

> [!abstract] Vai Trò
> Dùng trước khi claim work đã xong, fixed, hay passing. PHẢI run verification commands VÀ confirm output trước khi claim success.

> [!caution] The Iron Law
> ```
> NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
> ```
> Chưa run verification → KHÔNG ĐƯỢC claim nó pass.

## The Gate Function

```
BEFORE claiming status:
1. IDENTIFY: Command nào proves claim này?
2. RUN: Execute FULL command (fresh, complete)
3. READ: Full output, check exit code, count failures
4. VERIFY: Output confirms claim?
   - NO → State actual status WITH evidence
   - YES → State claim WITH evidence
5. ONLY THEN: Make the claim
```

## Common Failures

| Claim | Requires | NOT Sufficient |
|-------|----------|----------------|
| Tests pass | Test output: 0 failures | Previous run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check |
| Build succeeds | Build: exit 0 | "Linter passed" |
| Bug fixed | Test original symptom | "Code changed" |
| Agent completed | VCS diff shows changes | Agent reports "success" |
| Requirements met | Line-by-line checklist | Tests passing |

## Red Flags — STOP

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Done!")
- About to commit/push/PR without verification
- Trusting agent success reports
- **ANY wording implying success without running verification**

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "Should work now" | RUN the verification |
| "I'm confident" | Confidence ≠ evidence |
| "Just this once" | No exceptions |
| "Agent said success" | Verify independently |
| "Partial check is enough" | Partial proves nothing |

## Key Patterns

**Tests:**
```
✅ [Run test] [See: 34/34 pass] "All tests pass"
❌ "Should pass now" / "Looks correct"
```

**TDD Red-Green:**
```
✅ Write → Run (pass) → Revert fix → Run (MUST FAIL) → Restore → Run (pass)
❌ "I've written a regression test" (without red-green)
```

**Requirements:**
```
✅ Re-read plan → Create checklist → Verify each → Report
❌ "Tests pass, phase complete"
```

## When To Apply

**ALWAYS before:** ANY success claims, committing, PR creation, task completion, moving to next task.

**Non-negotiable.** Run. Read. THEN claim.

## Connections
- **Related:** [[Systematic Debugging]], [[Test Driven Development]]
- **Used by:** [[Executing Plans]], [[Finishing Dev Branch]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
