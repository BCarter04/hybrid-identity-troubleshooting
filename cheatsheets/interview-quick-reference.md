# Interview Quick Reference — Hybrid Identity & PIM

## Must-know terms

- **Password Hash Sync (PHS)** — Hashes synced to Entra; most common and recommended for most orgs.
- **Pass-through Authentication (PTA)** — Agents validate passwords against on-premises AD in real time.
- **Federation** — Redirects authentication to AD FS or another IdP.
- **Seamless SSO** — Kerberos-based silent sign-in for domain-joined devices.
- **Source Anchor** — Immutable identifier linking on-premises object to cloud object (usually mS-DS-ConsistencyGuid).
- **Hard Match** — Matching an existing cloud object to an on-premises object (restricted for privileged accounts).
- **Eligible vs Active (PIM)** — Just-in-time vs standing privilege.
- **PIM for Groups** — JIT membership of a security group (excellent for hybrid-sourced privileged groups).

## Classic interview questions

**“User changed password on-premises but cannot sign in to Microsoft 365.”**
- Confirm authentication method (PHS most common).
- Check last password hash sync time / force password sync if needed.
- Verify no Conditional Access or MFA issue.
- Check for account lockout on-premises.

**“Object is not appearing in Entra ID.”**
- Is it in sync scope?
- Has a sync cycle run?
- Any export errors?
- Staging mode or scheduler disabled?

**“How do you reduce standing privileged access?”**
- Convert permanent role assignments to Eligible (PIM).
- Require MFA + justification + short duration.
- Use PIM for Groups for hybrid-sourced privileged groups.
- Regular access reviews.
- Keep permanent only for documented break-glass accounts.

**“What is the difference between PHS, PTA, and Federation?”**
- PHS: hashes in cloud, works even if on-prem is down (for cloud sign-in).
- PTA: real-time validation against AD; needs healthy agents.
- Federation: full redirect to external IdP; more complex, certificate and claim issues.

**“When would you *not* use PIM?”**
- True always-on operational need that cannot tolerate activation.
- Non-privileged ordinary group membership.
- Service principals that cannot interactively activate.
- As a replacement for Conditional Access on normal user sign-in.

**“A PIM activation is failing. Walk me through your steps.”**
1. Confirm Eligible assignment exists.
2. Check role settings (MFA, approval, justification, duration).
3. Review sign-in logs for Conditional Access blocks on the PIM app.
4. Check audit logs for activation events.
5. In hybrid: confirm any source group has synced.

## Quick commands (Entra Connect server)

```powershell
Import-Module ADSync
Get-ADSyncScheduler
Get-Service ADSync
Start-ADSyncSyncCycle -PolicyType Delta
Get-ADSyncRunProfileResult | Select-Object -First 5
```

## One-sentence answers interviewers like

- “I separate sync problems from authentication method problems from Conditional Access and PIM activation problems.”
- “For PIM I always check whether the assignment is Eligible, what the activation requirements are, and the sign-in logs around the activation attempt.”
- “Hard matching privileged cloud accounts is blocked by design — that is a security control, not a bug.”
- “Eligible is the default; permanent is the exception and must be justified as break-glass.”
