# CLAUDE.md — Liberium operating instructions

You are working on a headless WooCommerce commerce project. Your job is to establish a reliable technical foundation before aesthetic work begins.

## Product intent

The owner wants to design the public storefront as a normal modern web application without fighting WordPress themes page by page. WordPress/WooCommerce should function as the commerce engine and operations back office.

The desired developer experience is:

```text
Next.js / React components -> WooCommerce APIs -> WooCommerce orders/payments/plugins
```

not:

```text
Custom Next.js ecommerce backend -> duplicated cart/order/payment logic -> WooCommerce as an afterthought
```

## Non-negotiable principles

1. **WooCommerce is the source of truth** for products, stock, customers, orders, coupons, shipping and payment state.
2. Do not build a second ecommerce backend in Next.js.
3. Do not hard-wire Stripe. The business requires a payment path compatible with the merchant category; Redsys/Bizum is a candidate and must be validated independently.
4. Phase 1 must optimize for **WooCommerce gateway/plugin compatibility**. A native Woo payment handoff is acceptable and preferred over a fragile custom payment implementation.
5. Do not begin final aesthetic work. UI may remain placeholder-quality until P0/P1 are green.
6. Preserve upstream MIT notices and attribution when copying substantial code from MIT projects.
7. `vakulkin/nextjs-woocommerce` currently has no license exposed in repository metadata. Study it; do not copy its code unless licensing is verified.
8. Never expose Woo REST secrets, WordPress admin credentials, JWT secrets or payment secrets to the browser. Server-only credentials stay server-only.
9. Every architecture change must reduce or clearly justify coupling to WordPress/WooCommerce internals.
10. Prefer small commits with one concern each. Never mix architecture refactors and visual redesign in the same commit.

## Upstreams

### Primary candidate — WooNext

Repository: https://github.com/Invizo/woonext

Why it is the primary candidate:

- MIT licensed.
- Next.js 16 / React 19 / TypeScript.
- Catalog, cart and checkout paths already exist.
- WooCommerce payment gateway discovery exists.
- JWT customer authentication exists.
- Account dashboard, order list and customer profile paths exist.
- Revalidation infrastructure exists.
- Has tests and its own contributor/Claude documentation.

Do not trust the README blindly. Audit the code paths listed in P0.

### Compatibility fallback — Next Woo

Repository: https://github.com/9d8dev/next-woo

Why it matters:

- MIT licensed.
- Simpler payment strategy: create the Woo order and redirect to WooCommerce for payment.
- This pattern maximizes compatibility with payment gateway plugins and is therefore a serious fallback for Redsys/Bizum.

### Architecture reference only

Repository: https://github.com/vakulkin/nextjs-woocommerce

Useful ideas to inspect conceptually:

- Woo Store API.
- Server Actions.
- Zustand cart/checkout state.
- Zod validation.
- Live shipping calculations.
- GA4 ecommerce instrumentation.

Do not copy source code until a license is confirmed.

## P0 — mandatory audit before feature work

Execute the checklist in `docs/IMPLEMENTATION_PLAN.md` and write findings to `docs/P0_AUDIT.md`.

At minimum inspect:

- product source and caching;
- cart persistence strategy;
- guest cart behavior;
- login/JWT cookie security;
- checkout/order creation;
- coupon handling;
- shipping rate calculation;
- payment gateway enumeration;
- redirect/callback handling;
- Woo order status synchronization;
- webhooks/revalidation;
- error handling and idempotency;
- server/client credential boundaries;
- test coverage;
- upgrade coupling to Woo internals.

## Architecture target

Preferred phase-1 shape:

```text
Next.js
  |- storefront UI
  |- cart UX
  |- account UX where stable
  |- checkout data collection where useful
  |- server-side Woo adapter
  |
  +--> WooCommerce REST/Store API
          |- catalog
          |- stock
          |- coupons
          |- shipping
          |- customers
          |- orders
          |- payment gateway plugin
                |
                +--> native/hosted payment flow when required
```

A user-visible redirect to a branded WooCommerce payment route is acceptable for the first production version if it materially increases payment reliability. We can eliminate the redirect later only after the payment adapter is proven.

## Payment abstraction

Do not scatter payment-provider assumptions across components. Introduce one application-level boundary such as:

```ts
interface PaymentHandoff {
  createOrLoadOrder(input: CheckoutInput): Promise<OrderRef>
  getPaymentDestination(order: OrderRef): Promise<PaymentDestination>
  verifyReturn(input: PaymentReturn): Promise<PaymentVerification>
}
```

The implementation may initially be `WooNativePaymentHandoff`.

Do not invent a Redsys API implementation until the chosen WooCommerce Redsys plugin and its real behavior are available for testing.

## Required quality gates

Before declaring the infrastructure milestone complete:

- `pnpm lint` passes.
- type checking passes.
- existing tests pass.
- add tests around our adapter boundaries.
- no secret appears in client bundles or `NEXT_PUBLIC_*` unless intentionally public.
- guest cart survives refresh.
- duplicate checkout submission cannot create accidental duplicate paid orders.
- failed/cancelled payment returns are handled.
- order totals are calculated/verified by WooCommerce, not trusted from browser state.
- inventory is checked server-side before payment handoff.

## Work style

When a decision is uncertain, document the trade-off in `docs/DECISIONS.md` before implementing a large change. Prefer proving a thin vertical slice over expanding breadth.

At the end of each work session update:

- `docs/STATUS.md` — what works now;
- `docs/DECISIONS.md` — decisions taken;
- `docs/OPEN_QUESTIONS.md` — unresolved items requiring owner input.

Do not wait for aesthetic direction to continue infrastructure work.
