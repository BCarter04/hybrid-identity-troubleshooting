# Seamless Single Sign-On

Seamless SSO uses Kerberos to give domain-joined, corporate-network devices a silent sign-in experience.

## Common failure reasons

- Feature not enabled in Entra Connect
- Device not domain-joined or not on the corporate network
- Kerberos ticket too large (user in too many groups)
- Private browsing mode
- Cached ticket still valid after disable/re-enable (up to ~10 hours)

## Quick checks

- Confirm Seamless SSO is enabled in the Entra admin center under Microsoft Entra Connect.
- Test from a domain-joined device on the corporate network.
- Reduce group membership if ticket size is suspected.

## Interview tip

“Seamless SSO is Kerberos-based and only works for domain-joined devices on the corporate network. Ticket size and private browsing are the two issues I check first when it works for some users but not others.”
