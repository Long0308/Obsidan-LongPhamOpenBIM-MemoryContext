---
title: Systematic Debugging
tags:
  - agent-skill
  - skill
  - superpowers
  - debugging
group: Superpowers
role: Debug cÃ³ há»‡ thá»‘ng â€” tÃ¬m root cause trÆ°á»›c khi fix
source: .agent/skills/systematic-debugging/SKILL.md
---

# Systematic Debugging â€” Root Cause First

> [!abstract] Vai TrÃ²
> DÃ¹ng khi gáº·p Báº¤T Ká»² bug, test failure, hoáº·c unexpected behavior. PHáº¢I dÃ¹ng TRÆ¯á»šC KHI propose fixes.

> [!caution] The Iron Law
> ```
> NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
> ```
> ChÆ°a xong Phase 1 â†’ KHÃ”NG ÄÆ¯á»¢C propose fixes.

## When to Use

Má»i technical issue: test failures, bugs, unexpected behavior, performance, build failures, integration issues.

**Äáº¶C BIá»†T khi:**
- Under time pressure (emergency = guessing tempting)
- "Just one quick fix" seems obvious
- ÄÃ£ try multiple fixes rá»“i
- ChÆ°a fully understand issue

## Four Phases (PHáº¢I theo thá»© tá»±)

### Phase 1: Root Cause Investigation

1. **Read Error Messages** â€” Ä‘á»c háº¿t, ká»ƒ cáº£ stack traces
2. **Reproduce** â€” trigger reliably? Exact steps? Every time?
3. **Check Recent Changes** â€” git diff, new deps, config changes
4. **Gather Evidence** (multi-component systems) â€” log data á»Ÿ má»—i component boundary â†’ run 1 láº§n â†’ xem WHERE it breaks
5. **Trace Data Flow** â€” where does bad value originate? Keep tracing up until source

### Phase 2: Pattern Analysis

1. **Find Working Examples** â€” code tÆ°Æ¡ng tá»± Ä‘ang hoáº¡t Ä‘á»™ng á»Ÿ Ä‘Ã¢u?
2. **Compare Against References** â€” Ä‘á»c TOÃ€N Bá»˜ reference, khÃ´ng skim
3. **Identify Differences** â€” list EVERY difference
4. **Understand Dependencies** â€” components, settings, config, env

### Phase 3: Hypothesis and Testing

1. **Form Single Hypothesis** â€” "I think X because Y" (viáº¿t ra)
2. **Test Minimally** â€” SMALLEST possible change, 1 variable má»—i láº§n
3. **Verify** â€” Worked? â†’ Phase 4. Didn't? â†’ NEW hypothesis (khÃ´ng pile thÃªm fixes)

### Phase 4: Implementation

1. **Create Failing Test** â€” simplest reproduction
2. **Implement Single Fix** â€” root cause only, NO "while I'm here" improvements
3. **Verify Fix** â€” test passes? No regressions?
4. **If Fix Doesn't Work** â€” <3 tries: return Phase 1. **â‰¥3 tries: QUESTION ARCHITECTURE**

> [!warning] 3+ Fixes Failed = Architectural Problem
> Pattern: má»—i fix reveals new shared state/coupling á»Ÿ chá»— khÃ¡c.
> â†’ STOP. Question fundamentals. Discuss with human partner.

## Red Flags â€” STOP & Follow Process

- "Quick fix for now"
- "Just try changing X"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "Pattern says X but I'll adapt differently"
- "One more fix attempt" (khi Ä‘Ã£ try 2+)

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple" | Simple bugs cÃ³ root causes too |
| "Emergency, no time" | Systematic = FASTER than thrashing |
| "Try this first" | First fix sets the pattern |
| "Multiple fixes saves time" | Can't isolate what worked |
| "I see the problem" | Seeing symptoms â‰  understanding cause |

## Quick Reference

| Phase | Activities | Success |
|-------|-----------|---------|
| 1. Root Cause | Read errors, reproduce, check changes | Understand WHAT + WHY |
| 2. Pattern | Find working examples, compare | Identify differences |
| 3. Hypothesis | Form theory, test minimally | Confirmed or new |
| 4. Implementation | Create test, fix, verify | Bug resolved âœ… |

## Supporting Techniques

- `root-cause-tracing.md` â€” trace bugs backward
- `defense-in-depth.md` â€” add validation multi-layer
- `condition-based-waiting.md` â€” replace timeouts with condition polling

## Connections
- **Related:** [[Test Driven Development]], [[Verification]]
- **Used by:** [[Executing Plans]], [[Subagent Driven Dev]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
