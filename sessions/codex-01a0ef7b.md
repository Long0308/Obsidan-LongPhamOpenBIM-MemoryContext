---
id: codex-01a0ef7b
title: "T7 implement Meeting Translator native WLK Whisper+NLLB pipeline integratio"
date: 30/09/2026 06:23:42
workspace: "[[workspaces/meeting-translator|meeting-translator]]"
model: "[[models/gpt-6-luna|gpt-6-luna]]"
ide: Codex Desktop
tokens: 3607331
tags: [session, codex, meeting-translator]
---

# 🗣️ Phiên Chat: T7 implement Meeting Translator native WLK Whisper+NLLB pipeline integratio

> **Nền tảng**: Codex Desktop · **Mô hình**: `[[models/gpt-6-luna|gpt-6-luna]]`
> **Thư mục**: `[[workspaces/meeting-translator|meeting-translator]]` · **Thời gian**: `30/09/2026 06:23:42`
> **Mức tiêu thụ**: **3,607,331 tokens**

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
  <cwd>D:\61.SetupAgent\setupagent\meeting-translator</cwd>
  <shell>powershell</shell>
  <current_date>2026-09-30</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>D:\61.SetupAgent\setupagent\meeting-translator</root></workspace_roots><permission_profile type="managed"><file_system type="restricted"><entry access="read"><special>:root</special></entry><entry access="write"><path>D:\61.SetupAgent\setupagent\meeting-translator</path></entry><entry access="write"><special>:slash_tmp</special></entry><entry access="write"><special>:tmpdir</special></entry><entry access="read"><path>D:\61.SetupAgent\setupagent\meeting-translator\.git</path></entry><entry access="read"><path>D:\61.SetupAgent\setupagent\meeting-translator\.agents</path></entry><entry access="read"><path>D:\61.SetupAgent\setupagent\meeting-translator\.codex</path></entry></file_system></permission_profile></filesystem>
</environment_context>

---

T7 implement Meeting Translator native WLK Whisper+NLLB pipeline integration. Workspace D:/61.SetupAgent/setupagent/meeting-translator. Root owns runtime config/api deploy; your scope ONLY apps/api/app/realtime/pipeline.py and apps/api/tests/test_live_pipeline.py (may edit same file, no other production sources). User wants complete extension E2E; this is the gating integration before rebuilding. Recall Maya-agent-memory unavailable RemoteDisconnected (soft gate). Read current plan row T7 and existing native client `apps/api/app/realtime/wlk_native.py` + its22 passing contract tests, then existing pipeline lifecycle. Current old pipeline uses WlkRealtimeClient for backend='wlk'; .env is about to target backend='wlk_native' and ws://host.docker.internal:8052 candidate. Branch selection must be opt-in without changing current `wlk` or speaches routes.
```

---

## 🤖 2. Phản Hồi Từ Trợ Lý AI (Assistant Response)

I’ll inspect the T7 plan row and the existing native client and pipeline lifecycle first. I’ll also check whether a usable recall endpoint is available; I’ll keep changes within the two files you named and leave the existing `wlk` and `speaches` branches intact.

---

The T7 plan confirms the integration must route native translation, timing, speaker labels, and translation errors to the matching segment, while DeepSeek remains the final authority. The current adapter only constructs the older WLK client for `backend="wlk"`; I’m tracing how partial drafts and final translation are emitted so native output can join that lifecycle without changing either existing route.

---

The native client is now an explicit `wlk_native` branch, and native audio offsets and source role are carried into the pipeline’s caption frames. I’m tightening the completion ordering next: NLLB drafts need to follow that line’s source caption, and late native updates must not overwrite a DeepSeek final.

---

## 🧭 3. Điều Hướng & Liên Kết Mạng Lưới
- 📋 Danh mục tổng: [[Session-Chat-History|Trang Tổng Hợp Lịch Sử Phiên Chat]]
- 🏢 Không gian làm việc: [[workspaces/meeting-translator|Dự án meeting-translator]]
- 🤖 Mô hình xử lý: [[models/gpt-6-luna|gpt-6-luna]]
- 🗺️ Bản đồ quan hệ: [[Memory-Graph.canvas|Canvas Mạng Lưới Tri Thức]]
