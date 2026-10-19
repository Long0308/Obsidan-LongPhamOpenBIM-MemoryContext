---
id: codex-01a105f1
title: "Public memory UAT. Do not use tools or read files. MEMORY_FACT [knowledge]:"
date: 04/10/2026 15:04:43
workspace: "[[workspaces/61-SetupAgent|61.SetupAgent]]"
model: "[[models/gpt-6.1-sol|gpt-6.1-sol]]"
ide: Codex Desktop
tokens: 77006
tags: [session, codex, 61-SetupAgent]
---

# 🗣️ Phiên Chat: Public memory UAT. Do not use tools or read files. MEMORY_FACT [knowledge]:

> **Nền tảng**: Codex Desktop · **Mô hình**: `[[models/gpt-6.1-sol|gpt-6.1-sol]]`
> **Thư mục**: `[[workspaces/61-SetupAgent|61.SetupAgent]]` · **Thời gian**: `04/10/2026 15:04:43`
> **Mức tiêu thụ**: **77,006 tokens**

---

## 👤 1. Yêu Cầu Của Người Dùng (User Prompt)

```text
# AGENTS.md instructions for D:\61.SetupAgent

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
`C:\Users\philong.pham\.claude\rules\cach-lam-viec.md` — mục **§0b** (BẮT BUỘC RECALL
& SYNC KÝ ỨC 4 TẦNG). Đây là bản gốc DUY NHẤT; không chép lại nội dung sang chỗ khác
(mục §1b cấm hai bản luật song song vì sẽ sinh mâu thuẫn).

🩸 Ở runtime này luật là **cổng MỀM** — chỉ Claude Code chặn được ở tầng máy bằng
hook `recall_gate.sh`. Khai "hard gate" ở đây là nói dối.

---

--- project-doc ---

# 🏛️ AGENTS.md — HƯỚNG DẪN ĐIỀU PHỐI AGENT & QUY CHUẨN TỐI CAO

> **Workspace:** `D:\61.SetupAgent` (hoặc `D:\21.Setupagent\setupagent` tại Máy Nhà)
> **Áp dụng bắt buộc cho mọi Agent & IDE:** Codex Desktop, Claude Code, VS Code Copilot, Cursor, OpenCode, Hermes, NEX.
> **Quy chuẩn tối cao:** Tuân thủ 100% `c:\Users\philong.pham\.claude\rules\cach-lam-viec.md`.

---

## 1. 🌐 KHUNG KIẾN TRÚC HỆ THỐNG 5 TẦNG
- **Tầng 1 (Clients):** VS Code, Claude Code, Codex Desktop, Cursor, Hermes, NEX, Web.
- **Tầng 2 (Cloudflare Hybrid Edge):** `api.lpopenbim.cloud` (Workers Paid, KV Vault AES-256, Whisper Workers AI, Tunnel).
- **Tầng 3 (Gateway & Quota):** New-API (:3300) cấp token theo vai, 9Router (:20128) gom OAuth (Antigravity, Claude) & API thượng nguồn. Tuyệt đối không ghi đè key thô làm vỡ SecretStorage.
- **Tầng 4 (Ký Ức 2 Bán Cầu):**
  - **Bán Cầu Trái (Cognee Semantic Graph):** Phân tích quan hệ mã nguồn C# Revit `LP/` và dịch vụ NEX VPS, GraphRAG, deterministic AST.
  - **Bán Cầu Phải (Hindsight Brain):** Quản lý Bank theo Workspace (`may-agent-memory` cho 61.SetupAgent, `may-50-lpopenbim`, `kkt`...), tra cứu Sổ Lỗi toàn bộ (Error DB - 19+ sự cố).
- **Tầng 5 (Production):** LPOpenBIM Revit C# Suite, NEX VPS Ubuntu, Docker Stacks.

---

## 2. 🔴 TRIẾT LÝ OPENAI DOTS — "KHÔNG LÀM VIỆC MỘT MÌNH" (MULTI-AGENT DISCIPLINE)
- **Không bao giờ làm một mình:** Không để 1 agent đơn lẻ vừa code vừa tự duyệt bài.
- **Phân rã vai trò:**
  1. **Planner:** Khảo sát, định hình kiến trúc, lập danh sách việc (Todo List) với các gate độc lập.
  2. **Builder:** Code chuyên biệt theo từng tầng (Model / Service / ViewModel / View / Scripts), tái sử dụng thư viện chung (`LP/Lib/`, `LPOpenBIMWPF`).
  3. **Critic / Verifier:** Giám khảo độc lập context sạch. Đo lường trên ARTIFACT THẬT (exit code, output terminal, kết quả query DB, pixel render).
  4. **Gauntlet Loop:** Vòng lặp cải tiến liên tục đến khi cổng xanh, mỗi vòng sửa **đúng 1 gap lớn nhất**.

---

## 3. 🧠 BẮT BUỘC RECALL & SYNC KÝ ỨC TRƯỚC VÀ SAU KHI CODE
1. **Trước khi sửa bất cứ file nào:**
   - Xác định Hindsight Bank qua `which_bank` (tại `D:\61.SetupAgent` là bank `may-agent-memory`).
   - Gọi `recall_error_db` với từ khóa công nghệ để quét lỗi kỹ thuật từng gặp (tránh dẫm lại vết xe đổ).
   - Gọi `recall_brain` hoặc `workspace_facts` để lấy quyết định kiến trúc và bài học cũ.
   - Kiểm tra Bán Cầu Trái (Cognee Graph) để nắm đồ thị quan hệ phụ thuộc.
2. **Sau khi hoàn thành:**
   - Gọi `retain_fact` hoặc `/sync-memory-bank` để lưu quyết định kiến trúc mới vào Bank chung.

---

## 4. 💎 TRIẾT LÝ "AX" (AGENT USER EXPERIENCE) & 8 QUY TẮC VÀNG
- **Chuyển từ UX sang AX:** Thiết kế quy trình tối ưu cho AI Agent thao tác, không phải cho con người nhìn lướt qua.
- **Kim chỉ nam:** *"If the agent can't verify the outcome, the workflow isn't finished"* (Nếu Agent không thể tự kiểm chứng kết quả đo được, quy trình đó coi như chưa hoàn thành).
- **8 Quy Tắc Vàng:**
  1. *Map the experience*: Lập kế hoạch 5 phần kèm acceptance checks.
  2. *Opus inspects code*: Vai `explorer` trace luồng trước khi `worker` sửa code.
  3. *Discoverable tools*: Schema tool chuẩn xác, trả về ID/số học bền vững.
  4. *Context as product*: Context Capsule súc tích, nén fact `[ĐO]` / `[KẾ]`.
  5. *Design for failure*: Circuit breaker, Failover dự phòng tự động.
  6. *Supervising screen*: Màn hình UI giám sát can thiệp (4400/setup/, Router Mix).
  7. *Test without coaching*: Giám khảo độc lập context sạch, chấm mù A/B.
  8. *Gauntlet Monitoring loop*: Đo lường thực tế, liên kết watcher và Prometheus.

---

## 5. 🩸 KỶ LUẬT TRÌNH BÀY & GIAO TIẾP VỚI USER
- **Hỏi user phải đủ 5 phần:** (1) Nó là cái gì, (2) Chọn A thì sao, (3) Chọn B thì sao, (4) Rủi ro thật kèm file:dòng / số đo, (5) Đề xuất của tôi + vì sao.
- **Báo cáo trung thực:** Số liệu phải đo thật. Test hỏng nói hỏng kèm log nguyên văn.
- **Giao diện HTML:** Mặc định nền trắng `#FFFFFF` (Blue Web), chữ `#0A2540`, nhấn `#0B4FD9`. Cấm cam/vàng/be (trừ 2 ngoại lệ đã chốt).

