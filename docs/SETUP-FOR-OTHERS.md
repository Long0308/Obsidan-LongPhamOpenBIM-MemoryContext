# 🔧 Setup Guide for Other Users

> Hướng dẫn cho người KHÁC muốn dùng Auto-Memory Kit với backend **riêng** của họ.

## Tổng quan

Kit này gồm 2 phần:
1. **Obsidian vault** (clone về dùng ngay)
2. **Backend** (InsForge + GitHub — mỗi người setup riêng)

## Step 1: Clone & Install Vault

```powershell
git clone https://github.com/Long0308/Obsidan-LongPhamOpenBIM-MemoryContext.git
cd Obsidan-LongPhamOpenBIM-MemoryContext
./install.ps1 -WorkspacePath "D:\YourObsidian"
```

✅ Done — bạn có toàn bộ 20 agents, 48 skills, canvas graphs, memory system.

## Step 2: Setup InsForge Backend (của riêng bạn)

### 2.1 Tạo InsForge Account + Project

1. Đăng ký tại [insforge.app](https://insforge.app)
2. Cài CLI:
   ```powershell
   npm install -g @insforge/cli
   insforge login
   ```
3. Tạo project:
   ```powershell
   insforge projects create --name "MyMemoryContext" --region ap-southeast-1
   ```
4. Note lại:
   - **Project ID** (dạng `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)
   - **Base URL** (dạng `https://xxxxxx.functions.insforge.app`)
   - **Anon Key** (dạng `eyJhbGc...`)

### 2.2 Tạo Database Schema

Paste nội dung `schema/setup.sql` vào InsForge SQL Editor:

```powershell
# Hoặc qua CLI
insforge db query --project <YOUR_PROJECT_ID> < schema/setup.sql
```

### 2.3 Deploy Edge Function

```powershell
insforge functions deploy mem-gw-final \
  --project <YOUR_PROJECT_ID> \
  --file functions/index.ts \
  --name "Memory Gateway"
```

### 2.4 Setup GitHub Repository

1. Tạo repo private trên GitHub (tên tùy ý, ví dụ: `my-memory-context`)
2. Tạo Personal Access Token (PAT):
   - GitHub → Settings → Developer settings → Personal access tokens → Fine-grained
   - Permissions: Contents (Read and write)
   - Copy token

### 2.5 Add Secrets vào InsForge

```powershell
insforge secrets set GITHUB_PAT "ghp_your_token_here" --project <YOUR_PROJECT_ID>
insforge secrets set GITHUB_OWNER "your-github-username" --project <YOUR_PROJECT_ID>
insforge secrets set GITHUB_REPO "my-memory-context" --project <YOUR_PROJECT_ID>
```

### 2.6 Setup Cron Schedule

```powershell
insforge schedules create \
  --project <YOUR_PROJECT_ID> \
  --name "Memory Sync" \
  --schedule "0 */2 * * *" \
  --endpoint "/mem-gw-final/sync-github" \
  --method POST
```

## Step 3: Update Config Files

### 3.1 Update `memory-config.md`

Mở `LPOpenBIMAI/Agent-Memory/memory-config.md` trong Obsidian, đổi:

| Field | Đổi thành |
|-------|-----------|
| `github_repo` | `your-username/my-memory-context` |
| `insforge_project` | Tên project của bạn |

### 3.2 Update `SKILL.md` API URL

Mở `.agent/skills/auto-memory/SKILL.md`, find & replace:

```
OLD: https://4ian5xm8.functions.insforge.app
NEW: https://YOUR_FUNCTION_URL.functions.insforge.app
```

> 💡 Lấy URL từ: `insforge functions list --project <YOUR_PROJECT_ID>`

## Step 4: Verify

```powershell
# Health check
Invoke-RestMethod https://YOUR_URL.functions.insforge.app/mem-gw-final/health

# Save test
$body = @{
  session_id = 'test'
  ide = 'antigravity'
  project = 'TestProject'
  content = 'Hello from my setup'
  decisions = @()
  push_github = $true
} | ConvertTo-Json

Invoke-RestMethod https://YOUR_URL.functions.insforge.app/mem-gw-final/save-session `
  -Method POST -Body $body -ContentType 'application/json'

# Check GitHub repo — should see sessions/ folder
```

## Step 5: Done!

Mở Antigravity (hoặc AI IDE khác) → agent tự:
1. 🧠 Auto-load context cũ
2. 📌 Checkpoint mỗi ~15 tool calls
3. 💾 Save session khi xong

---

## Quick Reference

| Component | Bạn cần | Long đã có sẵn |
|-----------|---------|-----------------|
| Obsidian vault | ✅ Clone từ repo | ✅ |
| InsForge account | ❌ Tạo mới | ✅ |
| InsForge project | ❌ Tạo mới | `105f7d35...` |
| DB schema | ✅ Run `setup.sql` | ✅ |
| Edge function | ✅ Deploy `index.ts` | `mem-gw-final` |
| GitHub repo | ❌ Tạo mới (private) | `Long0308/...` |
| GitHub PAT | ❌ Tạo mới | ✅ |
| Cron schedule | ❌ Tạo mới | `c86c044a` |
| SKILL.md URL | ❌ Update URL mới | ✅ |

## Troubleshooting

| Vấn đề | Fix |
|--------|-----|
| `save-session` trả 500 | Check DB schema đã run chưa. Check `sync_log` constraint |
| GitHub push failed | Verify `GITHUB_PAT` secret. Check repo permissions |
| Agent không auto-load | Verify SKILL.md URL đúng. Check `insforge functions list` |
| Cron không chạy | `insforge schedules logs <schedule_id>` |
| `sync_log` insert fail | Run: `GRANT SELECT, INSERT ON sync_log TO anon, authenticated;` |
