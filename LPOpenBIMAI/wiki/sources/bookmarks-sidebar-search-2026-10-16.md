---
title: LPOpenBIM - Bookmark v1.2.5
aliases: [Bookmark Sidebar Search v1.2]
date: 2026-10-16
tags: [bookmarks, chrome-extension, search, context-graph]
---

# LPOpenBIM - Bookmark v1.2.5

Kế thừa [[wiki/sources/bookmarks-cloud-extension-2026-10-16|Bookmark Cloud Extension v1.1]] và [[wiki/sources/bookmarks-hub-ai|Danh mục Bookmark HUB AI]].

## Luồng Hằng Ngày

Icon extension → Chrome Side Panel → tìm tên/URL/nhóm/mục đích/thẻ/đoạn trích cục bộ → chọn link → xem/chỉnh sửa và quan hệ. Bánh răng mở `manager.html` lớn; bốn bước backup/apply/verify nằm trong bảo trì, không chiếm thư viện hằng ngày.

Tìm không dấu bằng Fuse.js và graph Cytoscape chạy cục bộ. `newtecons` trả 27 URL của nhóm [[wiki/entities/bookmarks/categories/02-Newtecons|Newtecons]] trong bộ khởi đầu 308 URL/18 nhóm. 14 mô tả có nguồn từ workspace/skill/tên bookmark; không có công dụng giả cho các trang còn lại.

Mục đích, thẻ và URL liên quan ở top-level annotations, được kiểm schema/merge/CAS và đồng bộ qua kho riêng. URL giữ nguyên là định danh; chưa đổi URL hoặc xóa hai chiều. Trang đã nghiệm thu sửa/lưu qua journal bảo toàn ID, không lặp xác nhận 1–4. Chưa enrollment thì không âm thầm sửa native bookmark.

## Nội Dung Và Quan Hệ

Đoạn trích trang phải được người dùng chủ động lưu bằng activeTab+scripting, chỉ URL đã bookmark, chỉ trang chính HTTP/HTTPS. Tối đa 12 đoạn ×700 ký tự mỗi trang, kho 512 KiB. Nội dung chỉ lưu trên máy; không gửi Cloudflare/Hindsight/Cognee. Không tự quét toàn bộ trang hoặc đọc cookie/form/storage. Văn bản hiển thị có thể vẫn chứa thông tin nội bộ.

Graph phân biệt liên kết khai báo với gợi ý cùng thẻ/nhóm/miền, có lý do trong chi tiết. Đây là graph ngữ cảnh, không phải tìm kiếm vector hay GraphRAG. [[wiki/entities/bookmarks/categories/07-Memory & Knowledge|Cognee/Memory]] còn cổng an toàn; không query/ingest vượt cổng.

## Bằng Chứng Và Phạm Vi

Source: `D:/61.SetupAgent/bookmark/chrome-bookmark-sync`. `README.md`, `TEST-REPORT.md` và `artifacts/workbench-e2e-report.json` giữ kết quả thật và giới hạn.
54 unit/package/backend tests đạt; source/UI E2E dùng Chrome API và Worker thật/SQLite RAM qua HTTPS mock. Native recovery API E2E hai profile cô lập giữ308/195ID. Không tự cập nhật extension trên Chrome người dùng hoặc xác minh Google Sync/mọi máy.

Cloudflare Worker version `192da509-45e1-4174-99a6-a837f526d817`, predecessor rollback `276d7e70-4f78-4588-8413-c24ba33efb80`. Readback vẫn revision3/308URL/18nhóm; không thay dữ liệu production. Không sửa gateway AI/Vault.

Bước người dùng: Reload extension cùng thư mục (không gỡ để giữ storage), duyệt quyền mới nếu Chrome hỏi, bấm icon để mở sidebar và bánh răng để vào cấu hình. Cần nhập kết nối riêng để chia sẻ qua hai Gmail. Vị trí bên trái/phải là tùy chọn Chrome.

