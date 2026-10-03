# Decision log

## ADR-001 — WooCommerce is the commerce source of truth

**Status:** Accepted for prototype.

Products, prices, stock, coupons, shipping, customers, orders and payment status remain canonical in WooCommerce. Next.js owns the customer experience, not commerce truth.

## ADR-002 — Headless storefront, not a custom WordPress theme

**Status:** Accepted for prototype.

Reason: the project owner wants normal React/Next.js development freedom and does not want the final design constrained by theme templates/page builders.

## ADR-003 — Start from an existing MIT storefront

**Status:** Accepted.

Primary candidate: `Invizo/woonext`. Fallback/reference: `9d8dev/next-woo`.

Reason: cart/auth/account/checkout plumbing already exists and is not a differentiator for the business.

## ADR-004 — Payment compatibility over headless purity

**Status:** Accepted for phase 1.

A Woo-native payment redirect/handoff is acceptable if it preserves third-party gateway compatibility. Fully headless payment is an optimization, not a launch requirement.

## ADR-005 — Do not copy unlicensed public code

**Status:** Accepted.

`vakulkin/nextjs-woocommerce` may inform architectural thinking, but code will not be copied while the repository lacks an appropriate license.
