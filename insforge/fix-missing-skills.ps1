# Create missing skill notes + tag plugin nodes
$vault = "D:\10.Obsidan\LPOpenBIMAI"
$skillDir = "$vault\Agent-Skills"

# Skills referenced in agent notes but DON'T have files yet
$missingSkills = @{
    "Clean Code" = "Pragmatic coding standards. Concise, direct, no over-engineering, self-documenting code."
    "Architecture" = "Architectural decision-making framework. Requirements analysis, trade-off evaluation, ADR documentation."
    "API Patterns" = "API design principles. REST vs GraphQL vs tRPC, response formats, versioning, pagination."
    "Vulnerability Scanner" = "Advanced vulnerability analysis. OWASP 2025, supply chain security, attack surface mapping."
    "Red Team Tactics" = "Red team tactics based on MITRE ATT&CK. Attack phases, detection evasion, reporting."
    "Node.js Best Practices" = "Node.js development principles. Framework selection, async patterns, security, architecture."
    "Python Patterns" = "Python development principles. Framework selection, type hints, project structure."
    "Database Design" = "Database design principles. Schema design, indexing strategy, ORM selection, serverless databases."
    "Frontend Design" = "Design thinking for web UI. Components, layouts, color schemes, typography, aesthetics."
    "React Best Practices" = "React and Next.js performance optimization. Server components, waterfalls, bundle size."
    "Tailwind Patterns" = "Tailwind CSS v4 principles. CSS-first config, container queries, design tokens."
    "SEO Fundamentals" = "SEO fundamentals. E-E-A-T, Core Web Vitals, Google algorithm principles."
    "GEO Fundamentals" = "Generative Engine Optimization for AI search engines (ChatGPT, Claude, Perplexity)."
    "Mobile Design" = "Mobile-first design for iOS/Android. Touch interaction, performance, platform conventions."
    "Testing Patterns" = "Testing patterns. Unit, integration, E2E, mocking strategies, pyramid approach."
    "Game Development" = "Game development orchestrator. Routes to platform-specific skills by project type."
    "Deployment Procedures" = "Production deployment principles. Safe workflows, rollback strategies, verification."
    "Server Management" = "Server management principles. Process management, monitoring strategy, scaling decisions."
    "Performance Profiling" = "Performance profiling principles. Measurement, analysis, optimization techniques."
    "Documentation Templates" = "Documentation templates. README, API docs, code comments, AI-friendly docs."
    "TDD Workflow" = "Test-Driven Development. RED-GREEN-REFACTOR cycle, test-first methodology."
    "Webapp Testing" = "Web application testing. E2E, Playwright, deep audit strategies."
    "Code Review Checklist" = "Code review guidelines covering code quality, security, and best practices."
    "MCP Builder" = "MCP server building principles. Tool design, resource patterns, best practices."
    "Rust Pro" = "Rust 1.75+ with modern async patterns, advanced type system, Tokio, axum."
    "Behavioral Modes" = "AI operational modes: brainstorm, implement, debug, review, teach, ship, orchestrate."
}

$created = 0
foreach ($skill in $missingSkills.GetEnumerator()) {
    $name = $skill.Key
    $desc = $skill.Value
    $filePath = "$skillDir\$name.md"
    
    # Skip if already exists
    if (Test-Path $filePath) { continue }
    
    $slugName = $name.ToLower() -replace ' ', '-'
    
    $content = @"
---
tags:
  - skill
  - agent-swarm
source: .agent/skills/$slugName/SKILL.md
---

# $name

> [!abstract] Skill
> $desc

## See Also

- [[AGENT_SWARM|Agent Swarm MOC]]
"@
    
    Set-Content -Path $filePath -Value $content -Encoding UTF8
    $created++
}

Write-Output "Created $created new skill notes"

# ============ Count totals ============
$totalSkills = (Get-ChildItem "$skillDir\*.md").Count
$totalAgents = (Get-ChildItem "$vault\Agent-Agents\*.md").Count
$totalMemory = (Get-ChildItem "$vault\Agent-Memory\*.md").Count
Write-Output ""
Write-Output "=== VAULT TOTALS ==="
Write-Output "Agent-Agents: $totalAgents notes"
Write-Output "Agent-Skills: $totalSkills notes"
Write-Output "Agent-Memory: $totalMemory notes"
Write-Output "Total: $($totalAgents + $totalSkills + $totalMemory) tagged notes"
