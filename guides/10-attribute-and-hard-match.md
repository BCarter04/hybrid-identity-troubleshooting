# Attribute Conflicts and Hard Match

## Hard Match Security Hardening

Microsoft blocks hard matching in certain cases to prevent an on-premises account from taking over a privileged cloud-only account.

**Typical errors:**
- `InvalidHardMatch` — “The cloud user with privileged roles is not allowed to be taken over”
- “Hard match operation blocked due to security hardening”

This is **intentional**. Do not try to force it for Global Administrator or other privileged roles.

## Source Anchor

The source anchor (usually `mS-DS-ConsistencyGuid`) is the immutable link between the on-premises object and the Entra object. Changing or clearing it incorrectly causes orphaned or duplicated objects.

## Interview tip

“Hard-match blocking on privileged accounts is a security feature introduced to stop accidental or malicious takeover. I treat those errors as expected and look for soft-match or manual linking approaches instead of forcing a hard match.”
