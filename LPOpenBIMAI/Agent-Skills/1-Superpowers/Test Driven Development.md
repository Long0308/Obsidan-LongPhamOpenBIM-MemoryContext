---
title: Test Driven Development
tags:
  - skill
  - superpowers
  - testing
group: Superpowers
role: Write test first → watch fail → minimal code to pass
source: .agent/skills/test-driven-development/SKILL.md
---

# Test-Driven Development (TDD)

> [!abstract] Vai Trò
> Dùng khi implement BẤT KỲ feature hoặc bugfix. PHẢI viết test TRƯỚC code. Nếu test pass ngay → test sai.

> [!caution] The Iron Law
> ```
> NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
> ```
> Viết code trước test? **DELETE. Start over.** Không giữ "reference", không "adapt". Delete = delete.

## When to Use

**Always:** New features, Bug fixes, Refactoring, Behavior changes

**Exceptions (ask human partner):** Throwaway prototypes, Generated code, Config files

> Thinking "skip TDD just this once"? Stop. That's rationalization.

## Red-Green-Refactor Cycle

### 🔴 RED — Write Failing Test
- One behavior per test
- Clear name (describes behavior)
- Real code (no mocks unless unavoidable)

```typescript
test('retries failed operations 3 times', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };
  const result = await retryOperation(operation);
  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
```

### Verify RED — Watch It Fail (MANDATORY)
```bash
npm test path/to/test.test.ts
```
- Test fails (not errors)?
- Failure message expected?
- Fails because feature missing (not typos)?

### 🟢 GREEN — Minimal Code
Write **simplest** code to pass. Don't add features, don't "improve".

### Verify GREEN (MANDATORY)
- Test passes?
- Other tests still pass?
- Output pristine (no errors/warnings)?

### 🔵 REFACTOR — Clean Up
After green only: remove duplication, improve names, extract helpers. **Keep tests green. Don't add behavior.**

## Why Order Matters

| Excuse | Reality |
|--------|---------|
| "I'll test after" | Tests passing immediately prove nothing |
| "Already manually tested" | Ad-hoc ≠ systematic. No record, can't re-run |
| "Deleting X hours is wasteful" | Sunk cost fallacy. Keeping unverified code = debt |
| "Keep as reference" | You'll adapt it = testing after. Delete means delete |
| "Need to explore first" | Fine. Throw away exploration, start with TDD |
| "Test hard = design unclear" | Hard to test = hard to use. Fix design |
| "TDD will slow me down" | TDD faster than debugging |
| "Tests after achieve same goals" | Tests-after = "what does this do?" Tests-first = "what should this do?" |
| "Too simple to test" | Simple code breaks. Test takes 30 seconds |
| "This is different because..." | No. Delete code. Start over with TDD |

## Red Flags — STOP & Start Over

- Code before test
- Test after implementation
- Test passes immediately
- Can't explain why test failed
- Tests added "later"
- "Just this once"
- "I already manually tested it"

## Verification Checklist

- [ ] Every new function/method has a test
- [ ] Watched each test fail before implementing
- [ ] Failed for expected reason (feature missing, not typo)
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] Output pristine
- [ ] Tests use real code (mocks only if unavoidable)
- [ ] Edge cases and errors covered

Can't check all boxes? **You skipped TDD. Start over.**

## When Stuck

| Problem | Solution |
|---------|----------|
| Don't know how to test | Write wished-for API. Assertion first. Ask partner. |
| Test too complicated | Design too complicated. Simplify interface. |
| Must mock everything | Code too coupled. Use dependency injection. |
| Test setup huge | Extract helpers. Still complex? Simplify design. |

## Bug Fix Flow

Bug found? → Write failing test reproducing it → Follow TDD cycle → Test proves fix + prevents regression.

**Never fix bugs without a test.**

## Connections
- **Related:** [[Systematic Debugging]], [[Verification]]
- **Used by:** [[Subagent Driven Dev]], [[Executing Plans]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
