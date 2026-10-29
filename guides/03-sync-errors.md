# Sync Errors

## Where to look

1. **Synchronization Service Manager** → Operations tab → look for Export errors on the Entra ID connector.
2. **Microsoft Entra Connect Health** → Sync errors.
3. PowerShell: review recent run results (see `Get-RecentSyncRuns.ps1`).

## Most common error categories

| Category | Typical cause | Action |
|----------|---------------|--------|
| Duplicate attribute (UPN, proxyAddress) | Conflict with existing cloud or on-prem object | Resolve duplicate, then sync |
| InvalidHardMatch | Attempt to hard-match a privileged cloud account | Expected security control — see attribute guide |
| Permission / connectivity | Connector account or network issue | Check service account and firewall |
| Accidental delete threshold | Large number of deletions | Review before allowing |

## Interview tip

“I open Synchronization Service Manager, filter for Export errors on the Entra connector, and treat duplicate attribute and hard-match errors as the two most frequent production issues. I never disable the scheduler as a first step.”
