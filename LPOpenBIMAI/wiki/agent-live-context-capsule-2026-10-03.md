# Agent Live · Continuation Capsule

Workspace: `D:/61.SetupAgent`. Session: `01a0ff9a-8a57-7eb3-8920-bd775cdea9de`.
Bank: `may-agent-memory`. Source: measured receipts plus the current user request.
Scope: a manually curated resumption aid; see the hash-bound review receipt.
This file does not replace native Codex compaction.

## Active Goal

Hoàn tất UAT kiến trúc đang có, cập nhật trang Router Mix và bàn giao VS Code.
User vừa yêu cầu gọi `second-brain-sync` quanh compact và phải nén được ngữ cảnh.
Cần giữ yêu cầu, quyết định, lỗi, việc đang làm và bằng chứng trong capsule.
Latest steering: xác nhận OpenShell đã cài và đo vùng thực thi thật.

## Verified State

1. **Recall:** `recall.py --four-layers --no-cache` gọi đúng thứ tự workspace/bank →
   Error DB → Hindsight → Cognee. UAT nguồn tại
   `docs/agent-four-layer-recall-2026-10-03.json`: 19,830.46 ms; 79 error records
   scanned, zero matches; six Hindsight facts; ten Cognee chunks. Không dùng cache.
   Root đã recall lại trước lượt sửa này: 19,633 ms, cùng số nguồn.
2. **Cognee:** engine local 1.6.2, SQLite/Kuzu/LanceDB; fresh process readback
   khớp 88 nodes / 285 edges / eight source IDs. Đây là text extraction, chưa phải
   C# AST; `recall_graph` cũ vẫn là graph Hindsight.
3. **Compact failure:** compact 22:24:32 đã có hook, enqueue thất bại vì
   `152967072 > 134217728`. Giữ lịch sử tại
   `docs/agent-compact-memory-audit-2026-10-03.json`.
4. **Latest compact:** PreCompact 22:42:09 → queued 22:42:14 → native compact
   `2026-10-03T15:44:03.369Z` → PostCompact 22:44:04. Work ID
   `fd8e5eb9739d162fee46b86d891d7cb6`; nguồn đúng session.
5. **Capture / drain:** rollout 157,584,643 bytes → bounded tail 134,058,956 bytes;
   offset 23,525,687. Giữ 400 mục gần nhất. Independent Opus review PASS; actual
   drain 22:57:42 ghi và đọc lại SQL 400/400, Obsidian verified, terminal true.
   Xem `docs/agent-compact-memory-drain-2026-10-03.json`. Native restore chưa đo.
6. **Archive policy:** drain dùng `--archive-only --no-retain`; Hindsight và Jev
   compaction ở làn này được skip có chủ đích. Chỉ retain fact đã kiểm chứng,
   rồi đọc lại đúng bank; không nạp raw transcript vào Hindsight. Explicit fact
   readback ID `856654ff-b120-402a-b3ab-907b788cfcf0` khớp bốn identity/count
   guards; `compactPolicy=false`, nên không dùng fact này chứng minh policy.
   Metadata SQL đọc lại một session row. Automatic curated retain vẫn chưa nối.
7. **Jev:** probe 22:28:46 thực sự append receipt, 1,257.9 ms. UI glow 15 seconds,
   sau đó Stale snapshot. Native dispatch và ba mechanical forks chưa được đo.
   Low-confidence `gate=apply` vẫn là gap cần review.
8. **LiteLLM:** DeepSeek ranker trên :4200, 64-token budget FAIL 0/3 vì final text
   rỗng; 512-token budget PASS 3/3, 3,311.1 / 2,548.1 / 2,143.3 ms. Đây là
   reranking, không làm nguồn recall nhanh hơn. Chưa có so sánh cùng fixture với
   Cloudflare. Xem `docs/agent-litellm-recall-512-uat-2026-10-03.json`.
9. **OpenCode Go:** pinned channels 16/17 PASS 22:36:07, 2,220.4 / 1,573.4 ms;
   consumption IDs 90479 / 90478. Cached balance 0 không chứng minh hết tiền.
   Số dư upstream còn lại chưa đo. Receipt:
   `docs/agent-opencode-channels-recheck-2026-10-03.json`.
10. **Sonnet route:** `custom/oauth-anti-sonnet-5-5` có text/functional PASS,
    strict streamed tool lifecycle FAIL. Chưa chứng minh quality/cost parity với
    Opus; chưa đổi role pin. Saved model không hot-switch chat đang chạy.

