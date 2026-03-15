---
title: Finishing Dev Branch
tags:
  - skill
  - superpowers
  - workflow
group: Superpowers
role: Hoàn thành dev branch — verify tests → present options → execute → cleanup
source: .agent/skills/finishing-a-development-branch/SKILL.md
---

# Finishing a Development Branch

> [!abstract] Vai Trò
> Guide completion of development work: Verify tests → Present 4 options → Execute choice → Clean up.

## The Process (5 Steps)

### Step 1: Verify Tests
```bash
npm test / cargo test / pytest / go test ./...
```
- Tests fail? → **STOP.** Show failures. Cannot proceed.
- Tests pass? → Continue.

### Step 2: Determine Base Branch
```bash
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

### Step 3: Present Options (EXACTLY 4)
```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

### Step 4: Execute Choice

| Option | Actions |
|--------|---------|
| **1. Merge locally** | checkout base → pull → merge → verify tests → delete branch |
| **2. Create PR** | push -u origin → gh pr create |
| **3. Keep as-is** | Report branch/worktree location. Don't cleanup. |
| **4. Discard** | Confirm first ("type 'discard'") → checkout base → branch -D |

### Step 5: Cleanup Worktree
- **Options 1, 2, 4:** `git worktree remove <path>`
- **Option 3:** Keep worktree

## Quick Reference

| Option | Merge | Push | Keep WT | Cleanup Branch |
|--------|-------|------|---------|----------------|
| 1. Merge | ✓ | - | - | ✓ |
| 2. PR | - | ✓ | ✓ | - |
| 3. Keep | - | - | ✓ | - |
| 4. Discard | - | - | - | ✓ (force) |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skip test verification | Always verify BEFORE offering options |
| Open-ended questions | Present exactly 4 structured options |
| Auto worktree cleanup | Only cleanup for Options 1 and 4 |
| No discard confirmation | Require typed "discard" |

## Red Flags

**Never:** Proceed with failing tests, merge without verifying, delete without confirmation, force-push without request.

**Always:** Verify tests first, present exactly 4 options, confirm discard, cleanup worktree for Options 1 & 4 only.

## Integration

**Called by:**
- [[Subagent Driven Dev]] (after all tasks)
- [[Executing Plans]] (after all batches)

**Pairs with:**
- [[Git Worktrees]] — cleans up worktree created by that skill

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
