---
parent: "[[Agent-Memory]]"
group: "Config & Rules"
tags:
  - memory
  - agent-swarm
---
group: "Config & Rules"
# Context Rules — Memory Pruning & Decay

## Short-Term (Session Memory)
- **Gi?i h?n:** Token window ~80% capacity
- **Auto-summarize:** Khi >70% tokens ? tóm t?t 60% messages cu nh?t
- **Store full:** Full context luu vào Gateway `store({type: 'session'})`
- **Keep recent:** Gi? 40% messages g?n nh?t + summary
- **/compact:** User gõ `/compact` ? trigger summarization th? công

## Long-Term (Cross-Session Memory)
- **Facts:** Luu permanent, không decay
- **Preferences:** Luu permanent, update khi user thay d?i
- **Decisions:** Luu per-project, decay ch?m (×1.3 boost)
- **Patterns:** Luu global, decay ch?m (×1.3 boost)
- **Entities:** Luu per-project, decay bình thu?ng
- **Sessions:** Luu summary, full context decay sau 30 ngày

## Decay Rules
- `decayScore`: 1.0 (fresh) ? 0.0 (archived)
- **Formula:** `baseDecay × accessBoost × typeBoost`
  - `baseDecay = max(0, 1 - daysSinceAccess / 60)`
  - `accessBoost = min(2, 1 + log10(accessCount+1) × 0.3)`
  - `typeBoost = 1.3` cho decision/pattern/preference, `1.0` cho others
- **Archive:** `decayScore < 0.1` ? move to `archive/`
- **Check interval:** M?i 1 gi?

## Duplicate Merging
- Khi `store()` phát hi?n content similarity > 90%:
  - Merge vào entry cu
  - Tang `accessCount`
  - Update `lastAccessed`
  - Log `update` op thay vì `store` op
