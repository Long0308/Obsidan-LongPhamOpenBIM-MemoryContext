---
parent: "[[Agent-Memory]]"
group: "Memory Patterns"
title: "Memory Bank — Patterns"
tags: [memory-bank, patterns, auto-memory, agent-swarm]
date: 2026-03-15
updated: 2026-03-15
---
group: "Memory Patterns"
# 🧩 Reusable Patterns

> Patterns discovered across sessions. Referenced by agent for consistency.

## Pattern Index

| # | Pattern | Domain | First Seen |
|---|---------|--------|------------|
| 1 | [[#P1 — Glassmorphism Card]] | UI/CSS | 2026-03-15 |
| 2 | [[#P2 — Edge Function Route Pattern]] | Backend | 2026-03-15 |
| 3 | [[#P3 — Auto-Memory Checkpoint]] | Agent | 2026-03-15 |
| 4 | [[#P4 — Per-Model Config Object]] | Data | 2026-03-15 |
| 5 | [[#P5 — Obsidian Note Enrichment]] | Documentation | 2026-03-15 |

---
group: "Memory Patterns"
## P1 — Glassmorphism Card

**Context:** Dark-themed dashboards, data cards, status panels
**Pattern:**
```css
.card {
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 12px;
  backdrop-filter: blur(10px);
  padding: 16px;
}
```
**Used in:** `dashboard.html` (quota cards, stats cards)

---
group: "Memory Patterns"
## P2 — Edge Function Route Pattern

**Context:** Single-file Deno edge functions with multiple routes
**Pattern:**
```typescript
// Route matching via last path segment
const p = url.pathname.split('/').filter(Boolean).pop() || '';
if (req.method === 'POST' && p === 'route-name') { ... }
if (req.method === 'GET' && p === 'another-route') { ... }
```
**Used in:** `memory-gateway/index.ts` — health, save-session, init-session, sessions, context-stats, sync-github

---
group: "Memory Patterns"
## P3 — Auto-Memory Checkpoint

**Context:** Agent context window monitoring
**Pattern:**
```
Count tool calls → at thresholds (30/60/80/90):
1. Estimate tokens = (chat_messages * 4) + (file_refs * 800) + (tool_calls * 1200) + 2000
2. POST /save-session with summary
3. At 80%: ASK user to continue or new session
4. At 90%: STOP
```
**Used in:** GEMINI.md TIER 0, auto-memory/SKILL.md

---
group: "Memory Patterns"
## P4 — Per-Model Config Object

**Context:** When different models have different limits/resets/pricing
**Pattern:**
```javascript
const models = [
  { model: 'Gemini 3.1 Pro', tier: 'High', usage: 100.0, resetAt: geminiReset },
  { model: 'Claude Sonnet 4.6', tier: 'Thinking', usage: 60.0, resetAt: claudeReset },
];
// Each model carries its own config — no shared global
```
**Used in:** `dashboard.html` quota panel

---
group: "Memory Patterns"
## P5 — Obsidian Note Enrichment

**Context:** Converting thin stub notes into full documentation
**Pattern:**
```
1. Read original source (SKILL.md, agent .md)
2. Extract: triggers, processes, tables, checklists, red flags
3. Add Obsidian metadata (tags, connections, group)
4. Keep original structure, add cross-links via [[wikilinks]]
5. Result: note readable standalone in Obsidian without opening source
```
**Used in:** 30+ skill notes enrichment (session bd959bf9)

---
group: "Memory Patterns"
## Links

- [[Auto Memory|Auto-Memory Skill]]
- [[Memory Context Monitor|Dashboard]]
- [[AGENT_SWARM|MOC]]