## Cập Nhật v1.2.1: Cây Thư Mục Và Glass

Theo yêu cầu dùng `apple-design` và `revit-wpf-ui`, sidebar đưa đủ 18 nhóm ra cấp ngoài, có mũi tên màu, số link và subfolder thật. Ví dụ [[wiki/entities/bookmarks/categories/02-Newtecons|Newtecons]] -> Phòng họp & Vận hành -> AMS đặt phòng. [[wiki/entities/bookmarks/categories/09-Frontend UI|Frontend UI]] và [[wiki/entities/bookmarks/categories/10-Backend & API|Backend & API]] là hai nhóm riêng. Trạng thái mở được giữ trong phiên; tìm kiếm trả danh sách phẳng, xóa tìm kiếm quay về cây.

Vật liệu kính chỉ đặt trên lớp cấu trúc: sticky header `blur(16px) saturate(1.15)`, trắng alpha `.86`, viền sáng và bóng nhẹ. Nội dung giữ rõ chữ, không blur từng hàng hoặc neon chuyển động liên tục. Sáu màu nhóm Blue/Teal/Rose/Green/Violet/Cyan có biến thể Dark; giảm trong suốt hoặc tăng tương phản dùng nền đặc. Mã màu trong README, không áp nguyên XAML WPF vào extension web.

Đã sửa bộ lọc nhóm ẩn sau đồ thị -> Danh sách để tìm Cognee ngoài nhóm không bị mất kết quả. Gói giữ nguyên 308 URL/18 nhóm, quyền và backend; không sửa Chrome thật hoặc import chồng. Source JS SHA256 `4ab91ae5ad30a6b173d6483ed2394363c60755ec387f77844bd49dddd9d06d06`; CSS `59457f943bcbc353f07565f6695e29f4588ffb038666b0ba4d2f8d2aefb36313`. Review độc lập source APPROVE, 54 unit/package/backend +18 workbench +8 tree/glass checks đạt. Tree suite kiểm exact308 URL, native disclosure Enter, tìm Newtecons27, 400/360/320px không tràn, Dark contrast13.88:1, reduced motion/transparency; không HTTP hoặc native bookmark mutation.

ZIP `D:/61.SetupAgent/bookmark/chrome-bookmark-sync/HUB-AI-Bookmark-Sync-v1.2.1.zip`, SHA256 `84d49ae60624a8e6cf3e5a545a56766c29f538dd51921223342ec8b4c7b2f1d3`. Không cần deploy Worker cho patch UI này. Ảnh là nội dung sidepanel trong Chromium cô lập, không chứng minh dock phải hoặc Google Sync. Cognee vẫn hold; receipt từng kho tách riêng với nghiệm thu tính năng.

## Lịch Sử v1.2.2: Glass Toàn Khung

Người dùng gửi ảnh thực tế và chưa chấp nhận vật liệu v1.2.1 vì trắng, kính header quá nhẹ. Đã mở rộng chính khung sidebar: lớp nền blue/teal/lilac tĩnh, gutter 6px, rim sáng, bevel và bóng nhẹ; header trắng alpha .60/blur20px, nội dung trắng alpha .55. Dark charcoal, fallback giảm trong suốt/contrast/forced colors trả về nền đặc. Không đổi JS, quyền, bookmark hoặc backend. Cây và sáu màu nhóm vẫn giữ nguyên.

CSS hiện tại SHA256 `94d2546d55cbb6d038d5205781e44ebdc79e2d99c41c3bc12f297a63f61d090b`, JS giữ `4ab91ae5ad30a6b173d6483ed2394363c60755ec387f77844bd49dddd9d06d06`. Review độc lập đã so ảnh v1.2.1 với v1.2.2 và chạy lại tree suite: 9/9; workbench18/18 và unit54/54 đạt. Pixel mẫu nền thật của phần tử nhìn thấy cho Light5.37:1/Dark13.68:1, không suy thành toàn bộ WCAG. Gói `HUB-AI-Bookmark-Sync-v1.2.2.zip` 352353 bytes, SHA256 `613a0ad10a091eabbbde3d1041627f2b21730fa88277299163c42f3eed7bef3f`. Chỉ cần Reload cùng extension rồi đóng/mở sidebar, không gỡ hoặc import lại. User visual acceptance của bản mới vẫn chờ; không tự kết luận chỉ vì test đạt. Hindsight/Obsidian có receipt riêng, Supabase container dừng và Cognee hold chưa thay đổi.

