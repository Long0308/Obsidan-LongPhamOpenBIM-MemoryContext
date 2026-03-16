---
title: Writing Skills
tags:
  - skill
  - superpowers
  - meta
group: Superpowers
role: TDD cho documentation — tạo skill mới hoặc edit skill cũ
source: .agent/skills/writing-skills/SKILL.md
---

# Writing Skills — TDD for Documentation

> [!abstract] Vai Trò
> Áp dụng TDD cho process documentation. Viết test (pressure scenarios) → watch fail (baseline) → viết skill → watch pass → refactor (close loopholes).

> [!caution] The Iron Law
> ```
> NO SKILL WITHOUT A FAILING TEST FIRST
> ```
> Viết skill trước test? Delete. Start over. Applies to NEW skills AND EDITS.

## What is a Skill?
- **Are:** Reusable techniques, patterns, tools, reference guides
- **Are NOT:** Narratives about how you solved a problem once

## When to Create

| Create When | Don't Create For |
|-------------|------------------|
| Technique wasn't intuitively obvious | One-off solutions |
| Would reference again across projects | Standard practices documented elsewhere |
| Pattern applies broadly | Project-specific conventions (→ GEMINI.md) |
| Others would benefit | Mechanical constraints (→ automate) |

## TDD Mapping

| TDD Concept | Skill Creation |
|-------------|----------------|
| Test case | Pressure scenario with subagent |
| Production code | SKILL.md |
| RED (fails) | Agent violates rule without skill |
| GREEN (passes) | Agent complies with skill present |
| Refactor | Close loopholes |

## SKILL.md Structure

```markdown
---
name: Skill-Name-With-Hyphens
description: Use when [specific triggering conditions]
---

# Skill Name

## Overview — Core principle (1-2 sentences)
## When to Use — Symptoms, flowchart if non-obvious
## Core Pattern — Before/after code comparison
## Quick Reference — Table for scanning
## Implementation — Inline code or link to file
## Common Mistakes — What goes wrong + fixes
```

## Claude Search Optimization (CSO)

### Description Rules
- Start with "Use when..."
- **ONLY triggering conditions, NEVER summarize workflow**
- Third person
- Max 500 characters

> [!warning] Trap
> Descriptions that summarize workflow → Claude follows description instead of reading skill body. Tests proved this.

```yaml
# ❌ BAD: Summarizes workflow
description: Use for TDD - write test first, watch it fail, write minimal code

# ✅ GOOD: Just triggers
description: Use when implementing any feature or bugfix, before writing code
```

### Keyword Coverage
- Error messages, symptoms, synonyms, tools
- Use words Claude would search for

### Token Efficiency
- getting-started: <150 words
- Frequently-loaded: <200 words
- Other: <500 words

## Skill Types

| Type | Approach |
|------|----------|
| **Technique** | Concrete method with steps |
| **Pattern** | Way of thinking about problems |
| **Reference** | API docs, syntax guides |

## Bulletproofing Against Rationalization

1. **Close every loophole explicitly** — "Delete. Don't keep as reference."
2. **Address spirit vs letter** — "Violating letter = violating spirit"
3. **Build rationalization table** — capture every excuse from baseline testing
4. **Create red flags list** — easy self-check

## Skill Creation Checklist

**RED Phase:**
- [ ] Create 3+ pressure scenarios
- [ ] Run WITHOUT skill → document baseline
- [ ] Identify rationalization patterns

**GREEN Phase:**
- [ ] Name: hyphens only, no special chars
- [ ] YAML: name + description (max 1024 chars)
- [ ] Description: "Use when..." + triggers only
- [ ] Address specific baseline failures
- [ ] Run WITH skill → verify compliance

**REFACTOR Phase:**
- [ ] Find new rationalizations → add counters
- [ ] Build rationalization table
- [ ] Create red flags list
- [ ] Re-test until bulletproof

**Deploy:**
- [ ] Each skill tested individually before next
- [ ] Commit + push

## File Organization

| Pattern | When |
|---------|------|
| `SKILL.md` only | Everything fits inline |
| `SKILL.md` + `example.ts` | Reusable tool/code |
| `SKILL.md` + reference files | Heavy reference (100+ lines) |

## Connections
- **Depends on:** [[Test Driven Development]] — same discipline
- **Related:** [[Using Superpowers]], [[Brainstorming]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
