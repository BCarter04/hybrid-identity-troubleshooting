# Common Errors — Quick Reference

| Error / Message | Likely meaning | Guide |
|-----------------|----------------|-------|
| SyncCycleEnabled = False | Scheduler disabled | 02-entra-connect-health |
| StagingModeEnabled = True | Server not exporting | 02-entra-connect-health |
| InvalidHardMatch / Hard match blocked | Security hardening preventing takeover of privileged cloud account | 10-attribute-and-hard-match |
| AttributeValueMustBeUnique | Duplicate UPN, proxyAddress, etc. | 03-sync-errors |
| AADSTS80001 | PTA agent cannot reach Active Directory | 05-pass-through-authentication |
| MFA loop on PIM activation | Conditional Access intercepting activation | 09-pim-jit |
| Role activates but no access | Propagation delay or app caching | 09-pim-jit |
| Seamless SSO fails on some clients | Kerberos ticket size, private browsing, or prerequisites | 07-seamless-sso |

## Interview one-liners

- Hard match block on privileged accounts = intentional security control.
- PIM activation issues almost always start with sign-in logs + role settings.
- Always confirm the server is not in staging mode before blaming the network.
