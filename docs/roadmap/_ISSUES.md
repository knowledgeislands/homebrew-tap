---
last_id: 12
---

# Roadmap issue ledger

This ledger reserves every repository-scoped roadmap issue number through `012`. Allocate the next work item as one greater than `last_id`; never lower this value or reuse an issued number after a record is pruned. Reserve a number by committing this ledger's advance on its own before writing the record.
