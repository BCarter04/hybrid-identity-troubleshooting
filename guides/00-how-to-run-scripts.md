# How to Run the Scripts — Complete Guide

These scripts are **read-only diagnostic tools**. They do not change any settings, start syncs, or modify users. They only report the current state of Microsoft Entra Connect.

## What you need

| Requirement | Details |
|-------------|
| **Where to run** | On the **Microsoft Entra Connect server** itself (the server where Entra Connect is installed). The `ADSync` PowerShell module exists only on that server. |
| **PowerShell** | Windows PowerShell 5.1 (or PowerShell 7) running as Administrator is recommended. |
| **Permissions** | Local administrator on the Entra Connect server is normally sufficient for these read-only checks. |
| **Remote option** | If you cannot log on interactively, you can use PowerShell remoting (`Enter-PSSession` or `Invoke-Command`) to the Entra Connect server, provided WinRM is enabled. |

You **cannot** run these scripts from a normal workstation or domain controller unless you remote into the Entra Connect server. The module will not be found.

## How to get the scripts

1. Clone or download the repository:
   ```powershell
   git clone https://github.com/BCarter04/hybrid-identity-troubleshooting.git
   ```
2. Or download the ZIP from GitHub and extract it.
3. Open PowerShell **as Administrator** on the Entra Connect server.
4. Change to the `scripts` folder:
   ```powershell
   cd C:\path\to\hybrid-identity-troubleshooting\scripts
   ```

## Script 1: Get-EntraConnectStatus.ps1

**What it does**  
Shows whether the scheduler is enabled, whether the server is in staging mode, the last run result, the next scheduled sync time, and the status of the ADSync Windows service.

**How it works**  
- Imports the `ADSync` module.
- Calls `Get-ADSyncScheduler`.
- Checks the `ADSync` service.
- Outputs a simple list of key properties.

**How to run**
```powershell
.\Get-EntraConnectStatus.ps1
```

**What “good” looks like**
- `SyncCycleEnabled : True`
- `StagingModeEnabled : False`
- `LastRunStatus : Success`
- `ADSyncServiceStatus : Running`

## Script 2: Get-RecentSyncRuns.ps1

**What it does**  
Lists the most recent synchronization runs (Import / Export / etc.) so you can see if the last cycles succeeded.

**How it works**  
- Imports `ADSync`.
- Calls `Get-ADSyncRunProfileResult`.
- Sorts by start date and shows the newest ones.

**How to run**
```powershell
.\Get-RecentSyncRuns.ps1
# Or show more rows
.\Get-RecentSyncRuns.ps1 -Count 30
```

## Script 3: Generate-HybridIdentityReport.ps1

**What it does**  
Creates a plain-text summary report that combines the scheduler status and recent runs. Useful for pasting into a ticket or saving for later.

**How it works**  
- Collects scheduler information.
- Collects the last few run results.
- Writes everything to a text file (default name `HybridIdentityReport.txt` in the current folder).

**How to run**
```powershell
.\Generate-HybridIdentityReport.ps1
# Or specify a path
.\Generate-HybridIdentityReport.ps1 -OutputPath "C:\Temp\HybridReport.txt"
```

## Common problems when running the scripts

| Problem | Cause | Fix |
|---------|-------|-----|
| “ADSync module not found” | You are not on the Entra Connect server | Log on to the Entra Connect server or remote into it |
| Access denied | PowerShell not elevated | Right-click PowerShell → Run as administrator |
| No output / empty | Service stopped or module issue | Check `Get-Service ADSync` first |

## Safety note

All three scripts are deliberately read-only. They never call `Start-ADSyncSyncCycle` or change configuration. You can run them safely at any time.
