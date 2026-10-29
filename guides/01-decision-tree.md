# Decision Tree — Hybrid Identity & PIM Troubleshooting

Use this as the starting point for both production issues and interview scenarios.

## 1. Object not appearing or not updating in Entra ID

**Questions to ask:**
- Is the user/group in the scope of the sync (OU filtering, domain filtering, group-based filtering)?
- Has a sync cycle run since the change?
- Are there export errors on the Entra ID connector?

**Next steps:**
1. Run `Get-EntraConnectStatus.ps1` or check the scheduler.
2. Force a delta sync if safe: `Start-ADSyncSyncCycle -PolicyType Delta`
3. Review Synchronization Service Manager → Operations → Export errors.
4. See [Entra Connect Health](02-entra-connect-health.md) and [Sync Errors](03-sync-errors.md).

## 2. User cannot authenticate (sign-in fails)

**Identify the authentication method** (Entra admin center → Microsoft Entra Connect → Authentication methods, or check `Get-MgDomain` / tenant settings).

| Method | Typical symptom | Guide |
|--------|-----------------|-------|
| Password Hash Sync | “Incorrect password” after on-prem password change | [04-password-hash-sync.md] |
| Pass-through Authentication | Agent offline or AADSTS80001 | [05-pass-through-authentication.md] |
| Federation | Certificate, claim, or time skew issues | [06-federation.md] |
| Seamless SSO | Works on some devices, fails on others | [07-seamless-sso.md] |

Also check Conditional Access and MFA status — they can look like hybrid identity problems.

## 3. Hybrid-joined device issues

Symptoms: device not registered, PRT not issued, “account does not exist”.

→ [Hybrid Join](08-hybrid-join.md)

## 4. Privileged access / Just-in-Time (PIM) problems

Symptoms:
- Eligible role does not activate
- Activation stuck in Pending
- MFA loop during activation
- Group membership (PIM for Groups) not granting expected access
- Permanent assignment still present when it should be eligible only

→ [PIM and JIT](09-pim-jit.md)

## 5. Hard match or attribute conflicts (especially privileged users)

Error examples: `InvalidHardMatch`, “Hard match operation blocked due to security hardening”.

→ [Attribute and Hard Match](10-attribute-and-hard-match.md)

## Interview tip

When asked “How would you troubleshoot a hybrid identity sign-in issue?”, start with this decision tree. Interviewers want to see you separate **sync**, **authentication method**, **Conditional Access**, and **PIM activation** rather than jumping straight to one tool.
