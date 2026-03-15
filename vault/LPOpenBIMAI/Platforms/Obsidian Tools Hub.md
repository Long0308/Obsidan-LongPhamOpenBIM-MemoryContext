---
title: Obsidian Tools Hub
tags:
  - platform
  - obsidian
  - hub
  - tools
cssclasses:
  - hub-note
aliases:
  - Obsidian Tools
---

# 📝 Obsidian Tools — Vault Integration

> Skills cho tương tác với Obsidian vault.

## Skills (5)

| Skill | Mô tả | Trigger |
|-------|--------|---------|
| [[Obsidian Markdown]] | Wikilinks, callouts, frontmatter | "viết note" |
| [[Obsidian Bases]] | Database views, filters | "tạo view" |
| [[JSON Canvas]] | Canvas files | "tạo canvas" |
| [[Obsidian CLI]] | CLI commands | — |
| [[Defuddle]] | Web → clean markdown | "lấy web" |

## Plugins

> 15 plugins trong vault — xem [[Agent-Plugins]]

| Plugin | Vai trò |
|--------|---------|
| [[Lovely Mindmap]] | Mindmap visualization |
| [[Graph Analysis]] | Graph metrics |
| [[Full Calendar]] | Calendar view |
| [[3D Graph]] | 3D graph visualization |
| [[Simple CanvaSearch]] | Canvas search |

## Canvas Files

| Canvas | Mô tả |
|--------|--------|
| [[Agent-Swarm.canvas]] | Skill map visual |
| [[Memory-Graph.canvas]] | Memory system graph |

## 🎯 Coordinator

| Vai trò | Agent | Khi nào |
|---------|-------|---------|
| **Lead** | `explorer-agent` | Vault navigation, file discovery |
| **Content** | `documentation-writer` | Note creation, templates |
| **Quality** | `frontend-specialist` | Canvas layout, visual structure |

> **Routing rule:** `"obsidian"` / `"vault"` / `"note"` / `"canvas"` → `explorer-agent`.
> `"viết note"` / `"tạo doc"` → `documentation-writer`.

## Links

- [[Antigravity Kit|← Antigravity Kit]]
- [[AGENT_SWARM|← Agent Swarm MOC]]
