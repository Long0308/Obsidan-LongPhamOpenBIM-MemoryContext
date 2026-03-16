---
title: Stitch Loop
tags:
  - agent-skill
  - skill
  - design
  - automation
group: Design
role: Autonomous website builder loop â€” baton system + Stitch MCP
source: .agent/skills/stitch-loop/SKILL.md
---

# Stitch Build Loop

> [!abstract] Vai TrÃ²
> Autonomous frontend builder dÃ¹ng iterative baton-passing loop. Má»—i iteration: Ä‘á»c task â†’ generate page vá»›i Stitch â†’ integrate vÃ o site â†’ viáº¿t task tiáº¿p theo.

## Overview

```
next-prompt.md (baton) â†’ Read task â†’ Stitch generate â†’ Integrate â†’ Update docs â†’ Write next baton â†’ Loop
```

## Prerequisites

**Required:**
- Stitch MCP Server access
- Stitch project (existing or new)
- `DESIGN.md` â€” visual design system
- `SITE.md` â€” site vision and roadmap

**Optional:**
- Chrome DevTools MCP Server â€” visual verification

## The Baton System

`next-prompt.md` acts as relay baton between iterations:

```markdown
---
page: about
---
A page describing how the site works.

**DESIGN SYSTEM (REQUIRED):**
[Copy from DESIGN.md Section 6]

**Page Structure:**
1. Header with navigation
2. Main content
3. Footer with links
```

**Critical rules:**
- `page` frontmatter â†’ output filename
- Prompt MUST include design system block from `DESIGN.md`
- MUST update file before completing (keeps loop alive)

## Execution Protocol (6 Steps)

### Step 1: Read the Baton
Parse `next-prompt.md`: extract page name + prompt content

### Step 2: Consult Context Files

| File | Purpose |
|------|---------|
| `SITE.md` | Vision, Stitch Project ID, sitemap, roadmap |
| `DESIGN.md` | Required visual style |

**Check:** Don't recreate existing pages. Pick from backlog first.

### Step 3: Generate with Stitch
1. Get/create project â†’ save ID to `stitch.json`
2. `generate_screen_from_text` with full prompt + design system
3. `get_screen` â†’ download HTML + screenshot to `queue/`

### Step 4: Integrate into Site
1. Move `queue/{page}.html` â†’ `site/public/{page}.html`
2. Fix asset paths
3. Wire navigation (replace `href="#"` placeholders)
4. Ensure consistent headers/footers

### Step 4.5: Visual Verification (Optional)
If Chrome DevTools MCP available: start dev server â†’ navigate â†’ screenshot â†’ compare

### Step 5: Update Site Documentation
- Add page to `SITE.md` Section 4 (Sitemap) with `[x]`
- Remove consumed ideas from Section 6

### Step 6: Prepare Next Baton (CRITICAL)
**MUST update `next-prompt.md`** â€” check roadmap â†’ pick from backlog or invent new page

## File Structure

```
project/
â”œâ”€â”€ next-prompt.md      # The baton
â”œâ”€â”€ stitch.json         # Stitch project ID
â”œâ”€â”€ DESIGN.md           # Visual design system
â”œâ”€â”€ SITE.md             # Site vision + roadmap
â”œâ”€â”€ queue/              # Staging area
â””â”€â”€ site/public/        # Production pages
```

## Orchestration Options

| Method | How |
|--------|-----|
| CI/CD | GitHub Actions triggers on `next-prompt.md` changes |
| Human-in-loop | Developer reviews each iteration |
| Agent chains | One agent dispatches to another |
| Manual | Developer runs agent repeatedly |

## Common Pitfalls
- âŒ Forgetting to update `next-prompt.md` (breaks loop)
- âŒ Recreating existing page
- âŒ Not including design system block
- âŒ Leaving `href="#"` placeholders
- âŒ Forgetting to persist `stitch.json`

## Connections
- **Integrates with:** [[Stitch]], [[Frontend Design]]
- **Design system from:** `design-md` skill

## NhÃ³m
Design | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
