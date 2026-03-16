$base = "d:\10.Obsidan\LPOpenBIMAI"

# ============================================================
# 1. AGENT-AGENTS — 6 sub-folders
# ============================================================
$aa = "$base\Agent-Agents"

$aaGroups = @{
    "1-Architecture-Planning" = @("Orchestrator.md","Project Planner.md","Product Manager.md","Product Owner.md")
    "2-Development-Core" = @("Frontend Specialist.md","Backend Specialist.md","Mobile Developer.md","Database Architect.md","Game Developer.md")
    "3-Quality-Testing" = @("Debugger.md","Test Engineer.md","QA Automation Engineer.md","Code Archaeologist.md")
    "4-Security-DevOps" = @("Security Auditor.md","Penetration Tester.md","DevOps Engineer.md")
    "5-Performance-SEO" = @("Performance Optimizer.md","SEO Specialist.md")
    "6-Documentation-Research" = @("Documentation Writer.md","Explorer Agent.md")
}

foreach ($group in $aaGroups.Keys) {
    $dir = "$aa\$group"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    foreach ($file in $aaGroups[$group]) {
        $src = "$aa\$file"
        if (Test-Path $src) { Move-Item -Path $src -Destination "$dir\$file" -Force }
    }
}

# ============================================================
# 2. AGENT-SKILLS — 8 sub-folders
# ============================================================
$as = "$base\Agent-Skills"

$asGroups = @{
    "1-Superpowers" = @(
        "Brainstorming.md","Writing Plans.md","Executing Plans.md","Subagent Driven Dev.md",
        "Dispatching Parallel Agents.md","Requesting Code Review.md","Receiving Code Review.md",
        "Test Driven Development.md","TDD Workflow.md","Systematic Debugging.md","Verification.md",
        "Finishing Dev Branch.md","Git Worktrees.md",
        "App Builder.md","Plan Writing.md","Parallel Agents.md"
    )
    "2-OpenSpec" = @(
        "OpenSpec Explore.md","OpenSpec Propose.md","OpenSpec Apply.md","OpenSpec Archive.md"
    )
    "3-Obsidian" = @(
        "Obsidian Markdown.md","Obsidian Bases.md","JSON Canvas.md","Obsidian CLI.md","Defuddle.md"
    )
    "4-Design-Frontend" = @(
        "UI-UX Pro Max.md","Stitch Loop.md","Frontend Design.md","Mobile Design.md",
        "Tailwind Patterns.md","React Best Practices.md","i18n Localization.md","Web Design Guidelines.md"
    )
    "5-Backend-Infra" = @(
        "Auto Memory.md","Database Design.md","API Patterns.md","Node.js Best Practices.md",
        "Python Patterns.md","Rust Pro.md","MCP Builder.md","Server Management.md",
        "Deployment Procedures.md","InsForge SDK.md","InsForge CLI.md"
    )
    "6-Security-Quality" = @(
        "Vulnerability Scanner.md","Red Team Tactics.md","Testing Patterns.md","Webapp Testing.md",
        "Performance Profiling.md","Code Review Checklist.md","Lint and Validate.md"
    )
    "7-Meta" = @(
        "Using Superpowers.md","Writing Skills.md","Behavioral Modes.md","Clean Code.md",
        "Game Development.md","Bash Linux.md","PowerShell Windows.md","Intelligent Routing.md"
    )
    "8-Additional" = @(
        "Architecture.md","SEO Fundamentals.md","GEO Fundamentals.md","Documentation Templates.md"
    )
}

foreach ($group in $asGroups.Keys) {
    $dir = "$as\$group"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    foreach ($file in $asGroups[$group]) {
        $src = "$as\$file"
        if (Test-Path $src) { Move-Item -Path $src -Destination "$dir\$file" -Force }
    }
}

# ============================================================
# 3. AGENT-MEMORY — 5 sub-folders
# ============================================================
$am = "$base\Agent-Memory"

# Move assets folder first
$infraDir = "$am\3-Infrastructure"
if (-not (Test-Path $infraDir)) { New-Item -ItemType Directory -Path $infraDir -Force | Out-Null }
if ((Test-Path "$am\assets") -and -not (Test-Path "$infraDir\assets")) {
    Move-Item -Path "$am\assets" -Destination "$infraDir\assets" -Force
}

$amGroups = @{
    "1-Config" = @("MCP Config.md","GEMINI Rules.md","context-rules.md","memory-config.md","preferences.md")
    "2-Patterns" = @(
        "Memory Types trong Agentic Systems.md","memory-patterns.md","memory-decisions.md",
        "memory-active-context.md","memory-troubleshooting.md","patterns.md"
    )
    "3-Infrastructure" = @(
        "Edge Function v2.2.md","Symbiotic Pipeline.md","Context Hub Analysis.md",
        "Memory Context Monitor.md","Dashboard Guide.md","dashboard.html",
        "sync-quotas.ps1","explore-api.ps1","annotations.json","feedback.json","quotas.json",
        "QUOTA-API-README.md"
    )
    "4-Sessions" = @(
        "Session Dashboard.md",
        "session-2026-03-15-antigravity-LPOpenBIMAI.md",
        "session-2026-03-16-antigravity-LPOpenBIMAI.md"
    )
    "5-Guides" = @(
        "System-Guide.md","E2E-Guide.md","E2E-Setup-Guide.md","Install Guide.md",
        "Gemini Artifacts.md","people.md","tech-stack.md"
    )
}

