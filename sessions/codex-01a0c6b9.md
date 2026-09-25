---
id: codex-01a0c6b9
title: "Implement cross-IDE user skill installer for D:/61.SetupAgent/jev-typesafea"
date: 22/09/2026 08:27:05
workspace: "[[workspaces/61-SetupAgent|61.SetupAgent]]"
model: "[[models/opencode-go-deepseek-v4.1-flash|opencode-go/deepseek-v4.1-flash]]"
ide: Codex Desktop
tokens: 0
tags: [session, codex, 61-SetupAgent]
---

# 🗣️ Phiên Chat: Implement cross-IDE user skill installer for D:/61.SetupAgent/jev-typesafea

> **Nền tảng**: Codex Desktop · **Mô hình**: `[[models/opencode-go-deepseek-v4.1-flash|opencode-go/deepseek-v4.1-flash]]`
> **Thư mục**: `[[workspaces/61-SetupAgent|61.SetupAgent]]` · **Thời gian**: `22/09/2026 08:27:05`
> **Mức tiêu thụ**: **0 tokens**

---

## 👤 1. Yêu Cầu Của Người Dùng (User Prompt)

```text
# AGENTS.md instructions

<INSTRUCTIONS>
# 🩸 LUẬT ĐẦU TIÊN — NHỚ TRƯỚC KHI LÀM (chốt 2026-08-27)

> Ca thật: dựng TRÙNG trang phân quyền vì không recall trước khi code — trang giàu
> đủ ĐÃ TỒN TẠI (`/api/v1/cau-hinh`), và Hindsight đã giữ sẵn câu trả lời.

**TRƯỚC mọi lượt tạo/sửa code, endpoint, trang, tool, config:**

1. **NHỚ TRƯỚC** — gọi bộ nhớ bền trước khi viết bất cứ gì:
   `recall_brain(<đối tượng>)` · `recall_graph(<đối tượng>)` · `qa_tra(<câu hỏi>)` ·
   Hindsight bank (`:8890`) · brain bộ nhớ thứ hai — **ưu tiên ngang MCP**, không chỉ MCP.
2. **Recall trả về skill/route/tool CÙNG đối tượng ⇒ DÙNG hoặc MỞ RỘNG cái đó.**
   CẤM dựng song song.
3. **Dùng model THÔNG MINH để recall** (Opus / oauth-cc-opus) — model yếu đọc nhầm
   ký ức rồi kết luận sai.
4. **NHỚ SAU** — xong việc đáng nhớ thì `retain_fact` / ghi bank NGAY. Ký ức sống ở
   kho bền, KHÔNG sống trong context: vượt 1 triệu token hay qua hôm sau là mất.

Bản gốc đầy đủ (bảng cổng cứng/mềm theo từng runtime):
`D:\61.SetupAgent\docs\LUAT-RECALL-TRUOC-KHI-CODE.md`

🩸 Ở runtime này luật là **cổng MỀM** — chỉ Claude Code chặn được ở tầng máy bằng
hook `recall_gate.sh`. Khai "hard gate" ở đây là nói dối.

---
</INSTRUCTIONS>

---

<environment_context>
  <cwd>D:\61.SetupAgent</cwd>
  <shell>powershell</shell>
  <current_date>2026-09-22</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>D:\61.SetupAgent</root></workspace_roots><permission_profile type="disabled"><file_system type="unrestricted" /></permission_profile></filesystem>
</environment_context>

---

Implement cross-IDE user skill installer for D:/61.SetupAgent/jev-typesafeai. Root recall complete bank may-agent-memory generic facts no Jev. User explicitly authorized all Jev suite skills all IDE user level, not unrelated skills. Own scripts/install-skills.ps1 and docs/INSTALL_SKILLS_2026-09-22.md plus user skill destinations only. Another source agent is creating skills typesafe-ai, jev-computer, jev-starter, jev-ultrafast, jev-fast-compacttion (exact spelling). Canonical sources currently .agents/skills/typesafe-ai and jev-computer/skill/jev-computer; locate others once created. Installer: dry-run/check, backups differing copies, verify hashes, migrate old fast-jev-compaction skill only, never package directory. Inspect existing installed IDEs and npm skills registry or primary docs to validate supported user discovery paths: shared .agents/skills, Codex, Claude, Cursor, Gemini, Copilot, Continue, Antigravity etc. Install all supported user skill roots. Preserve unrelated configuration. Never copy secrets/env/runtime state. Do not enable hooks globally or call live Jev. No other agents. If source skills not ready implement installer and wait briefly or report ready so root invokes. Record actual paths and verification evidence. Applicable AGENTS and skills apply. Limit reads to task. Return concise.
```

---

## 🤖 2. Phản Hồi Từ Trợ Lý AI (Assistant Response)

*(Phiên làm việc thực thi lệnh CLI / Tools trực tiếp)*

---

## 🧭 3. Điều Hướng & Liên Kết Mạng Lưới
- 📋 Danh mục tổng: [[Session-Chat-History|Trang Tổng Hợp Lịch Sử Phiên Chat]]
- 🏢 Không gian làm việc: [[workspaces/61-SetupAgent|Dự án 61.SetupAgent]]
- 🤖 Mô hình xử lý: [[models/opencode-go-deepseek-v4.1-flash|opencode-go/deepseek-v4.1-flash]]
- 🗺️ Bản đồ quan hệ: [[Memory-Graph.canvas|Canvas Mạng Lưới Tri Thức]]
