# Entra Connect Health & Scheduler

## What you should see in a healthy environment

On the Entra Connect server:

```powershell
Import-Module ADSync
Get-ADSyncScheduler
```

**Sample output (healthy):**

```
SyncCycleEnabled             : True
SchedulerSuspended           : False
StagingModeEnabled           : False
NextSyncCycleStartTimeInUTC  : 29/10/2026 13:15:00
LastRunStatus                : Success
```

## Key checks

| Check | Healthy value | Meaning if wrong |
|-------|---------------|------------------|
| `SyncCycleEnabled` | `True` | Scheduler is disabled — no automatic sync |
| `StagingModeEnabled` | `False` | Server is in staging (does not export) |
| `SchedulerSuspended` | `False` | Manual suspension |
| `LastRunStatus` | `Success` | Last cycle failed |
| ADSync service | Running | Service stopped |

## Useful commands

```powershell
# Service status
Get-Service ADSync

# Recent runs
Get-ADSyncRunProfileResult | Sort-Object StartDate -Descending | Select-Object -First 10

# Force delta (only when safe)
Start-ADSyncSyncCycle -PolicyType Delta
```

## Version awareness (important)

Microsoft has required minimum Entra Connect versions for continued operation. Always verify the installed version (Synchronization Service Manager → About, or the version reported in the Entra admin center) and plan upgrades before hard deadlines.

## Interview tip

“I first confirm the scheduler is enabled, the server is not in staging mode, the ADSync service is running, and the last run succeeded. Then I look at export errors before touching authentication settings.”
