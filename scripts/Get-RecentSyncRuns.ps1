<#
.SYNOPSIS
    Shows recent Entra Connect synchronization run results.
.DESCRIPTION
    Read-only. Lists the most recent connector run profile results.
.NOTES
    Run on the Entra Connect server.
#>
[CmdletBinding()]
param(
    [int]$Count = 15
)

Import-Module ADSync -ErrorAction Stop

Get-ADSyncRunProfileResult |
    Sort-Object StartDate -Descending |
    Select-Object -First $Count ConnectorName, RunProfileName, StartDate, EndDate, Result |
    Format-Table -AutoSize
