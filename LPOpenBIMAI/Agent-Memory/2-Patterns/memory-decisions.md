---
parent: "[[Agent-Memory]]"
group: "Memory Patterns"
title: "Memory Bank — Decisions"
tags: [memory-bank, decisions, adr, auto-memory, agent-swarm]
date: 2026-03-15
updated: 2026-03-15
---
group: "Memory Patterns"
# 📋 Architecture Decision Records

> Significant technical decisions. Format: ADR (Architecture Decision Record).

## Decision Index

| # | Decision | Date | Status |
|---|----------|------|--------|
| ADR-001 | [[#ADR-001 — Edge Function over REST API]] | 2026-03-15 | ✅ Active |
| ADR-002 | [[#ADR-002 — Token-Based Context Estimation]] | 2026-03-15 | ✅ Active |
| ADR-003 | [[#ADR-003 — GEMINI.md as Enforcement Layer]] | 2026-03-15 | ✅ Active |
| ADR-004 | [[#ADR-004 — Session-Init for Dashboard Reset]] | 2026-03-15 | ✅ Active |
| ADR-005 | [[#ADR-005 — Memory Bank over Pure Session Notes]] | 2026-03-15 | ✅ Active |

---
group: "Memory Patterns"
## ADR-001 — Edge Function over REST API

**Date:** 2026-03-15
**Status:** ✅ Active
**Context:** Need a backend for auto-memory that saves sessions, syncs GitHub, and serves dashboard data.
**Decision:** Use Insforge Edge Function (`mem-gw-final`) instead of a standalone REST API.
**Rationale:**
- Zero infra management — Insforge handles deployment
- Direct access to Insforge DB (memories, entities, sync_log)
- Single file deployment via CLI
- Built-in CORS and auth
**Consequences:** Limited to Deno runtime. All routes in single file. No middleware chain.

---
group: "Memory Patterns"
## ADR-002 — Token-Based Context Estimation

**Date:** 2026-03-15
**Status:** ✅ Active
**Context:** Dashboard needs to show context window usage, but no direct API to get actual token count.
**Decision:** Estimate tokens heuristically: `system(2K) + chat(messages*4) + files(refs*800) + tools(calls*1200)`.
**Rationale:**
- Accurate enough for checkpoint decisions (30/60/80/90%)
- No dependency on IDE internals
- Can be calibrated over time
**Trade-offs:** Not exact — may drift ±10% from actual. Acceptable for monitoring.

---
group: "Memory Patterns"
## ADR-003 — GEMINI.md as Enforcement Layer

**Date:** 2026-03-15
**Status:** ✅ Active
**Context:** Auto-memory protocol kept failing after context truncation because it relied on SKILL.md files.
**Decision:** Embed core auto-memory rules in GEMINI.md (TIER 0) — always injected into system prompt.
**Rationale:**
- GEMINI.md survives truncation (always injected)
- SKILL.md is supplementary detail
- Checkpoint thresholds must never be forgotten
**Consequences:** GEMINI.md grows larger. Must keep enforcement section concise.

---
group: "Memory Patterns"
## ADR-004 — Session-Init for Dashboard Reset

**Date:** 2026-03-15
**Status:** ✅ Active
**Context:** Dashboard context gauge stayed stale when opening new conversation. Only updated at first checkpoint (~30 tool calls).
**Decision:** Add `POST /init-session` endpoint. Agent calls it immediately on new conv. Dashboard detects `session-init` category and resets gauge to ~2%.
**Rationale:**
- Immediate visual feedback for user
- Lightweight — only stores init timestamp, not full session
- `importance: 0.3` so it doesn't pollute session history
**Consequences:** Extra DB row per conversation start. Low cost.

---
group: "Memory Patterns"
## ADR-005 — Memory Bank over Pure Session Notes

**Date:** 2026-03-15
**Status:** ✅ Active
**Context:** Session notes capture conversation logs but not reusable knowledge. Patterns, decisions, and troubleshooting get lost between sessions.
**Decision:** Create 4 structured memory bank files alongside session notes:
- `memory-active-context.md` — volatile, updated per checkpoint
- `memory-patterns.md` — reusable patterns
- `memory-decisions.md` — ADRs
- `memory-troubleshooting.md` — known issues + fixes
**Rationale:** Inspired by Claude's CLAUDE-*.md pattern. Complements auto-memory's session logging with distilled knowledge.
**Consequences:** Agent must update memory bank files during relevant sessions. Not every session — only when new knowledge is discovered.

---
group: "Memory Patterns"
## Links

- [[Auto Memory|Auto-Memory Skill]]
- [[Memory Context Monitor|Dashboard]]
- [[AGENT_SWARM|MOC]]
