---
id: codex-01a104fa
title: "Independent contract review of a public architecture integration. Do not us"
date: 04/10/2026 10:34:45
workspace: "[[workspaces/openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db|openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db]]"
model: "[[models/custom-oauth-cc-opus|custom/oauth-cc-opus]]"
ide: Codex Desktop
tokens: 57849
tags: [session, codex, openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db]
---

# 🗣️ Phiên Chat: Independent contract review of a public architecture integration. Do not us

> **Nền tảng**: Codex Desktop · **Mô hình**: `[[models/custom-oauth-cc-opus|custom/oauth-cc-opus]]`
> **Thư mục**: `[[workspaces/openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db|openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db]]` · **Thời gian**: `04/10/2026 10:34:45`
> **Mức tiêu thụ**: **57,849 tokens**

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
`C:\Users\philong.pham\.claude\rules\cach-lam-viec.md` — mục **§0b** (BẮT BUỘC RECALL
& SYNC KÝ ỨC 4 TẦNG). Đây là bản gốc DUY NHẤT; không chép lại nội dung sang chỗ khác
(mục §1b cấm hai bản luật song song vì sẽ sinh mâu thuẫn).

🩸 Ở runtime này luật là **cổng MỀM** — chỉ Claude Code chặn được ở tầng máy bằng
hook `recall_gate.sh`. Khai "hard gate" ở đây là nói dối.

---
</INSTRUCTIONS>

---

<environment_context>
  <cwd>C:\Users\PHILON~1.PHA\AppData\Local\Temp\openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db</cwd>
  <shell>powershell</shell>
  <current_date>2026-10-04</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>C:\Users\PHILON~1.PHA\AppData\Local\Temp\openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db</root></workspace_roots><permission_profile type="managed"><file_system type="restricted"><entry access="read"><special>:root</special></entry></file_system></permission_profile></filesystem>
</environment_context>

---

