# Claude Code — first run

Use this as the first task after opening the repository in Claude Code.

```text
Read CLAUDE.md, README.md, docs/ARCHITECTURE.md, docs/UPSTREAM_EVALUATION.md and docs/IMPLEMENTATION_PLAN.md completely before modifying code.

Do not work on aesthetics yet.

Execute P0 only.

1. Run scripts/bootstrap-upstream.ps1 on Windows or scripts/bootstrap-upstream.sh on macOS/Linux.
2. Audit Invizo/woonext at the exact cloned commit. Run install, lint, tests and production build.
3. Trace the code paths for catalog, cart persistence, guest cart, coupons, shipping, JWT/auth cookies, checkout/order creation, payment gateway discovery, payment redirect/return, order status, webhooks/revalidation and server/client secret boundaries.
4. Compare only the payment/session architecture against 9d8dev/next-woo. Do not merge or copy code yet.
5. Do not copy code from vakulkin/nextjs-woocommerce because no license is currently confirmed. You may read its public documentation for architectural ideas.
6. Write docs/P0_AUDIT.md with a table: Area | WooNext behavior | Risk | Test performed | Result | Proposed action.
7. Update docs/DECISIONS.md only for decisions supported by the audit.
8. Update docs/STATUS.md and docs/OPEN_QUESTIONS.md.
9. Stop before large implementation work and summarize the recommended base plus the exact reason. If WooNext passes, propose the smallest next commit to adopt it. If it fails on payment compatibility, propose keeping WooNext for storefront/account while using a Woo-native payment handoff pattern.

Important: WooCommerce must remain the source of truth for totals, stock, coupons, shipping and order/payment state. Never trust totals supplied by the browser.
```
