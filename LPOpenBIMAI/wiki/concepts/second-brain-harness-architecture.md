# 🏛️ Kiến Trúc 4 Tầng Second Brain Harness

> **Mô hình Harness Engineering 2026**
> Giải quyết dứt điểm nghịch lý: Prompt phình to > 300k tokens gây nghẽn 55s/turn và làm DeepSeek / Claude rơi vào bẫy lặp CoT monologue.

---

## 4 Tầng Phân Lớp

### Tầng 1: Active Execution — LLM Engine
- **Mô hình**: DeepSeek V4.1 Flash, Claude 3.7 Sonnet, GPT-5.6, GLM-5.3.
- **Ranh giới**: Chỉ tập trung suy luận logic, giải thuật và sinh mã nguồn.
- **Ngưỡng vận hành**: Prompt làm việc luôn giữ ở mức **< 80.000 – 100.000 tokens** để duy trì tốc độ phản hồi **1.45s / turn** và hội tụ Attention 100%.

### Tầng 2: Decision & Fast Pruning — Jev System One
- **Mô hình**: TypeSafe AI Jev (`jev-1.13.0` / `jev-latest`).
- **Chi phí & Độ trễ**: **$0.042 / 1 triệu tokens**, 0 generation tokens, phản hồi trong **< 1.0 giây**.
- **Cơ chế**: Nhận toàn bộ transcript; chấm điểm xác suất `p(drop)` cho từng lượt gọi tool. Drop các đoạn đọc file thừa, log rác; giữ nguyên 100% nguyên văn (verbatim) code sửa và lỗi.

### Tầng 3: Structured Context Offloading — InsForge SQL & Obsidian
- **InsForge Backend**: PostgreSQL lưu toàn bộ raw JSON messages, tool parameters, diffs và checkpoints.
- **Obsidian Vault (`D:\20.Obsidian\MemoryContext`)**: Plaintext Markdown tổ chức theo Karpathy Wiki:
  - `raw/`: Tài liệu gốc.
  - `wiki/`: Khái niệm evergreen, liên kết Wikilinks `[[...]]`.
  - `projects/`: Vòng lặp `Inputs/` $\rightarrow$ `Process/` $\rightarrow$ `Outputs/` $\rightarrow$ `Feedback/`.

### Tầng 4: Long-Term Knowledge Graph — Hindsight Graph RAG
- **Cơ chế**: Đồng bộ cuối phiên qua `/sync-memory-bank`.
- **Nguyên tắc vàng**: Chỉ chắt lọc **3 – 7 fact cốt lõi** (quyết định kiến trúc, lỗi đã fix, ràng buộc chốt).
- **Lợi ích**: Không bị ô nhiễm bởi log rác, hỗ trợ tra cứu 0-token (`recall`) tức thì cho mọi Agent ở các phiên sau.

---

## 🔗 Liên Kết
- [[wiki/index|Quay về Mục Lục Tổng]]
- [[wiki/entities/codex-router|Codex Router]]
- [[wiki/entities/typesafe-jev|TypeSafe Jev]]
