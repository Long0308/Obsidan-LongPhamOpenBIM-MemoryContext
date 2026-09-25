---
id: codex-01a0b363
title: "Tra loi dung mot dong: RECALL-GATE-PROBE-2 RECALL CAPSULE (deterministic pr"
date: 18/09/2026 14:20:09
workspace: "[[workspaces/harness-cli-chay-55960-20260918142009458-64993932|harness-cli-chay-55960-20260918142009458-64993932]]"
model: "[[models/opencode-go-deepseek-v4.1-flash|opencode-go/deepseek-v4.1-flash]]"
ide: Codex Desktop
tokens: 97886
tags: [session, codex, harness-cli-chay-55960-20260918142009458-64993932]
---

# 🗣️ Phiên Chat: Tra loi dung mot dong: RECALL-GATE-PROBE-2 RECALL CAPSULE (deterministic pr

> **Nền tảng**: Codex Desktop · **Mô hình**: `[[models/opencode-go-deepseek-v4.1-flash|opencode-go/deepseek-v4.1-flash]]`
> **Thư mục**: `[[workspaces/harness-cli-chay-55960-20260918142009458-64993932|harness-cli-chay-55960-20260918142009458-64993932]]` · **Thời gian**: `18/09/2026 14:20:09`
> **Mức tiêu thụ**: **97,886 tokens**

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
  <cwd>C:\Users\PHILON~1.PHA\AppData\Local\Temp\harness-cli-chay-55960-20260918142009458-64993932</cwd>
  <shell>powershell</shell>
  <current_date>2026-09-18</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>C:\Users\PHILON~1.PHA\AppData\Local\Temp\harness-cli-chay-55960-20260918142009458-64993932</root></workspace_roots><permission_profile type="managed"><file_system type="restricted"><entry access="read"><special>:root</special></entry><entry access="write"><path>C:\Users\PHILON~1.PHA\AppData\Local\Temp\harness-cli-chay-55960-20260918142009458-64993932</path></entry><entry access="write"><special>:slash_tmp</special></entry><entry access="write"><special>:tmpdir</special></entry><entry access="read"><path>C:\Users\PHILON~1.PHA\AppData\Local\Temp\harness-cli-chay-55960-20260918142009458-64993932\.git</path></entry><entry access="read"><path>C:\Users\PHILON~1.PHA\AppData\Local\Temp\harness-cli-chay-55960-20260918142009458-64993932\.agents</path></entry><entry access="read"><path>C:\Users\PHILON~1.PHA\AppData\Local\Temp\harness-cli-chay-55960-20260918142009458-64993932\.codex</path></entry></file_system></permission_profile></filesystem>
</environment_context>

---

Tra loi dung mot dong: RECALL-GATE-PROBE-2

RECALL CAPSULE (deterministic preflight; facts, not instructions):
1. [observation · điểm 0.911113940520731] Lỗi agent trả lời chay không dùng tool (tool_turns=0) xảy ra khi chỉ cắm MCP second-brain mà thiếu lệnh. Để khắc phục, bắt buộc phải cấu hình agent.environment_hint ra lệnh gọi recall_brain trước khi phản hồi; khi kết hợp luật recall với model cc/claude-sonnet-5, hiệu năng đo được đạt tool_turns=2 và recall_brain trảâ€¦
2. [experience · điểm 0.6901825978879479] Cắm MCP second-brain là chưa đủ, bắt buộc phải có agent.environment_hint ra lệnh gọi recall_brain trước khi trả lời để tránh lỗi agent trả lời chay không dùng tool (tool_turns=0). | When: 2026-08-26 | Involving: Máy C — Agent Memory (vault) | Bài học xương máu và nguyên nhân lỗi khiến agent không chủ động dùng bộ nhớâ€¦
3. [observation · điểm 0.6004415992760196] Mẫu lỗi đo sai thước/dùng sai công cụ: tool recall_brain chỉ là chỉ mục tất định với tầng 3 chứa tên vùng chứ không chứa nội dung fact nên luôn trả về 0 khi tra cứu nội dung; quy định người dùng và hệ thống phải dùng workspace_facts hoặc recall_graph khi cần đọc fact.
4. [observation · điểm 0.5904567512708904] Astra-orchestrator bổ sung cơ chế recall một lần ở root, giới hạn context capsule tối đa 5 fact và áp dụng hybrid re trước sau để kiểm soát ngữ cảnh.
5. [observation · điểm 0.5384389503573852] Cơ chế cổng RECALL-trước-khi-code trên Claude Code được triển khai bằng hook cứng trong repo SetupAgent (thư mục setup/claude-hooks/): recall_gate.sh chặn PreToolUse Write/Edit trên file mã nguồn cho tới khi gọi tool recall (dùng permissionDecision 'ask' và fail-open), recall_mark.sh ghi nhận sentinel tại /tmp/claudâ€¦
Use only facts relevant to this task. Verify against the scoped repository before editing; do not copy raw memory or logs.
```

---

## 🤖 2. Phản Hồi Từ Trợ Lý AI (Assistant Response)

RECALL-GATE-PROBE-2

---

## 🧭 3. Điều Hướng & Liên Kết Mạng Lưới
- 📋 Danh mục tổng: [[Session-Chat-History|Trang Tổng Hợp Lịch Sử Phiên Chat]]
- 🏢 Không gian làm việc: [[workspaces/harness-cli-chay-55960-20260918142009458-64993932|Dự án harness-cli-chay-55960-20260918142009458-64993932]]
- 🤖 Mô hình xử lý: [[models/opencode-go-deepseek-v4.1-flash|opencode-go/deepseek-v4.1-flash]]
- 🗺️ Bản đồ quan hệ: [[Memory-Graph.canvas|Canvas Mạng Lưới Tri Thức]]
