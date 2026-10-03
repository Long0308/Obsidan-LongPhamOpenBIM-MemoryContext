# Phân tích & thực thi skill `drawio-architecture`

- **Ngày đo:** 2026-10-02 (Asia/Bangkok)
- **Phạm vi:** audit skill `drawio-architecture` đối chiếu thực tế repo, và thi hành BƯỚC 1/2 của skill (sinh lại sơ đồ NEX 7 tầng + Hạ tầng FPT/GPU).
- **Nguồn sự thật cấu hình sống:** `%USERPROFILE%\.codex\codex-router\astra-router-mix.json`
- **Kết luận ngắn:** generator chạy **ĐẠT**, không phá artifact cũ; skill có **3 khẳng định SAI** và **2 lỗ hổng thiếu cổng canh** cần vá.

---

## 1. Bảng audit: khẳng định trong skill ↔ bằng chứng thật

| Mục skill | Khẳng định | Bằng chứng thật | Phán quyết |
|---|---|---|---|
| §0 BƯỚC 1 | Chạy `python generate_nex_architecture_drawio.py` | Tồn tại `D:\61.SetupAgent\generate_nex_architecture_drawio.py`, 450 dòng, SHA256 `7C48F03B…4E64` | ĐÚNG |
| §0 BƯỚC 1 | Script nạp icon từ `Zalo-KKT\aicon` | Thư mục có 24 file ảnh; script glob `*.png/jpg/jpeg` (dòng 20–26) | ĐÚNG |
| §0 BƯỚC 1 | Xuất `MemoryContext/map-drawio/NEX Map.drawio` + `Zalo-KKT/docs/khung_kien_truc_nex_7_tang.drawio` | Dòng 13, 414, 426–428, 449 — khớp đường dẫn | ĐÚNG |
| §0 BƯỚC 1 | Xuất thêm `ha_tang_fpt_gpu_cloud.drawio` + `drawio_new_hashes.json` | Dòng 425, 449 — **skill không nhắc 2 file này** | THIẾU |
| §0 BƯỚC 2 | Mở `Zalo-KKT\docs\xem_so_do_drawio.html`, chọn Tab 5 / Tab 3 | File 825.355 B; có tab1..tab5 đúng nhãn, `#btnDrawioOnline` tại dòng 190 | ĐÚNG |
| §0 BƯỚC 2 | (ngầm) link `app.diagrams.net/#R…` luôn khớp sơ đồ mới | HTML nhúng **hash đóng băng**; skill không yêu cầu dựng lại viewer sau khi sinh sơ đồ | THIẾU (xem §3.2) |
| §1 | Cấu trúc `<mxfile>` → `<diagram>` → `<mxGraphModel>` → `<root>` | Cả 7 file .drawio parse đúng cấu trúc | ĐÚNG |
| §2 | Bảng màu Enterprise Blue Web | Generator dùng đúng nhóm màu chủ đạo; chi tiết xem §3.4 | ĐÚNG (có màu bổ trợ) |
| §3 | Icon nhúng Base64, cấm đường dẫn tương đối | Chỉ **2/7** file .drawio có icon Base64; 5 file còn lại = **0** icon Base64 | SAI (vi phạm cục bộ) |
| §4 | Connector `orthogonalEdgeStyle` | Có trong style của các edge trong generator | ĐÚNG |
| §5 | Dùng `xml.etree.ElementTree` dựng XML | Generator dùng đúng | ĐÚNG |
| §6 | `D:/61.SetupAgent/jev-typesafeai/jev-starter/scripts/jev_browser_agent.py` | **Không tồn tại**; `jev-starter\` không có thư mục `scripts\` | SAI |
| §7 | Bảng màu flow đồng bộ data plane | Không có cổng tự động kiểm; chỉ đọc bằng mắt | CHƯA XÁC MINH |
| §8 | Icon mã hoá sẵn trong `Zalo-KKT\aicon\_aicon.json` | `aicon\_aicon.json` **không tồn tại**; file thật ở `Zalo-KKT\docs\_aicon.json` (152 KB) | SAI |
| §8 | Danh mục icon | Thư mục có 24 file; skill liệt kê thiếu `logo trang.png`, `logo tren nen xanh-53.png`, `nex-robot-avatar.png` | THIẾU |
| §9 | `msedge.exe --headless --print-to-pdf` | `C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe` tồn tại | ĐÚNG |
| §10 | BBOX: icon + nhãn, `aspect=fixed`, lề an toàn | Thực tế dùng đúng mẫu icon-trên-thẻ (xem §3.3) | ĐÚNG |

**Tổng:** 11 ĐÚNG · 3 SAI · 3 THIẾU · 1 CHƯA XÁC MINH.

---

## 2. Bản đồ script trùng chức năng (chống dựng song song)

| Script | Vai trò thật | Trạng thái |
|---|---|---|
| `generate_nex_architecture_drawio.py` (gốc) | **Bản chính** cho 7 tầng + hạ tầng FPT/GPU | Đang dùng |
| `setupagent\generate_nex_architecture_drawio.py` | Bản sao — SHA256 **giống hệt** bản gốc | Trùng lặp (chưa drift) |
| `docs\tools\build_drawios.py`, `rebuild_nex_drawio.py`, `build_overall_drawio.py` | Tool dựng các sơ đồ khác (`zalo_hermes_hindsight_dataflow`, `so_do_nguyen_ly_ai_v1.1`, `ntc_dx_overall_architecture`) | Cũ hơn (24/09) |
| `docs\tools\ve_so_do_00c*.py` | Dựng **poster HTML** "00C" (không ghi file `.drawio` 7 tầng) | Khác artifact — không trùng |
| `docs\tools\make_viewer_html.py` | Sinh `xem_so_do_drawio.html`, nhúng hash từ `drawio_new_hashes.json` | Cần chạy lại khi sơ đồ đổi |

**Kết luận:** cho sơ đồ 7 tầng, `generate_nex_architecture_drawio.py` vẫn là bản chính. **CẤM** dựng thêm generator mới. Nên xoá/gộp bản sao `setupagent\`.

---

## 3. Kết quả thực thi (T03) và nghiệm thu (T04)

Lệnh: `python D:\61.SetupAgent\generate_nex_architecture_drawio.py` — vị trí trên `harness-cli.ps1 -Vai worker`.

### 3.1 Bằng chứng tiến trình

| Dòng | Giá trị |
|---|---|
| model CLI báo | `opencode-go/deepseek-v4.1-flash` |
| provider relay | `codex-router-signed` |
| upstream thật | `provider=opencode-go` |
| mã thoát / hết giờ / `turn.completed` | `0` / `False` / `True` |
| KẾT LUẬN | **DUNG** |

### 3.2 Toàn vẹn artifact (phép đo quan trọng nhất)

| File | Trước | Sau | Ghi chú |
|---|---|---|---|
| `NEX Map.drawio` | 10.145.841 B · 13 trang | 10.314.300 B · 13 trang | **0 trang mất**; 11 trang cũ giống hệt về ngữ nghĩa |
| `khung_kien_truc_nex_7_tang.drawio` | 15.678 B | 184.137 B | 12 icon Base64 |
| `ha_tang_fpt_gpu_cloud.drawio` | 527.199 B | 527.199 B | 9 icon Base64; tái sinh **không đổi** |
| `drawio_new_hashes.json` | 686.492 B | 686.492 B | 2 khoá: `ha_tang_fpt` 508.002 ký tự, `nex_7_tang` 178.444 ký tự |

Phép so sánh từng `mxCell` (id, value, style, parent, edge, source, target, x/y/w/h/relative) giữa backup và bản mới cho **11 trang không thuộc diện thay thế**: **0 cell khác biệt**.

⇒ Rủi ro "dùng `xml.etree` ghi lại cả file 10 MB sẽ nuốt định dạng trang cũ" **có thật nhưng KHÔNG xảy ra** trong lần chạy này: chỉ 2 trang đích bị thay, và `NEX-HA-TANG-FPT-GPU` tái sinh ra nội dung y hệt bản cũ (tính tất định).

Backup: 4 file `.bak-t03-20261002T142424` còn nguyên tại chỗ.

### 3.3 Bố cục & chống đè (trang `NEX-7-TANG-FRAMEWORK`)

- 48 vertex có toạ độ: **7 dải tầng** (`box_L7`…`box_L1`, mỗi dải rộng 1490) + 41 thẻ/dải đầu trang.
- 7 dải xếp dọc y = 90 / 210 / 330 / 460 / 580 / 710 / 840, khe hở 15 px, **không dải nào chồng dải nào**; dải cuối kết thúc y=945.
- 12 cặp "chồng" bị bộ kiểm hình học bắt: **toàn bộ là icon 30×30 nằm trên chính thẻ của nó** (ví dụ `c7_zalo` 270×55 ↔ `ico_zalo` 30×30). Đây là mẫu §10 "Icon + Nhãn văn bản" — **hợp lệ**, không phải lỗi.
- 1 phần tử ngoài mọi dải: `hdr_nex` (tiêu đề trang, y=20) — đúng thiết kế.

**Cảnh báo cho người viết cổng canh:** một cổng "cấm mọi bbox giao nhau" sẽ **báo động giả** trên chính sơ đồ đúng, vì mẫu icon-trên-thẻ tạo ra hộp lồng nhau. Cổng phải loại trừ cặp cha–con hoặc cặp icon–thẻ.

### 3.4 Hash → link `app.diagrams.net`

Giải mã `nex_7_tang`: `urllib.parse.unquote` → `base64.b64decode` → `zlib.decompress(wbits=-15)` (**raw deflate**, không phải zlib header) → 183.960 byte XML, parse được, chứa `NEX`, `KHUNG`, `Agent`.

### 3.5 Đồng bộ viewer

Hash mới sinh **có mặt nguyên văn** trong `xem_so_do_drawio.html` ⇒ viewer **đang khớp**. Lần chạy này thực chất **khôi phục** trang 7 tầng về bản chính (bản 9/26 đã bị thu gọn bởi tool khác).

**Nhưng không có cổng nào canh việc này.** Đã quét `docs\tools`, `docs\cong`, `backend\scripts`: **không script nào** đối chiếu hash nhúng trong HTML với hash trong `drawio_new_hashes.json`. Sơ đồ đổi mà quên chạy `make_viewer_html.py` ⇒ viewer cũ im lặng.

### 3.6 Nghiệm thu độc lập T04b — vai `tester`

Tiến trình: `exit 0`, `het_gio=False`, `turn.completed=True`, upstream `custom/oauth-anti-gemini-flash-high`, **KẾT LUẬN: DUNG**.
Script nghiệm thu của giám khảo ở `_scratch\quick_verify_t04b.py` (chỉ đọc); chạy lại cho:

| Phép đo của giám khảo | Kết quả |
|---|---|
| 11 trang legacy của `NEX Map.drawio` | **100% nguyên vẹn** |
| Trang 12 `NEX-HA-TANG-FPT-GPU` | 48 cell · 9 icon Base64 |
| Trang 13 `NEX-7-TANG-FRAMEWORK` | 50 cell · 12 icon Base64 |
| mxGraphModel trang 12 ↔ file standalone | **khớp 100% (0 byte lệch)** |
| mxGraphModel trang 13 ↔ file standalone | **khớp 100% (0 byte lệch)** |
| Hash `ha_tang_fpt` / `nex_7_tang` round-trip | **khớp 100%** cả hai; đều có trong viewer HTML |
| Chồng đè hình học | **hoàn toàn không chồng đè**; khe hở 15–20 px |
| Icon Base64 giải mã | 21/21 OK · **0 icon hỏng** |
| **VERDICT** | **ĐẠT CHUẨN 100% (PASS)** |

Đối chiếu chéo: giám khảo đo SHA256 `NEX Map.drawio` = `7085ea3baa536264…`, **trùng khít** số root đo. Hai con đường độc lập, một kết quả.

Phát hiện phụ có giá trị: `NEX Map.drawio` tăng **+168.459 B** và file standalone 7 tầng cũng tăng đúng **+168.459 B** ⇒ thay đổi duy nhất trong file 10 MB chính là trang 7 tầng.

---

## 4. Danh sách lỗi/hổng cần vá (ưu tiên giảm dần)

| # | Vấn đề | Bằng chứng | Đề xuất |
|---|---|---|---|
| G1 | Skill §8 khai sai vị trí `_aicon.json` | `aicon\_aicon.json` không tồn tại; file ở `docs\_aicon.json` | Sửa §8; hoặc bỏ hẳn vì generator không dùng file này |
| G2 | Skill §6 trỏ script Jev không tồn tại | `jev-starter\scripts\jev_browser_agent.py` không có | Cập nhật đường dẫn thật, hoặc bỏ ví dụ CLI |
| G3 | §3 "cấm đường dẫn tương đối" chỉ đúng 2/7 file | 5 file .drawio có 0 icon Base64 | Ghi rõ §3 áp dụng cho file do generator sinh |
| G4 | Không có cổng canh viewer khớp sơ đồ | Không script nào so hash | Thêm bước bắt buộc chạy `make_viewer_html.py` + cổng so hash |
| G5 | Bản sao generator ở `setupagent\` | SHA256 giống hệt | Xoá bản sao để tránh sửa nhầm |
| G6 | Tài sản trùng: `NEXZALO.png` = `nex-robot.png` | Cùng SHA256 `6E53CA48…73FB` | Bỏ 1 bản |
| G7 | Skill không nhắc 2 output còn lại của generator | `ha_tang_fpt_gpu_cloud.drawio`, `drawio_new_hashes.json` | Bổ sung vào §0 |

---

## 5. Nhật ký sự cố trong chính lượt điều phối này

| Mã | Sự việc | Chi tiết |
|---|---|---|
| I1 | **Lỗi của root:** 4 lần gọi `spawn_agent` đều truyền thêm `model=opencode-go/deepseek-v4.1-flash`, đè ghim vai (explorer đáng lẽ `gpt-6-luna`). Đã `interrupt_agent` cả 4 và chuyển sang harness CLI. | Đúng mẫu skill §⓿ đã cảnh báo ("sai lặp vì không đọc lại luật"). Bài học: đường spawn trong phiên không tự bảo đảm "không truyền model" khi orchestrator liên tục phát ra trường đó ⇒ dùng harness CLI cho tới khi có cổng chặn. |
| I2 | T04 lần 1 hết giờ (`exit 2`, `het_gio=True`, không `turn.completed`) | Đúng hướng dẫn skill: route Antigravity 0% cache chỉ nên nhận câu hỏi hẹp. Đã tách lại phạm vi. |
| I3 | T03 **không ghi** `evidence-T03.json` dù harness báo `DUNG` | `turn.completed` chỉ chứng minh lượt CLI kết thúc, **không** chứng minh quy trình được tuân thủ. Root đã đo lại và tái tạo file bằng số thật (`evidence_provenance: RECONSTRUCTED BY ROOT`). |
| I4 | T04 lần 1 (đã hết giờ) **vẫn chạy lại generator** dù prompt ghi rõ non-scope; mtime 4 artifact nhảy từ 14:25:56 → **14:37:13** | Không gây hại: SHA256 bản mới `7085ea3baa536264…` **trùng khít** bản đo lúc 14:28 ⇒ generator **tất định**, chạy 2 lần ra 1 kết quả. Đã nghiệm thu lại toàn vẹn trên chính file 14:37:13: 13 trang, 0 trang mất, 11 trang cũ giống hệt. Bài học: sandbox `workspace-write` không tự chặn ghi ngoài phạm vi — phải kiểm bằng mtime/hash **sau** khi agent kết thúc. |
| I5 | **Đính chính báo cáo:** thoạt tiên root kết luận T03 "không tạo bằng chứng" — **SAI**. Builder có tạo `Zalo-KKT\docs\drawio_t03_evidence.json` (10.410 B, 14:26:02) + 4 backup, chỉ **lệch đường dẫn** so với yêu cầu. Không xoá file của builder. | Hai bộ bằng chứng **khớp nhau**: cùng SHA256 `7085ea3baa536264…`, cùng `exit_code: 0`. |
| I6 | Lệch phạm vi ghi: builder đặt helper `verify_t03_drawio_skill_step1.py` ở **gốc repo** (ngoài phạm vi); giám khảo đặt `_scratch\quick_verify_t04b.py` (đúng quy ước repo). | Không gây hại. File ở gốc repo là rác cần dọn — **chưa xoá, chờ ý kiến người dùng**. |
