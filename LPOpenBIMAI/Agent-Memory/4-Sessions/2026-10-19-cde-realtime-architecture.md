# Capsule: 2026-10-19 — Newtecons CDE Realtime Architecture & Revit Server Cloud Protection

## 1. Bối Cảnh & Mục Tiêu
* **Người dùng chủ quản:** Phí Long Phạm (`philong.pham@newtecons.vn`) — Quản trị viên tối cao độc quyền gán quyền và quản lý dự án.
* **Hạ tầng 3-VM:**
  - VM1 (`192.168.210.4`): WireGuard VPN Gateway (Public IP: `103.160.85.39:51820`).
  - VM2 (`192.168.210.5`): Autodesk Revit Server 2022-2026, WCF NetTcp:808, Physical Storage `E:\BIM\NTC_Projects` (635 GB NVMe).
  - Web CDE: Next.js 16 + React 19 (`newteconsrevitsever/web-cde`) và FastAPI Backend.
* **Cam kết cốt lõi:**
  - Bảo vệ tuyệt đối vùng Central storage `E:\BIM\NTC_Projects` và cổng 808 TCP của Revit Server, không làm gián đoạn giám sát/kỹ sư đang vẽ mô hình.
  - Phân vùng an toàn CDE nằm độc lập trên ổ `F:\cde-system`.

## 2. Các Thay Đổi Kiến Trúc Đã Nghiệm Thu
1. **Khắc phục lỗi cấu hình VPN xuất ra:**
   - Cấu hình `.conf` xuất ra luôn ép chuẩn:
     ```ini
     AllowedIPs = 10.8.0.0/24, 192.168.210.0/24
     Endpoint = 103.160.85.39:51820
     PersistentKeepalive = 25
     ```
   - Nhân sự mới (Lê Văn Đại - IP `10.8.0.22`) được tự động đồng bộ vào nhóm Ban Chỉ Huy (BCH).
2. **Chuẩn hóa phân nhóm 3 tầng:**
   - 💻 **Ban BIM Newtecons (5 thành viên):** Phí Long Phạm, Thới Văn Hội, Nguyễn Ngọc Hiền, Trần Huỳnh Anh, Nguyễn Phương Loan.
   - 🏢 **Ban Chỉ Huy (BCH):** Lê Văn Đại, Trương Chiến, Trần Hoàng Long (Leader BIM).
   - 🏗️ **Nhà Thầu Phụ (NTP):** THQ, Vĩnh Đạt, Metech, Ba Dương, Đất Phan, Phương Nam, Vĩnh Tường.
   - Cho phép Admin chuyển đổi nhóm động trực tiếp trên web và lưu realtime vào cơ sở dữ liệu.
3. **Database Schema Mở Rộng Đa Dự Án:**
   - Đã biên soạn tệp `database/cde_master_schema_supabase_realtime.sql` sẵn sàng mở rộng không giới hạn hàng trăm dự án.
   - Bật cờ `ALTER PUBLICATION supabase_realtime ADD TABLE ...` cho toàn bộ các bảng.
4. **Sơ đồ Kiến trúc Đồ họa:**
   - Cập nhật đầy đủ icon brand vector SVG chính hãng (Autodesk Revit, WireGuard Dragon, Supabase Bolt, PostgreSQL Elephant, Next.js N, Windows Server 2025, Ubuntu, Cognee & Hindsight Dual-Brain).
   - Lưu trữ tại `newteconsrevitsever/revit-server-cloud/index.html` và `ARCHITECTURE_CDE_REALTIME_SPEC.md`.
5. **Next.js 16 + React 19 Build:**
   - Dự án `newteconsrevitsever/web-cde` đã cài dependencies và chạy `npm run build` thành công 100% trong 3.9s với 45 static/dynamic routes.
