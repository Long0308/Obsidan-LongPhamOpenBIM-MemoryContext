---
tags: [hub, ai, onboarding, kien-truc, huong-dan, jev, bim]
nguon: Notion HUB, Chrome Bookmarks, Local Skills Tree (~/.agents/skills & D:/61.SetupAgent/.agents/skills)
cap_nhat: 2026-09-23
chuan: codebase-onboarding skill (4 pha)
---

# Onboarding Guide: Hệ Sinh Thái AI Agent, Tri Thức & Kỹ Thuật (HUB AI)

Tài liệu định hướng kiến trúc, bản đồ linh hồn và hướng dẫn vận hành hệ sinh thái AI Agent toàn diện cho kỹ sư và nhà phát triển tại Newtecons / LPOpenBIM.

> [!important] Triết lý vận hành cốt lõi
> 1. **NHỚ TRƯỚC KHI LÀM**: Kiểm tra Hindsight Vector DB, Brain bộ nhớ bền trước khi viết code hay tạo tool mới.
> 2. **TÁI SỬ DỤNG TRƯỚC TIÊN**: Khi skill hoặc route đã tồn tại, ưu tiên mở rộng — cấm dựng song song làm loãng tri thức.
> 3. **TỐC ĐỘ & TIẾT KIỆM (Jev System One)**: Phân tách tầng quyết định nhanh (Jev) với tầng suy luận nặng (Opus/Astra).

---

## 🗺️ Pha 1: Khảo sát Toàn cảnh (Reconnaissance)

Hệ sinh thái tri thức và công cụ hiện tại được cấu thành từ 4 nguồn chính:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        HỆ SINH THÁI HUB AI                            │
├──────────────────┬──────────────────┬─────────────────┬────────────────┤
│  Chrome Bookmarks│   Notion HUB     │   User Skills   │Workspace Skills│
│   (167 links)    │   (13 mục con)   │   (40 skills)   │  (485 skills)  │
│  9 cụm chuyên môn│ 26 trang nghiệp vụ│ 16 Jev/TypeSafe │ MEP, BIM, CAD, │
│  AI, OCR, BIM... │  Notion API mirror│  CUA, Compaction│ Hindsight, Web │
└──────────────────┴──────────────────┴─────────────────┴────────────────┘
```

### Điểm chạm vào hệ thống (Key Entry Points):
- **Vault Obsidian**: `D:\61.SetupAgent\bookmark\hub-ai\` chứa toàn bộ tài liệu và Canvas trực quan.
- **Trang Notion Master**: `https://app.notion.com/p/HUB-T-i-li-u-AI-2b02ff4d751d8098b48adba687ec0aaf`.
- **Cửa ngõ Jev & TypeSafe**: `~/.agents/skills/jev-*` và `D:/61.SetupAgent/jev-typesafeai/`.
- **Cửa ngõ Memory**: Hindsight BIM MCP Server (`http://127.0.0.1:8888`), Neo4j Graph (`localhost:7474`), Qdrant Vector DB (`localhost:6333`).
- **Cửa ngõ Gateway / Model**: Codex Router (`127.0.0.1:4400`), LiteLLM, OpenRouter, Tailscale Admin (`:8444/:8445`).

---

## 🏛️ Pha 2: Bản đồ Kiến trúc 5 Tầng (Architecture Mapping)

Toàn bộ luồng dữ liệu và uỷ thác tác vụ trong hệ thống vận hành theo kiến trúc 5 tầng phân cấp chặt chẽ:

### Tầng 1: Ra quyết định Nhanh & Điều hướng (Decision & Routing Layer)
- **Công nghệ cốt lõi**: Jev (TypeSafe AI System One), `TheoLeeCJ/SemIf`, `0xNatoshi/jev-codex-router`.
- **Nhiệm vụ**: Phân loại ý định (Intent), định tuyến model nhẹ/nặng, chọn skill tự động, nén context (`fast-jev-compaction`) cắt 75% dữ liệu thô cũ.
- **Kỹ năng đại diện**: `jev-model-routing`, `jev-skill-select`, `jev-compaction`, `jev-computer`.

### Tầng 2: Điều phối Đa Agent & Khung Thực thi (Orchestration & Harness Layer)
- **Công nghệ cốt lõi**: Codex CLI, Claude Code, OpenClaw (`:18789`), Hermes Agent, ByteDance `deer-flow`, `CopilotKit`.
- **Nhiệm vụ**: Vòng lặp hành động (Agentic loop), quản lý session, chạy đa luồng (Astra điều phối + Luna thực thi), chạy kiểm thử lặp (Gauntlet Loop).
- **Kỹ năng đại diện**: `astra-orchestrator`, `autonomous-agent-harness`, `nex-gauntlet-loop`, `codex-computer-use`.

### Tầng 3: Cổng Chuyển tiếp & Quản trị Quota (AI Gateway & Router Layer)
- **Công nghệ cốt lõi**: `BerriAI/litellm`, OpenRouter, 9router, ModelAPI.vn, Cloudflare Access, Tailscale Mesh.
- **Nhiệm vụ**: Cân bằng tải API, chia key theo vai, kiểm soát chi phí token, chống nghẽn mạng và bảo mật qua tunnel riêng.
- **Kỹ năng đại diện**: `codex-router`, `9router-cong-gop-oauth`, `newapi-chia-key-theo-vai`, `newapi-ngan-hang-quota`.

