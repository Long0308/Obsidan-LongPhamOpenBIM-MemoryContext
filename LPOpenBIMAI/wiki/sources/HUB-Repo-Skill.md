---
tags: [hub, ai, github, skill, chi-muc, bookmark, jev, bim]
nguon: Notion HUB Tài liệu AI, Chrome Bookmarks (01-AI, 03-OCR, 04-BIM, 05-MCP, 06-Router), CUA Browser State
cap_nhat: 2026-09-23
cach_do: GitHub API qua gh CLI + Chrome Bookmarks Inspector + CUA REPL Inventory
---

# Repo & Skill trong HUB AI (Đồng bộ 2026-09-23)

Bảng chỉ mục tổng hợp toàn bộ các repo, agent skill và công cụ lập trình cốt lõi được đồng bộ từ:
1. **Notion HUB - Tài liệu AI** (Mục 1, 7, 8, 9, 12)
2. **Chrome Bookmarks** (`01-AI`, `03-OCR`, `04-BIM Revit`, `05-MCP`, `06-Router`)
3. **CUA Browser State & Tab đang mở** (`awesome-jev`, `litellm`, `SemIf`, `jev-ultrafast`, `fast-jev-compaction`, `jev-codex-router`, `treg`)
4. **40 User Skills** (`~/.agents/skills`) & **485 Workspace Skills** (`D:/61.SetupAgent/.agents/skills`)

Về note gốc: [[HUB-Tai-lieu-AI]] · Canvas trực quan: [[HUB-AI.canvas]] · Báo cáo đồng bộ: [[HUB-Bookmark-Sync-2026-09-23]] · Hướng dẫn Onboarding: [[HUB-Onboarding-Guide]]

---

## ⚡ 1. Hệ sinh thái Jev & TypeSafe (System One, Model Routing, UltraFast)

Các repo và skill thuộc kiến trúc Jev — ra quyết định nhanh tầng 1 (System 1), nén ngữ cảnh và điều hướng mô hình:

