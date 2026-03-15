# Auto-Memory Kit — Install Script
# Usage: ./install.ps1 -WorkspacePath "D:\YourWorkspace"
# Global: ./install.ps1 -Global

param(
    [Parameter(Mandatory=$false)]
    [string]$WorkspacePath = (Get-Location).Path,
    [switch]$Global
)

$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "`n🧠 Auto-Memory Kit Installer" -ForegroundColor Cyan
Write-Host "================================`n"

# Determine target
if ($Global) {
    $SkillTarget = "$env:USERPROFILE\.agents\skills\auto-memory"
    Write-Host "📍 Mode: GLOBAL ($SkillTarget)" -ForegroundColor Yellow
} else {
    $SkillTarget = Join-Path $WorkspacePath ".agent\skills\auto-memory"
    Write-Host "📍 Mode: LOCAL ($SkillTarget)" -ForegroundColor Yellow
}

$ConfigTarget = Join-Path $WorkspacePath "LPOpenBIMAI\Agent-Memory"

# Step 1: SKILL.md
Write-Host "`n[1/3] Installing SKILL.md..." -ForegroundColor Green
New-Item -ItemType Directory -Path $SkillTarget -Force | Out-Null
Copy-Item "$ScriptDir\skill\SKILL.md" -Destination $SkillTarget -Force
Write-Host "  ✅ SKILL.md → $SkillTarget"

# Step 2: Config
Write-Host "`n[2/3] Installing memory-config.md..." -ForegroundColor Green
New-Item -ItemType Directory -Path $ConfigTarget -Force | Out-Null
if (!(Test-Path "$ConfigTarget\memory-config.md")) {
    Copy-Item "$ScriptDir\config\memory-config.md" -Destination $ConfigTarget -Force
    Write-Host "  ✅ memory-config.md → $ConfigTarget"
} else {
    Write-Host "  ⏭️  memory-config.md already exists, skipping"
}

# Step 3: Verify
Write-Host "`n[3/3] Verifying..." -ForegroundColor Green
$allOk = $true
@("$SkillTarget\SKILL.md", "$ConfigTarget\memory-config.md") | ForEach-Object {
    $name = Split-Path $_ -Leaf
    if (Test-Path $_) {
        Write-Host "  ✅ $name" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $name NOT FOUND" -ForegroundColor Red
        $allOk = $false
    }
}

if ($allOk) {
    Write-Host "`n🎉 Installation complete!" -ForegroundColor Cyan
    Write-Host "`nNext steps:"
    Write-Host "  1. Open workspace in Antigravity (or any AI IDE)"
    Write-Host "  2. Start working — agent auto-loads/saves context"
    Write-Host "  3. Edit memory-config.md in Obsidian to customize`n"
} else {
    Write-Host "`n⚠️ Some files missing." -ForegroundColor Yellow
}
