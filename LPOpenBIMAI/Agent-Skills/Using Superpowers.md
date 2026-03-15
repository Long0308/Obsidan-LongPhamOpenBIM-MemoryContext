---
title: Using Superpowers
tags:
  - skill
  - superpowers
  - meta
group: Superpowers
role: Meta-skill — cách tìm và dùng skills, PHẢI invoke trước ANY response
source: .agent/skills/using-superpowers/SKILL.md
---

# Using Superpowers — Meta-Skill

> [!abstract] Vai Trò
> Quy tắc nền tảng: invoke relevant skills TRƯỚC bất kỳ response hay action nào, kể cả clarifying questions. Nếu 1% chance skill áp dụng → PHẢI invoke.

> [!caution] Non-Negotiable
> ```
> IF A SKILL APPLIES, YOU MUST USE IT. NO EXCEPTIONS.
> ```

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, GEMINI.md, direct requests) — highest
2. **Superpowers skills** — override default system behavior
3. **Default system prompt** — lowest

## The Rule

**Invoke relevant skills BEFORE any response or action.** Even 1% chance → invoke to check.

```
User message → Might any skill apply? 
  → YES (even 1%) → Invoke Skill → Announce "Using [skill] to [purpose]" 
    → Has checklist? → Create todo per item → Follow skill exactly
  → Definitely not → Respond normally
```

## Red Flags — Rationalizations

| Thought | Reality |
|---------|---------|
| "Just a simple question" | Questions are tasks. Check for skills. |
| "Need more context first" | Skill check comes BEFORE clarifying questions |
| "Let me explore codebase first" | Skills tell you HOW to explore. Check first. |
| "This doesn't need a formal skill" | If a skill exists, use it |
| "I remember this skill" | Skills evolve. Read current version |
| "The skill is overkill" | Simple → complex. Use it |
| "I'll just do this one thing first" | Check BEFORE doing anything |
| "I know what that means" | Knowing concept ≠ using skill. Invoke it |

## Skill Priority

Multiple skills could apply? Use this order:
1. **Process skills first** (brainstorming, debugging) — determine HOW
2. **Implementation skills second** (frontend-design, mcp-builder) — guide execution

Examples:
- "Let's build X" → brainstorming first → then implementation skills
- "Fix this bug" → debugging first → then domain skills

## Skill Types

| Type | Approach |
|------|----------|
| **Rigid** (TDD, debugging) | Follow exactly. Don't adapt away discipline |
| **Flexible** (patterns) | Adapt principles to context |

The skill itself tells you which type it is.

## Platform Adaptation

| Platform | How Skills Load |
|----------|----------------|
| Claude Code | `Skill` tool |
| Gemini CLI | `activate_skill` tool |
| Other | Check platform docs |

## Connections
- **Related:** ALL other skills (this is the meta-skill that governs skill usage)
- **Defined by:** [[GEMINI Rules]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
