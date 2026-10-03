---
id: codex-01a0f173
title: "OmniClass về qui chuẩn đặt tên cấu kiện"
date: 30/09/2026 15:34:20
workspace: "[[workspaces/61-SetupAgent|61.SetupAgent]]"
model: "[[models/gpt-6-astra|gpt-6-astra]]"
ide: Codex Desktop
tokens: 836359
tags: [session, codex, 61-SetupAgent]
---

# 🗣️ Phiên Chat: OmniClass về qui chuẩn đặt tên cấu kiện

> **Nền tảng**: Codex Desktop · **Mô hình**: `[[models/gpt-6-astra|gpt-6-astra]]`
> **Thư mục**: `[[workspaces/61-SetupAgent|61.SetupAgent]]` · **Thời gian**: `30/09/2026 15:34:20`
> **Mức tiêu thụ**: **836,359 tokens**

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
`D:\61.SetupAgent\docs\LUAT-RECALL-TRUOC-KHI-CODE.md`

🩸 Ở runtime này luật là **cổng MỀM** — chỉ Claude Code chặn được ở tầng máy bằng
hook `recall_gate.sh`. Khai "hard gate" ở đây là nói dối.

---
</INSTRUCTIONS>

---

<environment_context>
  <cwd>D:\61.SetupAgent</cwd>
  <shell>powershell</shell>
  <current_date>2026-09-30</current_date>
  <timezone>Asia/Bangkok</timezone>
  <filesystem><workspace_roots><root>D:\61.SetupAgent</root><root>D:\45.OCR Chandra</root><root>C:\Users\philong.pham\.codex\visualizations\2026\09\30\01a0f173-4c56-79e1-bb72-0b4c488d00b2</root></workspace_roots><permission_profile type="disabled"><file_system type="unrestricted" /></permission_profile></filesystem>
</environment_context>

---

OmniClass về qui chuẩn đặt tên cấu kiện

---

tìm kiếm và phân biệt lợi thế opmiclass và uniclass

---

làm bảng so sánh nhanh cấu kiện bể nước 
làm ví dụ cho cấu kiện này  bảng so sánh
```

---

## 🤖 2. Phản Hồi Từ Trợ Lý AI (Assistant Response)

Tôi sẽ tra nguồn chính thức để làm rõ OmniClass quy định phần nào của việc phân loại và đặt tên cấu kiện BIM/Revit.

---

**OmniClass dùng để chuẩn hóa mã và tên nhóm phân loại cấu kiện trong BIM. Còn cách đặt tên cụ thể như `STR_Cot_BTCT_400x600` là quy ước của doanh nghiệp hoặc dự án, cần quy định trong BEP.** Vì vậy, khi xây dựng tiêu chuẩn, nên gọi đầy đủ là **“Quy định phân loại theo OmniClass và quy ước đặt tên cấu kiện”**. CSI mô tả OmniClass là hệ thống tổ chức, phân loại và truy xuất thông tin ngành xây dựng. [Nguồn CSI](https://www.csiresources.org/standards/omniclass/standards-omniclass-about)

Trong BIM/Revit, anh có thể áp dụng theo cách sau.

**Trước hết, chọn đúng bảng OmniClass cho đối tượng cần quản lý:**

| Bảng | Nội dung phân loại | Áp dụng |
|---|---|---|
| **Table 21 – Elements** | Bộ phận công trình theo chức năng | Quản lý các bộ phận, tổ hợp thực hiện chức năng của công trình. |
| **Table 22 – Work Results** | Kết quả công tác xây dựng | Liên kết với công tác thi công và yêu cầu kỹ thuật; có thể dùng làm cơ sở ánh xạ BOQ. |
| **Table 23 – Products** | Sản phẩm, cấu kiện và cụm sản phẩm đưa vào công trình | Phân loại đối tượng, sản phẩm trong thư viện BIM. |

Đây là các góc phân loại khác nhau; cần chọn theo mục đích sử dụng dữ liệu. [Định nghĩa các bảng của CSI](https://www.csiresources.org/standards/omniclass/standards-omniclass-about)

**Về đặt tên cấu kiện, tôi đề xuất tách thành bốn lớp thông tin:**

| Lớp thông tin | Nội dung | Ví dụ minh họa |
|---|---|---|
| **Mã và tên phân loại** | Lấy từ đúng bảng, đúng phiên bản OmniClass được dự án chọn | Mã phân loại + tên phân loại chính thức tương ứng |
| **Family Name** | Nhận diện nhóm cấu kiện, hình thức hoặc nguyên lý cấu tạo | `ABC_STR_Cot_ChuNhat` |
| **Type Name** | Phân biệt các loại bằng vật liệu, kích thước hoặc thông số kỹ thuật | `BTCT_400x600mm` |
| **Mark / mã cấu kiện lắp đặt** | Nhận diện cấu kiện cụ thể trong dự án | `C-B3-001` |

Trong ví dụ này, `ABC`, `STR`, `BTCT` và `C-B3-001` là **mã quy ước nội bộ minh họa**, không phải mã OmniClass. Một mã phân loại có thể áp dụng cho nhiều cấu kiện; mã nhận diện từng cấu kiện cần quản lý riêng.

Có thể thống nhất cú pháp tên như sau:

```text
Family Name:
[MaDonVi]_[BoMon]_[LoaiCauKien]_[DacDiemCauTao]

