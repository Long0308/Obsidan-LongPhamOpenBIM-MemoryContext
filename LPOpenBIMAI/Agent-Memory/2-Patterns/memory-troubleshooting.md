---
parent: "[[Agent-Memory]]"
group: "Memory Patterns"
title: "Memory Bank — Troubleshooting"
tags: [memory-bank, troubleshooting, debugging, auto-memory, agent-swarm]
date: 2026-03-15
updated: 2026-03-15
---
group: "Memory Patterns"
# 🔧 Known Issues & Fixes

> Debugging knowledge that persists across sessions. Save time by not re-discovering.

## Issue Index

| # | Issue | Severity | Status |
|---|-------|----------|--------|
| 1 | [[#TSH-001 — Auto-memory lost after truncation]] | 🔴 Critical | ✅ Fixed |
| 2 | [[#TSH-002 — sync_log INSERT fails with RLS]] | 🟡 Medium | ✅ Fixed |
| 3 | [[#TSH-003 — Dashboard context gauge stale]] | 🟡 Medium | ✅ Fixed |
| 4 | [[#TSH-004 — Quota reset times identical]] | 🟢 Low | ✅ Fixed |
| 5 | [[#TSH-005 — Obsidian skill notes show only stubs]] | 🟡 Medium | ✅ Fixed |
| 6 | [[#TSH-006 — GitHub PAT auth fails on push]] | 🔴 Critical | ✅ Fixed |

---
group: "Memory Patterns"
## TSH-001 — Auto-memory lost after truncation

**Symptom:** Agent stops doing checkpoints after long conversations. No `📌 Checkpoint` logs.
**Root Cause:** Auto-memory was only defined in `SKILL.md` — gets lost when context truncates.
**Fix:** Embedded core protocol in `GEMINI.md` TIER 0 (always injected). SKILL.md now supplementary.
**Session:** `fbdd4deb` (2026-03-15)
**Prevention:** Any critical protocol must be in GEMINI.md, not only in skills.

---
group: "Memory Patterns"
## TSH-002 — sync_log INSERT fails with RLS

**Symptom:** `POST /save-session` succeeds for memories but fails silently for sync_log.
**Root Cause:** RLS policy on `sync_log` table didn't allow anonymous inserts from edge function.
**Fix:** Added RLS policy: `CREATE POLICY "Allow edge function inserts" ON sync_log FOR INSERT TO anon WITH CHECK (true);`
**Session:** `3261e65e` (2026-03-15)
**Prevention:** After creating any table, always check RLS policies for edge function access.

---
group: "Memory Patterns"
## TSH-003 — Dashboard context gauge stale

**Symptom:** Context window shows old data from previous conversation even after starting new one.
**Root Cause:** Dashboard reads from `sessions` API which only has data from last `save-session` POST. New conversation doesn't trigger a save.
**Fix:** Added `POST /init-session` endpoint + dashboard detection of `session-init` category entries.
**Session:** `1074004b` (2026-03-15)
**Prevention:** Any dashboard data that should reset on new events needs an explicit signal, not passive polling.

---
group: "Memory Patterns"
## TSH-004 — Quota reset times identical

**Symptom:** All model quota cards show same reset countdown.
**Root Cause:** Single `getResetTime()` function used for all models. Antigravity IDE has different reset schedules per model tier.
**Fix:** Per-model `resetAt` timestamps: Gemini resets 01:22 UTC+7, Claude/GPT resets 22:21 UTC+7.
**Session:** `1074004b` (2026-03-15)

---
group: "Memory Patterns"
## TSH-005 — Obsidian skill notes show only stubs

**Symptom:** Agent skill notes in Obsidian vault have ~990 bytes with only summary — no actual skill content.
**Root Cause:** Initial enrichment only extracted metadata, not full SKILL.md processes/tables/checklists.
**Fix:** Re-enriched all 30+ skill notes with complete content from source SKILL.md files.
**Session:** `bd959bf9` (2026-03-15)
**Prevention:** When creating vault notes from sources, always include the operational content, not just metadata.

---
group: "Memory Patterns"
## TSH-006 — GitHub PAT auth fails on push

**Symptom:** `ghPush` returns `failed:401` or `failed:403`.
**Root Cause:** GitHub PAT expired or didn't have `repo` scope.
**Fix:** Generated new fine-grained PAT with `contents: write` permission for the specific repo.
**Session:** `3261e65e` (2026-03-15)
**Prevention:** Use fine-grained PATs. Check expiry. Set `GITHUB_PAT` env in Insforge function settings.

---
group: "Memory Patterns"
## Links

- [[Auto Memory|Auto-Memory Skill]]
- [[Memory Context Monitor|Dashboard]]
- [[AGENT_SWARM|MOC]]
