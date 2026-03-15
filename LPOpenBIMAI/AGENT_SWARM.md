---
title: Agent Swarm MOC
tags:
  - agent
  - moc
  - swarm
aliases:
  - AGENT_SWARM
  - Agent Swarm
---

# 🤖 Agent Swarm — Map of Content

> **Antigravity Kit** + **58 skills** + **20 agents** + **Memory Gateway** + **OpenSpec**

## 📂 Index Notes

| Index | Nội dung | Items |
|-------|---------|-------|
| [[Agent-Agents]] | Danh sách 20 specialist agents | 20 agents |
| [[Agent-Skills]] | Danh sách 58 skills | 58 skills |
| [[Agent-Memory]] | Memory system config & sessions | 10+ files |
| [[Agent-Plugins]] | Obsidian plugins | 15 plugins |

## Hệ Thống Platform

```mermaid
graph TB
    MOC["🤖 AGENT_SWARM"]

    subgraph "🚀 Antigravity Kit"
        AK["Antigravity Kit"]
        AK --> SP["🧠 Superpowers"]
        AK --> OS["📋 OpenSpec"]
        AK --> IF["⚡ InsForge"]
        AK --> OT["📝 Obsidian Tools"]
        AK --> UD["🎨 UI Design"]
    end

    subgraph "🧠 Superpowers"
        BS["Brainstorm"] --> WP["Write Plan"]
        WP --> EP["Execute"]
        EP --> VR["Verify"]
        VR --> FN["Ship"]
    end

    subgraph "📋 OpenSpec"
        EX["Explore"] --> PR["Propose"]
        PR --> AP["Apply"]
        AP --> AR["Archive"]
    end

    subgraph "⚡ InsForge"
        DB["Database"]
        FN2["Edge Functions"]
        MEM["Auto Memory"]
    end

    MOC --> AK
```

## 🏗️ Platforms (Hub Navigation)

| # | Platform | Skills | Mô tả |
|---|----------|--------|--------|
| 1 | [[Antigravity Kit]] | 58 + 20 agents | 🚀 Agent scaffold — trung tâm hệ thống |
| 2 | [[Superpowers Hub]] | 13 | 🧠 Dev workflow: brainstorm → plan → execute → ship |
| 3 | [[OpenSpec Hub]] | 4 | 📋 Spec-driven: explore → propose → apply → archive |
| 4 | [[InsForge Hub]] | 4 | ⚡ Backend: DB + Auth + Storage + AI + Functions |
| 5 | [[Obsidian Tools Hub]] | 5 | 📝 Vault: markdown, canvas, CLI, bases |
| 6 | [[UI Design Hub]] | 18 | 🎨 Design + Tech + Security + Quality skills |

## 📊 Skill Roster (58 skills)

### 🧠 Superpowers (Dev Workflow)

| # | Skill | Trigger |
|---|-------|---------|
| 1 | [[Brainstorming]] | "brainstorm", "nghĩ idea" |
| 2 | [[Writing Plans]] | "viết plan" |
| 3 | [[Executing Plans]] | "chạy plan" |
| 4 | [[Subagent Driven Dev]] | "chia task" |
| 5 | [[Dispatching Parallel Agents]] | "chạy song song" |
| 6 | [[Requesting Code Review]] | "review code" |
| 7 | [[Receiving Code Review]] | — |
| 8 | [[Test Driven Development]] | "viết test" |
| 9 | [[TDD Workflow]] | "TDD" |
| 10 | [[Systematic Debugging]] | "debug", "fix lỗi" |
| 11 | [[Verification]] | "verify" |
| 12 | [[Finishing Dev Branch]] | "merge", "PR" |
| 13 | [[Git Worktrees]] | "worktree" |

### 📋 OpenSpec (Spec-Driven)

| # | Skill | Command |
|---|-------|---------|
| 14 | [[OpenSpec Explore]] | `/opsx:explore` |
| 15 | [[OpenSpec Propose]] | `/opsx:propose` |
| 16 | [[OpenSpec Apply Change]] | `/opsx:apply` |
| 17 | [[OpenSpec Archive Change]] | `/opsx:archive` |

### 📝 Obsidian Tools

| # | Skill | Trigger |
|---|-------|---------|
| 18 | [[Obsidian Markdown]] | "viết note" |
| 19 | [[Obsidian Bases]] | "tạo view" |
| 20 | [[JSON Canvas]] | "tạo canvas" |
| 21 | [[Obsidian CLI]] | — |
| 22 | [[Defuddle]] | "lấy web" |

### 🎨 Design & Frontend

