---
title: Writing Skills
tags:
  - agent-skill
  - skill
  - superpowers
  - meta
group: Superpowers
role: TDD cho documentation â€” táº¡o skill má»›i hoáº·c edit skill cÅ©
source: .agent/skills/writing-skills/SKILL.md
---

# Writing Skills â€” TDD for Documentation

> [!abstract] Vai TrÃ²
> Ãp dá»¥ng TDD cho process documentation. Viáº¿t test (pressure scenarios) â†’ watch fail (baseline) â†’ viáº¿t skill â†’ watch pass â†’ refactor (close loopholes).

> [!caution] The Iron Law
> ```
> NO SKILL WITHOUT A FAILING TEST FIRST
> ```
> Viáº¿t skill trÆ°á»›c test? Delete. Start over. Applies to NEW skills AND EDITS.

## What is a Skill?
- **Are:** Reusable techniques, patterns, tools, reference guides
- **Are NOT:** Narratives about how you solved a problem once

## When to Create

| Create When | Don't Create For |
|-------------|------------------|
| Technique wasn't intuitively obvious | One-off solutions |
| Would reference again across projects | Standard practices documented elsewhere |
| Pattern applies broadly | Project-specific conventions (â†’ GEMINI.md) |
| Others would benefit | Mechanical constraints (â†’ automate) |

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

## Overview â€” Core principle (1-2 sentences)
## When to Use â€” Symptoms, flowchart if non-obvious
## Core Pattern â€” Before/after code comparison
## Quick Reference â€” Table for scanning
## Implementation â€” Inline code or link to file
## Common Mistakes â€” What goes wrong + fixes
```

## Claude Search Optimization (CSO)

### Description Rules
- Start with "Use when..."
- **ONLY triggering conditions, NEVER summarize workflow**
- Third person
- Max 500 characters

> [!warning] Trap
> Descriptions that summarize workflow â†’ Claude follows description instead of reading skill body. Tests proved this.

```yaml
# âŒ BAD: Summarizes workflow
description: Use for TDD - write test first, watch it fail, write minimal code

# âœ… GOOD: Just triggers
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

1. **Close every loophole explicitly** â€” "Delete. Don't keep as reference."
2. **Address spirit vs letter** â€” "Violating letter = violating spirit"
3. **Build rationalization table** â€” capture every excuse from baseline testing
4. **Create red flags list** â€” easy self-check

## Skill Creation Checklist

**RED Phase:**
- [ ] Create 3+ pressure scenarios
- [ ] Run WITHOUT skill â†’ document baseline
- [ ] Identify rationalization patterns

**GREEN Phase:**
- [ ] Name: hyphens only, no special chars
- [ ] YAML: name + description (max 1024 chars)
- [ ] Description: "Use when..." + triggers only
- [ ] Address specific baseline failures
- [ ] Run WITH skill â†’ verify compliance

**REFACTOR Phase:**
- [ ] Find new rationalizations â†’ add counters
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
- **Depends on:** [[Test Driven Development]] â€” same discipline
- **Related:** [[Using Superpowers]], [[Brainstorming]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
