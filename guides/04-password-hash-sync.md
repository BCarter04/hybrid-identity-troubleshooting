# Password Hash Sync (PHS) Troubleshooting

Password Hash Sync is the most common authentication method in hybrid environments.

## Healthy indicators

- Password changes on-premises appear in Entra ID within a few minutes.
- No “Password Hash Synchronization has stopped working” alerts in Connect Health.
- Users can sign in with the new password after the sync cycle.

## Common symptoms & checks

| Symptom | First checks |
|---------|--------------|
| Password change not working in cloud | Confirm PHS is enabled; check last successful password sync; force delta cycle |
| Intermittent failures | Look for Connect Health alerts; verify Entra Connect version and connectivity |
| Works for some users only | Check if those users are in a different domain or filtered |

## Useful commands (on Entra Connect server)

```powershell
# Diagnostics (requires appropriate build)
Import-Module ADSyncDiagnostics -ErrorAction SilentlyContinue
Invoke-ADSyncDiagnostics -PasswordSync
```

## Interview tip

“With Password Hash Sync I confirm the feature is enabled, check for Connect Health alerts, verify a recent successful sync cycle, and remember that a full password sync can be forced if needed. I also rule out Conditional Access and account lockout.”