## Current Tasks

- **M02 / compact_spool_tail_fix:** spool/drain đã review và actual archive PASS;
  root targeted suite 124 passed. Worker sửa test isolation sau khi tìm ba
  `sess-hook-no-retain` fixtures ở production spool; chúng đã được quarantine.
  Giữ lịch sử lỗi và archive-only/no-retain policy.
- **M02 / context_compactor_fix:** builder complete; latest 43 focused / 46 with
  deploy-consumer tests passed. Earlier 173 Jev / 58 sync-and-task tests preceded
  the last two safety fixes. Compactor accepts normalized input,
  preserves chronological order, pinned evidence and tool pairs, keeps records
  on missing/invalid/low-confidence answers. PUBLIC Jev UAT at 15:59:10Z took
  0.449s: six input messages, five kept, one dropped; reported SDK usage1003/123.
  This is a filter sidecar, not automatic semantic summarization or native restore.
  Opus found a fan-out tool-pair orphan in the single-pass protection sweep.
  Builder now sorts groups and propagates keep to a fixpoint; the new regression
  fails the old block in memory. Final Opus delta review pending. Source SHA
  `8ed9e26971861a6f941112b759d5d90c7682bb842e953bff0548c9ec5b9904be`.
- **O02 / OpenShell:** keepalive61384 revived gateway after Connection refused.
  Existing demo IDa5e38e5b is StartFailed/Error; stop/start refused, old workspace
  preserved. Separate demo-uat-20261003 ID08bf8878 is Ready. Five public fixtures
  PASS at23:21:27: /sandbox, uid1000, shell verify42, host drives absent, /etc write
  denied. Receipt docs/agent-openshell-current-executor-uat-2026-10-03.json.
  CLI0.1.2; gateway Connected/Authenticated mTLS. command-v inventory finds no
  codex/opencode/dsh/node/python3/curl on sandbox PATH; readiness receipt is
  docs/agent-openshell-harness-readiness-2026-10-03.json. Windows harness calls
  codex.cmd directly; independent Opus source audit confirms this path.
  This does not prove that the Codex host executor or inference uses OpenShell.
- **M03:** recall bốn tầng đã UAT CLI; `/brain/search?bon_tang=1` opt-in. Default
  catalog phải giữ tương thích timeout. API container chưa reload cho thay đổi này.
- **AR04:** root thêm recovery receipt trên trang live, browser UAT, cập nhật
  handover/tracker; sync fact và independent bank readback.
  Proposed new fact sync was rejected by auto-review for payload/destination
  authorization; exact proposal is second-brain-fix-fact.md. User answer pending;
  do not run sync_final_fact.py through another permission mode or tool.

## Open Gates

Cloudflare rank route chưa deploy hoặc provision dedicated token; Vault/origin
gaps còn mở. OpenShell có boundary UAT riêng nhưng sandbox cũ Error; terminal host
và production harness chưa tự động chạy trong sandbox. P2P chỉ one-way + root-relayed ACK; direct A2A
chưa đo. Gauntlet ba families trên cùng frozen manifest, automatic screenshot,
automatic curated retain/native restore, IDE-native E2E, learned habits trong
Cognee và full production publication còn mở. Không chốt toàn kiến trúc done.

## Resume Instructions

Mở tracker `docs/PLAN-2026-10-03-agent-live.md`; kiểm reviewer receipt/hash trước
khi chốt compactor, capsule hoặc UI. Đọc recovery receipt mới nhất. Luật chuẩn duy
nhất ở `C:/Users/philong.pham/.claude/rules/cach-lam-viec.md` §0b.
Preserve VS Code SecretStorage và concurrent dirty files. Không mass-stage hoặc
restart Router/Docker/app. Global model/team/hook proposals vẫn diff-first.

## Display Preferences

English technical headers; Vietnamese explanations. `ROOT · Orchestrator`.
Green = measured evidence; red = failure/unmeasured; 9Router redirect = orange.
`Snapshot` không được gắn `Running`. Byte reduction không phải measured tokens.


## OpenShell continuation · 2026-10-04

