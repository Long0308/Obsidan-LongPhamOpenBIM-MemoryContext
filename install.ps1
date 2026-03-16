# Auto-Memory Kit — Full Stack Install Script
# Usage:
#   ./install.ps1 -WorkspacePath "D:\YourObsidian"        # Install to workspace
#   ./install.ps1 -WorkspacePath "D:\YourObsidian" -Global # Install skill globally
#   ./install.ps1 -VaultOnly -WorkspacePath "D:\YourObsidian"  # Only copy Obsidian vault

param(
    [Parameter(Mandatory=$false)]
    [string]$WorkspacePath = (Get-Location).Path,
    [switch]$Global,
    [switch]$VaultOnly
)

$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "`n🧠 Auto-Memory Kit — Full Stack Installer" -ForegroundColor Cyan
Write-Host "============================================`n"

# === Step 1: Copy Obsidian Vault ===
$VaultSource = Join-Path $ScriptDir "vault\LPOpenBIMAI"
$VaultTarget = Join-Path $WorkspacePath "LPOpenBIMAI"

Write-Host "[1/4] Installing Obsidian vault..." -ForegroundColor Green
if (Test-Path $VaultSource) {
    if (!(Test-Path $VaultTarget)) {
        Copy-Item $VaultSource -Destination $VaultTarget -Recurse -Force
        Write-Host "  ✅ LPOpenBIMAI/ → $VaultTarget (full vault)"
    } else {
        Write-Host "  ⏭️  LPOpenBIMAI/ already exists"
        Write-Host "  💡 To overwrite, delete it first: Remove-Item -Recurse $VaultTarget"
    }
} else {
    Write-Host "  ⚠️  vault/ folder not found in kit" -ForegroundColor Yellow
}

if ($VaultOnly) {
    Write-Host "`n🎉 Vault-only install complete!" -ForegroundColor Cyan
    return
}

# === Step 2: Copy SKILL.md ===
if ($Global) {
    $SkillTarget = "$env:USERPROFILE\.agents\skills\auto-memory"
    Write-Host "`n[2/4] Installing SKILL.md (GLOBAL)..." -ForegroundColor Green
} else {
    $SkillTarget = Join-Path $WorkspacePath ".agent\skills\auto-memory"
    Write-Host "`n[2/4] Installing SKILL.md (LOCAL)..." -ForegroundColor Green
}
New-Item -ItemType Directory -Path $SkillTarget -Force | Out-Null
Copy-Item "$ScriptDir\skill\SKILL.md" -Destination $SkillTarget -Force
Write-Host "  ✅ SKILL.md → $SkillTarget"

# === Step 3: Ensure memory-config exists ===
$ConfigTarget = Join-Path $WorkspacePath "LPOpenBIMAI\Agent-Memory"
Write-Host "`n[3/4] Checking memory-config.md..." -ForegroundColor Green
if (Test-Path "$ConfigTarget\memory-config.md") {
    Write-Host "  ✅ memory-config.md exists"
} else {
    New-Item -ItemType Directory -Path $ConfigTarget -Force | Out-Null
    Copy-Item "$ScriptDir\config\memory-config.md" -Destination $ConfigTarget -Force
    Write-Host "  ✅ memory-config.md → $ConfigTarget"
}

# === Step 4: Verify ===
Write-Host "`n[4/4] Verifying..." -ForegroundColor Green
$checks = @(
    @{ Path = "$VaultTarget\AGENT_SWARM.md"; Name = "AGENT_SWARM.md (MOC)" },
    @{ Path = "$VaultTarget\Agent-Swarm.canvas"; Name = "Agent-Swarm.canvas" },
    @{ Path = "$VaultTarget\Agent-Agents\Orchestrator.md"; Name = "Agent profiles (20)" },
    @{ Path = "$VaultTarget\Agent-Skills\Auto Memory.md"; Name = "Skill cards (48)" },
    @{ Path = "$SkillTarget\SKILL.md"; Name = "SKILL.md (protocol)" },
    @{ Path = "$ConfigTarget\memory-config.md"; Name = "memory-config.md" }
)

$allOk = $true
foreach ($check in $checks) {
    if (Test-Path $check.Path) {
        Write-Host "  ✅ $($check.Name)" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $($check.Name) NOT FOUND" -ForegroundColor Red
        $allOk = $false
    }
}

if ($allOk) {
    Write-Host "`n🎉 Full stack installation complete!" -ForegroundColor Cyan
    Write-Host "`n📋 What you get:"
    Write-Host "  • 20 AI agent profiles (Orchestrator, Frontend, Backend...)"
    Write-Host "  • 48 skill cards (Auto Memory, Clean Code, Brainstorming...)"
    Write-Host "  • 15 Obsidian plugin references"
    Write-Host "  • Canvas graphs (Agent-Swarm, Memory-Graph)"
    Write-Host "  • Auto-memory system (auto-load/save sessions)"
    Write-Host "`nNext steps:"
    Write-Host "  1. Open $WorkspacePath in Obsidian"
    Write-Host "  2. Open workspace in Antigravity"
    Write-Host "  3. Start working — agent handles the rest`n"
} else {
    Write-Host "`n⚠️ Some files missing." -ForegroundColor Yellow
}