Independent contract review of a public architecture integration. Do not use tools or edit files. Return a concise JSON object with verdict PASS or FAIL, blocking findings, and limits. This is plan review, not measured implementation acceptance.
Planned contract: existing localhost Router Mix GET agent-live adds openSpec projection. A bounded reader reads openspec/config.yaml, up to32 change directories, proposal/design/specs/tasks presence, task checkbox counts, and live.json bindings to PLAN IDs and owner. It reads version-pinned installation hashes for11 skills in each of5 IDE roots. It rejects paths outside workspace and symlink files, bounds file bytes and recursion. Polls do not run CLI or invoke models. A dated7-case CLI/worktree receipt is displayed as historical readiness, never as Running. Installed skills and completed checkboxes do not prove native IDE invocation, P2P, isolation, runtime acceptance, or task dispatch.
Execution: four-layer recall is first; OpenSpec explore supplements ECC/Superpowers/Karpathy brainstorming; propose freezes contract; each parallel worker owns its own change/worktree and uses existing cooperative tasks.json claims. OpenShell explicitly executes approved Linux tasks, Windows-native workloads retain Windows execution. Independent test evidence is mandatory. Orchestrator serializes shared sync/archive/merge and retains sourced facts. OpenSpec verification is advisory. Single PLAN is the authoritative session tracker; tasks.md references those IDs, with manual synchronization.
UI: English technical headers; existing theme tokens; section between session workflow and skill layer. Source-to-target arrows have explicit owner/skill labels and describe workflow topology, not real per-hop telemetry. Show two real changes with owner root, so we do not invent parallel worker activity.
Check concurrency and safety pitfalls. What acceptance conditions are missing before implementation can be called complete?
```

---

## 🤖 2. Phản Hồi Từ Trợ Lý AI (Assistant Response)

Reviewed as a contract-freeze gate: the epistemic layer is unusually honest, but several safety and concurrency clauses are under-specified in ways that would let a non-conforming implementation pass.

```json
{
  "verdict": "FAIL",
  "scope": "Plan/contract review only. No tools run, no files read, no measurement. Verdict judges contract completeness, not implementation quality.",
  "summary": "Labeling and non-inference discipline are sound (historical receipt never Running, topology arrows not telemetry, explicit disclaimers that installed skills and checkboxes prove nothing about invocation, P2P, isolation, or dispatch). Blocking gaps sit in the enforcement clauses: containment is specified too weakly for a Windows workspace, cooperative claims have no atomicity primitive, bounds are unquantified, and no acceptance test forces honest empty-state rendering.",
  "blocking_findings": [
    {
      "id": "B1",
      "area": "safety/containment",
      "finding": "'Rejects paths outside workspace and symlink files' is insufficient on Windows. It misses directory symlinks, NTFS junctions (IO_REPARSE_TAG_MOUNT_POINT is not a symlink), hardlinks (no reparse point at all), 8.3 short-name aliases (the working path itself uses PHILON~1.PHA, so string-prefix containment is both fragile and bypassable), and UNC/extended-length forms. Check-then-open is also TOCTOU-exposed while workers mutate the tree.",
      "required_fix": "Canonicalize root and candidate via final-path resolution, compare path components not string prefixes, reject any reparse point on every component, detect hardlinks by volume+file-id, and validate on the opened handle rather than the path string."
    },
    {
      "id": "B2",
      "area": "safety/bounds",
      "finding": "'Bounds file bytes and recursion' carries no numbers, so any implementation trivially conforms. No cap on total files or total bytes per poll, max line length (one oversized tasks.md line defeats a per-file cap), YAML anchor expansion, or JSON nesting depth.",
      "required_fix": "Declare numeric caps for per-file bytes, max line length, files per change, total bytes and files per poll, directory depth, checkbox count, YAML/JSON depth; safe-load only; surface a truncated flag whenever any cap trips."
    },
    {
      "id": "B3",
      "area": "concurrency/atomicity",
      "finding": "Parallel workers rewrite tasks.md and live.json while the reader walks the same tree. No snapshot or atomicity semantics are stated, so a poll can observe a half-written live.json or mid-edit tasks.md and publish checkbox counts and PLAN bindings that never existed. Archive moving a change directory mid-walk also yields ENOENT.",
      "required_fix": "Single whole-file read per file with strict parse; partial or invalid parse yields unknown, never zero and never a silently cached prior value; writers use temp-file plus atomic replace (ReplaceFile/MoveFileEx on Windows); tolerate mid-walk disappearance as unknown."
    },
    {
      "id": "B4",
      "area": "concurrency/claims",
      "finding": "'Existing cooperative tasks.json claims' is read-modify-write on a shared file with no lock, CAS, or lease. Two workers can claim the same task (lost update), and a worker that dies holding a claim blocks it forever. No stated behavior for crash recovery.",
      "required_fix": "Compare-and-swap on a version/etag field or a lock file carrying owner plus TTL, with documented stale-claim reclamation and a contention test proving exactly one winner."
    },
    {
      "id": "B5",
      "area": "availability",
      "finding": "Per poll the reader touches up to 32 change directories times 4 presence checks plus parse, plus 55 skill hashes (11 skills x 5 IDE roots). No request deadline, no single-flight, no mtime/size-keyed cache, and no statement that the walk is off the handler path. A slow root (network mount, antivirus, OneDrive) stalls an endpoint that other consumers already depend on.",
      "required_fix": "Background snapshot with timestamp, hard per-request deadline returning a bounded partial, single-flight so overlapping polls cannot stack, and a hash cache keyed on mtime+size."
    },
    {
      "id": "B6",
      "area": "safety/rendering",
      "finding": "Change directory names, config.yaml values, live.json owner strings, and PLAN IDs are untrusted strings flowing into an HTML section. No validation, length cap, or escaping rule is specified.",
      "required_fix": "Allowlist regex and length caps for IDs and owners, context-correct escaping at render, and a snapshot test with script tags, quotes, RTL overrides, and a 10k-char value."
    },
    {
      "id": "B7",
      "area": "correctness/hashes",
      "finding": "'Version-pinned installation hashes' does not define what is hashed (SKILL.md only or whole directory), line-ending normalization (CRLF vs LF produces false drift on Windows), the authoritative pin source, or what a mismatch renders as. Undefined, this projection reports drift that does not exist or hides drift that does.",
      "required_fix": "Declare canonical hash input, normalization rule, pin manifest location, and explicit drift/unknown/match rendering states."
    },
    {
      "id": "B8",
      "area": "epistemic/state",
      "finding": "Presence flags and checkbox counts conflate three distinct states: file absent, file present with zero items, and parse failed. Zero rendered as progress is a false claim, and the contract's own honesty goal depends on this distinction. Separately, the dated 7-case receipt has no staleness or invalidation policy, so a correctly-labeled historical receipt still becomes a false currency claim over time.",
      "required_fix": "Tri-state (absent / zero / unknown) for every presence and count field; receipt TTL plus invalidation triggers (relevant commit, skill hash change) with an explicit expired rendering."
    }
  ],
  "non_blocking_findings": [
    "Manual PLAN-to-tasks.md synchronization is a guaranteed drift source with no detector; add a non-blocking indicator for referenced-but-missing and unreferenced PLAN IDs.",
    "'Two real changes with owner root' needs a deterministic selection and ordering rule plus defined behavior at 0, 1, and more than 2 changes, so the UI never falls back to placeholder rows.",
    "Confirm bind is 127.0.0.1, reject foreign Origin (any browser page can reach a localhost endpoint), and decide explicitly whether absolute paths and the OS username may appear in the payload.",
    "Payload needs a schema version and forward-tolerant UI parsing."
  ],
  "missing_acceptance_conditions": [
    "Adversarial filesystem suite that must fail closed: traversal, absolute path, file symlink, directory symlink, NTFS junction, external hardlink, 8.3 short-name alias of the root, UNC, >260-char path, case variants, device names.",
    "Bound enforcement with asserted numbers: 33rd change ignored with truncated=true, oversized file, single huge line, deep recursion, malformed YAML/JSON, empty files.",
    "Empty-workspace no-fabrication test: zero changes, zero skills, no receipt renders explicit empty/unknown states, not zeros styled as success and not demo rows. This is the primary guard on the contract's stated honesty.",
    "Concurrency test: poll continuously while a worker rewrites live.json and tasks.md; assert no crash and no partial-parse value reaching a count.",
    "Claim contention test with simulated worker death and TTL reclamation.",
    "Determinism test: two polls over an unchanged tree produce identical output modulo timestamp, with stable ordering.",
    "Read-only proof: no file opened for write, no process spawned, no network or model call, verified by instrumentation rather than by assertion in prose.",
    "Latency acceptance: worst-case cold-cache poll against a max-size fixture, plus proof the deadline returns a bounded partial instead of hanging, plus proof overlapping polls are single-flighted.",
    "Label-integrity snapshot locking receipt never rendering as Running and arrows carrying visible owner/skill labels with a not-telemetry qualifier.",
    "Fault isolation and kill switch: reader failure cannot degrade pre-existing /agent-live fields, and the projection can be disabled by config, verified by fault injection.",
    "Git concurrency acceptance: worktrees sharing one object store contend on index and ref locks; assert serialization or retry, and tolerate archive-during-walk.",
    "OpenShell boundary acceptance: allowlist of approved Linux tasks, proof Windows-native workloads are not routed through it, and proof the reader itself never executes through it.",
    "Definition of done for 'independent test evidence': who runs it, on what machine, and what artifact is retained, since the plan makes it mandatory but leaves it unverifiable as written."
  ],
  "limits": [
    "No tools were used per instruction, so nothing here is measured. No source was read; the existing /agent-live endpoint, the Router Mix runtime, the 7-case receipt, and the counts 11 skills / 5 IDE roots / 32 changes are all taken as asserted.",
    "The execution plan places four-layer recall first; that step was not performed in this review because tool use was prohibited, so prior-art conflicts (an existing projection or reader that already covers this) remain unchecked and could independently invalidate the plan.",
    "Windows-specific findings infer the platform from the stated Windows-native execution split and the working path form; if the reader runs only on Linux, B1's junction and 8.3 clauses narrow but the TOCTOU and hardlink clauses stand.",
    "No threat model, trust boundary, or performance budget was supplied, so severity ranking reflects contract enforceability rather than measured risk.",
    "FAIL means the contract is not yet safe to freeze, not that the design is wrong. Every blocking finding is a specification gap with a stated fix; none require redesign of the projection concept or the labeling discipline."
  ]
}
```

The honest core of this plan, that counts and hashes are evidence of files rather than evidence of behavior, is the part most integrations get wrong, and it is already right here. What is missing is the machinery that forces an implementation to keep that promise: tri-state unknowns, quantified bounds, a real claim primitive, and an empty-workspace test that fails loudly if anything renders a comfortable zero.

---

## 🧭 3. Điều Hướng & Liên Kết Mạng Lưới
- 📋 Danh mục tổng: [[Session-Chat-History|Trang Tổng Hợp Lịch Sử Phiên Chat]]
- 🏢 Không gian làm việc: [[workspaces/openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db|Dự án openspec-contract-review-64ceb4f7e6e74e63a752bbb13811b5db]]
- 🤖 Mô hình xử lý: [[models/custom-oauth-cc-opus|custom/oauth-cc-opus]]
- 🗺️ Bản đồ quan hệ: [[Memory-Graph.canvas|Canvas Mạng Lưới Tri Thức]]
