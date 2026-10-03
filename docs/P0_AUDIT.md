# P0 upstream audit

> Fill this document with evidence from the exact upstream commit tested. Do not convert assumptions into decisions.

## Tested revisions

| Repository | Commit SHA | Install | Lint | Tests | Production build |
|---|---|---:|---:|---:|---:|
| Invizo/woonext | TBD | ⏳ | ⏳ | ⏳ | ⏳ |
| 9d8dev/next-woo | TBD | ⏳ | ⏳ | ⏳ | ⏳ |

## Audit matrix

| Area | WooNext behavior | Risk | Test performed | Result | Proposed action |
|---|---|---|---|---|---|
| Product source | TBD | TBD | TBD | ⏳ | TBD |
| Caching/revalidation | TBD | TBD | TBD | ⏳ | TBD |
| Cart persistence | TBD | TBD | TBD | ⏳ | TBD |
| Guest cart | TBD | TBD | TBD | ⏳ | TBD |
| Coupons | TBD | TBD | TBD | ⏳ | TBD |
| Shipping | TBD | TBD | TBD | ⏳ | TBD |
| Guest checkout | TBD | TBD | TBD | ⏳ | TBD |
| Logged-in checkout | TBD | TBD | TBD | ⏳ | TBD |
| JWT/session security | TBD | TBD | TBD | ⏳ | TBD |
| Payment gateways | TBD | TBD | TBD | ⏳ | TBD |
| Order creation | TBD | TBD | TBD | ⏳ | TBD |
| Idempotency | TBD | TBD | TBD | ⏳ | TBD |
| Payment redirect/return | TBD | TBD | TBD | ⏳ | TBD |
| Order confirmation | TBD | TBD | TBD | ⏳ | TBD |
| Webhooks | TBD | TBD | TBD | ⏳ | TBD |
| Secret boundaries | TBD | TBD | TBD | ⏳ | TBD |
| Test coverage | TBD | TBD | TBD | ⏳ | TBD |
| Upgrade coupling | TBD | TBD | TBD | ⏳ | TBD |

## Payment comparison

Document the practical difference between:

1. WooNext's current payment flow.
2. 9d8dev/next-woo's Woo-native order payment redirect.

The recommended production path must prioritize compatibility with the eventual WooCommerce Redsys/Bizum gateway.

## Conclusion

**Recommended base:** TBD

**Cart/session strategy:** TBD

**Phase-1 payment handoff:** TBD

**Blocking risks:** TBD

**Smallest next implementation commit:** TBD
