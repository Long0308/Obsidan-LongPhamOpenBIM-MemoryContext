---
title: Executing Plans
tags:
  - skill
  - superpowers
  - execution
group: Superpowers
role: Thực thi implementation plan đã viết, với review checkpoints
source: .agent/skills/executing-plans/SKILL.md
---

# Executing Plans — Load → Review → Execute

> [!abstract] Vai Trò
> Load plan, review critically, execute all tasks, report khi hoàn tất. Dùng khi KHÔNG có subagent support. Nếu có subagents → dùng [[Subagent Driven Dev]] thay thế.

**Announce:** "I'm using the executing-plans skill to implement this plan."

## Process (3 Steps)

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically — identify questions/concerns
3. Nếu có concerns → raise với human partner trước
4. Nếu OK → Create TodoWrite → proceed

### Step 2: Execute Tasks
Cho mỗi task:
1. Mark as `in_progress`
2. Follow each step exactly (plan có bite-sized steps)
3. Run verifications as specified
4. Mark as `completed`

### Step 3: Complete Development
Sau khi all tasks done:
- Announce: "I'm using the finishing-a-development-branch skill"
- **REQUIRED:** → [[Finishing Dev Branch]]
- Verify tests → present options → execute choice

## Khi Nào STOP

> [!warning] STOP ngay khi:
> - Hit blocker (missing dependency, test fails, instruction unclear)
> - Plan có critical gaps
> - Không hiểu instruction
> - Verification fails repeatedly

**Hỏi clarification thay vì guess.**

## Khi Nào Quay Lại

Return to Review (Step 1) khi:
- Partner updates plan based on feedback
- Fundamental approach cần rethink

## Rules

- Review plan critically FIRST
- Follow plan steps EXACTLY
- Không skip verifications
- Reference skills khi plan yêu cầu
- Stop when blocked, don't guess
- NEVER start implementation trên main/master mà không có explicit user consent

## Required Workflow Skills

| Skill | Vai trò |
|-------|---------|
| [[Git Worktrees]] | REQUIRED: Set up isolated workspace trước |
| [[Writing Plans]] | Tạo plan mà skill này execute |
| [[Finishing Dev Branch]] | Complete development sau all tasks |

## Connections
- **Input from:** [[Writing Plans]]
- **Alternative:** [[Subagent Driven Dev]] (nếu có subagents)
- **Flows to:** [[Finishing Dev Branch]]

## Nhóm
Superpowers | Xem thêm tại [[AGENT_SWARM|Agent Swarm MOC]]
