# 🧠 CLAUDE.md — Quy Chuẩn Vận Hành Second Brain Obsidian

> Bản hợp đồng hành vi cho Claude Code, Codex Desktop, VS Code Copilot và mọi Agent khi tương tác với Vault này.

## 1. Ranh Giới Lưu Trữ
- **Tài liệu gốc (Raw inputs)**: Đặt vào `raw/`. Tuyệt đối không chỉnh sửa file trong `raw/` sau khi đã lưu.
- **Khái niệm & Thực thể (Wiki)**: Đặt vào `wiki/concepts/` hoặc `wiki/entities/`. Luôn gắn liên kết `[[...]]` hai chiều để mở rộng đồ thị Graph View.
- **Dự án thực thi**: Nằm trong `projects/<tên-dự-án>/` tuân theo vòng lặp 4 bước:
  - `Inputs/`: Đề bài, yêu cầu.
  - `Process/`: Kế hoạch, bản nháp, phân tích.
  - `Outputs/`: Sản phẩm hoàn thiện, mã code, báo cáo.
  - `Feedback/`: Đo lường, nhận xét, rút kinh nghiệm.

## 2. Quy Tắc Nén Ngữ Cảnh & Ghi Ký Ức
- Khi làm việc trong các phiên dài, không nhồi nhét log thực thi vào file markdown dài bất tận.
- Tận dụng Jev Compaction để gọt giũa ngữ cảnh.
- Rút tỉa 3-5 fact quan trọng nhất đẩy vào Hindsight qua skill `/sync-memory-bank`.
