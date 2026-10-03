# Implementation plan

## P0 — Upstream audit and architecture proof

Objective: determine whether WooNext can be the foundation without hidden payment/session traps.

Deliverables:

- `docs/P0_AUDIT.md` with a pass/fail/unknown matrix.
- one chosen cart/session strategy.
- one chosen phase-1 payment handoff strategy.
- list of required WordPress plugins.
- local build/test instructions confirmed.
- risk list with severity.

Audit checklist:

- [ ] Clone WooNext and record upstream commit SHA.
- [ ] Run install, lint, tests and production build.
- [ ] Trace product fetching end-to-end.
- [ ] Trace add/update/remove cart paths.
- [ ] Confirm persistence across refresh and new tab.
- [ ] Trace coupon application/removal.
- [ ] Trace shipping address and rate selection.
- [ ] Trace guest checkout.
- [ ] Trace logged-in checkout.
- [ ] Trace payment gateway discovery.
- [ ] Trace order creation and total calculation.
- [ ] Check idempotency / duplicate-submit behavior.
- [ ] Trace payment redirect/return behavior.
- [ ] Trace order-status confirmation.
- [ ] Audit JWT cookie flags and token handling.
- [ ] Audit server/client secret boundaries.
- [ ] Audit webhook/revalidation validation.
- [ ] Compare payment flow to 9d8dev/next-woo native payment redirect.
- [ ] Decide whether phase 1 should reuse WooNext checkout or use native Woo payment handoff.

## P1 — Local WooCommerce integration

Objective: prove real data, not mocks.

- WordPress + WooCommerce instance available.
- API user and server-only REST credentials.
- test products: simple + variable + out-of-stock.
- one coupon.
- two shipping scenarios.
- COD/offline gateway for smoke testing.

Acceptance flow:

```text
product -> add -> quantity change -> coupon -> shipping -> create order -> payment handoff -> confirmation
```

## P2 — Commerce adapter cleanup

Objective: isolate Woo specifics from React components.

Create a small typed boundary for:

- catalog;
- cart;
- checkout;
- account;
- payment handoff;
- order lookup.

No component should directly assemble authenticated Woo REST calls.

## P3 — Payment compatibility spike

Objective: validate the actual Woo payment plugin chosen for production.

First target: Redsys/Bizum candidate once merchant/gateway configuration is available.

Test cases:

- successful payment;
- failed payment;
- cancelled payment;
- 3DS challenge;
- refresh during payment;
- duplicate click;
- return with stale browser session;
- callback arrives before browser return;
- callback arrives after browser return;
- refund from Woo admin;
- order status reconciliation.

Do not replace native Woo handoff until these cases pass in a headless flow.

## P4 — Accounts

- register/login/logout;
- HTTP-only secure session approach;
- account details;
- order list/detail;
- password reset decision;
- guest-to-account strategy if desired.

## P5 — Production ops

- caching/revalidation;
- observability/error reporting;
- backups;
- rate limiting;
- WAF/CDN;
- staging environment;
- CI build/test;
- dependency update strategy;
- payment and order alerting.

## P6 — Design

Only after the commerce path is stable, replace the starter visual layer systematically. Commerce adapter contracts should remain stable while UI changes.
