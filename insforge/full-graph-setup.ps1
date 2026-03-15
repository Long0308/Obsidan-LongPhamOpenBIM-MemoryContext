# === FULL E2E GRAPH COLORING ===
$vault = "D:\10.Obsidan\LPOpenBIMAI"

# ============ 1. Create Plugin notes ============
$pluginDir = "$vault\Agent-Plugins"
New-Item -ItemType Directory -Path $pluginDir -Force | Out-Null

$plugins = @{
    "Pane Relief" = "Navigate pane history with back/forward, maximize panes, and manage splits."
    "File Include" = "Embed and transclude file content into notes with live preview."
    "Autocorrect Formatter" = "Auto-format text with smart corrections and styling."
    "Ordered List Style" = "Customize ordered list numbering styles (a, b, c or i, ii, iii)."
    "Advanced Cursors" = "Multiple cursors, selections, and advanced editing operations."
    "Simple CanvaSearch" = "Search and navigate within Canvas files quickly."
    "Always Color Text" = "Apply persistent text coloring to notes."
    "Full Calendar" = "Full-featured calendar view for managing events in notes."
    "Dialogue" = "Create dialogue-style conversations in notes with speech bubbles."
    "Smart Typography" = "Auto-convert quotes, dashes, and ellipses to typographic characters."
    "Lovely Mindmap" = "Convert markdown headings into interactive mind maps."
    "3D Graph" = "3D visualization of vault knowledge graph with spatial navigation."
    "Graphviz" = "Render Graphviz DOT diagrams within notes."
    "Graph Analysis" = "Analyze graph metrics: centrality, clustering, betweenness."
    "Graphs" = "Enhanced graph views with filtering and visualization options."
}

$pluginCount = 0
foreach ($p in $plugins.GetEnumerator()) {
    $name = $p.Key
    $desc = $p.Value
    $filePath = "$pluginDir\$name.md"
    
    if (Test-Path $filePath) { continue }
    
    $content = @"
---
tags:
  - plugin
  - agent-swarm
type: obsidian-plugin
---

# $name

> [!tip] Plugin
> $desc

## See Also

- [[System-Guide|System Guide]]
- [[AGENT_SWARM|Agent Swarm MOC]]
"@
    
    Set-Content -Path $filePath -Value $content -Encoding UTF8
    $pluginCount++
}

Write-Output "Created $pluginCount plugin notes"

# ============ 2. Update System-Guide wikilinks ============
$sysGuide = "$vault\System-Guide.md"
if (Test-Path $sysGuide) {
    $content = Get-Content $sysGuide -Raw -Encoding UTF8
    # Add plugin tag if missing
    if ($content -notmatch 'tag.*plugin') {
        if ($content -match 'tags:') {
            # Don't double-add
        } else {
            $content = "---`ntags:`n  - hub`n  - agent-swarm`n---`n`n$content"
        }
    }
    Set-Content -Path $sysGuide -Value $content -Encoding UTF8 -NoNewline
}

# ============ 3. Create canvas reference notes ============
$canvasNotes = @{
    "Agent-Swarm Canvas" = "Architecture diagram showing 33 nodes and 22 edges of the Agent Swarm system."
    "Memory-Graph Canvas" = "Memory Gateway architecture: 17 nodes, 11 edges showing adapters and middleware."
}

foreach ($c in $canvasNotes.GetEnumerator()) {
    $filePath = "$vault\$($c.Key).md"
    if (Test-Path $filePath) { continue }
    
    $content = @"
---
tags:
  - canvas
  - agent-swarm
type: architecture-diagram
---

# $($c.Key)

> [!note] Canvas Diagram
> $($c.Value)

## See Also

- [[AGENT_SWARM|Agent Swarm MOC]]
"@
    Set-Content -Path $filePath -Value $content -Encoding UTF8
}
Write-Output "Created canvas reference notes"

# ============ 4. AUTO-CONFIGURE graph.json ============
$graphConfig = @"
{
  "collapse-filter": false,
  "search": "",
  "showTags": false,
  "showAttachments": false,
  "hideUnresolved": false,
  "showOrphans": true,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "tag:#hub",
      "color": { "a": 1, "rgb": 16724787 }
    },
    {
      "query": "tag:#agent",
      "color": { "a": 1, "rgb": 16750899 }
    },
    {
      "query": "tag:#skill",
      "color": { "a": 1, "rgb": 5635925 }
    },
    {
      "query": "tag:#memory",
      "color": { "a": 1, "rgb": 4382181 }
    },
    {
      "query": "tag:#plugin",
      "color": { "a": 1, "rgb": 11184810 }
    },
    {
      "query": "tag:#canvas",
      "color": { "a": 1, "rgb": 10233776 }
    }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1.58,
  "lineSizeMultiplier": 1.16,
  "collapse-forces": true,
  "centerStrength": 0.52,
  "repelStrength": 10,
  "linkStrength": 1,
  "linkDistance": 250,
  "scale": 1.05,
  "close": false
}
"@

$graphJsonPath = "$vault\.obsidian\graph.json"
Set-Content -Path $graphJsonPath -Value $graphConfig -Encoding UTF8
Write-Output "Updated graph.json with 6 color groups"

# ============ 5. Summary ============
$totalAgents = (Get-ChildItem "$vault\Agent-Agents\*.md").Count
$totalSkills = (Get-ChildItem "$vault\Agent-Skills\*.md").Count
$totalMemory = (Get-ChildItem "$vault\Agent-Memory\*.md").Count
$totalPlugins = (Get-ChildItem "$vault\Agent-Plugins\*.md").Count

Write-Output ""
Write-Output "========================================="
Write-Output "  FULL E2E GRAPH COLORING COMPLETE"
Write-Output "========================================="
Write-Output ""
Write-Output "Color Groups in graph.json:"
Write-Output "  RED .... tag:#hub     = Hubs/MOC"
Write-Output "  ORANGE . tag:#agent   = $totalAgents Agents"
Write-Output "  GREEN .. tag:#skill   = $totalSkills Skills"
Write-Output "  BLUE ... tag:#memory  = $totalMemory Memory"
Write-Output "  GREY ... tag:#plugin  = $totalPlugins Plugins"
Write-Output "  PURPLE . tag:#canvas  = Canvas refs"
Write-Output ""
Write-Output "Total tagged notes: $($totalAgents + $totalSkills + $totalMemory + $totalPlugins + 3 + 2)"
Write-Output ""
Write-Output "ACTION: Reload Obsidian (Ctrl+R) to see changes"
