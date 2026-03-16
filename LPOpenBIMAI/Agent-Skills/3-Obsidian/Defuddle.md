---
title: Defuddle
tags:
  - agent-skill
  - skill
  - tools
  - web
group: Tools
role: Extract clean markdown tá»« web pages, giáº£m token usage
source: .agent/skills/defuddle/SKILL.md
---

# Defuddle â€” Clean Web Content Extraction

> [!abstract] Vai TrÃ²
> CLI tool extract clean readable content tá»« web pages. Prefer over WebFetch cho standard pages â€” remove navigation, ads, clutter â†’ giáº£m token usage Ä‘Ã¡ng ká»ƒ.

## Installation

```bash
npm install -g defuddle
```

## Usage

### Extract markdown (default choice)
```bash
defuddle parse <url> --md
```

### Save to file
```bash
defuddle parse <url> --md -o content.md
```

### Extract metadata
```bash
defuddle parse <url> -p title
defuddle parse <url> -p description
defuddle parse <url> -p domain
```

## Output Formats

| Flag | Format | Khi nÃ o dÃ¹ng |
|------|--------|-------------|
| `--md` | Markdown | Máº·c Ä‘á»‹nh, dÃ¹ng cho má»i extraction |
| `--json` | JSON (HTML + markdown) | Khi cáº§n cáº£ HTML láº«n markdown |
| *(none)* | HTML | Khi cáº§n raw HTML |
| `-p <name>` | Metadata property | Khi chá»‰ cáº§n 1 property (title, domain...) |

## When to Use

- User provides URL â†’ dÃ¹ng Defuddle thay WebFetch
- Online documentation, articles, blog posts
- Báº¥t ká»³ standard web page nÃ o
- Má»¥c tiÃªu: giáº£m token count báº±ng cÃ¡ch loáº¡i bá» noise

## Connections
- **Use instead of:** WebFetch (cho standard pages)
- **Related:** [[Clean Code]] (token efficiency)

## NhÃ³m
Tools | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
