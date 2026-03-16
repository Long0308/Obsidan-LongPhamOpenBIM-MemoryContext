---
tags:
  - memory
  - hub
  - antigravity
parent: "[[Antigravity Kit]]"
aliases:
  - Gemini Artifacts
  - Antigravity Brain
---

# 🧠 .gemini — Antigravity Artifacts

> [!info] Brain Directory
> Thư mục `.gemini` chứa artifacts được Antigravity tạo ra trong quá trình làm việc.
> Mỗi conversation tạo 1 subfolder riêng với plans, walkthroughs, và task tracking.

## Cấu trúc

```
C:\Users\Admin\.gemini\antigravity\brain\
├── {conversation-id}/
│   ├── task.md              # Task checklist
│   ├── implementation_plan.md  # Kế hoạch thực thi
│   ├── walkthrough.md       # Bản tổng kết sau hoàn thành
│   └── media/               # Screenshots, recordings
```

## Mối liên hệ với Auto-Memory

| Layer | Vị trí | Mục đích |
|-------|--------|----------|
| `.gemini/brain/` | `C:\Users\Admin\.gemini\` | Artifacts tạm thời theo conversation |
| [[Agent-Memory]] | `LPOpenBIMAI/Agent-Memory/` | Session notes lâu dài (Obsidian) |
| Insforge DB | Cloud | Memories, entities, relationships |
| GitHub | Remote | Backup + sync |

> `.gemini` artifacts là **tạm thời** — dùng trong phiên làm việc.
> [[Agent-Memory]] session notes là **persistent** — tổng hợp từ nhiều phiên.

## Tích hợp

- Khi session kết thúc → nội dung quan trọng từ `.gemini` artifacts được tổng hợp vào session note
- Session note push lên [[Agent-Memory]] → Insforge DB → GitHub
- Conversation tiếp theo auto-load từ DB, không cần đọc lại `.gemini` cũ

## Links

- [[Agent-Memory|Memory Hub]]
- [[Auto Memory|Auto-Memory Skill]]
- [[memory-config|Memory Config]]
- [[Antigravity Kit|Platform Hub]]
