---
title: UI-UX Pro Max
tags:
  - agent-skill
  - skill
  - design
  - frontend
group: Design
role: Design intelligence â€” 50 styles, 97 palettes, 57 fonts, 99 UX guidelines, 9 stacks
source: .agent/skills/ui-ux-pro-max/SKILL.md
---

# UI-UX Pro Max â€” Design Intelligence

> [!abstract] Vai TrÃ²
> Comprehensive design guide: 50+ styles, 97 color palettes, 57 font pairings, 99 UX guidelines, 25 chart types Ã— 9 technology stacks. Searchable database vá»›i priority-based recommendations.

## Rule Categories by Priority

| # | Category | Impact | Domain |
|---|----------|--------|--------|
| 1 | Accessibility | CRITICAL | `ux` |
| 2 | Touch & Interaction | CRITICAL | `ux` |
| 3 | Performance | HIGH | `ux` |
| 4 | Layout & Responsive | HIGH | `ux` |
| 5 | Typography & Color | MEDIUM | `typography`, `color` |
| 6 | Animation | MEDIUM | `ux` |
| 7 | Style Selection | MEDIUM | `style` |
| 8 | Charts & Data | LOW | `chart` |

## Quick Reference â€” Critical Rules

### Accessibility (CRITICAL)
- `color-contrast` â€” Min 4.5:1 ratio
- `focus-states` â€” Visible focus rings
- `aria-labels` â€” aria-label for icon-only buttons
- `keyboard-nav` â€” Tab order matches visual order

### Touch & Interaction (CRITICAL)
- `touch-target-size` â€” Min 44Ã—44px
- `loading-buttons` â€” Disable during async
- `cursor-pointer` â€” Add to all clickable elements

### Performance (HIGH)
- `image-optimization` â€” WebP, srcset, lazy loading
- `reduced-motion` â€” Check `prefers-reduced-motion`

### Layout (HIGH)
- `viewport-meta` â€” width=device-width initial-scale=1
- `readable-font-size` â€” Min 16px body on mobile
- `z-index-management` â€” Define scale (10, 20, 30, 50)

## Workflow (4 Steps)

### Step 1: Analyze Requirements
Extract: product type, style keywords, industry, stack

### Step 2: Generate Design System (REQUIRED)
```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system -p "Project Name"
```

### Step 2b: Persist (Master + Overrides)
```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system --persist -p "Name"
# Creates: design-system/MASTER.md + design-system/pages/
```

### Step 3: Supplement with Domain Searches
```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain <domain>
```

### Step 4: Stack Guidelines
```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<keyword>" --stack html-tailwind
```

## Available Domains

| Domain | Use For |
|--------|---------|
| `product` | SaaS, e-commerce, portfolio recommendations |
| `style` | glassmorphism, minimalism, dark mode... |
| `typography` | Google Fonts pairings |
| `color` | Palettes by industry |
| `landing` | Page structure, CTAs |
| `chart` | Chart types, library recs |
| `ux` | Best practices, anti-patterns |
| `react` | React/Next.js performance |
| `web` | ARIA, focus, keyboard, semantic |

## Available Stacks

| Stack | Focus |
|-------|-------|
| `html-tailwind` | Tailwind, responsive, a11y (DEFAULT) |
| `react` | Hooks, performance, patterns |
| `nextjs` | SSR, routing, images, API |
| `vue` | Composition API, Pinia |
| `svelte` | Runes, stores, SvelteKit |
| `swiftui` | Views, State, Navigation |
| `react-native` | Components, Lists |
| `flutter` | Widgets, Layout, Theming |
| `shadcn` | shadcn/ui components |

## Professional UI Rules

### Icons
| Do | Don't |
|----|-------|
| SVG icons (Heroicons, Lucide) | Emojis as UI icons ðŸš€ |
| Consistent sizing (24Ã—24) | Mix icon sizes |

### Light/Dark Mode
| Do | Don't |
|----|-------|
| `bg-white/80` in light mode | `bg-white/10` (invisible) |
| `#0F172A` for text | `#94A3B8` for body text |
| `border-gray-200` in light | `border-white/10` |

## Pre-Delivery Checklist

- [ ] No emojis as icons â†’ use SVG
- [ ] All clickable elements have `cursor-pointer`
- [ ] Hover states: 150-300ms transitions
- [ ] Light mode text: 4.5:1 contrast min
- [ ] Responsive: 375px, 768px, 1024px, 1440px
- [ ] `prefers-reduced-motion` respected

## Connections
- **Related:** [[Frontend Design]], [[Web Design Guidelines]]
- **Used by:** [[Frontend Specialist]], [[Mobile Developer]]

## NhÃ³m
Design | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
