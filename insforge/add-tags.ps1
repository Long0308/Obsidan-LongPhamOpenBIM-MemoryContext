# Add tags to all Obsidian notes for Graph color groups
# Agent notes already have tags: [agent, agent-swarm]

$vault = "D:\10.Obsidan\LPOpenBIMAI"
$updated = 0

# ============ SKILLS ============
$skillDir = "$vault\Agent-Skills"
$skillFiles = Get-ChildItem "$skillDir\*.md"
foreach ($f in $skillFiles) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    if ($content -match '^---') {
        # Has frontmatter - check if tags exist
        if ($content -match 'tags:') {
            # Already has tags - add skill tag if missing
            if ($content -notmatch 'skill') {
                $content = $content -replace '(tags:\s*\n\s*-\s*)', "`$1skill`n  - "
                $content = $content -replace '(tags:\s*\[)', '${1}skill, '
            }
        } else {
            # Has frontmatter but no tags - add tags after first ---
            $content = $content -replace '^(---\s*\n)', "---`ntags:`n  - skill`n  - agent-swarm`n"
        }
    } else {
        # No frontmatter - add new frontmatter
        $content = "---`ntags:`n  - skill`n  - agent-swarm`n---`n`n$content"
    }
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8 -NoNewline
    $updated++
}
Write-Output "Skills: Updated $updated files"

# ============ MEMORY ============
$memDir = "$vault\Agent-Memory"
$memFiles = Get-ChildItem "$memDir\*.md"
$memCount = 0
foreach ($f in $memFiles) {
    $content = Get-Content $f.FullName -Raw -Encoding UTF8
    
    if ($content -match '^---') {
        if ($content -match 'tags:') {
            if ($content -notmatch '\bmemory\b') {
                $content = $content -replace '(tags:\s*\[)', '${1}memory, '
            }
        } else {
            $content = $content -replace '^(---\s*\n)', "---`ntags:`n  - memory`n  - agent-swarm`n"
        }
    } else {
        $content = "---`ntags:`n  - memory`n  - agent-swarm`n---`n`n$content"
    }
    
    Set-Content -Path $f.FullName -Value $content -Encoding UTF8 -NoNewline
    $memCount++
}
Write-Output "Memory: Updated $memCount files"

# ============ MOC / Hub files ============
$hubFiles = @(
    "$vault\AGENT_SWARM.md",
    "$vault\E2E-Guide.md",
    "$vault\System-Guide.md"
)
$hubCount = 0
foreach ($path in $hubFiles) {
    if (Test-Path $path) {
        $content = Get-Content $path -Raw -Encoding UTF8
        
        if ($content -match '^---') {
            if ($content -match 'tags:') {
                if ($content -notmatch '\bhub\b') {
                    $content = $content -replace '(tags:\s*\[)', '${1}hub, '
                }
            } else {
                $content = $content -replace '^(---\s*\n)', "---`ntags:`n  - hub`n  - agent-swarm`n"
            }
        } else {
            $content = "---`ntags:`n  - hub`n  - agent-swarm`n---`n`n$content"
        }
        
        Set-Content -Path $path -Value $content -Encoding UTF8 -NoNewline
        $hubCount++
    }
}
Write-Output "Hubs: Updated $hubCount files"

Write-Output "`n=== SUMMARY ==="
Write-Output "Agent notes: 20 (already tagged: agent)"
Write-Output "Skill notes: $updated (tagged: skill)"  
Write-Output "Memory notes: $memCount (tagged: memory)"
Write-Output "Hub notes: $hubCount (tagged: hub)"
Write-Output "Total: $($updated + $memCount + $hubCount + 20) notes with color tags"
