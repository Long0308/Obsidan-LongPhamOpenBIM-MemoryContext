---
title: Verification
tags:
  - agent-skill
  - skill
  - superpowers
  - quality
group: Superpowers
role: Verify trÆ°á»›c khi claim completion â€” evidence before assertions
source: .agent/skills/verification-before-completion/SKILL.md
---

# Verification Before Completion

> [!abstract] Vai TrÃ²
> DÃ¹ng trÆ°á»›c khi claim work Ä‘Ã£ xong, fixed, hay passing. PHáº¢I run verification commands VÃ€ confirm output trÆ°á»›c khi claim success.

> [!caution] The Iron Law
> ```
> NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
> ```
> ChÆ°a run verification â†’ KHÃ”NG ÄÆ¯á»¢C claim nÃ³ pass.

## The Gate Function

```
BEFORE claiming status:
1. IDENTIFY: Command nÃ o proves claim nÃ y?
2. RUN: Execute FULL command (fresh, complete)
3. READ: Full output, check exit code, count failures
4. VERIFY: Output confirms claim?
   - NO â†’ State actual status WITH evidence
   - YES â†’ State claim WITH evidence
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

## Red Flags â€” STOP

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Done!")
- About to commit/push/PR without verification
- Trusting agent success reports
- **ANY wording implying success without running verification**

## Rationalization Prevention

| Excuse | Reality |
|--------|---------|
| "Should work now" | RUN the verification |
| "I'm confident" | Confidence â‰  evidence |
| "Just this once" | No exceptions |
| "Agent said success" | Verify independently |
| "Partial check is enough" | Partial proves nothing |

## Key Patterns

**Tests:**
```
âœ… [Run test] [See: 34/34 pass] "All tests pass"
âŒ "Should pass now" / "Looks correct"
```

**TDD Red-Green:**
```
âœ… Write â†’ Run (pass) â†’ Revert fix â†’ Run (MUST FAIL) â†’ Restore â†’ Run (pass)
âŒ "I've written a regression test" (without red-green)
```

**Requirements:**
```
âœ… Re-read plan â†’ Create checklist â†’ Verify each â†’ Report
âŒ "Tests pass, phase complete"
```

## When To Apply

**ALWAYS before:** ANY success claims, committing, PR creation, task completion, moving to next task.

**Non-negotiable.** Run. Read. THEN claim.

## Connections
- **Related:** [[Systematic Debugging]], [[Test Driven Development]]
- **Used by:** [[Executing Plans]], [[Finishing Dev Branch]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
