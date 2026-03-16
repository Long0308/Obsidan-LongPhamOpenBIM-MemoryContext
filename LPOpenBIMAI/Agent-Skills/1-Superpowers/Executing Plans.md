---
title: Executing Plans
tags:
  - agent-skill
  - skill
  - superpowers
  - execution
group: Superpowers
role: Thá»±c thi implementation plan Ä‘Ã£ viáº¿t, vá»›i review checkpoints
source: .agent/skills/executing-plans/SKILL.md
---

# Executing Plans â€” Load â†’ Review â†’ Execute

> [!abstract] Vai TrÃ²
> Load plan, review critically, execute all tasks, report khi hoÃ n táº¥t. DÃ¹ng khi KHÃ”NG cÃ³ subagent support. Náº¿u cÃ³ subagents â†’ dÃ¹ng [[Subagent Driven Dev]] thay tháº¿.

**Announce:** "I'm using the executing-plans skill to implement this plan."

## Process (3 Steps)

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically â€” identify questions/concerns
3. Náº¿u cÃ³ concerns â†’ raise vá»›i human partner trÆ°á»›c
4. Náº¿u OK â†’ Create TodoWrite â†’ proceed

### Step 2: Execute Tasks
Cho má»—i task:
1. Mark as `in_progress`
2. Follow each step exactly (plan cÃ³ bite-sized steps)
3. Run verifications as specified
4. Mark as `completed`

### Step 3: Complete Development
Sau khi all tasks done:
- Announce: "I'm using the finishing-a-development-branch skill"
- **REQUIRED:** â†’ [[Finishing Dev Branch]]
- Verify tests â†’ present options â†’ execute choice

## Khi NÃ o STOP

> [!warning] STOP ngay khi:
> - Hit blocker (missing dependency, test fails, instruction unclear)
> - Plan cÃ³ critical gaps
> - KhÃ´ng hiá»ƒu instruction
> - Verification fails repeatedly

**Há»i clarification thay vÃ¬ guess.**

## Khi NÃ o Quay Láº¡i

Return to Review (Step 1) khi:
- Partner updates plan based on feedback
- Fundamental approach cáº§n rethink

## Rules

- Review plan critically FIRST
- Follow plan steps EXACTLY
- KhÃ´ng skip verifications
- Reference skills khi plan yÃªu cáº§u
- Stop when blocked, don't guess
- NEVER start implementation trÃªn main/master mÃ  khÃ´ng cÃ³ explicit user consent

## Required Workflow Skills

| Skill | Vai trÃ² |
|-------|---------|
| [[Git Worktrees]] | REQUIRED: Set up isolated workspace trÆ°á»›c |
| [[Writing Plans]] | Táº¡o plan mÃ  skill nÃ y execute |
| [[Finishing Dev Branch]] | Complete development sau all tasks |

## Connections
- **Input from:** [[Writing Plans]]
- **Alternative:** [[Subagent Driven Dev]] (náº¿u cÃ³ subagents)
- **Flows to:** [[Finishing Dev Branch]]

## NhÃ³m
Superpowers | Xem thÃªm táº¡i [[AGENT_SWARM|Agent Swarm MOC]]
