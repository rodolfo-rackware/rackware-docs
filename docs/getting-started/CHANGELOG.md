# Getting Started Guide – changelog

## 1.2 – November 2026
Second validation by an independent "new customer" walk-through (0 blockers, 4 major findings).
- OCI permissions moved before the Cloud User form, with the complete minimum policy, dynamic group (instance principal) and API-key options.
- BYOL trial clarified: 2 free licenses valid 30 days, requested with `rwadm relicense` + email.
- Pre-Provisioning wording corrected (target VM is created when the wave starts).
- New section 9.8 "Stop protecting a server / clean up".
- Firewall how-tos (OCI Security List, firewalld), DR dialog options, schedule ranges, toolbar tooltip names, sizing aligned with the Marketplace listing.
- Plain-text commands file for copy and paste.
- Moved from Word to Markdown in this repository.

## 1.1 – November 2026
First validation walk-through (1 blocker, 36 findings).
- Web-console user creation for all Marketplace listings; DR disk (ZFS pool) setup; licensing steps.
- Existing-target registration, failover groups with tiers, labelled icon toolbars.
- Clarified the two meanings of Complete Failover; cutover guidance; consistent example names; personal names removed from screenshots.

## 1.0 – November 2026
First version, built from a live migration and DR test on RMM 7.7.6.5 in OCI.
