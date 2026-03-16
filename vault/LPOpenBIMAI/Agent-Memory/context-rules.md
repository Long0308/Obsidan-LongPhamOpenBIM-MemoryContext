---
tags:
  - memory
  - agent-swarm
---

# Context Rules — Memory Pruning & Decay

## Short-Term (Session Memory)
- **Giới hạn:** Token window ~80% capacity
- **Auto-summarize:** Khi >70% tokens → tóm tắt 60% messages cũ nhất
- **Store full:** Full context lưu vào Gateway `store({type: 'session'})`
- **Keep recent:** Giữ 40% messages gần nhất + summary
- **/compact:** User gõ `/compact` → trigger summarization thủ công

## Long-Term (Cross-Session Memory)
- **Facts:** Lưu permanent, không decay
- **Preferences:** Lưu permanent, update khi user thay đổi
- **Decisions:** Lưu per-project, decay chậm (×1.3 boost)
- **Patterns:** Lưu global, decay chậm (×1.3 boost)
- **Entities:** Lưu per-project, decay bình thường
- **Sessions:** Lưu summary, full context decay sau 30 ngày

## Decay Rules
- `decayScore`: 1.0 (fresh) → 0.0 (archived)
- **Formula:** `baseDecay × accessBoost × typeBoost`
  - `baseDecay = max(0, 1 - daysSinceAccess / 60)`
  - `accessBoost = min(2, 1 + log10(accessCount+1) × 0.3)`
  - `typeBoost = 1.3` cho decision/pattern/preference, `1.0` cho others
- **Archive:** `decayScore < 0.1` → move to `archive/`
- **Check interval:** Mỗi 1 giờ

## Duplicate Merging
- Khi `store()` phát hiện content similarity > 90%:
  - Merge vào entry cũ
  - Tăng `accessCount`
  - Update `lastAccessed`
  - Log `update` op thay vì `store` op
