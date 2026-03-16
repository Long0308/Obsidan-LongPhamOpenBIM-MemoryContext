# Fix broken wikilinks after vault restructure
# Old: [[Agent-Skills/Clean Code|Clean Code]] -> New: [[Agent-Skills/1-Superpowers/Clean Code|Clean Code]]
# Old: [[Agent-Agents/Backend Specialist|Backend Specialist]] -> New: [[Agent-Agents/2-Development-Core/Backend Specialist|Backend Specialist]]

$root = "d:\10.Obsidan\LPOpenBIMAI"

# Build mapping: note name -> sub-folder path
$mapping = @{}

# Scan all .md files in subdirectories and build the mapping
Get-ChildItem -Path $root -Recurse -Filter "*.md" | ForEach-Object {
    $relPath = $_.FullName.Substring($root.Length + 1).Replace('\', '/')
    $name = $_.BaseName
    
    # Only map files that are in numbered sub-folders (1-xxx, 2-xxx, etc.)
    if ($relPath -match '^([^/]+)/(\d+-[^/]+)/(.+)\.md$') {
        $parentDir = $Matches[1]   # e.g. Agent-Agents
        $subFolder = $Matches[2]    # e.g. 1-Architecture-Planning
        $fileName = $Matches[3]     # e.g. Orchestrator
        
        # Old path format: ParentDir/FileName
        $oldPath = "$parentDir/$fileName"
        # New path format: ParentDir/SubFolder/FileName
        $newPath = "$parentDir/$subFolder/$fileName"
        
        $mapping[$oldPath] = $newPath
    }
}

Write-Host "Built mapping with $($mapping.Count) entries"
Write-Host ""

# Show first 10 mappings for verification
$i = 0
foreach ($kv in $mapping.GetEnumerator() | Sort-Object Name) {
    if ($i -ge 10) { break }
    Write-Host "  $($kv.Key) -> $($kv.Value)"
    $i++
}
Write-Host "  ... ($($mapping.Count) total)"
Write-Host ""

# Now scan all .md files and fix wikilinks
$totalFixed = 0
$filesChanged = 0

Get-ChildItem -Path $root -Recurse -Filter "*.md" | ForEach-Object {
    $file = $_
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content
    $fileFixCount = 0
    
    foreach ($kv in $mapping.GetEnumerator()) {
        $oldLink = $kv.Key
        $newLink = $kv.Value
        
        # Fix [[OldPath|Display]] -> [[NewPath|Display]]
        $pattern = [regex]::Escape("[[" + $oldLink + "|")
        $replacement = "[[" + $newLink + "|"
        
        $matches = [regex]::Matches($content, $pattern)
        if ($matches.Count -gt 0) {
            $content = $content -replace $pattern, $replacement
            $fileFixCount += $matches.Count
        }
        
        # Fix [[OldPath]] (no display text) -> [[NewPath]]
        $pattern2 = [regex]::Escape("[[" + $oldLink + "]]")
        $replacement2 = "[[" + $newLink + "]]"
        
        $matches2 = [regex]::Matches($content, $pattern2)
        if ($matches2.Count -gt 0) {
            $content = $content -replace $pattern2, $replacement2
            $fileFixCount += $matches2.Count
        }
    }
    
    if ($content -ne $original) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        $totalFixed += $fileFixCount
        $filesChanged++
        Write-Host "  Fixed $fileFixCount links in $($file.Name)"
    }
}

Write-Host ""
Write-Host "========================================="
Write-Host "DONE: Fixed $totalFixed links in $filesChanged files"
Write-Host "========================================="