foreach ($group in $amGroups.Keys) {
    $dir = "$am\$group"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    foreach ($file in $amGroups[$group]) {
        $src = "$am\$file"
        if (Test-Path $src) { Move-Item -Path $src -Destination "$dir\$file" -Force }
    }
}

# ============================================================
# 4. AGENT-PLUGINS — 4 sub-folders
# ============================================================
$ap = "$base\Agent-Plugins"

$apGroups = @{
    "1-Visualization" = @("Lovely Mindmap.md","Graph Analysis.md","3D Graph.md","Graphs.md","Graphviz.md")
    "2-Editor" = @("Advanced Cursors.md","Smart Typography.md","Autocorrect Formatter.md","Ordered List Style.md","Always Color Text.md")
    "3-Navigation" = @("Simple CanvaSearch.md","Pane Relief.md","File Include.md")
    "4-Productivity" = @("Full Calendar.md","Dialogue.md")
}

foreach ($group in $apGroups.Keys) {
    $dir = "$ap\$group"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    foreach ($file in $apGroups[$group]) {
        $src = "$ap\$file"
        if (Test-Path $src) { Move-Item -Path $src -Destination "$dir\$file" -Force }
    }
}

# ============================================================
# 5. PLATFORMS — 3 sub-folders
# ============================================================
$pl = "$base\Platforms"

$plGroups = @{
    "1-Core" = @("Antigravity Kit.md","Superpowers Hub.md")
    "2-Development" = @("InsForge Hub.md","OpenSpec Hub.md")
    "3-Design-Tools" = @("UI Design Hub.md","Obsidian Tools Hub.md")
}

foreach ($group in $plGroups.Keys) {
    $dir = "$pl\$group"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    foreach ($file in $plGroups[$group]) {
        $src = "$pl\$file"
        if (Test-Path $src) { Move-Item -Path $src -Destination "$dir\$file" -Force }
    }
}

# ============================================================
# 6. RESOURCES — 2 sub-folders
# ============================================================
$rs = "$base\Resources"

$rsGroups = @{
    "1-AI-References" = @("AI Agent Resources.md","Claude Skills Resources.md","Prompt & AI Image Library.md")
    "2-Development" = @("Antigravity Kit Resources.md","OpenSpec Integration.md","SaaS Planning Workflow.md","UI-UX Design Resources.md")
}

foreach ($group in $rsGroups.Keys) {
    $dir = "$rs\$group"
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    foreach ($file in $rsGroups[$group]) {
        $src = "$rs\$file"
        if (Test-Path $src) { Move-Item -Path $src -Destination "$dir\$file" -Force }
    }
}

# ============================================================
# SUMMARY
# ============================================================
$totalAfter = (Get-ChildItem -Path $base -Recurse -File | Measure-Object).Count
Write-Host ""
Write-Host "============================================"
Write-Host "  VAULT RESTRUCTURE COMPLETE"
Write-Host "============================================"
Write-Host "  Total files after: $totalAfter (expected: 214)"
Write-Host ""

Write-Host "--- Agent-Agents ---"
Get-ChildItem "$aa" -Directory | Sort-Object Name | ForEach-Object { Write-Host "  $($_.Name)/ ($((Get-ChildItem $_.FullName -File).Count) files)" }
Write-Host ""
Write-Host "--- Agent-Skills ---"
Get-ChildItem "$as" -Directory | Sort-Object Name | ForEach-Object { Write-Host "  $($_.Name)/ ($((Get-ChildItem $_.FullName -File).Count) files)" }
Write-Host ""
Write-Host "--- Agent-Memory ---"
Get-ChildItem "$am" -Directory | Sort-Object Name | ForEach-Object { Write-Host "  $($_.Name)/ ($((Get-ChildItem $_.FullName -File -Recurse).Count) files)" }
Write-Host ""
Write-Host "--- Agent-Plugins ---"
Get-ChildItem "$ap" -Directory | Sort-Object Name | ForEach-Object { Write-Host "  $($_.Name)/ ($((Get-ChildItem $_.FullName -File).Count) files)" }
Write-Host ""
Write-Host "--- Platforms ---"
Get-ChildItem "$pl" -Directory | Sort-Object Name | ForEach-Object { Write-Host "  $($_.Name)/ ($((Get-ChildItem $_.FullName -File).Count) files)" }
Write-Host ""
Write-Host "--- Resources ---"
Get-ChildItem "$rs" -Directory | Sort-Object Name | ForEach-Object { Write-Host "  $($_.Name)/ ($((Get-ChildItem $_.FullName -File).Count) files)" }
