---
title: Using Superpowers
tags:
  - agent-skill
  - skill
  - superpowers
  - meta
group: Superpowers
role: Meta-skill â€” cÃ¡ch tÃ¬m vÃ  dÃ¹ng skills, PHáº¢I invoke trÆ°á»›c ANY response
source: .agent/skills/using-superpowers/SKILL.md
---

# Using Superpowers â€” Meta-Skill

> [!abstract] Vai TrÃ²
> Quy táº¯c ná»n táº£ng: invoke relevant skills TRÆ¯á»šC báº¥t ká»³ response hay action nÃ o, ká»ƒ cáº£ clarifying questions. Náº¿u 1% chance skill Ã¡p dá»¥ng â†’ PHáº¢I invoke.

> [!caution] Non-Negotiable
> ```
> IF A SKILL APPLIES, YOU MUST USE IT. NO EXCEPTIONS.
> ```

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, GEMINI.md, direct requests) â€” highest
2. **Superpowers skills** â€” override default system behavior
3. **Default system prompt** â€” lowest

## The Rule

**Invoke relevant skills BEFORE any response or action.** Even 1% chance â†’ invoke to check.

```
User message â†’ Might any skill apply? 
  â†’ YES (even 1%) â†’ Invoke Skill â†’ Announce "Using [skill] to [purpose]" 
    â†’ Has checklist? â†’ Create todo per item â†’ Follow skill exactly
  â†’ Definitely not â†’ Respond normally
```

## Red Flags â€” Rationalizations

| Thought | Reality |
|---------|---------|
| "Just a simple question" | Questions are tasks. Check for skills. |
| "Need more context first" | Skill check comes BEFORE clarifying questions |
| "Let me explore codebase first" | Skills tell you HOW to explore. Check first. |
| "This doesn't need a formal skill" | If a skill exists, use it |
| "I remember this skill" | Skills evolve. Read current version |
| "The skill is overkill" | Simple â†’ complex. Use it |
| "I'll just do this one thing first" | Check BEFORE doing anything |
| "I know what that means" | Knowing concept â‰  using skill. Invoke it |

## Skill Priority

Multiple skills could apply? Use this order:
1. **Process skills first** (brainstorming, debugging) â€” determine HOW
2. **Implementation skills second** (frontend-design, mcp-builder) â€” guide execution

Examples:
- "Let's build X" â†’ brainstorming first â†’ then implementation skills
- "Fix this bug" â†’ debugging first â†’ then domain skills

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

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
