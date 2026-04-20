---
name: review-implementation
description: Review implementation against provided markdown requirements/spec docs and apply fixes. Use when a user supplies one or more .md file paths and asks to verify correctness/completeness, find missing or overbuilt parts, assess critical issues or design flaws, refactor long files/functions, and update the code accordingly.
---

# Review Implementation

## Overview

Review code against the given markdown docs, identify gaps and risks, refactor as needed, and apply fixes while keeping changes minimal and aligned to the requirements.

## Workflow

### 1) Intake and scope

- Read all provided .md files and extract explicit requirements, constraints, and acceptance criteria.
- Note implied expectations and any ambiguity; ask a question only if a critical decision cannot be made safely.
- Check for repo-specific guidelines (limits, style, tests) and follow them.

### 2) Map requirements to implementation

- Locate the relevant code paths and build a checklist mapping each requirement to code evidence.
- Flag missing, partial, or conflicting implementation.

### 3) Review design, quality, risk, and scope

- Identify critical issues first: correctness, security, data loss, concurrency, API contract breaks, and major performance regressions.
- Evaluate design soundness: module boundaries, responsibility split, data flow, coupling, and long-term maintainability.
- Detect over-implementation: extra features, unused abstractions, or complexity beyond the docs.
- Find code health issues: overly long files/functions, duplicated logic, unclear naming, or unnecessary indirection.

### 4) Apply fixes and refactors

- Fix issues directly in code with minimal, targeted changes.
- Split overly long files/functions into smaller units with clear, intention-revealing names.
- Remove or simplify overbuilt code that is not justified by the docs.
- Keep behavior consistent with the documented requirements.

### 5) Validate and report

- Run relevant tests/linters if available and allowed; otherwise state what was not run.
- Report findings in severity order with file/line references, then list fixes applied and any remaining risks or decisions made.
- For non-critical decisions, choose the optimal approach and proceed; for critical blockers, clearly flag them and ask.
