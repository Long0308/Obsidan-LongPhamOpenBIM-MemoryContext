---
title: Bookmark Cloud Extension v1.1
date: 2026-10-16
tags:
  - bookmarks
  - cloudflare
  - chrome-extension
  - verified-source
---

# Bookmark Cloud Extension v1.1

## Quan Hệ

- Kế thừa [[wiki/sources/bookmarks-hub-ai|Danh mục Bookmark HUB AI]], không ghi đè snapshot 307 URL ngày 12/10/2026.
- Hai hồ sơ dự kiến tham gia: [[wiki/entities/bookmarks/accounts/kenpham320|kenpham320@gmail.com]] và [[wiki/entities/bookmarks/accounts/philongpham018|philongpham018@gmail.com]]. Chưa cài hoặc áp dụng extension lên hai hồ sơ thật.
- Liên quan [[wiki/entities/bookmarks/categories/02-Newtecons|Newtecons]], [[wiki/entities/bookmarks/categories/05-Agent & Harness|Agent & Harness]], [[wiki/entities/bookmarks/categories/06-Skills & Prompts|Skills & Prompts]] và [[wiki/entities/bookmarks/categories/07-Memory & Knowledge|Memory & Knowledge]].
- Phân tầng [[wiki/entities/bookmarks/categories/09-Frontend UI|Frontend UI]], [[wiki/entities/bookmarks/categories/10-Backend & API|Backend & API]] và [[wiki/entities/bookmarks/categories/15-Cloud, VPS & Mạng|Cloud, VPS & Mạng]].

## Nguồn Đang Chạy

Chrome extension → HTTPS bookmark API → Cloudflare Worker `hub-ai-bookmark-sync` → D1 cùng tên → các bản cài được cấp khóa và bật đồng bộ.

Endpoint: `https://hub-ai-bookmark-sync.kenpham320.workers.dev/v1/library`.
Readback ngày 16/10/2026: revision **3**, **308 URL / 18 nhóm**. Hai bản Chrome cô lập đã đọc cùng nội dung bằng GET; không sửa bookmark người dùng. Worker và D1 này tách khỏi gateway AI/Vault hiện hữu.

308 URL là seed có thể mở rộng. Cho phép thêm nhóm/link, nhận chỉnh tên/thư mục, gộp JSON và retry revision CAS. Lần đầu bắt buộc xem trước, tải sao lưu và xác nhận; tự đồng bộ chỉ chạy sau enrollment đã kiểm cây. Chưa đồng bộ xóa hai chiều, chưa nghiệm thu scheduler dài hạn hoặc Google Sync giữa các máy thật.

## Bằng Chứng

- Source: `D:/61.SetupAgent/bookmark/chrome-bookmark-sync`.
- Hướng dẫn: `README.md`; kết quả và giới hạn: `TEST-REPORT.md`.
- `artifacts/release-receipt.json`: gói 19 tệp, 15 tệp extension; hash từng entry khớp; không kèm `.private`, profile hay snapshot.
- SHA256 ZIP: `78aa68dc602cf880496b786db84b31f526d9f289562ac38f4d0c29865bc8ab09`.
- 40/40 unit/package/backend tests đạt. Chromium cô lập: 471→308, giữ 308 ID; 204→308, giữ 195 ID.
- Source/UI E2E dùng Chrome API thật, HTTPS mock chạy Worker thật + SQLite RAM. Cloudflare source-read E2E riêng chỉ GET production, cùng revision 3 và hash nội dung.
- Review độc lập source và ZIP: APPROVE. Không đồng nghĩa đã cài vào Gmail/máy người dùng.

## Ký Ức Và Bàn Giao

Bank đúng workspace: `may-bookmark-kenpham320`. Runtime: Codex Desktop; native chat UUID `01a0ea7d-e412-76c2-9981-a1d45bf53835`.
Checkpoint: `D:/61.SetupAgent/bookmark/chrome-bookmark-sync/artifacts/memory-fact.txt`.
Biên nhận đồng bộ sẽ nằm tại `artifacts/memory-sync-receipt.json`; trạng thái từng kho phải đọc từ receipt, không suy từ việc tạo note.
Cognee còn incident hold; không ingest/query vượt cổng. Supabase và Hindsight cần biên nhận riêng. Wikilinks ở trên là quan hệ Obsidian, không phải bằng chứng Cognee đã ingest.

Bước tiếp theo: người dùng cài thư mục `extension` vào từng hồ sơ Chrome, nhập tệp kết nối riêng, kết nối kho rồi xem trước/sao lưu/áp dụng và bật tự đồng bộ.