## Bàn Giao Cuối Phiên

[Bàn giao chuẩn trong project](D:/61.SetupAgent/bookmark/chrome-bookmark-sync/HANDOVER-2026-10-16-bookmark-sync.md) giữ Plan, API/D1, file/hash, task BM-01..BM-07, prompt tiếp tục và giới hạn. Nối tiếp trên cùng source này; không sửa ZIP đã duyệt để thêm checkpoint. Nghiệm thu Chrome thật và hai Gmail còn chờ, tách với việc lưu bank/Obsidian. Checkpoint cuối có receipt riêng `D:/61.SetupAgent/bookmark/chrome-bookmark-sync/artifacts/handover-memory-receipt.json`.

## Lịch Sử v1.2.3: LPOpenBIM, Glass Đồng Nhất Và Lưu Trang

Tên hiển thị mới là **LPOpenBIM - Bookmark** trên action, panel, thư viện và Cài đặt. Dùng đúng logo gốc `LPlogoxpw.png` trong tài nguyên LPOpenBIM, SHA256 `42d83b1b70ba58cbce17f3f2d64ba67fb2d52894ee07fa654a3434ea5e932f22`, đóng gói local, không tạo lại. Đổi tên không thay storage/libraryId/Worker hay dữ liệu. Reload cùng extension rồi đóng/mở sidebar, không gỡ/import chồng.

Người dùng chốt **glass đồng nhất Light/Dark**, không chỉ một khung ngoài: folder và subfolder có sáu tone/rim/bevel/tab/depth; thư viện lớn, settings và save dialog dùng cùng bảng màu kính. Text/input vẫn rõ, không blur từng link, không animation chạy liên tục. Giảm trong suốt/contrast-more/forced-colors trả glass surface về nền đặc, no gradient/blur/shadow. CSS shared `e5d34925e9e18bd85fec49264d96b609a076fffc89739c2decfd14b503f365b1`; folder CSS `ead5ccc56d4a41d6c5130c0caf76cb1fd3e5e442c0baa09155ad0507a7c8f9ba`.

Mở trang -> bấm icon LP -> **Lưu trang đang mở** -> kiểm tên/exact URL -> chọn folder/subfolder/rỗng -> lưu. URL trùng có nút mở editor hiện có để chuyển, không tạo bản dư; giữ ID/metadata. Chỉ đọc active current-window khi bấm, không đoán trang khác; restricted/manual và cancel phản hồi muộn có guard. Lưu link không đồng nghĩa lưu đoạn nội dung. Chưa enrollment vẫn source-only, không sửa native. Luồng đặt phòng [[wiki/entities/bookmarks/categories/02-Newtecons|Newtecons]], [[wiki/entities/bookmarks/categories/09-Frontend UI|Frontend UI]], [[wiki/entities/bookmarks/categories/10-Backend & API|Backend & API]] và [[wiki/entities/bookmarks/categories/07-Memory & Knowledge|Memory]] giữ nguyên trong cùng thư viện.

Đã đạt unit/package/backend61, workbench18, tree12, save8 và parity4 (18tổ hợp theme/media/trang,102sample surface); source không drift, không pageerror ở E2E cuối. Gói `LPOpenBIM-Bookmark-v1.2.3.zip`1780755bytes,32entry/28extension; SHA256 `3576550313fb83a2a3beacdb36430f7467d7c57073377cb31c9a1a2438a59053`. Biên nhận reviewer `artifacts/v123-independent-review.json`; mốc memory mới `artifacts/memory-sync-v123-receipt.json`. Không deploy backend hoặc sửa Chrome người dùng, không suy Google Sync/mọi máy/toolbar/permission-dialog từ fixture. Supabase/Cognee còn giới hạn riêng như handover; không tuyên bố full memory sync.