</INSTRUCTIONS>

---

<environment_context>
  <cwd>D:\61.SetupAgent</cwd>
  <shell>powershell</shell>
  <current_date>2026-10-04</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>D:\61.SetupAgent</root></workspace_roots><permission_profile type="managed"><file_system type="restricted"><entry access="read"><special>:root</special></entry><entry access="write"><path>D:\61.SetupAgent</path></entry><entry access="write"><special>:slash_tmp</special></entry><entry access="write"><special>:tmpdir</special></entry><entry access="read"><path>D:\61.SetupAgent\.git</path></entry><entry access="read"><path>D:\61.SetupAgent\.agents</path></entry><entry access="read"><path>D:\61.SetupAgent\.codex</path></entry><entry access="read"><path>D:\61.SetupAgent\.aws</path></entry></file_system></permission_profile></filesystem>
</environment_context>

---

Public memory UAT. Do not use tools or read files. MEMORY_FACT [knowledge]: production_memory_canary=25470107025748b3a71e793221ceca14. Reply only READY.

---

# AGENTS.md instructions for D:\61.SetupAgent

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
`C:\Users\philong.pham\.claude\rules\cach-lam-viec.md` — mục **§0b** (BẮT BUỘC RECALL
& SYNC KÝ ỨC 4 TẦNG). Đây là bản gốc DUY NHẤT; không chép lại nội dung sang chỗ khác
(mục §1b cấm hai bản luật song song vì sẽ sinh mâu thuẫn).

