---
title: Lint and Validate
tags:
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

# 🔍 Lint and Validate

> [!abstract] Mục đích
> Chạy linting và validation trên code. Đảm bảo code quality, type safety, và formatting standards trước khi commit.

## Khi nào dùng

- Sau MỌI code change
- Trước commit/PR
- Khi `checklist.py` chạy (step 2: Code Quality)

## Công cụ hỗ trợ

| Tool | Mục đích |
|------|----------|
| ESLint | JavaScript/TypeScript linting |
| Prettier | Code formatting |
| TypeScript compiler | Type checking (`tsc --noEmit`) |
| Biome | All-in-one lint+format (alternative) |

## Quy trình

```
Code Change → Lint Runner:
  1. ESLint/Biome check → fix auto-fixable issues
  2. TypeScript strict check → report type errors
  3. Prettier format → enforce consistent style
  4. Report: pass/fail + details
```

## Script

```bash
python .agent/skills/lint-and-validate/scripts/lint_runner.py
```

## Kết hợp với

| Skill | Quan hệ |
|-------|---------|
| `clean-code` | Standards mà lint enforce |
| `testing-patterns` | Lint chạy trước tests |
| `verification-before-completion` | Lint là bước đầu của verification |

## Links

- [[Agent-Skills|← Skills Index]]
- [[Clean Code|🧹 Clean Code]]
- [[Testing Patterns|🧪 Testing Patterns]]