### Tầng 4: Bộ nhớ Bền vững & Đồ thị Tri thức (Memory & Knowledge Layer)
- **Công nghệ cốt lõi**: Vectorize `hindsight` (:8888), `mem0ai/mem0`, `LightRAG`, Obsidian Vaults, Neo4j, MinIO.
- **Nhiệm vụ**: Lưu trữ sự kiện, bài học sau phiên làm việc, liên kết hồ sơ dự án BIM, tra cứu ngữ nghĩa không suy giảm theo thời gian.
- **Kỹ năng đại diện**: `hindsight-bim-mcp`, `hindsight-ky-uc-phan-tang`, `sync-memory-bank`, `workspace-auto-brain`.

### Tầng 5: Chuyên ngành & Tự động hoá Kỹ thuật (Domain Execution Layer)
- **Công nghệ cốt lõi**: Revit API (C# .NET), `DomCR/ACadSharp`, `IfcOpenShell`, `CadQuery`, Chandra OCR, Apache Superset.
- **Nhiệm vụ**: Tự động kết nối MEP (ống gió, ống nước, máng cáp), bóc tách khối lượng (QTO), trích xuất bản vẽ CAD, phân tích dữ liệu công trường.
- **Kỹ năng đại diện**: `acadsharp-cad-reader`, `auto-connect-mep`, `auto-parallel-pipe`, `lpopenbim-ocr`, `cad-block-extractor`.

---

## 📐 Pha 3: Quy ước & Tiêu chuẩn Phát triển (Convention Detection)

### 1. Quy ước Soạn thảo Obsidian Markdown
- Mọi ghi chú tri thức phải có YAML Frontmatter: `tags`, `nguon`, `cap_nhat`, `cach_do`.
- Sử dụng Wikilinks `[[Tên Note]]` cho tài liệu nội bộ vault; dùng link ngoài `[Text](URL)` cho liên kết web.
- Tận dụng Callout chuẩn: `> [!info]`, `> [!tip]`, `> [!warning]`, `> [!important]`, `> [!danger]`.

### 2. Quy chuẩn Trực quan hoá Obsidian Canvas (theo skill `obsidian-canvas-theme`)
- **Hệ 6 màu ngữ nghĩa bắt buộc**:
  - 🔴 `1` (Đỏ): Deploy / Lỗi link / Việc treo / Điểm tới hạn
  - 🟠 `2` (Cam): QA/QC / Kiểm tra link / Báo cáo audit
  - 🟡 `3` (Vàng): Kiến trúc / Cấu hình / Router / Onboarding Guide
  - 🟢 `4` (Xanh lá): Dữ liệu / CAD / Trang con / OCR
  - 🔵 `5` (Xanh lơ): Core / Primary / HUB Trung tâm / Jev Ecosystem
  - 🟣 `6` (Tím): Tiện ích / Lưu trữ / Media / Vault Files
- **Đường nối thẳng tuyệt đối (Straight Arrows)**: Cùng tọa độ Y tâm cho mũi tên ngang; cùng tọa độ X tâm cho mũi tên dọc.
- **Lưới căn chỉnh**: Toạ độ và kích thước node là bội số của **20px** (Snap to grid). Khoảng cách node tối thiểu **40px**.

### 3. Quy chuẩn An toàn & Hợp đồng Tác vụ
- Khi thực thi Computer Use đa bước: Phải hiển thị Checklist Tracking trước khi gọi tool.
- Trạng thái chuẩn: `pending · in_progress · blocked · in_review · completed · cancelled`.
- Kiểm tra postcondition sau mỗi hành động, không dựa vào tự báo cáo.

---

## 🚀 Pha 4: Thao tác Thường gặp (Common Tasks & Cheatsheet)

| Nhu cầu công việc | File / Nơi cần xem | Lệnh hoặc Thao tác |
|---|---|---|
| Tìm repo / skill AI mới | [[HUB-Repo-Skill]] | Tra bảng 75+ repo theo danh mục |
| Kiểm tra dấu trang Chrome | [[HUB-Bookmark-Sync-2026-09-23]] | Xem 167 link phân bố 9 thư mục |
| Xem bản đồ tư duy đồ hoạ | [[HUB-AI.canvas]] | Mở trong Obsidian có theme neon glow |
| Mở mindmap tương tác web | `HUB-AI-MindMap.html` | Bấm đôi mở trên Chrome / Edge |
| Xem danh sách trang con Notion | [[HUB-Trang-con]] | 26 trang con nhóm theo chuyên mục |
| Lập trình tự động hoá Revit | `D:/61.SetupAgent/.agents/skills/` | Tìm các skill tiền tố `auto-*` hoặc `revit-*` |
| Định tuyến mô hình qua Jev | `~/.agents/skills/jev-model-routing` | Chạy Jev System One phân luồng |
| Tra cứu bộ nhớ Hindsight | MCP tool `bim_recall` | Gọi query qua port 8888 |

---

*(Biên soạn ngày 23/09/2026 — Đồng bộ chuẩn hoá theo chỉ đạo kiến trúc LPOpenBIM)*