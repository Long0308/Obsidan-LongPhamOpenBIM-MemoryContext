---
parent: "[[Agent-Memory]]"
group: "Memory Patterns"
title: "Memory Types trong Agentic Systems"
tags:
  - ai-agent
  - memory
  - architecture
  - reference
aliases:
  - Các Loại Bộ Nhớ Agent
  - Memory Architecture
created: 2026-03-15
---
group: "Memory Patterns"
# 🧠 Memory Types trong Agentic Systems

> Phân tích kiến trúc bộ nhớ trong hệ thống AI Agent — áp dụng vào auto-memory protocol.

![[memory-types-agentic-systems.png]]

---
group: "Memory Patterns"
## 1. Context Window (Cửa Sổ Ngữ Cảnh)

Luồng xử lý bên trái diagram — đây là **bộ nhớ tạm thời** trong một phiên chat duy nhất.

| Bước | Mô tả | Ví dụ |
|------|-------|-------|
| **Query** | Người dùng gửi yêu cầu | "Đặt vé bay đi Tokyo tháng 12" |
| **Thought** | Agent suy nghĩ, kiểm tra constraints | "Cần check budget, dates, preferences" |
| **Tool Call** | Gọi API bên ngoài | Flights API, Weather API, Calendar |
| **Retrieve** | Lấy kiến thức từ Long-Term Memory | Sở thích du lịch, mã sân bay, visa |
| **Task State** | Lưu trạng thái task hiện tại | "task_status: in_progress" |
| **Thought** | Đánh giá context hiện tại và quyết định | "Review the context & decide" |
| **Response** | Phản hồi + cập nhật bộ nhớ | "Respond & then clear state & update memory" |

### ⚠️ Giới hạn Context Window
- **Có kích thước cố định** (16K–1M tokens tùy model)
- **Bị truncate** khi vượt giới hạn → mất protocol, mất context
- **Không persistent** — mất hết khi kết thúc session

---
group: "Memory Patterns"
## 2. Long-Term Memory (Bộ Nhớ Dài Hạn)

Hệ thống lưu trữ bền vững — **tồn tại qua nhiều sessions**.

### 📖 Episodic Memory (Bộ nhớ Tình tiết)
> Các sự kiện, tương tác, và sở thích từ quá khứ.

- **Là gì:** Nhớ lại các cuộc hội thoại trước, quyết định đã đưa ra
- **Ví dụ trong hệ thống ta:** Session notes trên Obsidian + GitHub
- **Mapping:** `session-{date}-{ide}-{project}.md` + Query Log table
- **Trạng thái hiện tại:** ✅ Đã implement qua auto-memory protocol

### 📚 Semantic Memory (Bộ nhớ Ngữ nghĩa)
> Kiến thức chung + kiến thức chuyên ngành.

- **Là gì:** Tri thức domain (BIM/Revit, coding patterns, user preferences)
- **Ví dụ trong hệ thống ta:** Knowledge Items (KI), skill files, GEMINI.md rules
- **Mapping:** `.agent/skills/`, `knowledge/` folder, conversation_summaries
- **Trạng thái hiện tại:** ✅ Đã implement qua KI system + skills

### 🔧 Procedural Memory (Bộ nhớ Thủ tục)
> Các quy trình, workflow, và decision patterns đã học được.

- **Là gì:** Biết cách thực hiện một task (step-by-step)
- **Ví dụ trong hệ thống ta:** Workflows (.agent/workflows/), auto-memory checkpoint protocol
- **Mapping:** `/create`, `/debug`, `/plan` → workflow files
- **Trạng thái hiện tại:** ✅ Đã implement qua workflow system

---
group: "Memory Patterns"
## 3. Working Memory (Bộ Nhớ Làm Việc)

Scratchpad tạm thời — **buffer giữa Context Window và Long-Term Memory**.

| Thành phần | Mô tả | Mapping trong hệ thống |
|------------|-------|------------------------|
| **Task Context** | ID, loại, trạng thái, context hiện tại | `task_boundary` tool → task.md |
| **Parameters** | Tham số, constraints, dates | Implementation plan, user preferences |
| **Next Steps/Results** | Kết quả tạm, candidates, bước tiếp | Checkpoint saves, intermediate states |

### Working Memory trong Auto-Memory Protocol
```
task.md          → Task Context (what we're doing)
implementation_plan.md → Parameters + constraints
walkthrough.md   → Results + verification
session note     → Episodic snapshot → pushed to Long-Term
```

---
group: "Memory Patterns"
## 4. Quy Trình 4 Bước (Diagram bên phải)

| # | Bước | Mô tả | Trong hệ thống ta |
|---|------|-------|-------------------|
| 1 | **Task State Storage** | Agent lưu chi tiết task đang xử lý vào scratchpad tạm | `task.md` + `task_boundary` calls |
| 2 | **Task State Storage** | Giữ context window gọn gàng bằng cách chuyển details ra ngoài | Session note checkpoints |
| 3 | **Retrieval** | Lấy kiến thức liên quan để hỗ trợ quyết định | KI system, past session notes, skills |
| 4 | **Memory Storage** | Sau interaction, lưu thông tin quan trọng vào permanent storage | POST `/save-session` → GitHub + Obsidian |

---
group: "Memory Patterns"
## 5. Gap Analysis — So sánh với hệ thống hiện tại

### ✅ Đã có
| Tính năng | Implementation |
|-----------|---------------|
| 🧠 Persistent Memory | Session notes + GitHub + Insforge DB |
| 🔍 Skill-Based Search | `.agent/skills/` + KI system |
| 🤖 Automatic Operation | Auto-memory protocol trong GEMINI.md TIER 0 |
| 🔒 Context Configuration | user_rules, GEMINI.md config |
| 📋 Episodic Memory | Session notes với Query Log + Decision Log |
| 📚 Semantic Memory | KI system + skill files |
| 🔧 Procedural Memory | Workflow files (.agent/workflows/) |
| 📝 Working Memory | task.md + implementation_plan.md + walkthrough.md |

### ⚠️ Thiếu hoặc Chưa hoàn thiện
| Tính năng | Trạng thái | Giải pháp đề xuất |
|-----------|------------|-------------------|
| 📊 Progressive Disclosure | ❌ Chưa có | Layered memory retrieval — chỉ load tóm tắt trước, load chi tiết khi cần |
| 🌐 Web Viewer UI | ❌ Chưa có | Real-time memory stream tại localhost (dashboard đang có nhưng chưa stream) |
| 🔗 Citations | ❌ Chưa có | Reference past observations bằng ID — link tới session notes cụ thể |
| 🔒 Privacy Control | ❌ Chưa có | `<private>` tags để exclude sensitive content khỏi storage |
| 🧪 Beta Channel | ❌ Chưa có | Endless Mode / version switching cho auto-memory |
| ⏰ Context Window Tracking (real-time) | 🟡 Heuristic | Chỉ đếm tool calls — không có API lấy token count thật |
| 🔄 Quota Reset Timer | 🟡 Data có | `resetTime` trong API nhưng chưa hiện countdown trên dashboard |
| 📛 Conversation Title Auto-detect | 🟡 Data có | Có từ `conversation_summaries` nhưng chưa auto-populate |

---
group: "Memory Patterns"
## Links

- [[Auto-Memory Protocol|← Auto-Memory Protocol]]
- [[AI Agent Resources|AI Agent Resources]]
- [[E2E-Setup-Guide|E2E Setup Guide]]
- [[GEMINI Rules|GEMINI Rules]]