| # | Skill | Trigger |
|---|-------|---------|
| 23 | [[UI-UX Pro Max]] | "design", "UI/UX" |
| 24 | [[Stitch Loop]] | "build UI" |
| 25 | [[Frontend Design]] | "thiết kế web" |
| 26 | [[Mobile Design]] | "thiết kế mobile" |
| 27 | [[Tailwind Patterns]] | "tailwind" |
| 28 | [[React Best Practices]] | "react", "next.js" |
| 29 | [[i18n Localization]] | "i18n", "translation" |
| 30 | [[Web Design Guidelines]] | "review UI", "accessibility" |

### ⚙️ Backend & Infra

| # | Skill | Trigger |
|---|-------|---------|
| 31 | [[Auto Memory]] | auto |
| 32 | [[Database Design]] | "database" |
| 33 | [[API Patterns]] | "API" |
| 34 | [[Node.js Best Practices]] | "node" |
| 35 | [[Python Patterns]] | "python" |
| 36 | [[Rust Pro]] | "rust" |
| 37 | [[MCP Builder]] | "MCP" |
| 38 | [[Server Management]] | "server" |
| 39 | [[Deployment Procedures]] | "deploy" |
| 40 | [[InsForge SDK]] | "@insforge/sdk" |
| 41 | [[InsForge CLI]] | "insforge-cli" |

### 🛡️ Security & Quality

| # | Skill | Trigger |
|---|-------|---------|
| 42 | [[Vulnerability Scanner]] | "security scan" |
| 43 | [[Red Team Tactics]] | "red team" |
| 44 | [[Testing Patterns]] | "testing" |
| 45 | [[Webapp Testing]] | "E2E test" |
| 46 | [[Performance Profiling]] | "performance" |
| 47 | [[Code Review Checklist]] | "checklist" |

### 📖 Meta Skills

| # | Skill | Trigger |
|---|-------|---------|
| 48 | [[Using Superpowers]] | — |
| 49 | [[Writing Skills]] | "tạo skill" |
| 50 | [[Behavioral Modes]] | — |
| 51 | [[Clean Code]] | — |
| 52 | [[Game Development]] | "game" |
| 53 | [[Bash Linux]] | "bash", "linux" |
| 54 | [[PowerShell Windows]] | "powershell" |

### 📖 Additional Skills

| # | Skill | Trigger |
|---|-------|---------|
| 55 | [[Architecture]] | "architecture" |
| 56 | [[SEO Fundamentals]] | "SEO" |
| 57 | [[GEO Fundamentals]] | "GEO", "AI search" |
| 58 | [[Documentation Templates]] | "docs" |

## Memory Gateway

| Lớp | Backend | Trạng thái |
|-----|---------|-----------| 
| InsForge | PostgreSQL + Edge Functions | 🟢 Primary |
| Supabase | Remote Postgres | 🟡 Backup |
| SQLite | Local `agent.db` | 🟢 Offline |

## MCP Servers

| Server | Vai trò |
|--------|--------|
| obsidian-mcp | Read/write notes, search, tags |
| supabase-mcp | Database + Edge Functions |
| github-mcp | Git + PR + Issues |
| firecrawl-mcp | Web scraping + search |
| mcp-server-for-revit | BIM automation |
| stitch-mcp | UI generation |

## 📚 Resources

| # | Note | Nội dung |
|---|------|---------|
| 1 | [[AI Agent Resources]] | System prompts, OpenAI cookbook, LLM apps |
| 2 | [[Prompt & AI Image Library]] | Nano Banana Pro, AI image prompts |
| 3 | [[UI-UX Design Resources]] | Dribbble, Stitch, components, themes |
| 4 | [[Antigravity Kit Resources]] | ag-kit, Superpowers, InsForge repos |
| 5 | [[Claude Skills Resources]] | Claude skills, best practices |
| 6 | [[SaaS Planning Workflow]] | Production SaaS methodology |
| 7 | [[OpenSpec Integration]] | CLI reference & setup guide |
| 8 | [[Memory Types trong Agentic Systems]] | Memory architecture (Episodic/Semantic/Procedural) |
| 9 | [[Context Hub Analysis]] | Andrew Ng context-hub patterns for agents |

## Links

- [[Agent-Agents|🤖 Agents Index]] — 20 specialist agents
- [[Agent-Skills|🧩 Skills Index]] — 58 skills
- [[Agent-Memory|🧠 Memory Index]] — Memory system
- [[Agent-Plugins|🔌 Plugins Index]] — 15 plugins
- [[E2E-Guide|📘 Hướng Dẫn E2E]]
- [[Memory-Graph.canvas|🧠 Memory Graph]]
- [[Agent-Swarm.canvas|🗺️ Skill Map]]
- [[Vault Dashboard|📊 Vault Dashboard]] — Base views: table, cards, filters
- [[GEMINI Rules]] — AI agent rules & checkpoint protocol
- [[Gemini Artifacts]] — Brain artifacts & memory flow
