<#
.SYNOPSIS
    Read-only status check for Microsoft Entra Connect scheduler and service.
.DESCRIPTION
    Displays scheduler settings, staging mode, last run status, and ADSync service state.
    Safe to run; makes no changes.
.NOTES
    Run on the Entra Connect server (or via remote PowerShell).
#>
[CmdletBinding()]
param()

try {
    Import-Module ADSync -ErrorAction Stop
}
catch {
    Write-Error "ADSync module not found. Run this on the Entra Connect server."
    return
}

$scheduler = Get-ADSyncScheduler -ErrorAction SilentlyContinue
$service   = Get-Service -Name ADSync -ErrorAction SilentlyContinue

[PSCustomObject]@{
    SyncCycleEnabled    = $scheduler.SyncCycleEnabled
    StagingModeEnabled  = $scheduler.StagingModeEnabled
    SchedulerSuspended  = $scheduler.SchedulerSuspended
    LastRunStatus       = $scheduler.LastRunStatus
    NextSyncCycleUTC    = $scheduler.NextSyncCycleStartTimeInUTC
    ADSyncServiceStatus = if ($service) { $service.Status } else { "Not found" }
    Timestamp           = Get-Date
} | Format-List