| Repo / Nguồn | Loại | Dùng để làm gì & Skill tương ứng |
|---|---|---|
| [heyjunpenn/awesome-jev](https://github.com/heyjunpenn/awesome-jev) | Catalog | Danh mục 640+ dự án mã nguồn mở xây dựng với Jev. Nguồn tra cứu kiến trúc Jev tổng thể. |
| [0xNatoshi/jev-codex-router](https://github.com/0xNatoshi/jev-codex-router) | Repo / Router | Điều phối model và reasoning depth theo từng turn cho Codex qua Jev. Tương ứng: skill `jev-model-routing`. |
| [tamaratran/fast-jev-compaction](https://github.com/tamaratran/fast-jev-compaction) | Plugin / Compaction | Plugin Claude Code nén context: chấm điểm tool call/result, loại bỏ dữ liệu thô cũ, giữ nguyên prompt. Tương ứng: skill `jev-fast-compacttion`, `jev-compaction`. |
| [browser-use/jev-ultrafast](https://github.com/browser-use/jev-ultrafast) | Harness / Web | Web agent nhanh nhất và rẻ nhất, tối ưu token bằng Jev. Tương ứng: skill `jev-ultrafast`, `jev-browser-use`. |
| [kerpopule/hermes-jev-skills](https://github.com/kerpopule/hermes-jev-skills) | Skill Suite | Bộ skill Jev cho Hermes Agent, Claude Code và Codex: model routing, memory, compaction, computer use. |
| [superdesigndev/treg](https://github.com/superdesigndev/treg) | Proxy / Tool Gateway | OpenRouter dành riêng cho agent tools, định tuyến gọi công cụ thông minh. |
| [TheoLeeCJ/SemIf](https://github.com/TheoLeeCJ/SemIf) | Engine | Semantic Ifs từ mô hình mã nguồn mở chạy local (RTX 3090), rẽ nhánh logic tự nhiên không phụ thuộc cloud API. |
| [TypeSafe Console](https://console.typesafe.ai/keys) | Dashboard / API | Quản trị key và hạn ngạch TypeSafe AI System One. Tương ứng: skill `typesafe-ai`, `jev-computer`. |

> [!tip] Danh sách 16 Skill Jev đang cài tại `~/.agents/skills`
> `jev-browser-use` · `jev-compaction` · `jev-computer` · `jev-computer-use` · `jev-fast-compacttion` · `jev-fit-audit` · `jev-frontier-work` · `jev-mailbox` · `jev-memory` · `jev-model-routing` · `jev-search` · `jev-setup` · `jev-skill-select` · `jev-starter` · `jev-ultrafast` · `typesafe-ai`.

---

## 🧱 2. Nền tảng Skill & Agent Best Practice

Các tiêu chuẩn thiết kế agent, quy trình kỹ thuật và best practice hàng đầu:

| Danh mục | Repo / Nguồn | ⭐ | Dùng để làm gì |
|---|---|---|---|
| Nền tảng | [obra/superpowers](https://github.com/obra/superpowers) | 282.477 | Quy trình phát triển phần mềm cho agent: Spec → Plan → TDD → Review. |
| Nền tảng | [mattpocock/skills](https://github.com/mattpocock/skills) | 254.576 | Kỹ năng coding thực tế từ workflow kỹ sư phần mềm chuyên nghiệp. |
| Nền tảng | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | 210.607 | Nguyên tắc coding của Andrej Karpathy: suy nghĩ trước, viết code đơn giản. |
| Nền tảng | [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | 210.607 | Bản cập nhật CLAUDE.md cải thiện hành vi Claude Code theo quan sát của Karpathy. |
| Nền tảng | [anthropics/skills](https://github.com/anthropics/skills) | 174.864 | Skills chính thức từ Anthropic cho tài liệu, dữ liệu và thiết kế. |
| Nền tảng | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 92.586 | Kỹ năng engineering thực chiến từ Addy Osmani (Google). |
| Quy trình | [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) | 65.687 | Chuyển từ vibe coding sang agentic engineering; chuẩn hoá quy trình prompt. |
| Quy trình | [robonuggets/gauntlet-loop](https://github.com/robonuggets/gauntlet-loop) | 829 | Agent tự đặt tiêu chuẩn chất lượng (bar), chạy cặp builder/critic lặp đến khi đạt. |
| Gọn output | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | 103.941 | Trả lời súc tích, tiết kiệm ~65% token prompt/completion. |
| Gọn output | [tech-leads-club/agent-skills](https://github.com/tech-leads-club/agent-skills) | 5.141 | Output ngắn gọn, dễ quét mắt, giảm phân tán tư duy. |
| Chất lượng code | [dmmulroy/anti-slop](https://www.skills.sh/dmmulroy/anti-slop) | — | Chống sinh code rác, chống boiler-plate thừa, giữ mã nguồn tinh giản. |
| Multi-Agent | [We0 Claude Opus 5 Gauntlet Loop](https://we0.ai/articles/claude-opus-5-s-gauntlet-loop) | — | Bài phân tích vòng lặp Gauntlet Loop dựng game trên trình duyệt bằng đa agent. |

---

## 🏗️ 3. CAD, CAE, 3D & BIM Engineering

Nhóm công cụ tự động hoá mô hình BIM (Revit), đọc/ghi CAD hình học và kết nối dữ liệu MEP:

| Lĩnh vực | Repo / Nguồn | ⭐ | Dùng để làm gì |
|---|---|---|---|
| CAD Skill | [flowful-ai/cad-skill](https://github.com/flowful-ai/cad-skill) | — | Claude Code skill sinh mô hình 3D in được bằng CadQuery tham số hoá. |
| CAD Skill | [earthtojake/text-to-cad](https://github.com/earthtojake/text-to-cad) | — | Thư viện agent skills toàn diện cho CAD, CAE và CAM. |
| CAD Engine | [DomCR/ACadSharp](https://github.com/DomCR/ACadSharp) | 847 | Thư viện C# đọc/ghi DWG & DXF trực tiếp, bỏ bước gọi DwgTextExtract.exe. |
| Revit Tool | [NeVeSpl/RevitDBExplorer](https://github.com/NeVeSpl/RevitDBExplorer) | — | Khám phá database Revit trực quan: soi thông số element, parameter, relationship. |
| Revit 3D UI | [ViewSuSu/Su.Revit.HelixToolkit.SharpDX](https://github.com/ViewSuSu/Su.Revit.HelixToolkit.SharpDX) | — | Toolkit hiển thị 3D hiệu năng cao nhúng trực tiếp trong dockable pane Revit bằng SharpDX. |
| Revit Test | [ricaun-io/ricaun.RevitTest](https://github.com/ricaun-io/ricaun.RevitTest) | — | Multi-version NUnit testing framework cho Revit API add-ins. |
| Revit Script | [pyrevitlabs/pyRevit](https://github.com/pyrevitlabs/pyRevit) | — | Môi trường RAD Python cho Autodesk Revit. |
| WebBIM | [xeokit/xeokit-sdk](https://github.com/xeokit/xeokit-sdk) | — | SDK WebGL 3D BIM IFC viewer hiệu năng cao, double precision, chạy trực tiếp trên browser. |
| WebBIM | [opensourceBIM/bimvie.ws](https://github.com/opensourceBIM/bimvie.ws) | — | Trình xem BIM client chạy HTML5/JS theo chuẩn mở IFC, BCF, BIMSie. |
| IFC Engine | [IfcOpenShell/IfcOpenShell](https://github.com/IfcOpenShell/IfcOpenShell) | — | Bộ thư viện mã nguồn mở đọc, ghi và xử lý hình học IFC mạnh mẽ nhất. |
| Revit RAG | [imkcrevit/revit-api-rag](https://github.com/imkcrevit/revit-api-rag) | — | Dự án RAG chuyên sâu cho lập trình Revit API. |
| Revit to IFC | [simonmoreau/RevitToIFC](https://github.com/simonmoreau/RevitToIFC) | — | Web app chuyển đổi Revit file sang IFC tự động. |
| Revit API Ref | [The Building Coder](https://jeremytammik.github.io/tbc/) | — | Kho tri thức chuẩn của Jeremy Tammik: Family API, Cable Tray, GenAI RAG, MCP. |

---

## ⚙️ 4. Agent Harness & Multi-Agent Frameworks

Hạ tầng điều phối agent, sandbox, môi trường thực thi và không gian cộng tác:

| Repo / Nguồn | ⭐ | Dùng để làm gì |
|---|---|---|
| [bytedance/deer-flow](https://github.com/bytedance/deer-flow) | Trendshift | SuperAgent harness chân trời dài (long-horizon) của ByteDance: sandbox, memory, tool, subagent gateway. |
| [deepseek-ai/deepseek-harness](https://github.com/deepseek-ai/deepseek-harness) | — | DeepSeek Harness: kiến trúc Everything is a Plugin cho agent. |
| [Hermes Agent (Nous Research)](https://hermes-agent.nousresearch.com/) | — | Nền tảng agent chuyên sâu của Nous Research, hỗ trợ local model và reasoning loop. |
| [abundantbeing/hermes-browser-extension](https://github.com/abundantbeing/hermes-browser-extension) | — | Side panel native cho trình duyệt kết nối web context vào Hermes runtime cục bộ. |
| [CopilotKit/channels-sdk](https://github.com/CopilotKit/channels-sdk) | — | SDK đưa agent vào Slack, MS Teams, Discord, Telegram với native interactive UI. |
| [CopilotKit/OpenBot](https://github.com/CopilotKit/openbot) | — | AI coworker mã nguồn mở có computer use riêng: browser, files, tools, ghi lại mọi hành động. |
| [block/buzz](https://github.com/block/buzz) | — | Hive mind communication platform cho cộng tác nhóm agent của Block. |
| [MeisnerDan/mission-control](https://github.com/MeisnerDan/mission-control) | — | Hệ thống quản trị task mã nguồn mở cho kỷ nguyên agentic, điều phối công việc uỷ thác. |
| [webadderallorg/Recordly](https://github.com/webadderallorg/Recordly) | — | Quay và tạo video demo chuyên nghiệp tự động cho agent (Mac/Win/Linux). |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | 251.351 | ECC: bộ harness khổng lồ gồm skills, instincts, memory, security hooks. |
| [ultraworkers/claw-code](https://github.com/ultraworkers/claw-code) | 195.189 | Bộ agent quản trị viết bằng Rust, tối ưu hiệu năng và tốc độ thực thi. |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 131.796 | Bộ harness 23 tool của Garry Tan: CEO, Designer, Engineer đóng vai. |
| [vudovn/ag-kit](https://github.com/vudovn/ag-kit) | 8.168 | Kit cấu hình Antigravity cho lập trình viên Việt Nam: rule, skill, workflow, memory. |
| [OpenClaw Control Panel](http://127.0.0.1:18789/agents) | — | Bảng điều khiển phiên agent cục bộ đang chạy tại port 18789. |

---

## 🖥️ 5. Codex, CLI & Model Routers

Công cụ dòng lệnh, gateway định tuyến model và kết nối LLM:

| Repo / Nguồn | ⭐ / Link | Dùng để làm gì |
|---|---|---|
| [donvito/codex-astra-luna-orchestrator](https://github.com/donvito/codex-astra-luna-orchestrator) | — | Điều phối đa agent trong Codex: Astra làm tổng quản (orchestrator), Luna làm subagents thực thi. |
| [miuuyy/codex-chatgpt-web](https://github.com/miuuyy/codex-chatgpt-web) | — | Dùng ChatGPT Web (kể cả Pro) như native model trong Codex có context, tool, stream, không tốn quota API. |
| [teng-lin/notebooklm-py](https://github.com/teng-lin/notebooklm-py) | — | Thư viện Python & skill cho Google Gemini NotebookLM, tương tác với Claude Code, Codex, OpenClaw. |
| [BerriAI/litellm](https://github.com/BerriAI/litellm) | 25.000+ | AI Gateway chuẩn OpenAI format cho 100+ LLM API, load balancing, cost tracking, guardrails. |
| [OpenCode Go](https://opencode.ai/de/go) | — | Nền tảng gói coding model kinh tế cao: GLM, Kimi, DeepSeek, MiMo, MiniMax, Qwen. |
| [Codex Router Local](http://127.0.0.1:4400/) | — | Router proxy cục bộ port 4400 và dashboard Tailscale 8444/8445 chia key theo vai. |

---

## 🧠 6. Memory, Second Brain & Tri thức Bền vững

Kiến trúc bộ nhớ ngoài, knowledge graph và liên kết ngữ nghĩa:

| Repo / Nguồn | ⭐ | Dùng để làm gì |
|---|---|---|
| [vectorize-io/hindsight](https://github.com/vectorize-io/hindsight) | 22.772 | Bộ nhớ agent tự học từ các phiên trước qua bank tri thức. Đang phục vụ tại port 8888 (skill `hindsight-bim-mcp`). |
| [mem0ai/mem0](https://github.com/mem0ai/mem0) | 28.000+ | Tầng bộ nhớ phổ quát (Universal memory layer) cho AI Agents. |
| [LightRAG](https://lightrag.github.io/) | — | Đồ thị RAG nhẹ, liên kết văn bản theo thực thể và quan hệ nhanh chóng. |
| [andrewyng/context-hub](https://github.com/andrewyng/context-hub) | 13.963 | Kho tài liệu markdown có phiên bản cho agent tra cứu qua CLI `chub`. |
| [epwalsh/obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) | 6.180 | Quản lý vault Obsidian trực tiếp từ Neovim. |
| [Claude 4.5 Opus Soul Document](https://gist.github.com/Richard-Weiss/efe157692991535403bd7e7fb20b6695) | Gist | Soul document quy định bản sắc, tư duy và định hướng hành động của model agent. |

---

## 🎨 7. Thiết kế UI/UX, Component & Media Design

Thư viện thiết kế, hiệu ứng động, component web và tạo media AI:

| Repo / Nguồn | ⭐ / Link | Dùng để làm gì |
|---|---|---|
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | 125.529 | UI/UX chuyên nghiệp cho web và mobile. Tương ứng: skill `ui-ux-pro-max`. |
| [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | 114.458 | Bộ DESIGN.md của các brand lớn, định hình design system cho agent. |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | 84.882 | Giúp sản phẩm AI tạo ra có gu thẩm mỹ cao, không bị generic. |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | 35.901 | Bộ skill thiết kế của Emil Kowalski: `emil-design-eng`, `review-animations`, `animation-vocabulary`, `apple-design`. |
| [MengTo/threeui](https://github.com/MengTo/threeui) | 5.259 | Thư viện 3D UI component tương tác với Three.js của Design+Code. |
| [MengTo/sylva](https://github.com/MengTo/sylva) | — | Nghiên cứu cảnh quan Three.js tương tác với con trỏ. |
| [remotion-dev/skills](https://github.com/remotion-dev/skills) | — | Bộ agent skills chính thức tạo video lập trình với Remotion React. |
| [freestylefly/awesome-gpt-image-2](https://github.com/freestylefly/awesome-gpt-image-2) | 28.351 | Hơn 530 mẫu prompt tạo ảnh chuẩn công nghiệp đóng gói thành skills. |
| [comfy-org/comfyui](https://github.com/comfy-org/comfyui) | 55.000+ | Backend tạo ảnh và video modular mạnh nhất qua giao diện node/graph. |

---

## 📊 8. Data, Dashboard, Tài liệu & OCR

Các công cụ phân tích dữ liệu, render đồ thị và trích xuất tài liệu kỹ thuật:

| Repo / Nguồn | ⭐ / Link | Dùng để làm gì |
|---|---|---|
| [apache/echarts](https://github.com/apache/echarts) | 60.000+ | Thư viện trực quan hoá dữ liệu và biểu đồ tương tác số 1 trên web. |
| [microsoft/markitdown](https://github.com/microsoft/markitdown) | 30.000+ | Công cụ Python của Microsoft chuyển đổi tệp Office, PDF sang Markdown chuẩn. |
| [Stirling-Tools/Stirling-PDF](https://github.com/Stirling-Tools/Stirling-PDF) | 45.000+ | Ứng dụng xử lý PDF mã nguồn mở #1 trên GitHub. |
| [datalab-to/surya](https://github.com/datalab-to/surya) | — | OCR đa ngôn ngữ, phân tích layout tài liệu kỹ thuật và phát hiện bảng biểu. |
| [Chandra OCR Local](http://localhost:8000/docs) | Local | Hệ thống OCR Chandra trích xuất hồ sơ nghiệm thu, PCCC đang chạy local. |

---

## 🔌 9. MCP Servers & Protocol

Các MCP server kết nối máy tính và công cụ ngoại vi vào Agent:

| Repo / Nguồn | Loại | Dùng để làm gì |
|---|---|---|
| [duty1g/x64dbg-mcp-server](https://github.com/duty1g/x64dbg-mcp-server) | MCP Server | MCP server viết bằng Zig cho x64dbg: debug, đặt breakpoint, đọc memory trực tiếp. |
| [Filesystem MCP Server (Glama)](https://glama.ai/mcp/servers/@modelcontextprotocol/filesystem) | MCP Server | Giao thức thao tác tệp tin an toàn qua MCP. |
| [Apache Superset MCP Service](https://preset.io/blog/superset-mcp-service-deep-dive/) | MCP Server | Truy vấn dữ liệu và biểu đồ từ Superset qua AI Agent. |
| [Brave Search API](https://api-dashboard.search.brave.com/) | Web Search | API tìm kiếm web độc lập bảo vệ quyền riêng tư cho agent. |

---

## ⚠️ 10. Danh mục cảnh báo & Bảo trì link

- `vudovn/antigravity-kit` đã đổi tên thành `vudovn/ag-kit`, link cũ chỉ sống nhờ chuyển hướng.
- `NoeFabris/opencode-antigravity-auth` đã archived, muốn dùng lâu dài cần fork.
- `andrewyng/context-hub` sao cao nhưng ba tháng không đẩy commit mới.
- `appmotion.design` đã chết (404, trang Framer đã dỡ), cần gỡ khỏi mục 3.
- Các link demo `jakubantalik.com` (gooey, beam, orbs) đã chuyển sang `libraries.dev`.