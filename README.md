# Hybrid Identity Troubleshooting

Practical guides and PowerShell scripts for diagnosing Microsoft Entra Connect (hybrid identity) issues, authentication methods, Seamless SSO, hybrid join, attribute problems, and Privileged Identity Management (PIM / Just-in-Time) activation issues.

Designed for daily troubleshooting **and** as interview preparation material for Identity & Access Management roles.

All content is generic and professional. Sample outputs are realistic but fully anonymized.

## Quick Start

1. Start with the [Decision Tree](guides/01-decision-tree.md).
2. Jump to the relevant guide based on the symptom.
3. Use the scripts on the Entra Connect server (or remotely via WinRM) for read-only checks.
4. Review the [Interview Quick Reference](cheatsheets/interview-quick-reference.md) before interviews.

## Decision Tree (Summary)

```
User cannot sign in or object not appearing in Entra ID?
│
├─ Is the object expected to be synced?
│  ├─ No → Cloud-only account or not in scope. Check filtering.
│  └─ Yes → Check Entra Connect health → [02-entra-connect-health.md]
│
├─ Sync errors present?
│  └─ Yes → [03-sync-errors.md] and [10-attribute-and-hard-match.md]
│
├─ Authentication failing?
│  ├─ Password Hash Sync → [04-password-hash-sync.md]
│  ├─ Pass-through Authentication → [05-pass-through-authentication.md]
│  └─ Federation → [06-federation.md]
│
├─ Seamless SSO issues? → [07-seamless-sso.md]
├─ Device hybrid join problems? → [08-hybrid-join.md]
└─ Privileged role / JIT activation issues? → [09-pim-jit.md]
```

## Design Principles

- **Read-only by default** — scripts do not change configuration.
- **Symptom-first** — guides start with what the user or admin sees.
- **Interview-aware** — key concepts and “what an interviewer expects” callouts.
- **Realistic samples** — outputs look like a live, well-managed tenant.
- **PIM / JIT included** — because hybrid groups and on-premises identity frequently feed into privileged access.

## Scripts

| Script | Purpose | Run where |
|--------|---------|-----------|
| `Get-EntraConnectStatus.ps1` | Scheduler, staging mode, last run status | Entra Connect server |
| `Get-RecentSyncRuns.ps1` | Recent connector run history | Entra Connect server |
| `Generate-HybridIdentityReport.ps1` | Combined summary report | Entra Connect server |

## License

MIT
