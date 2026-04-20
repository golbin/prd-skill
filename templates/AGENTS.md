# Repository Guidelines

## Overview
[Project name] is [one short sentence describing what this repository builds and who it serves].

Primary invariant: [the one thing agents must protect: server-side authorization, data integrity, cross-platform behavior, release safety, etc.].

Use [package manager/tooling] only. Do not introduce competing lockfiles, commands, or workflow cache keys.

Core stack:

- [Framework/runtime]
- [Language and UI stack]
- [Database/auth/integration]
- [Testing/build tooling]

## Structure
```text
[directory]/       [purpose]
[directory]/       [purpose]
[directory]/       [purpose]
docs/              Architecture, development, and release notes
scripts/           Maintenance and automation scripts
tests/             Repository-level tests
```

## Key Docs

- `docs/architecture.md`: system boundaries, data flow, ownership
- `docs/development.md`: local setup and conventions
- `docs/deployment.md`: release, rollback, environment notes
- `docs/security.md`: auth, permissions, secrets, privacy

Keep this file concise. Move detailed domain rules, schemas, runbooks, and platform notes into linked docs.

## Commands
```bash
[install command]
[dev command]
[test command]
[lint command]
[build command]
```

Do not run broad or expensive commands unless the user asks or risk requires them. Prefer the smallest focused check that proves the change.

## Non-Negotiables

- Preserve [critical domain/security/platform invariant].
- Validate client input, generated output, and external service responses at the proper boundary.
- Never log secrets, credentials, tokens, private keys, or sensitive user data.
- Keep side effects, network calls, persistence, filesystem access, and OS integration in explicit boundary modules.
- Leave unrelated dirty worktree changes untouched.

## Planning

Write a short Problem 1-Pager before coding when work is non-trivial, ambiguous, cross-platform, release-related, or touches upstream integration:

- Background
- Problem
- Goal
- Non-goals
- Constraints
- Implementation outline
- Verification plan
- Rollback or recovery notes, when release/build behavior is involved

For small, obvious fixes, proceed after reading the relevant surrounding code.

## Code Quality

- Read the surrounding code before editing.
- Prefer explicit, intention-revealing code over hidden magic.
- Keep adapters thin: app code should call clear boundary APIs; platform, filesystem, network, persistence, and OS integration behavior should live in dedicated boundary modules.
- Keep side effects at boundary layers.
- Use structured APIs for paths, JSON, TOML, YAML, and shell arguments instead of ad hoc string manipulation.
- Avoid premature abstractions. Extract helpers only when duplication is real or behavior becomes hard to read.
- Split long files and functions before they obscure behavior.
- Handle paths, encodings, date/time, and process execution with platform differences in mind.

Suggested limits: file 300 LOC, function 50 LOC, parameters 5, cyclomatic complexity 10.

If a change needs to exceed these limits, document why in the 1-Pager or split the implementation.

## Verification

- Match validation to risk: static checks, focused tests, integration tests, API-level checks, UI/browser checks, screenshots, manual smoke checks, or observability checks.
- Prefer deterministic tests. Use fakes, fixtures, or contract-style samples for external systems.
- State what was run, what was not run, and any remaining risk.

## Git And PR

- Keep commits small, focused, and reversible.
- Stage only files related to the current task.
- Do not rewrite history, move release tags, or force-push unless explicitly requested.
- PRs should describe behavior changes, user impact, config/schema/migration changes, operational risk, and verification performed.
