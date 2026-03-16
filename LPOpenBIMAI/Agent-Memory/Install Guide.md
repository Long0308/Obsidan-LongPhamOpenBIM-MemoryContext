---
title: Install Guide
tags:
  - memory
  - setup
  - guide
aliases:
  - Installation Guide
  - Auto-Memory Setup
---

# ⚡ Install Guide — Auto-Memory Kit

> Hướng dẫn cài đặt toàn bộ hệ thống Auto-Memory vào workspace mới.

## Quick Install

```powershell
# 1. Clone
git clone https://github.com/Long0308/Obsidan-LongPhamOpenBIM-MemoryContext.git
cd Obsidan-LongPhamOpenBIM-MemoryContext

# 2. Chọn 1 trong 3 cách
./install.ps1 -WorkspacePath "D:\YourWorkspace"          # Local workspace
./install.ps1 -WorkspacePath "D:\YourObsidian" -Global   # Global (all projects)
./install.ps1 -VaultOnly -WorkspacePath "D:\YourObsidian" # Vault only
```

## Install Script làm gì?

| Bước | Hành động | Kết quả |
|------|-----------|---------|
| **1/4** | Copy Obsidian vault | `vault/LPOpenBIMAI/` → workspace |
| **2/4** | Install SKILL.md | `.agent/skills/auto-memory/` (local) hoặc `~/.agents/skills/` (global) |
| **3/4** | Copy memory-config | `LPOpenBIMAI/Agent-Memory/memory-config.md` |
| **4/4** | Verify | Check 6 critical files tồn tại |

## Modes

### Local Install (default)
```powershell
./install.ps1 -WorkspacePath "D:\MyProject"
```
- SKILL.md → `.agent/skills/auto-memory/SKILL.md`
- Chỉ hoạt động trong workspace đó

### Global Install
```powershell
./install.ps1 -WorkspacePath "D:\MyProject" -Global
```
- SKILL.md → `~/.agents/skills/auto-memory/SKILL.md`
- Hoạt động trong MỌI workspace

### Vault Only
```powershell
./install.ps1 -VaultOnly -WorkspacePath "D:\MyObsidian"
```
- Chỉ copy Obsidian vault (20 agents, 58 skills, 15 plugins)
- Không cài SKILL.md (dùng khi chỉ cần vault reference)

## Sau khi cài

1. **Mở Obsidian** → Open vault `LPOpenBIMAI/`
2. **Mở IDE** (Antigravity, Cursor, etc.) → mở workspace
3. **Bắt đầu làm việc** — agent tự động:
   - Load 5 sessions gần nhất
   - Init session mới
   - Monitor context window
   - Auto-save khi cần

## Setup Backend Riêng (Optional)

> Nếu muốn dùng InsForge backend riêng thay vì shared.

1. Tạo InsForge account + project tại [insforge.dev](https://insforge.dev)
2. Link project: `npx @insforge/cli link --project-id YOUR_ID`
3. Chạy schema: `schema/setup.sql`
4. Deploy edge function: `insforge/functions/mem-gw-final/index.ts`
5. Add secrets: `GITHUB_PAT`, `GITHUB_OWNER`, `GITHUB_REPO`
6. Update URLs trong SKILL.md + memory-config.md

👉 Chi tiết: [[E2E-Setup-Guide]]

## Kiểm tra cài đặt

```powershell
# Test health endpoint
Invoke-RestMethod "https://4ian5xm8.functions.insforge.app/mem-gw-final/health"
# → {status: "ok", v: "2.2", memories: 56}
```

## Cấu trúc khi cài xong

```
YourWorkspace/
├── .agent/skills/auto-memory/SKILL.md    ← Protocol
├── LPOpenBIMAI/                          ← Obsidian vault
│   ├── Agent-Agents/ (20 agents)
│   ├── Agent-Skills/ (58 skills)
│   ├── Agent-Plugins/ (15 plugins)
│   ├── Agent-Memory/ (config + sessions)
│   ├── Platforms/ (hub notes)
│   └── Resources/ (reference)
└── (IDE workspace files)
```

## Links

- [[Agent-Memory|← Memory System]]
- [[E2E-Setup-Guide|E2E Guide]]
- [[Auto Memory|Auto-Memory Skill]]
- [[Edge Function v2.2|Edge Function]]
