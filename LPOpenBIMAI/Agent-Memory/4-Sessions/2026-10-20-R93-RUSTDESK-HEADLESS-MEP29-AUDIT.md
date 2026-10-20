# R93 Checkpoint & Capsule — RustDesk Headless P2P Tailscale, MEP29 E2E Audit & Config Self-Healing

Workspace: D:/61.SetupAgent
Date: 20 October 2026, Asia/Bangkok
Bank: may-agent-memory, may-61-setupagent
Status: RUSTDESK DIRECT IP P2P VERIFIED, MEP29 TOKENS INITIALIZED & VAULT SYNCED, CONFIG TOML AUTO-HEALED

## 1. RustDesk P2P Direct IP Qua Tailscale — Headless 24/7 Không Cần Mở Cửa Sổ
- **Vấn đề đã giải quyết:**
  - Máy Nhà (RTX 5080) và máy BIM02 công ty cần kết nối P2P trực tiếp qua Tailscale Direct IP (`100.105.122.1` $\leftrightarrow$ `100.78.215.48`, cổng `21118`).
  - Lỗi cũ: Khi người dùng bấm dấu `X` tắt cửa sổ GUI trên máy tính, cổng `21118` bị ngắt (`Failed to connect to IP:21118`).
- **Phát hiện kỹ thuật từ mã nguồn RustDesk:**
  - Cờ `--tray` chỉ tạo icon khay hệ thống, KHÔNG mở socket Direct IP 21118.
  - Cờ **`--server`** là tiến trình headless server chính thức, mở cổng `TCP 21118` ngay lập tức mà **HOÀN TOÀN KHÔNG HIỆN CỬA SỔ** trên màn hình desktop.
- **Triển khai tự động hóa:**
  - Tạo `bat-rustdesk-chay-ngam.cmd`: Kích hoạt `rustdesk.exe --server` ẩn hoàn toàn.
  - Tạo `cai-rustdesk-tu-khoi-dong.cmd`: Cài đặt Windows Service `RustDesk` chạy `Automatic`, mở Firewall Inbound TCP/UDP 21118, đặt Startup Shortcut chạy ngầm khi mở máy.
  - Mật khẩu cố định: `QAnh@02042024` (vào thẳng không cần bấm Accept). Hỗ trợ thanh công cụ 2 màn hình `[1 | 2]`.
- **Đóng gói Skill:** Xuất bản Skill mới `.agents/skills/rustdesk-p2p-setup/SKILL.md`.

## 2. Audit Production Router & Chuẩn Hóa Cài Đặt Máy MEP29 E2E
- **Cấp phát Token New-API độc lập cho máy MEP29 (`hoi.thoivan`):**
  - Cấp 10 Token riêng biệt: `VSCODE-MEP29-Admin`, `ROUTER-MEP29-API-OpenCodeGo` và 8 token Router group (`Antigravity`, `ClaudeCode`, `CommandCode`, `OpenRouter`, `Cursor`, `Oauth-GPT`, `xKiro`, `DeepSeek`).
  - Hạn mức Unlimited Quota, mở trọn bộ 109 models.
- **Nâng cấp Cloudflare KV Vault Sync (`tong_hop_tat_ca_keys.py`):**
  - Tích hợp nén `gzip` mức 9, giảm payload từ 5.4 MB xuống 278 KB (tránh lỗi 413 Payload Too Large của Cloudflare Worker).
  - Đóng gói và đẩy thành công 186 env keys + 184 machine tokens + 109 models `merged-models.json` lên Vault.
- **Lệnh cài đặt 1-chạm cho kỹ sư MEP29:**
  ```powershell
  winget install --id Git.Git -e --silent; git clone https://github.com/Long0308/setupagent.git D:\61.SetupAgent; cd D:\61.SetupAgent; .\cai-mep29.cmd
  ```
- **Cập nhật Skill:** Đồng bộ 2 luồng (Người mới cài đặt vs Cập nhật máy cũ) vào Skill `codex-router-setup`.

## 3. Tự Chữa Lành `config.toml` & Nâng Cấp Codex CLI Tránh Rớt Model GPT-6.1 Sol
- **Nguyên nhân mất GPT-6.1 Sol:** OpenAI lọc danh mục theo `client_version` của Codex CLI; máy cũ mang CLI `0.154.0` bị OpenAI tự xóa model `gpt-6.x`.
- **Giải pháp:**
  - Tự động nâng cấp `codex-cli >= 0.163.0` qua npm và gán biến môi trường `CODEX_BIN` vĩnh viễn.
  - Sắp xếp Priority 0..6 cho các model GPT chính thống (`GPT-6.1 Sol`, `GPT-6 Astra`, `GPT-6 Sol`...) lên ngay đầu danh sách picker.
  - Viết `tools/chua_lanh_config_toml.py` với hàm `safe_write_toml` ghi chuẩn LF `\n`, triệt tiêu hoàn toàn lỗi cú pháp `carriage return must be followed by newline`.
- **Bảo toàn dự án máy Nhà:** Tạo `tools/khoi_phuc_lich_su_jennie.py` thu hồi 100% lịch sử chat của thư mục `23.JennieHomeSchool` (JennieJoyKids, Ly Sữa Ấm, ComfyUI, Alice...) và đặt lên vị trí số 1 trên Sidebar.

## 4. Nghiệm Thu & Kiểm Chứng
- [x] Test-NetConnection cổng 21118 Tailscale Direct IP: `TcpTestSucceeded: True` (độ trễ 6ms).
- [x] Remote Desktop P2P thực tế: Đã vào màn hình máy Nhà RTX 5080 hiển thị thanh công cụ `[1 | 2]`.
- [x] Test live 9/9 Providers trên Codex Router: `ALL PASS` (1-4s).
- [x] Cổng 4200, 4202, 4310, 4320, 4400, 3300, 20128: `ONLINE 100%`.
- [x] Đã cập nhật 1 dòng audit vào `wiki/log.md` và đồng bộ Supabase `agent_sessions`.
