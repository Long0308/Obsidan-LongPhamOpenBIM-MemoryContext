# Bàn giao kiến trúc R84 · 14/10/2026

Root `01a0ff9a-8a57-7eb3-8920-bd775cdea9de`, workspace `D:/61.SetupAgent`, bank `may-agent-memory`. Trạng thái có thẩm quyền nằm trong [PLAN](PLAN-2026-10-03-agent-live.md) và [audit](AUDIT-2026-10-08-agent-architecture-e2e.md). Tại mốc này: **40/63 task gốc đã đóng, 23 còn mở** (14 đang làm, 7 review, 2 pending). Toàn kiến trúc chưa nghiệm thu; `productionAccepted=false`. Các tick kỹ thuật R84 chưa đóng thêm task gốc.

## Phiên VS Code được cứu

Chat **Đọc giá trị từ settings.json**, agent-host `9997596a-2e94-43d6-b5f3-2d2dbec3e380`, ánh xạ SDK `f86be891-6af2-4ae1-8bd8-3922dbd806ef`. Thu thập 11.754 sự kiện không lỗi định dạng, 79 tin user, 30 assistant message có prose, 10 snapshot và 31 tệp đính kèm. Snapshot SQLite dùng Online Backup để giữ WAL. Giám khảo độc lập đã chấp nhận `HANDOVER_SOURCE_GO`.

[Capsule](../.runtime/architecture-audit-20261008/r84-settings-context/context-capsule.md) dài 9028 byte, SHA `fb5d232234a64686dd0621be25eb7ea70f92fda97f6d0e6dc368e53d4cac244f`. [Bàn giao chi tiết](HANDOVER-2026-10-14-vscode-settings-session.md) giữ việc CDE/Revit Server đã làm và còn dở. Những số đo VM trong phiên là lịch sử; không phải nghiệm thu VM hiện tại. Hai agent KIT của user tiếp tục sở hữu việc CDE.

Hindsight và file vault Obsidian đã đọc lại đúng capsule. Obsidian API27124 bị từ chối kết nối; Cognee chưa ingest/readback capsule mới. Recall Cognee lượt R84 mới trả 4 đoạn cũ trong 10.789,5ms, chỉ 1 đoạn có header xuất xứ; không thay thế cổng ingest mới.

Native `/compact`, model switch và chat mới tiêu thụ capsule chưa nghiệm thu. Picker DeepSeek không chứng minh model thay đổi: 64 event SDK vẫn Gemini→Gemini. Lỗi Gemini400 INVALID_ARGUMENT bọc502 còn chưa xác định được field; bỏ13ảnh không giải quyết. Dùng chat mới trong cùng workspace và nạp capsule theo bàn giao; giữ lịch sử/pin/edits, không sửa native DB/SecretStorage hay chạy CLI writer vào SDK bị khóa.

## WF13 · R7 được duyệt ở tầng source

Router sửa race: trạng thái cooldown/settings dùng để dispatch được đọc lại sau các await chuẩn bị request. Khi hoãn lỗi search của primary nhưng cooldown/failover không còn cho phép, router trả lại lỗi400 gốc. Không hạ điều kiện search capability của provider thay thế.

- Source `codex_router/codex-router/src/router.mjs`: `65f904d39772c70d9772d5f90ff91cc5b48566c70c6923cc65f97f2d3f14b5d9`.
- Test `test/model-failover-router.test.mjs`: `df11abcf9038801336ca5558315cc392329664b9de8cc536518a44838cd74b84`.
- Builder report: `a8a3aeaeafcdb42702837c2fdc922d532d19bbccc25c17f8211ebac44f481780`.
- Giám khảo `/root/r84_wf13_r7_critic`, UUID `01a13a50-bdbe-77f0-a94d-560d3bad7d1a`, native reviewer, actual OpenCode Go GPT-6 Luna: **SOURCE_GO**, **110/110** test, 0fail, 42,9s. Root tự chạy syntaxexit0 và focused6/6.
- [Biên nhận độc lập](../.runtime/architecture-audit-20261008/r84-wf13-r7-independent-review.json) giữ nguyên FINAL, kể cả lỗi gõ hash builder report; hash nguồn/test khớp, hash report thật được đối chiếu với native Get-FileHash và đo lại bởi root.

R6 NO_GO và các lần fail trước vẫn giữ. Chưa có barrier riêng cho cooldown hết hạn/tắt failover trong preparation hoặc cancel ở held-relay mới. Chưa reload shared4202; sourceGO không đóng WF13. Catalog/tool inventory, fallback native402/429/model-unavailable/timeout, identity/cancellation/no duplicate effects còn phải nghiệm thu theo tiêu chí gốc.

## Hai task còn lại trong đợt

**WF18:** R3 sourceGO; real Cognee worker6chunks và controlled native capsule consumption đã đo. FAST live recall0/8 là FAIL; automatic injection, full-context equivalence và DEEP/JUDGE calibration còn mở. Không thay nguồn hiện hành bằng fact cũ để làm xanh.

**LIVE-B14:** R3 CLI verifier bridge sourceGO. Còn native ALLOW/DENY trên ledger và hook trust theo cơ chế chuẩn. Managed worktree trước thất bại FilenameTooLong; giữ failure, không đoán checkout/path, không bypass trust/private RPC.

## Skill và vòng đời

Reference R84 của astra-orchestrator/agent-architecture-audit đã bổ sung cổng re-read cooldown/settings sau await và trả lỗi search gốc khi không còn cơ sở deferral. 5 copy đọc lại đúng SHA `76b63910c0486c1a47bd036c1c9dd456e1d8d66149cb5fe21a91c8e6f64302ab`; 6 validator exit0. Hai thân skill cùng reference dùng chung:32677/32745/32712byte, trần32768. Giữ khác biệt local trong thân skill. Source-sync không chứng minh hook/native đã kích hoạt.

Builder và critic R7 đã interrupt rồi archive đúng UUID/parent. Live4400/4310 nhận đúng role/task/model trong lúc review; API acceptance tách khỏi pixel E2E. Bảo toàn hai agent KIT, chat chính, pin, unsaved work và dịch vụ khỏe. Không dùng đường browser/CDP/screenshot khác để vòng qua lần UI UAT bị từ chối.

Ưu tiên tiếp: WF13-S1 trước nativeactivation/S2; sửa FAST0/8 của WF18; đo writer native của LIVE-B14 bằng cơ chế được hỗ trợ. Chỉ đổi completed khi tiêu chí gốc và giám khảo độc lập đạt.

