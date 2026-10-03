# Upstream evaluation

Research snapshot: 2026-10-03.

## 1. Invizo/woonext — PRIMARY CANDIDATE

Repository: https://github.com/Invizo/woonext

Observed repository metadata/features:

- MIT license.
- Next.js 16.1.x, React 19.2.x, TypeScript.
- WordPress REST/GraphQL support.
- WooCommerce catalog support.
- cart route and checkout route.
- payment gateway route.
- JWT authentication.
- account dashboard, order list and profile update flows.
- revalidation webhook support.
- Vitest tests.
- standalone Next output.

Why it is attractive: it already covers most of the boring plumbing we want to avoid rebuilding.

Risks to audit:

- exactly how cart persistence works with and without WPGraphQL for WooCommerce;
- whether checkout is sufficiently compatible with real third-party Woo gateways;
- whether JWT implementation and cookies meet our production security expectations;
- amount of dependence on specific plugins;
- idempotency/duplicate order behavior;
- shipping/coupon completeness.

## 2. 9d8dev/next-woo — PAYMENT-COMPATIBILITY FALLBACK

Repository: https://github.com/9d8dev/next-woo

Observed repository metadata/features:

- MIT license.
- Next.js 16 / React 19 / TypeScript.
- product browsing/search/filtering.
- persistent client cart using localStorage.
- Next checkout form creates Woo order.
- payment redirects to WooCommerce order/payment URL.
- account redirects to native WooCommerce My Account.
- cache revalidation plugin included.

Why it matters: the native payment redirect is conceptually robust for gateway plugins such as a Redsys integration that may expect WooCommerce hooks/runtime.

Trade-offs:

- weaker headless account experience out of the box;
- localStorage cart is simpler but may not be the final desired session model;
- less infrastructure included than WooNext.

## 3. vakulkin/nextjs-woocommerce — REFERENCE ONLY

Repository: https://github.com/vakulkin/nextjs-woocommerce

Observed features:

- Next.js 16 headless Woo storefront.
- Woo Store API.
- Server Actions.
- Zustand.
- Zod.
- persistent cart/session handling.
- multi-step checkout and live shipping.
- GA4 ecommerce instrumentation.
- Stripe-centric payment implementation plus webhook sync.

Critical licensing note: GitHub repository metadata currently reports no license. Therefore we may read and learn from public behavior/documentation, but **must not copy code into the commercial project unless the author provides an appropriate license or permission**.

## Working recommendation

Start by auditing **WooNext**. Keep **Next Woo's native Woo payment handoff** as the planned fallback if WooNext's payment path proves brittle with Redsys/Bizum or another third-party gateway.

Do not combine code from all three "because it exists". Select the smallest stable base and add only demonstrated requirements.