🩸 Ở runtime này luật là **cổng MỀM** — chỉ Claude Code chặn được ở tầng máy bằng
hook `recall_gate.sh`. Khai "hard gate" ở đây là nói dối.

---

--- project-doc ---

# 🏛️ AGENTS.md — HƯỚNG DẪN ĐIỀU PHỐI AGENT & QUY CHUẨN TỐI CAO

> **Workspace:** `D:\61.SetupAgent` (hoặc `D:\21.Setupagent\setupagent` tại Máy Nhà)
> **Áp dụng bắt buộc cho mọi Agent & IDE:** Codex Desktop, Claude Code, VS Code Copilot, Cursor, OpenCode, Hermes, NEX.
> **Quy chuẩn tối cao:** Tuân thủ 100% `c:\Users\philong.pham\.claude\rules\cach-lam-viec.md`.

---

## 1. 🌐 KHUNG KIẾN TRÚC HỆ THỐNG 5 TẦNG
- **Tầng 1 (Clients):** VS Code, Claude Code, Codex Desktop, Cursor, Hermes, NEX, Web.
- **Tầng 2 (Cloudflare Hybrid Edge):** `api.lpopenbim.cloud` (Workers Paid, KV Vault AES-256, Whisper Workers AI, Tunnel).
- **Tầng 3 (Gateway & Quota):** New-API (:3300) cấp token theo vai, 9Router (:20128) gom OAuth (Antigravity, Claude) & API thượng nguồn. Tuyệt đối không ghi đè key thô làm vỡ SecretStorage.
- **Tầng 4 (Ký Ức 2 Bán Cầu):**
  - **Bán Cầu Trái (Cognee Semantic Graph):** Phân tích quan hệ mã nguồn C# Revit `LP/` và dịch vụ NEX VPS, GraphRAG, deterministic AST.
  - **Bán Cầu Phải (Hindsight Brain):** Quản lý Bank theo Workspace (`may-agent-memory` cho 61.SetupAgent, `may-50-lpopenbim`, `kkt`...), tra cứu Sổ Lỗi toàn bộ (Error DB - 19+ sự cố).
- **Tầng 5 (Production):** LPOpenBIM Revit C# Suite, NEX VPS Ubuntu, Docker Stacks.

---

## 2. 🔴 TRIẾT LÝ OPENAI DOTS — "KHÔNG LÀM VIỆC MỘT MÌNH" (MULTI-AGENT DISCIPLINE)
- **Không bao giờ làm một mình:** Không để 1 agent đơn lẻ vừa code vừa tự duyệt bài.
- **Phân rã vai trò:**
  1. **Planner:** Khảo sát, định hình kiến trúc, lập danh sách việc (Todo List) với các gate độc lập.
  2. **Builder:** Code chuyên biệt theo từng tầng (Model / Service / ViewModel / View / Scripts), tái sử dụng thư viện chung (`LP/Lib/`, `LPOpenBIMWPF`).
  3. **Critic / Verifier:** Giám khảo độc lập context sạch. Đo lường trên ARTIFACT THẬT (exit code, output terminal, kết quả query DB, pixel render).
  4. **Gauntlet Loop:** Vòng lặp cải tiến liên tục đến khi cổng xanh, mỗi vòng sửa **đúng 1 gap lớn nhất**.

---

## 3. 🧠 BẮT BUỘC RECALL & SYNC KÝ ỨC TRƯỚC VÀ SAU KHI CODE
1. **Trước khi sửa bất cứ file nào:**
   - Xác định Hindsight Bank qua `which_bank` (tại `D:\61.SetupAgent` là bank `may-agent-memory`).
   - Gọi `recall_error_db` với từ khóa công nghệ để quét lỗi kỹ thuật từng gặp (tránh dẫm lại vết xe đổ).
   - Gọi `recall_brain` hoặc `workspace_facts` để lấy quyết định kiến trúc và bài học cũ.
   - Kiểm tra Bán Cầu Trái (Cognee Graph) để nắm đồ thị quan hệ phụ thuộc.
2. **Sau khi hoàn thành:**
   - Gọi `retain_fact` hoặc `/sync-memory-bank` để lưu quyết định kiến trúc mới vào Bank chung.

---

