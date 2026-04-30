---
title: Tool Wrapper design pattern
impact: MEDIUM
tags: [design-pattern, content-design, sdk, api]
---

# design-tool-wrapper -- Encapsulate library/SDK knowledge into a Skill

## Pattern

Wrap a specific library, SDK, or API's usage conventions, common pitfalls, and correct patterns into a Skill. The agent loads this Skill only when it needs to use that library, avoiding context waste.

## When to use

- Agent needs to call a specific SDK/API correctly
- Library has non-obvious conventions (unit formats, required call order, etc.)
- Team repeatedly encounters the same library misuse
- Official docs are too large to fit in context; distill the essentials

## Structure

```
stripe-wrapper/
SKILL.md          # Rules + API quick reference
references/       # Optional: extended docs
  error-codes.md
assets/           # Optional: schema files, examples
  webhook-payload.json
```

## SKILL.md Anatomy

A Tool Wrapper Skill has three key sections:

1. **Usage Rules** -- The "you must / you must not" constraints
2. **API Quick Reference** -- Distilled code snippets for common operations
3. **Pitfall Catalog** -- Known mistakes the agent is likely to make

```markdown
---
name: stripe-wrapper
description: Enforce correct Stripe SDK usage patterns including amount units, customer dedup, and webhook verification
---

## What I do

- Enforce correct Stripe API calling conventions
- Provide quick-reference code snippets for common operations
- Prevent known pitfalls (wrong units, missing dedup, unverified webhooks)

## When to use me

- Writing payment processing code using the Stripe SDK
- Creating or modifying webhook handlers for Stripe events
- Integrating Stripe Checkout or PaymentIntent flows

## Usage Rules

- All monetary amounts must be in cents (not dollars): $20.00 = 2000
- Always check if a Customer already exists by email before creating
- Webhook verification must use stripe.webhooks.constructEvent()
- Never log full card numbers; use last4 only

## API Quick Reference

### Create a PaymentIntent

python
import stripe
stripe.api_key = os.environ["STRIPE_KEY"]

intent = stripe.PaymentIntent.create(
    amount=2000,  # $20.00 in cents
    currency="usd",
    payment_method_types=["card"],
)


### Verify Webhook Signature

python
@app.post("/webhook")
async def stripe_webhook(request: Request):
    payload = await request.body()
    sig = request.headers["stripe-signature"]
    event = stripe.Webhook.construct_event(
        payload, sig, endpoint_secret
    )


## Pitfall Catalog

| Pitfall | Consequence | Correct approach |
|---------|-------------|-----------------|
| Amount in dollars instead of cents | Charge 100x intended amount | Always multiply by 100 |
| No customer dedup | Duplicate customer records | Query by email first |
| Skip webhook signature check | Accept forged events | Always verify with constructEvent |

## Constraints

- This Skill covers Stripe Python SDK v7+
- Does not cover Stripe Connect or marketplace flows
- Assumes API keys are stored in environment variables
```

## Key Principles

1. **Distill, don't copy** -- Extract the rules an agent is most likely to violate, not the entire API reference
2. **Include code** -- Agents learn better from concrete snippets than prose descriptions
3. **Catalog pitfalls** -- Each pitfall = a mistake you or your team has actually made
4. **Keep scoped** -- One library per Skill; don't mix Stripe + Twilio in one

## Composability

Tool Wrapper is often the leaf node in a Pipeline:

```
Pipeline Step 3: Implement payment flow
  -> loads stripe-wrapper Skill
  -> follows Usage Rules
  -> uses API Quick Reference snippets
```

It can also be combined with Reviewer to audit existing code against the Usage Rules.

## Notes

- Update the Skill when the library releases breaking changes
- Include version constraints in the Skill metadata or constraints section
- For large SDKs, split into multiple Wrapper Skills by domain (e.g., stripe-payments, stripe-billing)