Type Name:
[VatLieu]_[KichThuoc]_[ThongSoPhanBiet]
```

Các trường trong Type Name chỉ sử dụng khi phù hợp với loại cấu kiện. Ví dụ:

| Cấu kiện | Family Name đề xuất | Type Name đề xuất |
|---|---|---|
| Cột bê tông cốt thép chữ nhật | `ABC_STR_Cot_ChuNhat` | `BTCT_400x600mm` |
| Cửa thép một cánh mở quay | `ABC_ARC_CuaDi_MoQuay1Canh` | `Thep_900x2200mm_EI60` |
| Van bướm | `ABC_PHE_Van_Buom` | `DN100_PN16` |

**Đây là mẫu quy ước đề xuất cho dự án, không phải cú pháp do OmniClass ban hành.** Các thông số chỉ được đưa vào tên khi phù hợp với dữ liệu kỹ thuật của cấu kiện.

Để áp dụng nhất quán, quy định BIM nên chốt những điểm sau:

- **Ban hành danh mục thuật ngữ và viết tắt:** thống nhất một cách gọi cho mỗi loại cấu kiện, chẳng hạn `Cot`, `Dam`, `CuaDi`, `Van_Buom`; tránh mỗi đơn vị tự đặt.
- **Thống nhất định dạng:** dấu phân cách, chữ hoa/chữ thường, ngôn ngữ và đơn vị. Nếu chọn tên không dấu thì vẫn có thể lưu mô tả tiếng Việt có dấu trong trường Description.
- **Lưu mã OmniClass ở tham số riêng:** tên Family/Type phục vụ nhận diện; mã và tên phân loại phục vụ tra cứu, lọc và trao đổi dữ liệu. Nếu dự án muốn thêm mã vào tên, vẫn cần lưu đầy đủ trong tham số.
- **Quản lý vị trí theo từng cấu kiện:** tầng, khu vực, phòng và vị trí lắp đặt nên nằm trong các tham số tương ứng; tránh đưa vào tên Family dùng chung.
- **Giữ thông số kỹ thuật trong tham số:** kích thước, vật liệu, công suất, cấp áp lực… phải có dữ liệu tương ứng để lập bảng thống kê và BOQ; không chỉ tồn tại dưới dạng chữ trong tên.
- **Chốt bảng và phiên bản OmniClass:** dùng cùng nguồn mã cho toàn dự án. Autodesk xác nhận một số mã OmniClass có sẵn trong các phiên bản Revit có thể cũ hoặc thiếu. [Hướng dẫn Autodesk](https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/OmniClass-codes-are-out-of-date-in-Revit.html)

Riêng trong Revit, các tài liệu trước đây dùng trường **OmniClass Number / OmniClass Title**, gắn với Table 23. Tài liệu Revit 2026 sử dụng tên **Classification Number / Classification Title**, nên biểu mẫu kiểm tra cần phù hợp với phiên bản phần mềm. [Tài liệu phân loại Autodesk](https://interoperability.autodesk.com/classificationmanager/downloads/Autodesk%20Whitepaper%20-%20Classification%20Systems.pdf), [thuộc tính Family Revit 2026](https://help.autodesk.com/cloudhelp/2026/ENU/RevitLT-StructEng/files/GUID-97DE744A-CDC8-45D3-9963-BAA7C721F1CD.htm)

Nếu đưa vào BEP hoặc quy định quản lý mô hình, anh có thể dùng đoạn sau:

> Cấu kiện trong mô hình BIM phải được gán mã và tên phân loại theo bảng, phiên bản OmniClass được dự án thống nhất. Tên Family và Type tuân thủ quy ước đặt tên của dự án, sử dụng danh mục thuật ngữ, mã bộ môn, dấu phân cách và đơn vị thống nhất. Mã phân loại, thông số kỹ thuật và mã nhận diện cấu kiện phải được quản lý bằng các tham số tương ứng để phục vụ kiểm tra, thống kê khối lượng và trao đổi dữ liệu.

---

Tôi sẽ tìm nguồn chính thức để so sánh OmniClass và Uniclass về cấu trúc, lợi thế khi dùng trong BIM/Revit, BOQ và quản lý tài sản.

---

## 🧭 3. Điều Hướng & Liên Kết Mạng Lưới
- 📋 Danh mục tổng: [[Session-Chat-History|Trang Tổng Hợp Lịch Sử Phiên Chat]]
- 🏢 Không gian làm việc: [[workspaces/61-SetupAgent|Dự án 61.SetupAgent]]
- 🤖 Mô hình xử lý: [[models/gpt-6-astra|gpt-6-astra]]
- 🗺️ Bản đồ quan hệ: [[Memory-Graph.canvas|Canvas Mạng Lưới Tri Thức]]
