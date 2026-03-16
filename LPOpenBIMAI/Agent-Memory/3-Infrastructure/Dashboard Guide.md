---
parent: "[[Agent-Memory]]"
group: "Infrastructure"
title: Dashboard Guide
tags:
  - memory
  - dashboard
  - monitoring
aliases:
  - Memory Dashboard
  - Agent Dashboard
---
group: "Infrastructure"
# 📊 Dashboard Guide

> Live monitoring dashboard cho hệ thống Agent Memory.

## Cách mở

```powershell
# Chạy HTTP server
npx -y http-server LPOpenBIMAI/Agent-Memory -p 8484 -c-1 --cors

# Mở browser
# → http://localhost:8484/dashboard.html
```

## Tính năng

### 1. Session History
- Hiển thị tất cả sessions gần nhất
- Filter theo project
- Xem conversation IDs + timestamps

### 2. Model Quotas
- Theo dõi quota usage từng model (Gemini, Claude, GPT)
- Hiển thị remaining percentage
- Color coding: 🟢 >50% | 🟡 20-50% | 🔴 <20%
- Reset timer theo gói

### 3. Context Window
- Theo dõi context usage hiện tại
- Thresholds: 30% → 60% → 80% → 90%

### 4. Sync to GitHub
- Nút bấm sync sessions lên GitHub
- Gọi `/sync-github` endpoint

### 5. DB Stats
- Memory count, entity count, sync log count
- Từ `/health` endpoint

## File

| File | Size | Loại |
|------|------|------|
| `dashboard.html` | ~46KB | Single HTML file (CSS + JS embedded) |

## Data Flow

```
Dashboard → fetch('/mem-gw-final/quotas') → Hiển thị quota bars
Dashboard → fetch('/mem-gw-final/sessions') → Hiển thị session list
Dashboard → fetch('/mem-gw-final/health') → Hiển thị DB stats
Sync btn → POST('/mem-gw-final/sync-github') → Push GitHub
```

## Fixes Log

| Date | Fix |
|------|-----|
| 2026-03-15 | `loadQuotas()` sửa endpoint → `/quotas` |
| 2026-03-15 | Remaining % display chính xác |
| 2026-03-15 | Sync button gọi `sync-github` route |

## Links

- [[Agent-Memory|← Memory System]]
- [[Edge Function v2.2|Edge Function]]
- [[sync-quotas.ps1 → quota sync script]]
- [[Memory Context Monitor|Context Monitor]]
