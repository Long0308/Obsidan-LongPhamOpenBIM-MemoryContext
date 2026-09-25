# 🗣️ Context Memory Chat & Session Transcripts

> Nơi tổng hợp toàn bộ các phiên làm việc (chat sessions, agent tool logs, context snapshots) đã được lưu vết và nén ngữ cảnh.
> Định dạng ngày chuẩn: **DD/MM/YYYY** · Đồng bộ hai chiều với **Supabase `public.agent_sessions`**.

---

## 📅 Danh Sách Các Phiên Làm Việc (Sessions Directory)

| Ngày (DD/MM/YYYY) | Tiêu Đề Phiên (Session Title)                         | Nền Tảng IDE    | Mô Hình AI             | File Lưu Vết & Chi Tiết                                                                                              | Trạng Thái Context       |
| ----------------- | ----------------------------------------------------- | --------------- | ---------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| **25/09/2026**    | **Khởi Tạo Jev Compactor & Vá Lỗi CoT Loop DeepSeek** | Codex Desktop   | `deepseek-v4.1-flash`  | [[wiki/log\|Nhật Ký Phiên 25/09/2026]]                                                                               | Đã nén 1s (< 80k tokens) |
| **25/09/2026**    | **Nghiệm Thu Toàn Diện Second Brain Harness 4 Tầng**  | Unified CLI     | `opencode-go/deepseek` | [[Second-Brain-Harness.canvas\|Second-Brain-Harness.canvas]]                                                         | Hoàn thành UAT E2E 100%  |
| **21/03/2026**    | **Phát Triển LPOpenBIM Revit MCP Skill**              | VS Code Copilot | `claude-3-7-sonnet`    | [[LPOpenBIMAI/Agent-Memory/4-Sessions/session-2026-03-21-vscode-LPOpenBIM-RevitMCPSkill\|session-2026-03-21-vscode]] | Lưu vết transcript       |
| **19/03/2026**    | **Audit & Nâng Cấp Hệ Thống AgentSwarm**              | Antigravity     | `gemini-2.5-pro`       | [[LPOpenBIMAI/Agent-Memory/4-Sessions/session-2026-03-19-antigravity-LPOpenBIMAI\|session-2026-03-19-antigravity]]   | Đồng bộ Swarm Canvas     |
| **16/03/2026**    | **Fix Context Gauge Reset & Đồng Bộ GitHub Vault**    | Antigravity     | `gemini-2.5-pro`       | [[sessions/s-cd4a7c7a-b63b-4521-8636-38d97253ea2c\|s-cd4a7c7a (Conv 453a7ede)]]                                      | Context 90% (180k/200k)  |
| **16/03/2026**    | **Tái Cấu Trúc Toàn Bộ Vault & Fix Dashboard State**  | Antigravity     | `gemini-2.5-pro`       | [[sessions/s-e4deaa45-06fc-4eb4-af7e-76504c34603e\|s-e4deaa45 (Conv ac8ba15d)]]                                      | Restructured Vault       |
| **15/03/2026**    | **Khởi Tạo Auto-Memory Kit & Deno Functions Backend** | Antigravity     | `gemini-2.5-pro`       | [[sessions/s-0024bd5d-b42f-4b70-bfb6-2d4657efe1cd\|s-0024bd5d (Conv init)]]                                          | Khởi tạo ban đầu         |

---

## 📂 Thư Mục Chi Tiết
1. **`sessions/`**: Chứa 21 bản ghi session chi tiết dạng markdown (`s-*.md`) kèm ID hội thoại duy nhất.
2. **`context-snapshots/`**: Chứa các bản chụp ngữ cảnh dạng JSON (`snapshot-*.json`) dùng để khôi phục trạng thái prompt.
3. **`LPOpenBIMAI/Agent-Memory/4-Sessions/`**: Chứa dashboard và báo cáo tổng hợp session.

---

## 🧭 Điều Hướng Nhanh
- [[Second-Brain-Harness.canvas|🗺️ Sơ đồ Canvas 4 Tầng]]
- [[Memory-Graph.canvas|📊 Sơ đồ Memory Graph]]
- [[Agent-Swarm.canvas|🤖 Sơ đồ Phân Vai 23 Agents]]
- [[LPOpenBIMAI/wiki/index|📖 Mục Lục Trung Tâm (Wiki Index)]]