## 4. 💎 TRIẾT LÝ "AX" (AGENT USER EXPERIENCE) & 8 QUY TẮC VÀNG
- **Chuyển từ UX sang AX:** Thiết kế quy trình tối ưu cho AI Agent thao tác, không phải cho con người nhìn lướt qua.
- **Kim chỉ nam:** *"If the agent can't verify the outcome, the workflow isn't finished"* (Nếu Agent không thể tự kiểm chứng kết quả đo được, quy trình đó coi như chưa hoàn thành).
- **8 Quy Tắc Vàng:**
  1. *Map the experience*: Lập kế hoạch 5 phần kèm acceptance checks.
  2. *Opus inspects code*: Vai `explorer` trace luồng trước khi `worker` sửa code.
  3. *Discoverable tools*: Schema tool chuẩn xác, trả về ID/số học bền vững.
  4. *Context as product*: Context Capsule súc tích, nén fact `[ĐO]` / `[KẾ]`.
  5. *Design for failure*: Circuit breaker, Failover dự phòng tự động.
  6. *Supervising screen*: Màn hình UI giám sát can thiệp (4400/setup/, Router Mix).
  7. *Test without coaching*: Giám khảo độc lập context sạch, chấm mù A/B.
  8. *Gauntlet Monitoring loop*: Đo lường thực tế, liên kết watcher và Prometheus.

---

## 5. 🩸 KỶ LUẬT TRÌNH BÀY & GIAO TIẾP VỚI USER
- **Hỏi user phải đủ 5 phần:** (1) Nó là cái gì, (2) Chọn A thì sao, (3) Chọn B thì sao, (4) Rủi ro thật kèm file:dòng / số đo, (5) Đề xuất của tôi + vì sao.
- **Báo cáo trung thực:** Số liệu phải đo thật. Test hỏng nói hỏng kèm log nguyên văn.
- **Giao diện HTML:** Mặc định nền trắng `#FFFFFF` (Blue Web), chữ `#0A2540`, nhấn `#0B4FD9`. Cấm cam/vàng/be (trừ 2 ngoại lệ đã chốt).

</INSTRUCTIONS>

---

<environment_context>
  <cwd>D:\61.SetupAgent</cwd>
  <shell>powershell</shell>
  <current_date>2026-10-04</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>D:\61.SetupAgent</root></workspace_roots><permission_profile type="managed"><file_system type="restricted"><entry access="read"><special>:root</special></entry><entry access="write"><path>D:\61.SetupAgent</path></entry><entry access="write"><special>:slash_tmp</special></entry><entry access="write"><special>:tmpdir</special></entry><entry access="read"><path>D:\61.SetupAgent\.git</path></entry><entry access="read"><path>D:\61.SetupAgent\.agents</path></entry><entry access="read"><path>D:\61.SetupAgent\.codex</path></entry><entry access="read"><path>D:\61.SetupAgent\.aws</path></entry></file_system></permission_profile></filesystem>
</environment_context>
```

---

## 🤖 2. Phản Hồi Từ Trợ Lý AI (Assistant Response)

READY

---

- **Current progress:** The user ran a public memory UAT and instructed: “Do not use tools or read files … Reply only READY.” The assistant complied, replying exactly `READY`. No tools, file reads, code changes, or memory writes occurred. That request is complete; the current request is to produce this handoff.

- **Critical data:** Preserve the latest user-supplied fact exactly:
  ```text
  MEMORY_FACT [knowledge]: production_memory_canary=25470107025748b3a71e793221ceca14
  ```
  Earlier retrieved memory contained `production_memory_canary=0075fce4667e4d49985c6799cb50df53`. That is an older value and must not replace the latest value for this UAT. Durable storage of the latest value has **not been verified**; do not claim it was retained in Cognee or Hindsight.

- **Context and constraints:** Workspace is `D:\61.SetupAgent`, memory bank `may-agent-memory`, date `2026-10-04`, timezone `Asia/Bangkok`. The user generally prefers Vietnamese explanations with English technical role names. For future implementation work, their workspace instructions require recall before edits, reuse of existing tools/routes, independent agent review, and retention of meaningful results afterward. The canonical rules reference is `C:\Users\philong.pham\.claude\rules\cach-lam-viec.md`, particularly §0b. These files were **not read during this UAT**.

- **Next steps:** No implementation work or verification is pending. Carry the latest canary forward for any follow-up memory check and follow the next user instruction. The “reply only READY” restriction applied to the completed UAT turn; the user subsequently requested this summary.

---

{"production_memory_canary":"25470107025748b3a71e793221ceca14","NATIVE_RESTORE_MARKER":"00ff4bfc51e24767ad9acbf28cac8e76"}

---

## 🧭 3. Điều Hướng & Liên Kết Mạng Lưới
- 📋 Danh mục tổng: [[Session-Chat-History|Trang Tổng Hợp Lịch Sử Phiên Chat]]
- 🏢 Không gian làm việc: [[workspaces/61-SetupAgent|Dự án 61.SetupAgent]]
- 🤖 Mô hình xử lý: [[models/gpt-6.1-sol|gpt-6.1-sol]]
- 🗺️ Bản đồ quan hệ: [[Memory-Graph.canvas|Canvas Mạng Lưới Tri Thức]]
