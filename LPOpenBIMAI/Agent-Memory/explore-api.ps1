<# 
  explore-api.ps1 - Dump full GetUserStatus response to find context window data
#>
$proc = Get-CimInstance Win32_Process -Filter "name='language_server_windows_x64.exe'" |
    Where-Object { $_.CommandLine -match 'antigravity' } |
    Select-Object -First 1

if (-not $proc) { Write-Error "language_server not found"; exit 1 }

$cmd = $proc.CommandLine
$csrf = ""
if ($cmd -match '--csrf_token\s+([a-f0-9\-]+)') { $csrf = $Matches[1] }

$ports = Get-NetTCPConnection -OwningProcess $proc.ProcessId -State Listen -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty LocalPort | Sort-Object

try {
    Add-Type -TypeDefinition @'
using System.Net;
public class ExploreSSL {
    public static void Enable() {
        ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
    }
}
'@
    [ExploreSSL]::Enable()
} catch { }

$body = '{"metadata":{"ideName":"antigravity","extensionName":"antigravity","locale":"en"}}'

foreach ($port in $ports) {
    try {
        $resp = Invoke-RestMethod `
            -Uri "https://127.0.0.1:$port/exa.language_server_pb.LanguageServerService/GetUserStatus" `
            -Method POST -Body $body -ContentType 'application/json' `
            -Headers @{'Connect-Protocol-Version'='1'; 'X-Codeium-Csrf-Token'=$csrf} `
            -TimeoutSec 10
        
        Write-Host "SUCCESS on port $port" -ForegroundColor Green
        
        # Dump full response
        $json = $resp | ConvertTo-Json -Depth 15
        $outPath = Join-Path $env:TEMP "antigravity_full_response.json"
        $json | Out-File -FilePath $outPath -Encoding UTF8
        Write-Host "Full response saved to: $outPath"
        Write-Host "Response size: $($json.Length) chars"
        
        # Show structure
        Write-Host "`n--- Top-level keys ---"
        $resp.PSObject.Properties | ForEach-Object { Write-Host "  $($_.Name): $($_.Value.GetType().Name)" }
        
        Write-Host "`n--- userStatus keys ---"
        $resp.userStatus.PSObject.Properties | ForEach-Object { Write-Host "  $($_.Name): $($_.Value.GetType().Name)" }
        
        break
    } catch { }
}