## Lịch Sử v1.2.4: Dùng Đúng LPlogoxp.png

Người dùng không thấy logo trắng trong panel và chốt lại **`LPlogoxp.png`**, không phải `LPlogoxpw.png`. Bản xanh nguyên byte SHA256 `c3a37ff6797c8933c3b6c78fa7eced52e4f680d642f7696ff9b2d153629a6378` được đóng gói và dùng cho manifest/action cùng ba header. Logo40x40 có nền đỡ CSS sáng nhỏ để không chìm vào Dark; không thay màu/filter hoặc sửa pixel ảnh. Vật liệu glass Light/Dark của folder và toàn bộ các màn hình giữ nguyên; không đổi JS sản phẩm, storage, backend hay308link/18nhóm.

Logo render test đạt3gate/18case (3trang x2theme x400/360/320px), có screenshot pixel thật và kiểm header không lấn. Bản đầu bắt được logo xanh còn tối trên Dark, giữ cùng ngưỡng và chỉ thêm nền đỡ rồi đo lại. Source/render đã duyệt độc lập; biên nhận phát hành `artifacts/v124-independent-review.json`, memory `artifacts/memory-sync-v124-receipt.json`. Reload cùng extension/version1.2.4 rồi mở lại panel; không gỡ/import. Các giới hạn Google/Gmail/Cognee/SQL ở handover tiếp tục áp dụng.

## Bản Hiện Tại v1.2.5: Tự Điền Metadata Trong Panel Và Gợi Ý Thư Mục Cục Bộ

Người dùng yêu cầu khi bấm lưu trang trong panel thì tiêu đề và URL phải tự động nhận định và lấy, đồng thời gợi ý thư mục phù hợp để giảm thao tác thủ công. Baseline v1.2.4 không host pregrants tái hiện đúng lỗi trắng tên/URL và default vào `01-NEX` (`artifacts/autofill-panel-baseline-v124-report.json`).

Manifest v1.2.5 bổ sung quyền `tabs` metadata (7 quyền chuẩn, không xin host permissions rộng, không chèn content scripts). Truy vấn chỉ thực hiện khi người dùng bấm Lưu với `{ active: true, currentWindow: true }`. Module `folder-suggestion.mjs` gợi ý cục bộ hoàn toàn theo thứ bậc:
1. **Exact URL**: Trả về đúng thư mục đã lưu trước đó nếu link đã tồn tại.
2. **Origin + Pathname**: Khớp trang cùng đường dẫn (bỏ qua query/hash), ví dụ route đặt phòng Newtecons gợi ý đúng `["02-Newtecons", "Phòng họp & Vận hành"]`.
3. **Unique Hostname**: Nếu hostname chỉ thuộc duy nhất một nhóm trong 18 nhóm gốc (các host dùng chung như github.com được giữ trung lập).
4. **Topic cues**: Từ khóa đặc trưng trong URL/tiêu đề gợi ý nhóm gốc thật (ví dụ `21st.dev` gợi ý `["09-Frontend UI"]`).
5. **Placeholder trung lập**: Nếu không đủ căn cứ, form yêu cầu chọn thư mục có chủ đích (`""` - "Chọn thư mục…"), không tự gán vào `01-NEX`. Lựa chọn thủ công của người dùng được tôn trọng và không bị autosuggest ghi đè.

Bộ kiểm thử: 67/67 unit/package/backend tests PASS; `autofill-panel-e2e.mjs` đạt 6/6 PASS qua physical CDP input; toàn bộ regression (save-panel, tree, glass-parity, logo, workbench) đều PASS. Gói `LPOpenBIM-Bookmark-v1.2.5.zip` (33 entries / 29 extension files).
