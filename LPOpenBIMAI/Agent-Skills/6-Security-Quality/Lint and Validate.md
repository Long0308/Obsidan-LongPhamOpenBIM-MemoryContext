---
title: Lint and Validate
tags:
  - agent-skill
  - skill
  - testing
  - quality
  - lint
parent: "[[Agent-Skills]]"
skill-folder: lint-and-validate
group: Testing & Quality
aliases:
  - Lint and Validate Skill
  - Linting
---

# ðŸ” Lint and Validate

> [!abstract] Má»¥c Ä‘Ã­ch
> Cháº¡y linting vÃ  validation trÃªn code. Äáº£m báº£o code quality, type safety, vÃ  formatting standards trÆ°á»›c khi commit.

## Khi nÃ o dÃ¹ng

- Sau Má»ŒI code change
- TrÆ°á»›c commit/PR
- Khi `checklist.py` cháº¡y (step 2: Code Quality)

## CÃ´ng cá»¥ há»— trá»£

| Tool | Má»¥c Ä‘Ã­ch |
|------|----------|
| ESLint | JavaScript/TypeScript linting |
| Prettier | Code formatting |
| TypeScript compiler | Type checking (`tsc --noEmit`) |
| Biome | All-in-one lint+format (alternative) |

## Quy trÃ¬nh

```
Code Change â†’ Lint Runner:
  1. ESLint/Biome check â†’ fix auto-fixable issues
  2. TypeScript strict check â†’ report type errors
  3. Prettier format â†’ enforce consistent style
  4. Report: pass/fail + details
```

## Script

```bash
python .agent/skills/lint-and-validate/scripts/lint_runner.py
```

## Káº¿t há»£p vá»›i

| Skill | Quan há»‡ |
|-------|---------|
| `clean-code` | Standards mÃ  lint enforce |
| `testing-patterns` | Lint cháº¡y trÆ°á»›c tests |
| `verification-before-completion` | Lint lÃ  bÆ°á»›c Ä‘áº§u cá»§a verification |

## Links

- [[Agent-Skills|â† Skills Index]]
- [[Clean Code|ðŸ§¹ Clean Code]]
- [[Testing Patterns|ðŸ§ª Testing Patterns]]
