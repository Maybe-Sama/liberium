# Liberium

Working repository for a custom headless ecommerce storefront backed by WooCommerce.

## Goal

Build the storefront as a normal modern Next.js application while WooCommerce remains the commerce engine and admin panel.

The project deliberately separates:

- **Storefront:** Next.js / React / TypeScript / Tailwind.
- **Commerce source of truth:** WordPress + WooCommerce.
- **Payments:** configured in WooCommerce. Phase 1 should preserve native WooCommerce payment compatibility instead of reimplementing a gateway in Next.js.
- **Design:** intentionally deferred. The first milestone is functional infrastructure, not final aesthetics.

## Current architecture hypothesis

```text
Customer
  |
  v
Next.js storefront
  |  products / cart / account / checkout orchestration
  v
WooCommerce / WordPress
  |  catalog / stock / orders / customers / coupons / shipping / plugins
  v
WooCommerce payment gateway
  |  Redsys / Bizum candidate, subject to integration validation
  v
Bank / acquirer
```

The most important architectural rule is that **WooCommerce remains the source of truth for commerce state**. The Next.js app is not allowed to become a second ecommerce backend.

## Starting point

Primary upstream candidate:

- [Invizo/woonext](https://github.com/Invizo/woonext) — MIT — Next.js 16 + React 19 + TypeScript; catalog, cart, checkout, WooCommerce payment methods, JWT login, account/orders/profile, revalidation.

Secondary upstream candidate:

- [9d8dev/next-woo](https://github.com/9d8dev/next-woo) — MIT — simpler architecture; client cart + order creation + redirect to native WooCommerce payment/account flows. Useful as the compatibility-first payment fallback.

Reference only:

- [vakulkin/nextjs-woocommerce](https://github.com/vakulkin/nextjs-woocommerce) — technically interesting Store API / Server Actions / Zustand implementation, but the repository currently exposes no license in GitHub metadata. **Do not copy code from it unless a usable license is confirmed.** It may be studied as an architectural reference only.

See `docs/UPSTREAM_EVALUATION.md`.

## First milestone

A local proof of concept that proves this flow end-to-end:

```text
Woo product -> Next product page -> cart -> shipping/coupon -> order -> Woo payment handoff -> order confirmation
```

No final branding, animation system, design system, product copy, SEO campaign work or catalogue import should block this milestone.

## For Claude Code

Read `CLAUDE.md` before doing anything. Then execute the P0 audit in `docs/IMPLEMENTATION_PLAN.md`.

## Bootstrap

On Windows PowerShell:

```powershell
./scripts/bootstrap-upstream.ps1
```

On macOS/Linux:

```bash
bash ./scripts/bootstrap-upstream.sh
```

The bootstrap script clones the two MIT upstreams into a sibling `_upstreams` directory for comparison. It does **not** merge them automatically. Claude must audit before choosing or porting code.
