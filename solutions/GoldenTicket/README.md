## Solution

Since the waitlist expiration is updated inside an `unchecked` block, we can increment it till it wraps back to 0.

The `_guess` to claim the prize is simple to calculate since it is completely deterministic relative to a block.

The attack must be done by a seperate contract given that foundry scripts do not replace `block.number` and `block.timestamp` with real on-chain values. Deploying a contract is a workaround. 