# Architecture

## Objective

Use WooCommerce as a mature commerce backend while retaining complete freedom over the public storefront.

## System boundaries

### Next.js owns

- presentation and interaction;
- routing and rendering;
- storefront search/filter UX;
- cart presentation;
- checkout presentation/orchestration;
- customer-facing account presentation where supported;
- cache/revalidation logic;
- analytics event emission;
- a thin server-side Woo adapter.

### WooCommerce owns

- product records and variants;
- canonical prices;
- stock;
- tax rules;
- shipping methods/rates;
- coupons and discount validity;
- customer/order records;
- canonical order totals;
- order state machine;
- payment gateway configuration;
- refunds and operational admin workflows;
- plugin integrations.

### Payment provider owns

- card/payment credentials where applicable;
- authorization/authentication such as 3DS;
- payment result;
- gateway callbacks.

Next.js must never become the canonical payment ledger.

## Phase-1 checkout strategy

The default assumption is **hybrid checkout**:

1. User browses and adds to cart in Next.js.
2. Next.js submits validated customer/cart data server-side.
3. WooCommerce recalculates totals, shipping, coupon validity and stock.
4. WooCommerce creates/updates the order.
5. For gateways that expect Woo runtime/hooks, the user is handed off to the native Woo payment endpoint.
6. Payment gateway completes 3DS/payment/callback flow.
7. Gateway/Woo updates the order.
8. User returns to a Next.js confirmation page.
9. Next.js fetches authoritative order status server-side before displaying success.

This is intentionally less "pure headless" than reimplementing payment, because plugin compatibility is worth more than architectural purity.

## Future option

If the chosen gateway exposes a stable server API or Woo Store API integration that is demonstrably headless-safe, the payment form can later move fully into Next.js without changing the rest of the storefront.

## Security boundaries

- Woo consumer secret: server only.
- WordPress JWT secret: WordPress only.
- Customer auth token: HTTP-only, secure cookie where feasible.
- Payment secrets: server only.
- Browser-submitted prices/totals are advisory only; Woo recalculates.
- Checkout endpoints need CSRF/origin protection appropriate to the chosen session model.
- Webhooks require signature/shared-secret validation and idempotency.

## Deployment hypothesis

```text
www.example.com       -> Next.js (Vercel or equivalent)
admin.example.com     -> WordPress/WooCommerce managed host
payment/admin routes  -> WordPress/WooCommerce as required
media                 -> WordPress/CDN/object storage
```

The exact hosts remain open until P0/P1.
