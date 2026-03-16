---
title: App Builder
tags:
  - skill
  - architecture
  - full-stack
  - scaffolding
parent: "[[Agent-Skills]]"
skill-folder: app-builder
group: Architecture & Planning
aliases:
  - App Builder Skill
---

# 🏗️ App Builder

> [!abstract] Mục đích
> Skill chính để tạo ứng dụng full-stack từ mô tả ngôn ngữ tự nhiên. Orchestrator cho quá trình build app — xác định project type, chọn tech stack, phối hợp các agents.

## Khi nào dùng

- User nói "build", "create app", "tạo project mới"
- Request type = **COMPLEX CODE** hoặc **DESIGN/UI**
- Cần scaffolding toàn bộ project structure

## Cách hoạt động

```
User Request → App Builder analyzes:
  1. Project Type Detection (web, mobile, API, game)
  2. Tech Stack Selection (Next.js, Vite, React Native...)
  3. Agent Routing (frontend-specialist, backend-specialist...)
  4. Scaffold Generation (folder structure, configs, base code)
  5. Skill Chaining (load relevant skills for each step)
```

## Kết hợp với Skills khác

| Skill | Vai trò |
|-------|---------|
| `brainstorming` | Socratic Gate trước khi build |
| `architecture` | System design decisions |
| `frontend-design` | UI/UX nếu có giao diện |
| `database-design` | Schema nếu có database |
| `deployment-procedures` | Deploy sau khi build xong |

## Agents liên quan

- [[Orchestrator]] — điều phối quá trình build
- [[Frontend Specialist]] — xử lý UI components
- [[Backend Specialist]] — xử lý API/server

## Key Rules

1. **Luôn chạy Socratic Gate trước** — hỏi Purpose, Users, Scope
2. **Tạo `task-slug.md`** cho mọi complex build
3. **Không skip testing** — testing-patterns skill phải được load

## Links

- [[Agent-Skills|← Skills Index]]
- [[Architecture|🏛️ Architecture Skill]]
- [[Brainstorming|🧠 Brainstorming Skill]]
