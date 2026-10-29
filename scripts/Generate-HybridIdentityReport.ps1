<#
.SYNOPSIS
    Generates a simple text summary of Entra Connect health.
.DESCRIPTION
    Combines scheduler status and recent runs into one report.
    Read-only.
#>
[CmdletBinding()]
param(
    [string]$OutputPath = ".\HybridIdentityReport.txt"
)

Import-Module ADSync -ErrorAction Stop

$report = @()
$report += "Hybrid Identity Health Report"
$report += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$report += "========================================`n"

$sched = Get-ADSyncScheduler
$report += "Scheduler"
$report += "  SyncCycleEnabled   : $($sched.SyncCycleEnabled)"
$report += "  StagingModeEnabled : $($sched.StagingModeEnabled)"
$report += "  LastRunStatus      : $($sched.LastRunStatus)"
$report += "  NextSync (UTC)     : $($sched.NextSyncCycleStartTimeInUTC)`n"

$report += "Recent Runs"
$runs = Get-ADSyncRunProfileResult | Sort-Object StartDate -Descending | Select-Object -First 8
foreach ($r in $runs) {
    $report += ("  {0,-30} {1,-12} {2} → {3}" -f $r.ConnectorName, $r.RunProfileName, $r.StartDate, $r.Result)
}

$report += "`nEnd of report"

$report | Out-File -FilePath $OutputPath -Encoding utf8
Write-Host "Report written to $OutputPath"
Get-Content $OutputPath
