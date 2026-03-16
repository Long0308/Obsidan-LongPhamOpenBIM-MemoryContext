<# 
  sync-quotas.ps1 - Fetch Antigravity quota and sync to Insforge DB
  Usage: powershell -ExecutionPolicy Bypass -File sync-quotas.ps1
#>
param(
    [string]$InsforgeUrl = "https://4ian5xm8.ap-southeast.insforge.app",
    [string]$Project = "LPOpenBIMAI"
)

# --- Step 1: Find language_server process ---
$proc = Get-CimInstance Win32_Process -Filter "name='language_server_windows_x64.exe'" |
    Where-Object { $_.CommandLine -match 'antigravity' } |
    Select-Object -First 1

if (-not $proc) {
    Write-Error "language_server not found. Is Antigravity running?"
    exit 1
}

$cmd = $proc.CommandLine
$csrf = ""
if ($cmd -match '--csrf_token\s+([a-f0-9\-]+)') { $csrf = $Matches[1] }
if (-not $csrf) { Write-Error "CSRF token not found"; exit 1 }

# --- Step 2: Get listening ports ---
$ports = Get-NetTCPConnection -OwningProcess $proc.ProcessId -State Listen -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty LocalPort | Sort-Object

# --- Step 3: SSL bypass ---
try {
    Add-Type -TypeDefinition @'
using System.Net;
public class QuotaSyncSSL {
    public static void Enable() {
        ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
    }
}
'@
    [QuotaSyncSSL]::Enable()
} catch { }

# --- Step 4: Fetch quota from language_server ---
$body = '{"metadata":{"ideName":"antigravity","extensionName":"antigravity","locale":"en"}}'
$resp = $null

foreach ($port in $ports) {
    try {
        $resp = Invoke-RestMethod `
            -Uri "https://127.0.0.1:$port/exa.language_server_pb.LanguageServerService/GetUserStatus" `
            -Method POST -Body $body -ContentType 'application/json' `
            -Headers @{'Connect-Protocol-Version'='1'; 'X-Codeium-Csrf-Token'=$csrf} `
            -TimeoutSec 10
        break
    } catch { }
}

if (-not $resp) {
    Write-Error "Could not reach language_server API"
    exit 1
}

# --- Step 5: Parse models ---
$models = $resp.userStatus.cascadeModelConfigData.clientModelConfigs
Write-Host "Found $($models.Count) models:" -ForegroundColor Cyan

$quotaData = @()
$tierPattern = '\(([^)]+)\)'
foreach ($m in $models) {
    $label = $m.label
    $remaining = $m.quotaInfo.remainingFraction
    $resetTime = $m.quotaInfo.resetTime
    $usagePct = 0
    if ($remaining -ne $null) { $usagePct = [math]::Round($remaining * 100, 1) }
    
    # Determine tier from label
    $tier = ""
    if ($label -match $tierPattern) { $tier = $Matches[1] }
    
    # Clean model name (remove tier suffix)
    $cleanName = $label -replace '\s*\(.*\)$', ''
    
    Write-Host "  $label  ->  Usage: ${usagePct}%  Reset: $resetTime"
    
    $quotaData += @{
        model_name = $cleanName
        tier = $tier
        usage_pct = $usagePct
        reset_at = $resetTime
        project = $Project
    }
}

# --- Step 6: Sync to Insforge DB ---
Write-Host ""
Write-Host "Syncing to Insforge DB..." -ForegroundColor Yellow

foreach ($q in $quotaData) {
    $mn = $q.model_name
    $ti = $q.tier
    $up = $q.usage_pct
    $ra = $q.reset_at
    $pr = $q.project
    $sql = "INSERT INTO model_quotas (model_name, tier, usage_pct, reset_at, project) VALUES ('$mn', '$ti', $up, '$ra', '$pr') ON CONFLICT (model_name, tier) DO UPDATE SET usage_pct = EXCLUDED.usage_pct, reset_at = EXCLUDED.reset_at, updated_at = now()"
    
    try {
        $result = & insforge db query $sql 2>&1
        Write-Host "  OK: $mn ($ti): ${up}%" -ForegroundColor Green
    } catch {
        Write-Host "  FAIL: ${mn}: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# --- Step 6.5: Write quotas.json for dashboard direct read ---
$jsonOut = @{
    quotas = $quotaData
    updated_at = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    plan = @{
        available = $resp.userStatus.planStatus.availablePromptCredits
        monthly = $resp.userStatus.planStatus.planInfo.monthlyPromptCredits
    }
} | ConvertTo-Json -Depth 4

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$jsonPath = Join-Path $scriptDir "quotas.json"
$jsonOut | Out-File -FilePath $jsonPath -Encoding utf8 -Force
Write-Host "  Wrote quotas.json -> $jsonPath" -ForegroundColor Cyan

Write-Host ""
Write-Host "Quota sync complete!" -ForegroundColor Green

# --- Step 7: Show plan info ---
$plan = $resp.userStatus.planStatus
if ($plan) {
    $available = $plan.availablePromptCredits
    $monthly = $plan.planInfo.monthlyPromptCredits
    $usedPlan = 0
    if ($monthly -gt 0) { $usedPlan = [math]::Round(($monthly - $available) / $monthly * 100, 1) }
    Write-Host "Plan: Credits $available/$monthly (${usedPlan}% used)" -ForegroundColor Cyan
}
