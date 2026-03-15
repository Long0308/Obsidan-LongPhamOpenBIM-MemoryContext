# Create Agent-Agents folder and generate Obsidian notes
$agentDir = "D:\10.Obsidan\LPOpenBIMAI\Agent-Agents"
New-Item -ItemType Directory -Path $agentDir -Force | Out-Null

$agents = @{
    "Orchestrator" = @{
        desc = "Multi-agent coordination and task orchestration. Decomposes complex tasks into domain-specific subtasks and coordinates specialized agents."
        skills = @("Clean Code","Dispatching Parallel Agents","Brainstorming","Writing Plans","Architecture")
        icon = "target"
        role = "Master Coordinator"
        slug = "orchestrator"
        triggers = "complex tasks, multi-domain analysis, coordinated execution"
    }
    "Project Planner" = @{
        desc = "4-phase project planning methodology: Analysis, Planning, Solutioning, Implementation. Creates task breakdowns and roadmaps."
        skills = @("Writing Plans","Brainstorming","Architecture")
        icon = "clipboard-list"
        role = "Strategic Planner"
        slug = "project-planner"
        triggers = "plan, roadmap, milestones, task breakdown"
    }
    "Security Auditor" = @{
        desc = "Elite cybersecurity expert. OWASP 2025, supply chain security, zero trust. Think like an attacker, defend like an expert."
        skills = @("Clean Code","Vulnerability Scanner","Red Team Tactics")
        icon = "shield"
        role = "Security Expert"
        slug = "security-auditor"
        triggers = "security, vulnerability, owasp, xss, injection, auth, encrypt"
    }
    "Penetration Tester" = @{
        desc = "Active security testing specialist. Red team tactics, MITRE ATT&CK framework, exploitation and defense validation."
        skills = @("Red Team Tactics","Vulnerability Scanner")
        icon = "crosshair"
        role = "Red Team Specialist"
        slug = "penetration-tester"
        triggers = "pentest, red team, exploit, attack simulation"
    }
    "Backend Specialist" = @{
        desc = "Expert backend architect for Node.js, Python, serverless/edge. API development, DB integration, security-first design."
        skills = @("Clean Code","Node.js Best Practices","Python Patterns","API Patterns","Database Design")
        icon = "server"
        role = "Backend Architect"
        slug = "backend-specialist"
        triggers = "backend, server, api, endpoint, database, auth"
    }
    "Frontend Specialist" = @{
        desc = "Expert frontend architect for React, Next.js. Component design, state management, performance, accessibility."
        skills = @("Clean Code","Frontend Design","React Best Practices","Tailwind Patterns","SEO Fundamentals")
        icon = "palette"
        role = "Frontend Architect"
        slug = "frontend-specialist"
        triggers = "frontend, ui, component, react, next.js, css, design"
    }
    "Mobile Developer" = @{
        desc = "Mobile app specialist for React Native, Flutter, native. Touch interaction, performance, platform conventions."
        skills = @("Clean Code","Mobile Design","Testing Patterns")
        icon = "smartphone"
        role = "Mobile Specialist"
        slug = "mobile-developer"
        triggers = "mobile, ios, android, react native, flutter, expo"
    }
    "Debugger" = @{
        desc = "Systematic debugging expert. Root cause analysis, hypothesis-driven investigation, minimal reproduction strategies."
        skills = @("Clean Code","Systematic Debugging","Testing Patterns")
        icon = "bug"
        role = "Bug Hunter"
        slug = "debugger"
        triggers = "bug, error, crash, debug, unexpected behavior, fix"
    }
    "Game Developer" = @{
        desc = "Game development specialist. Unity, Godot, Unreal, Phaser. Game loops, physics, multiplayer, asset pipelines."
        skills = @("Clean Code","Game Development")
        icon = "gamepad-2"
        role = "Game Architect"
        slug = "game-developer"
        triggers = "game, unity, godot, unreal, phaser, multiplayer"
    }
    "Database Architect" = @{
        desc = "Database design specialist. Schema design, indexing strategy, ORM selection, serverless databases, migrations."
        skills = @("Database Design","Clean Code","API Patterns")
        icon = "database"
        role = "Database Expert"
        slug = "database-architect"
        triggers = "database, schema, migration, prisma, drizzle, sql"
    }
    "DevOps Engineer" = @{
        desc = "Infrastructure and deployment specialist. CI/CD pipelines, containerization, monitoring, scaling strategies."
        skills = @("Deployment Procedures","Server Management","Clean Code")
        icon = "rocket"
        role = "Infrastructure Expert"
        slug = "devops-engineer"
        triggers = "deploy, ci/cd, docker, kubernetes, monitoring, scaling"
    }
    "Performance Optimizer" = @{
        desc = "Performance profiling specialist. Measurement, bottleneck identification, Core Web Vitals, caching strategies."
        skills = @("Performance Profiling","Clean Code")
        icon = "zap"
        role = "Performance Expert"
        slug = "performance-optimizer"
        triggers = "performance, slow, optimize, profiling, bottleneck, caching"
    }
    "Explorer Agent" = @{
        desc = "Codebase discovery specialist. Maps project structure, identifies dependencies, discovers patterns and architecture."
        skills = @("Clean Code","Architecture")
        icon = "compass"
        role = "Code Explorer"
        slug = "explorer-agent"
        triggers = "explore, discover, map, dependencies, structure"
    }
    "Code Archaeologist" = @{
        desc = "Legacy code specialist. Understands old codebases, identifies technical debt, plans modernization strategies."
        skills = @("Clean Code","Architecture")
        icon = "landmark"
        role = "Legacy Expert"
        slug = "code-archaeologist"
        triggers = "legacy, old code, technical debt, modernize, refactor"
    }
    "Documentation Writer" = @{
        desc = "Documentation specialist. README, API docs, code comments, AI-friendly docs. Only invoked on explicit request."
        skills = @("Documentation Templates","Clean Code")
        icon = "file-text"
        role = "Docs Specialist"
        slug = "documentation-writer"
        triggers = "docs, readme, documentation, api docs, comments"
    }
    "Product Manager" = @{
        desc = "Product strategy specialist. User stories, feature prioritization, stakeholder communication, roadmap alignment."
        skills = @("Brainstorming","Writing Plans")
        icon = "bar-chart"
        role = "Product Strategist"
        slug = "product-manager"
        triggers = "product, user story, feature, prioritize, stakeholder"
    }
    "Product Owner" = @{
        desc = "Product ownership specialist. Backlog management, sprint planning, acceptance criteria, user value maximization."
        skills = @("Brainstorming","Writing Plans")
        icon = "list-checks"
        role = "Backlog Manager"
        slug = "product-owner"
        triggers = "backlog, sprint, acceptance criteria, user value"
    }
    "QA Automation Engineer" = @{
        desc = "QA automation specialist. Test automation frameworks, CI integration, regression testing, quality metrics."
        skills = @("Testing Patterns","TDD Workflow","Webapp Testing")
        icon = "bot"
        role = "QA Specialist"
        slug = "qa-automation-engineer"
        triggers = "qa, automation, regression, quality, test framework"
    }
    "SEO Specialist" = @{
        desc = "SEO optimization specialist. Meta tags, Core Web Vitals, E-E-A-T, Google algorithm, analytics integration."
        skills = @("SEO Fundamentals","GEO Fundamentals","Clean Code")
        icon = "search"
        role = "SEO Expert"
        slug = "seo-specialist"
        triggers = "seo, meta tags, google, search ranking, analytics"
    }
    "Test Engineer" = @{
        desc = "Testing specialist. TDD workflow, unit/integration/E2E testing, coverage analysis, test automation."
        skills = @("Testing Patterns","TDD Workflow","Webapp Testing","Code Review Checklist")
        icon = "flask-conical"
        role = "Testing Expert"
        slug = "test-engineer"
        triggers = "test, spec, coverage, jest, pytest, playwright, e2e"
    }
}

$count = 0
foreach ($agent in $agents.GetEnumerator()) {
    $name = $agent.Key
    $data = $agent.Value
    $fileName = "$agentDir\$name.md"
    
    # Build skills wikilinks
    $skillLinks = ($data.skills | ForEach-Object {
        "- [[Agent-Skills/$_|$_]]"
    }) -join "`n"
    
    # Build related agents (same role category)
    $allNames = $agents.Keys | Where-Object { $_ -ne $name } | Sort-Object
    $related = ($allNames | Select-Object -First 4 | ForEach-Object {
        "- [[Agent-Agents/$_|$_]]"
    }) -join "`n"

    $content = @"
---
tags:
  - agent
  - agent-swarm
role: $($data.role)
source: .agent/agents/$($data.slug).md
---

# $name

> [!abstract] $($data.role)
> $($data.desc)

## Triggers

``$($data.triggers)``

## Skills

$skillLinks

## See Also

$related
- [[AGENT_SWARM|Agent Swarm MOC]]
"@

    Set-Content -Path $fileName -Value $content -Encoding UTF8
    $count++
}

Write-Output "Created $count agent notes in $agentDir"
