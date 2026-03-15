---
title: Defuddle
tags:
  - skill
  - tools
  - web
group: Tools
role: Extract clean markdown từ web pages, giảm token usage
source: .agent/skills/defuddle/SKILL.md
---

# Defuddle — Clean Web Content Extraction

> [!abstract] Vai Trò
> CLI tool extract clean readable content từ web pages. Prefer over WebFetch cho standard pages — remove navigation, ads, clutter → giảm token usage đáng kể.

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

| Flag | Format | Khi nào dùng |
|------|--------|-------------|
| `--md` | Markdown | Mặc định, dùng cho mọi extraction |
| `--json` | JSON (HTML + markdown) | Khi cần cả HTML lẫn markdown |
| *(none)* | HTML | Khi cần raw HTML |
| `-p <name>` | Metadata property | Khi chỉ cần 1 property (title, domain...) |

## When to Use

- User provides URL → dùng Defuddle thay WebFetch
- Online documentation, articles, blog posts
- Bất kỳ standard web page nào
- Mục tiêu: giảm token count bằng cách loại bỏ noise

## Connections
- **Use instead of:** WebFetch (cho standard pages)
- **Related:** [[Clean Code]] (token efficiency)

## Nhóm
Tools | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
