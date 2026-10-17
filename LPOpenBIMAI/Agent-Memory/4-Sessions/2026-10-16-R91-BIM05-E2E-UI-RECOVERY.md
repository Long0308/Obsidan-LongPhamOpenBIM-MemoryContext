# R91 Checkpoint & Capsule — BIM05 E2E, Router UI & Self-Healing

Workspace: D:/61.SetupAgent
Date: 16 October 2026, Asia/Bangkok
Bank: may-agent-memory, may-61-setupagent
Status: E2E VERIFIED (BIM05 8/9 PASS), ALL 7 PORTS HEALTHY (100% READY)

## 1. Nghiệm thu E2E Máy con BIM05
- Bộ cài `cai-bim05.cmd` qua `tools/cai-dat-e2e-may-con.ps1` chạy trọn vẹn 8/8 bước cho máy `anh.tranhuynh`.
- 8/9 Provider PASS qua Cloudflare Tunnel (`api.lpopenbim.cloud/v1`): OpenCode Go (DeepSeek v4.1, GLM 5.3), Google Antigravity (Gemini 3.8 Flash High), Claude Code (Opus 5.5), Command Code (GPT-5.6), xKiro (Mistral), OpenRouter, ChatGPT Account Pool.
- Khắc phục lỗi venv exit code 103 bằng `uv pip install --require-hashes -r requirements/python.txt`.
- Khóa UAC Sandbox bằng `[windows] sandbox = "unelevated"`.

## 2. Nâng cấp Giao diện Tiến trình Service Tổng (:4400/setup)
- Thanh ProgressBar Tổng $0\% \rightarrow 100\%$ phản ánh tình trạng sẵn sàng của toàn hệ thống thời gian thực.
- 6 Thanh Mini-ProgressBar con kèm bước nạp phụ thuộc `[BƯỚC 1/6]` đến `[BƯỚC 6/6]` và độ trễ phản hồi $\text{ms}$.
- 5 Hộp lệnh cứu hộ trực quan với nút bấm sao chép 1-chạm (Update, Docker/WSL sâu, New-API/9Router restart, Router restart, Watchdog).
- Cập nhật watchdog `check-va-bat-lai.ps1` giám sát và tự phục hồi 7 cổng (bổ sung New-API :3300).

## 3. Khắc phục Rò rỉ RAM Electron & Kẹt Hàng đợi Codex Desktop
- Đóng 18 tiến trình `ChatGPT.exe` / `codex.exe` ngốn 5.34GB RAM làm kẹt hàng đợi (`App server request expired while queued`).
- Thu hồi $90\%$ RAM về $\approx 500\text{ MB}$, reset hàng đợi IPC và bảo tồn 7 Projects chuẩn UTF-8 trong `state_5.sqlite` qua script `_restore_and_restart_codex.ps1`.
- Sửa lỗi xung đột tài khoản trùng lặp `codex.v3` trong `chatgpt-account-pool.json`. Sửa `server/index.mjs` đọc `account.identity.email` và `dash-tab.js` fallback `accounts[0]` giúp widget hiển thị mượt mà.

## 4. Đồng bộ Ký ức Hindsight
- Retained fact vào cả 2 bank: `may-agent-memory` và `may-61-setupagent` (HTTP 200).
- Handover canonical: `docs/HANDOVER-2026-10-16-BIM05-E2E-AND-ROUTER-UI-RECOVERY.md`.
