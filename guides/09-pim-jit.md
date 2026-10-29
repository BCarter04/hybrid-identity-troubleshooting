# Privileged Identity Management (PIM) and Just-in-Time Access — Practical Guide

PIM lives in the **Microsoft Entra admin center** (not in Intune).  
Path: **Identity governance → Privileged Identity Management**.

You need a Microsoft Entra ID P2, Microsoft Entra ID Governance, or Microsoft Entra Suite license to use Eligible assignments. Without it you can only make Active assignments.

## Core concepts (simple)

| Concept | What it means | What the user experiences |
|---------|---------------|---------------------------|
| **Eligible** | The user is allowed to activate the role when they need it. They do **not** have the privileges until they activate. | They see the role under “My roles” and must click Activate. |
| **Active / Permanent** | The role is always on (standing privilege). No activation required. | The user already has the role. They can use it immediately. |
| **Activation** | The short process (usually MFA + reason, sometimes approval) that temporarily turns Eligible into Active. | User clicks Activate, completes checks, role becomes available for a limited time, then expires. |
| **PIM for Groups** | Just-in-time membership (or ownership) of a security group. Very useful with hybrid-synced groups that grant access. | User activates membership in the group; group membership appears only while activated. |

## When to use each type

**Use Eligible (recommended default) when:**
- The person only needs the privilege sometimes (e.g., helpdesk lead who occasionally needs User Administrator).
- You want an audit trail of when and why someone elevated.
- You want to force MFA, a ticket number, or approval at elevation time.
- You are reducing standing (always-on) privileged accounts.

**Use Active / Permanent only for:**
- Break-glass / emergency accounts (highly controlled, monitored, not used daily).
- Service principals or managed identities that cannot click “Activate”.

**Do not use PIM for:**
- Ordinary non-privileged group membership.
- Everyday sign-in MFA or Conditional Access (those are separate).

## Scenario 1 — Make a user Eligible for a role (most common)

**Goal:** Jane Doe should be able to become Global Administrator only when she needs it.

1. Sign in to the Microsoft Entra admin center as a Privileged Role Administrator or Global Administrator.  
   https://entra.microsoft.com
2. Go to **Identity governance → Privileged Identity Management → Microsoft Entra roles**.
3. Select **Roles**.
4. Click **Add assignments**.
5. Select the role (e.g., Global Administrator).
6. Select the user (Jane Doe).
7. On the next screen choose **Assignment type = Eligible**.
8. Leave it permanent or set an end date.
9. Click **Assign**.

Jane is now Eligible. She does **not** have Global Administrator rights until she activates.

## Scenario 2 — User activates the role when needed

1. Jane signs in to the Entra admin center.
2. Goes to **Identity governance → Privileged Identity Management → My roles → Microsoft Entra roles**.
3. Finds Global Administrator and clicks **Activate**.
4. Completes MFA if required.
5. Enters a reason (e.g., “INC-48291 – mailbox recovery”).
6. Clicks **Activate**.

The role becomes Active for the configured duration (often 1–8 hours), then automatically returns to Eligible.

## Scenario 3 — PIM for Groups (hybrid-friendly)

**Goal:** A synced on-premises group should not have standing privileged membership. Users activate membership only when needed.

1. Create or choose a cloud security group (note: groups synchronized from on-premises cannot be managed directly in PIM for Groups — you usually create a cloud group and nest or manage membership carefully).
2. Go to **Identity governance → Privileged Identity Management → Groups**.
3. Select **Discover groups** → choose the group → **Manage groups**.
4. Open the group → **Assignments** → **Add assignments**.
5. Choose role = **Member**.
6. Select the users.
7. Set **Assignment type = Eligible**.
8. Click **Assign**.

Users can now activate membership the same way they activate a role (My roles → Groups → Activate).

## Role settings you should configure

Inside the role (or group) → **Settings** → Edit:

- Require MFA on activation
- Require justification
- Optionally require approval
- Set maximum activation duration (1–4 hours for high-privilege roles)

## Common mistakes

- Assigning Active when you meant Eligible → the user has standing privilege.
- Forgetting to remove the old permanent role assignment after making the user Eligible.
- Expecting PIM to appear in the Intune admin center — it is only in the Entra admin center.
- Trying to enable PIM for Groups on a group that is synchronized from on-premises (not supported).

## Interview tip

“I make users Eligible by default, configure MFA + justification on activation, and only keep permanent Active assignments for documented break-glass accounts. Activation happens in Identity governance → Privileged Identity Management → My roles.”
