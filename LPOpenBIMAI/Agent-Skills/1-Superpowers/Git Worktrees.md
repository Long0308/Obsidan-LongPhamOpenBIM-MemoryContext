---
title: Git Worktrees
tags:
  - agent-skill
  - skill
  - superpowers
  - workflow
group: Superpowers
role: Táº¡o isolated workspace báº±ng git worktree â€” smart directory + safety verification
source: .agent/skills/using-git-worktrees/SKILL.md
---

# Using Git Worktrees

> [!abstract] Vai TrÃ²
> Táº¡o isolated workspace chia sáº» cÃ¹ng repo. DÃ¹ng khi cáº§n work trÃªn nhiá»u branches Ä‘á»“ng thá»i mÃ  khÃ´ng switch.

> [!tip] Core Principle
> Systematic directory selection + safety verification = reliable isolation

## Directory Selection Priority

1. **Check existing:** `.worktrees/` (preferred, hidden) â†’ `worktrees/`
2. **Check CLAUDE.md/GEMINI.md** for preference
3. **Ask user** â€” present 2 options:
   - `.worktrees/` (project-local, hidden)
   - `~/.config/superpowers/worktrees/<project>/` (global)

## Safety Verification (MANDATORY for project-local)

```bash
# Verify directory is git-ignored
git check-ignore -q .worktrees 2>/dev/null
```

**NOT ignored?** â†’ Add to `.gitignore` â†’ Commit â†’ Proceed

> [!warning] Critical
> Prevents accidentally committing worktree contents to repo.

## Creation Steps

### 1. Detect Project Name
```bash
project=$(basename "$(git rev-parse --show-toplevel)")
```

### 2. Create Worktree
```bash
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"
```

### 3. Run Project Setup (auto-detect)
| File | Command |
|------|---------|
| `package.json` | `npm install` |
| `Cargo.toml` | `cargo build` |
| `requirements.txt` | `pip install -r requirements.txt` |
| `pyproject.toml` | `poetry install` |
| `go.mod` | `go mod download` |

### 4. Verify Clean Baseline
```bash
npm test / cargo test / pytest / go test ./...
```
- Fail â†’ Report, ask proceed or investigate
- Pass â†’ Report ready

### 5. Report Location
```
Worktree ready at <full-path>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name>
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| `.worktrees/` exists | Use it (verify ignored) |
| `worktrees/` exists | Use it (verify ignored) |
| Both exist | Use `.worktrees/` |
| Neither exists | Check docs â†’ Ask user |
| Not ignored | Add to .gitignore + commit |
| Tests fail baseline | Report + ask |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skip ignore verification | Always `git check-ignore` |
| Assume directory location | Follow priority: existing > docs > ask |
| Proceed failing tests | Report, get permission |
| Hardcode setup commands | Auto-detect from project files |

## Red Flags

**Never:** Create worktree without ignore check, skip baseline test, proceed failing tests without asking, assume directory.

**Always:** Follow directory priority, verify ignored, auto-detect setup, verify clean test baseline.

## Integration

**Called by:**
- [[Brainstorming]] (Phase 4) â€” khi design approved
- [[Subagent Driven Dev]] â€” REQUIRED before tasks
- [[Executing Plans]] â€” REQUIRED before tasks

**Pairs with:**
- [[Finishing Dev Branch]] â€” cleanup after work complete

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
