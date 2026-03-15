# Antigravity Quota Check — How It Works

## Overview

Fetches **real-time model quota data** from Antigravity's internal `language_server` API, syncs it to an Insforge database, and displays it on the Agent Memory Dashboard.

## Architecture

```
language_server_windows_x64.exe (local HTTPS)
        ↓ POST GetUserStatus
    sync-quotas.ps1
        ↓ insforge db query
    model_quotas table (Insforge DB)
        ↓ PostgREST API
    dashboard.html
```

## API Details (reverse-engineered from ag-quota extension)

### Endpoint
```
POST https://127.0.0.1:{port}/exa.language_server_pb.LanguageServerService/GetUserStatus
```

### Headers
```
Content-Type: application/json
Connect-Protocol-Version: 1
X-Codeium-Csrf-Token: {csrf_token}
```

### Body
```json
{"metadata":{"ideName":"antigravity","extensionName":"antigravity","locale":"en"}}
```

### Response (relevant fields)
```json
{
  "userStatus": {
    "cascadeModelConfigData": {
      "clientModelConfigs": [
        {
          "label": "Claude Sonnet 4.6 (Thinking)",
          "quotaInfo": {
            "remainingFraction": 1.0,
            "resetTime": "2026-03-15T20:21:53Z"
          }
        }
      ]
    },
    "planStatus": {
      "availablePromptCredits": 500,
      "planInfo": { "monthlyPromptCredits": 50000 }
    }
  }
}
```

## How to Get Port + CSRF Token

```powershell
# Find language_server process
$proc = Get-CimInstance Win32_Process -Filter "name='language_server_windows_x64.exe'" |
    Where-Object { $_.CommandLine -match 'antigravity' } |
    Select-Object -First 1

# Extract CSRF token from CommandLine args
$proc.CommandLine -match '--csrf_token\s+([a-f0-9\-]+)' | Out-Null
$csrf = $Matches[1]

# Get listening ports
$ports = Get-NetTCPConnection -OwningProcess $proc.ProcessId -State Listen |
    Select-Object -ExpandProperty LocalPort
```

## Usage

```powershell
# Run manually
powershell -ExecutionPolicy Bypass -File "d:\10.Obsidan\LPOpenBIMAI\Agent-Memory\sync-quotas.ps1"

# The script will:
# 1. Auto-detect language_server process
# 2. Extract CSRF token + port
# 3. Call GetUserStatus API  
# 4. Sync all model quotas to Insforge DB
```

## Source

Reverse-engineered from: `henrikdev.ag-quota-1.1.0-universal` extension
- `src/core/quota_manager.ts` — API call logic
- `src/core/process_finder.ts` — Port/CSRF discovery
- `src/core/platform_strategies.ts` — Windows/Unix process detection