- [ĐO] Existing harness now has `-Executor openshell` for an explicit public file manifest. Runtime Node22.20/Codex0.160; current r5 sandbox9bc243a8-21a3-432e-b6bf-18a2c60bb950; uid1000;2CPU/2GiB; no Windows drives. Restricted provider bridge4422→Router4202; no raw credential upload.
- [ĐO] Success jobe8e960aaa8a049f199b619554e453c10; thread01a1030e-2282-7880-a3f4-f42f139c7f91; Opus/high;7exact requests;1test/3assertionsPASS; only calculator.py changed. Root independently reran artifact test and read runtime hashes inside sandbox.
- [ĐO] Timeout job930afb3c3fbe449c9a6282768a89ac04 produced durable failed receipt(exit-9;4kill signals;wait reaped); exact job process scan0. Boundary5/5PASS includes a fresh explicit policy denial.17Python regressions/38PSchecksPASS; independent Opus review approved within public-fixture scope.
- [ĐO] Canonical evidence `docs/agent-openshell-harness-uat-2026-10-04.json` binds10sources,full image ID,UUID/policy,thread/rollout/requests. Failed r5 attempt769ccbaaae1f44caa971f328cbbe0d7c stays failed(status0 stream). Superseded r1–r4 stopped,workspaces kept; originaldemoError preserved.
- [MỞ] Root terminal/Windows-native tasks remain Windows. General production manifests,automatic IDE executor dispatch,OpenCode/dsh,Cloudflare ingress,cold-start/sleep/reboot unverified. P2P/tasks/LangGraph and automatic curated memory retain/restore remain separate gates. Global/team/hook proposals unapplied; no Git push/Cloudflare deploy. Pending rejected fact-sync payload stays unexecuted.
- Resume: read the current canonical receipt and `docs/PLAN-2026-10-03-agent-live.md` OS01–OS05; verify API/live source-bound projection. This local capsule update is not an automatic PreCompact hook or a durable external memory retain.

## Execution map and context audit · 2026-10-04

- Latest user asks for explicit source→target arrows/status, visible OpenShell usage, the difference from a Windows terminal in System32, and the published specification. Keep English technical headers and Vietnamese explanations.
- [ĐO] Firecrawl MCP performed two public searches and three fresh NVIDIA scrapes, all HTTP200. Sources, IDs and version caveats are in `docs/openshell-spec-audit-2026-10-04.md`. Filesystem/identity policy applies at startup; REST path blocking needs `enforcement: enforce`; credential binding and base/effective policy are distinct. Current docs do not attest every feature in installed CLI0.1.2.
- [ĐO] Root recalled before scoped UI/receipt changes: `.runtime/m03-compact-recovery/execution-map-recall-20261004.json`, completedtrue, bank may-agent-memory,29419.38ms,79error records/0matches,6Hindsight/12Cognee sources. The earlier restricted attempt was interrupted without a completed receipt; it is not successful recall or proof of an outage.
- [ĐO] Dashboard recall is workspace-scoped; compact recovery is selected-session-scoped. Root must recall and hand a sourced capsule to a worker. The OpenShell harness contains no recall calls; Codex recall remains a soft/manual gate. Never treat a green workspace recall card as proof every chat recalled before writing.
- [ĐO] The capsule advanced9483bytes/f2a0359a while recovery metadata still named7544bytes/9255a1f6. Refresh both local receipt bindings after this revision; preserve archive measurement times and prior generations. Independent review must bind the exact new hash. Old PASS cannot attest a revised capsule.
- [MỞ] Execution route-map work is in progress in existing live.js/live.css only. Show dated Measured UAT/Configured/Unmeasured, never fake Running for old receipts. Provider bridge configuration does not prove per-hop live timing. Cloudflare ingress,automatic IDE/OpenCode dispatch remain unmeasured.
- [ĐO] Router Mix session selector showed3recent sessions and the requested root session. It tracks Router requests/model/effort/parent-child/error/usage, not complete chat text/history; its bounded window can omit inactive sessions and bypass traffic.
- [MỞ] Full-session lossless compression/native restore is not proven: recovery retains400of3452normalized messages,3052omitted. Curated byte reduction is not token reduction or automatic PreCompact summarization.
- Native navigation rail: user clarified missing horizontal prompt markers belong to Codex Desktop. Native read_thread confirms this chat and older history exist; no cause/toggle for the rail was verified. Do not build a Router Mix rail as a substitute or infer memory loss from the missing rail.
- Continue: complete and browser-verify the route map, review this exact capsule, record a new screenshot/acceptance receipt without recertifying the old browser test. Preserve all unrelated dirty work; no global config,Git push,Cloudflare deploy,external fact sync or broad service restart.
