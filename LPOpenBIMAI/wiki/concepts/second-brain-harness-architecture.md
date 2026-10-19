---
title: Second Brain Harness và checkpoint DSH
tags: [second-brain, harness, checkpoint, dsh]
updated: 2026-10-16
source: docs/HANDOVER-2026-10-16-R95-DSH-SKILLS-MEMORY.md
---

# Second Brain Harness: recall, lưu vết và khôi phục

Mốc R95 · 16/10/2026 · workspace D:/61.SetupAgent · bank `may-agent-memory`.
Nguồn trạng thái task là PLAN; wiki giải thích và dẫn tới bằng chứng. Không coi
một skill được cài là hook đã chạy hoặc model đã nhận context.

## Bản đồ vận hành

| Công việc | Skill và nguồn chuẩn |
|---|---|
| Điều phối task, owner, critic và gate | `astra-orchestrator`, `agent-architecture-audit` |
| Chọn bank, recall bài học trước code | `workspace-memory-router`, `workspace-auto-brain`, `hindsight-ky-uc-phan-tang` |
| Lưu quyết định/bài học phiên code | `sync-memory-bank`; retain chọn lọc và exact readback |
| Lọc kết quả truy hồi | `jev-memory`; không tự lưu hay recall |
| Quan hệ ngữ nghĩa có source/hash | `cognee-hindsight-mesh`; semantic graph không phải AST |
| Symbol/caller/callee từ code | `codegraph`, index đúng project/revision |
| Checkpoint/resume và peer REQUEST/ACK/RESULT/end | `second-brain-harness` |
| Spool, SQL slice, checkpoint Obsidian, Hindsight khi được chỉ định | `second-brain-sync` |
| Note/wiki và thao tác vault | `obsidian-markdown`, `obsidian-cli` |
| DSH Desktop/web cùng history/backend | `codex-router`, reference `dsh-harness-and-web-parity.md` |

## Các tầng cần kiểm riêng

1. Host giữ native history và compact theo khả năng của chính runtime. Jev là
   cố vấn, không thay native transcript. Không áp một ngưỡng token hay tốc độ cố
   định cho mọi model/host.
2. Raw transcript ở disk spool; SQL chỉ giữ lát chuẩn hóa theo giới hạn helper.
   Không gọi SQL slice là bản archive nguyên văn đầy đủ.
3. Vault hiện hành là `D:/61.SetupAgent/MemoryContext/LPOpenBIMAI`. Checkpoint
   ghi đúng một event có ID/digest vào `wiki/log.md` bằng
   `tools/sync_second_brain_all.py::step3_obsidian_sync`, rồi đọc lại. Trang wiki
   này giữ bản đồ tri thức, không phải bản chép toàn bộ hội thoại.
4. Hindsight giữ fact tuyển chọn có nguồn; verify đúng document/text/hash.
   Cognee ingest/readback cần entrypoint đã review, source/hash và PID đọc riêng.
   Incident hold hiện còn hiệu lực: mốc mới chưa được xác minh ở Cognee; không
   reset graph hoặc đổi con trỏ normal restore để làm trạng thái xanh.

`second-brain-sync --archive-only --no-retain` không retain Hindsight và không
có bước Cognee. Fact/neo của script có Hindsight nhưng vẫn không ingest Cognee.
Harness điều phối hợp đồng đầy đủ và báo trạng thái từng kho; tồn tại script
không chứng minh một daemon/hook đang tự chạy.

## Mốc DSH R94 được giữ lại ở R95

Web authenticated → Cloudflare Access/Tunnel → SSO gateway3080 → cùng backend
Desktop19387 và home `.dsh` của BIM02. Đã đo 31 sessions, 65 Router models,
2 custom presets; harness Gemini30/web Gemini31/web Go4.1 32 có ACK/tool/result/
completedEnd, recall marker cũ trước tool; reload giữ 32 turns. Container
`sa-agent-dsh` có home riêng, là runtime dự phòng, không phải public history hiện tại.

Native RPC này chưa chứng minh HTTP A2A, direct network P2P, reverse delivery,
daemon, all-IDE lifecycle hoặc tự phục hồi pin sau Desktop restart. Hai UI dùng
một UUID là một chat. Mọi request mới dùng correlation/challenge mới và đối
chiếu native turn trước retry khi kết quả không rõ.

## Bàn giao và nguồn

- [Bàn giao R95](D:/61.SetupAgent/docs/HANDOVER-2026-10-16-R95-DSH-SKILLS-MEMORY.md)
- [Bàn giao UAT R94](D:/61.SetupAgent/docs/HANDOVER-2026-10-16-R94-DSH-SHARED-NATIVE-UAT.md)
- [PLAN canonical](D:/61.SetupAgent/docs/PLAN-2026-10-03-agent-live.md): 40/63 đã đóng,
  23 còn mở tại mốc kiểm này; không đóng task từ việc sync memory.
- [Receipt mốc R95](D:/61.SetupAgent/.runtime/architecture-audit-20261008/r95-dsh-skill-memory/)
- [[wiki/log|Nhật ký checkpoint]] · [[wiki/index|Mục lục wiki]]

Nội dung lịch sử và số hiệu năng không có receipt hiện hành
đã được bảo toàn nguyên byte trong receipt `wiki-harness-before.md`. Chỉ nguồn
và số đo hiện hành ở trên được dùng cho lần tiếp tục này. Chưa kiểm pixel render
trong ứng dụng Obsidian; nghiệm thu lưu file/readback là phạm vi riêng.
