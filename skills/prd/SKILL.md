---
name: prd
description: >
  Create or update an evidence-backed living Product Requirements Document
  (PRD) and, when useful, linked context and phase execution files under tasks/.
  Use for feature planning, implementation scoping, autonomous agent work, or
  checked-off PRDs that must be validated, reviewed, and revised during
  development. Triggers on: create a prd, write a prd, plan this feature, spec
  this out, update the prd, create an execution plan.
---

# Evidence-Backed Living PRD Generator

Create compact PRD file(s) that are grounded in the existing system, explicit
enough for a junior developer or fresh AI agent to execute, and structured as a
living source of truth. Work is checked off in the PRD, later phases are revised
as implementation reveals new information, and every phase ends with structured
validation and review.

Do not implement the feature unless the user explicitly asks. This skill creates
or updates PRD, context, and phase files only.

## Core Rules

- Always create or update markdown files under `tasks/`; do not only answer in
  chat.
- Start from evidence. Inspect relevant code, tests, docs, configs, APIs, and
  official external references before designing the plan when such context is
  available.
- Use **phases** as the execution structure. Use scenarios or user stories only
  for product context.
- Keep the master PRD compact. Split large plans into linked context and phase
  files.
- Use markdown checkboxes (`- [ ]`, `- [x]`) for discovery, implementation,
  validation, reviews, and completion.
- Make every requirement and checklist item concrete, verifiable, and small
  enough to become one focused execution task.
- Prefer autonomous progress. Ask only for material unknowns; otherwise make the
  best reasonable decision, record the assumption, and continue.
- Preserve completed checkboxes and meaningful user edits when updating existing
  PRDs.
- Use the real current date for `Last Updated` and change log entries.

## Discovery Policy

A good PRD starts with a fast but serious discovery pass. Do not invent the plan
from the prompt alone when relevant project context is available.

Before writing or materially updating a PRD:

1. Read related PRDs, tasks, issues, README files, architecture notes, API docs,
   product notes, and implementation notes.
2. Inspect affected code surfaces: routes, screens, components, services,
   models, schemas, migrations, jobs, permissions, config, tests, fixtures,
   observability, and existing patterns.
3. Identify current behavior, extension points, naming conventions, data flows,
   integration boundaries, dependency/framework versions, and likely blast
   radius.
4. Review available validation paths: static checks, unit tests, integration
   tests, API-level E2E, browser/UI checks, app simulator checks, screenshots,
   manual smoke checks, and observability checks.
5. Use official external docs or web sources when third-party APIs, framework
   behavior, platform limits, recent rules, or current product behavior affect
   the design.
6. Record what was reviewed, what could not be reviewed, material constraints,
   risks, unknowns, and design implications.
7. Ask the user only if material ambiguity remains after this discovery pass.

For small PRDs, include a compact `Discovery Summary` in the master PRD. For
larger plans, create:

- `tasks/prd-[feature-name]/context.md`

The context file is a source map, not a code dump. Include reviewed inputs,
current system summary, validation surface, existing patterns, constraints,
risks, unknowns, and design implications.

Every phase must also include a **Phase Discovery Gate** that tells the executor
which files, docs, commands, APIs, tools, and assumptions to re-check before
editing code.

## Question Policy

Ask at most 3 questions, and only when the answer materially changes scope,
architecture, user-visible behavior, data impact, compliance, security, cost, or
an irreversible decision.

Ask after discovery whenever possible. Do not ask about preferences the agent can
reasonably decide. Use numbered questions with lettered options, for example
`1B, 2D, 3A`.

## File Mode Selection

Choose the layout automatically unless the user explicitly requests one.

### Single-File Mode

Use one file when the feature remains easy to scan:

- 1-3 short phases
- one primary domain or workflow
- no long phase checklist
- discovery notes fit comfortably in the master PRD

Path: `tasks/prd-[feature-name].md`

### Split-File Mode

Use split-file mode by default when any condition is true:

- the plan has **4 or more phases**
- any phase has more than about 10-12 implementation items
- discovery notes would distract from the master PRD
- multiple domains are involved, such as data model, backend, frontend,
  migration, permissions, async jobs, observability, rollout, or billing
- the feature is likely to change while being implemented
- the master PRD would become long enough that developers may stop reading it

Paths:

- Master PRD: `tasks/prd-[feature-name].md`
- Phase directory: `tasks/prd-[feature-name]/`
- Context file, when useful: `tasks/prd-[feature-name]/context.md`
- Phase files: `tasks/prd-[feature-name]/phase-01-[phase-name].md`, etc.

In split-file mode, create the master PRD and all initial phase files in the
same run. Use relative links. Keep product intent, requirements, global rules,
status, phase index, final review, open questions, and change log in the master.
Put detailed phase checklists in phase files. At the end of every phase, update
the active phase file, update the master PRD, and revise later phase files if new
discoveries affect them.

## Validation Policy

Validation is evidence, not ritual. The PRD must specify the smallest sufficient
validation mix for the risk and available tooling. Do **not** hard-code one path
such as `dev-browser` for every UI-adjacent change.

Possible validation paths include:

- static checks: typecheck, lint, formatting, build, schema validation
- unit tests: pure logic, reducers, utilities, validators, permissions, parsing,
  state transitions
- integration tests: database behavior, services, repositories, queues, provider
  adapters, auth flows
- API-level E2E: complete workflows proven through HTTP/RPC/CLI/SDK calls
  without launching UI
- browser/UI E2E: DOM behavior, routing, forms, client state, accessibility, or
  real user interaction
- agent/dev browser checks: exploratory or scripted browser verification when a
  browser-capable skill is available and UI behavior matters
- mobile/app simulator checks: native or Expo-style flows, screenshots,
  permissions, deep links, device states, platform-specific behavior
- visual/screenshot checks: layout, responsive states, visual regressions,
  platform rendering
- manual smoke checks: when automation is unavailable, too costly for the risk,
  or useful as final sanity check
- observability checks: logs, metrics, traces, alerts, dashboards, audit records

Validation checklist items must name the chosen method and, when known, the
command, tool, surface, or scenario. If the best tool is unavailable, record the
gap and choose the next best evidence path. Do not block unless confidence would
be materially unsafe.

## Planning Method

Before writing, infer the smallest complete plan that satisfies the user's goal:

1. Run discovery and summarize only facts that matter.
2. Clarify material unknowns that remain.
3. Identify the problem, target users, desired outcome, goals, non-goals, and
   success criteria.
4. Convert intent into numbered functional and non-functional requirements.
5. Capture constraints, risks, dependencies, data impacts, UX notes, validation
   options, and technical implications.
6. Divide work into dependency-ordered phases, usually 3-6.
7. Give each phase a discovery gate, implementation checklist, validation
   strategy, exit criteria, and phase-end multi-pass review.
8. Include a final multi-pass review after all phases.

## Master PRD Template

Use this structure for the master PRD. In single-file mode, include full phase
sections under `Phase Plan`. In split-file mode, keep only the phase index in the
master and put phase details in linked phase files.

```markdown
# PRD: [Feature Name]

## Document Status
- Status: Draft | In Progress | Complete
- File Mode: Single | Split
- Current Phase: Not Started | Phase N | Complete
- Active Phase File: [Phase N](./prd-[feature-name]/phase-0N-[phase-name].md) <!-- split only -->
- Context File: [context.md](./prd-[feature-name]/context.md) <!-- if created -->
- Last Updated: YYYY-MM-DD
- PRD File: `tasks/prd-[feature-name].md`
- Purpose: Living PRD and execution source of truth. Check off work here, update
  this document as implementation reveals new information, and revise future
  phases before continuing when the plan changes.

## Problem
[What problem exists, who is affected, and why it matters.]

## Goals
- G-1: ...

## Non-Goals
- NG-1: ...

## Success Criteria
- SC-1: [Observable outcome or acceptance condition]

## Key Scenarios
### Scenario 1: [Name]
- Actor:
- Trigger:
- Expected outcome:

## Discovery Summary
- Reviewed: [important code/docs/tests/configs/external docs, or link to context file]
- Current system: [how the relevant system works today]
- Validation surface: [available checks/tools and gaps]
- Design implications: [facts that shaped this PRD]
- Confidence / gaps: [what remains uncertain and why]

## Requirements
### Functional Requirements
- FR-1: ...

### Non-Functional Requirements
- NFR-1: ...

## Assumptions
- A-1: ...

## Dependencies / Constraints
- ...

## Risks / Edge Cases
- ...

## Execution Rules
- Complete phases in order unless this PRD is explicitly revised.
- Before starting any phase, read the master PRD, active phase file, and relevant
  context notes.
- Use the PRD files as the only active plan; do not create a competing checklist.
- For minor ambiguities, choose the best reasonable option, record the
  assumption, and continue.
- Stop for help only for material blockers such as missing access, irreversible
  destructive change, major requirement conflict, or meaningful security/legal
  risk.
- Prefer minimal, reversible changes that satisfy the goals.
- Preserve existing code patterns unless there is a clear reason not to.
- Select validation methods according to risk and available tools; do not default
  to one testing tool for every phase.
- At the end of each phase, update this PRD and revise future phases based on
  what was learned.

## Phase Index
| Phase | Status | Objective | Validation Focus | File |
|---|---|---|---|---|
| Phase 1: [Name] | Not Started | ... | ... | [phase-01-[name].md](./prd-[feature-name]/phase-01-[name].md) |

<!-- Single-file mode only: include full phase details below. Split-file mode: keep only the index above. -->

## Phase Plan

### Phase 1: [Name]
[Include the phase template here only in single-file mode.]

## Final Multi-Pass Review After All Phases
Complete in order:
- [ ] 1. Requirements coverage review: every FR, NFR, and success criterion is satisfied or explicitly deferred.
- [ ] 2. Cross-phase integration review: phase outputs work together without gaps, broken assumptions, or duplicated ownership.
- [ ] 3. Correctness review: happy paths, edge cases, errors, empty states, permissions, and state transitions are handled.
- [ ] 4. Simplicity/refactor review: the final design is no more complex than necessary.
- [ ] 5. Duplication/cleanup review: repeated logic, dead code, temporary code, noisy logs, commented leftovers, unused files, and unused dependencies are removed.
- [ ] 6. Security/privacy review: auth, access control, secrets, sensitive data, auditability, and data exposure are safe.
- [ ] 7. Performance/load review: bottlenecks, expensive queries, N+1 patterns, unnecessary renders, and avoidable network calls are addressed.
- [ ] 8. Validation review: the final mix of unit, integration, API E2E, UI/browser, simulator, visual, manual, or observability checks is appropriate for the risk.
- [ ] 9. Documentation/operability review: docs, runbooks, release notes, migrations, rollback, monitoring, or support notes are updated when needed.
- [ ] 10. PRD closeout review: status is Complete, change log is current, and follow-ups are recorded.

## Open Questions
- ...

## Change Log
- YYYY-MM-DD: Initial PRD created.
```

## Phase Template

Use this structure for each phase file in split-file mode. Also use it inside
the master PRD when using single-file mode.

```markdown
# Phase N: [Phase Name]

Parent PRD: [PRD: Feature Name](../prd-[feature-name].md)
Status: Not Started | In Progress | Complete
Last Updated: YYYY-MM-DD

## Objective
[What this phase accomplishes and why it comes now.]

## Context From Master PRD
- Goals covered: G-...
- Success Criteria: SC-...
- Requirements covered: FR-..., NFR-...
- Key scenarios touched: ...

## Phase Discovery Gate
Before editing code, re-check:
- [ ] Relevant code/files: `path`, `path`
- [ ] Relevant tests/fixtures: `path`, `path`
- [ ] Relevant docs/specs/external references: `path-or-link`
- [ ] Relevant commands or tools: `command/tool`
- [ ] Assumptions from the master PRD still hold
- [ ] If discoveries change this phase or later phases, update PRD files before implementation

## Scope
### In Scope
- ...

### Out of Scope
- ...

## Implementation Checklist
- [ ] [Concrete implementation step with target file/component/system and expected outcome]

## Validation Strategy
[Choose the smallest sufficient validation mix for this phase. Explain why unit,
integration, API E2E, browser/UI, simulator, visual/screenshot, manual,
observability, or other checks are appropriate. Name tools/commands when known.
Do not force browser validation unless UI behavior specifically needs it.]

## Validation Checklist
- [ ] Static checks pass, if available: [command]
- [ ] Automated tests added or updated and pass, if applicable: [command/test path]
- [ ] API/CLI/service-level workflow verified, if sufficient: [surface]
- [ ] Browser/UI check completed only when DOM/client interaction is part of the risk: [tool/flow]
- [ ] Mobile/app simulator or screenshot check completed only when platform rendering/native behavior is part of the risk: [tool/flow]
- [ ] Observability/logging/audit behavior checked, if relevant: [surface]
- [ ] Manual smoke check completed when automation is insufficient or as final sanity check
- [ ] Relevant error, empty, loading, permission, retry, and rollback states verified when applicable

## Exit Criteria
- [ ] Phase objective is satisfied
- [ ] Requirements listed above are implemented or explicitly deferred
- [ ] Validation checklist is complete or gaps are recorded with rationale
- [ ] No known blocker remains for the next phase

## Phase-End Multi-Pass Review
Complete in order before moving to the next phase:
- [ ] 1. Intent/coverage review: this phase achieves its objective and mapped requirements.
- [ ] 2. Correctness review: happy paths, edge cases, errors, empty states, state transitions, and permissions are handled.
- [ ] 3. Simplicity review: the solution is no more complex than necessary.
- [ ] 4. Code quality review: names, boundaries, abstractions, and local consistency are clean.
- [ ] 5. Duplication/cleanup review: repeated logic, dead code, temporary code, noisy logs, commented leftovers, unused files, and unused dependencies are removed.
- [ ] 6. Security/privacy review: access control, secrets, sensitive data, injection risks, unsafe client exposure, and audit needs are handled.
- [ ] 7. Performance/load review: bottlenecks, expensive queries, N+1 patterns, unnecessary renders, avoidable blocking work, and unnecessary network calls are addressed.
- [ ] 8. Validation review: chosen checks are appropriate for phase risk; missing checks are justified.
- [ ] 9. Future-phase review: later phase files and checklists are still correct; revise them if implementation changed the plan.
- [ ] 10. PRD sync review: master PRD status, active phase, assumptions, risks, validation surface, and change log are updated.

## Discoveries / Decisions
- ...

## Phase Change Log
- YYYY-MM-DD: Phase file created.
```

## Writing Rules

- Use short sections, concrete bullets, and exact names when known.
- Avoid vague checklist items such as "improve UX", "clean up", or "make it
  robust" unless the observable result is specified.
- Include permissions, failure handling, empty states, loading states, edge cases,
  migration, backfill, rollback, rollout, observability, and debuggability when
  relevant.
- Keep phase checklist items implementation-sized, not epic-sized.
- If a detail is unknown but not blocking, write a reasonable assumption instead
  of asking the user.
- Treat tests and validation as evidence, not ritual. Pick the evidence that best
  proves the change works.

## Updating Existing PRDs

When revising an existing PRD:

1. Read the current master PRD and affected phase files first.
2. Preserve checked items and meaningful user edits.
3. Update only sections affected by new information.
4. If discoveries change the plan, revise future phase files before adding new
   work.
5. If file mode should change, migrate carefully: keep the master path stable,
   create or remove phase files as needed, update all links, and preserve status.
6. Never silently delete important scope. Move it to Non-Goals, defer it to
   follow-ups, or explain the change in the Change Log.
7. Update status, current phase, active phase file, last updated date, and change
   logs where applicable.

## Quality Bar Before Saving

Before saving, verify:

- [ ] A file was created or updated under `tasks/`
- [ ] Discovery was performed or access limitations were recorded
- [ ] In split-file mode, every phase link points to a real created or updated file
- [ ] Questions were skipped unless materially necessary
- [ ] Assumptions are recorded
- [ ] Goals, non-goals, success criteria, FRs, and NFRs are clear and testable
- [ ] File mode is appropriate; 4+ phases or large plans use split-file mode
- [ ] Phase order is dependency-aware and each phase has exit criteria
- [ ] Every phase has discovery, implementation, validation, and multi-pass review checklists
- [ ] Validation strategy is tool-agnostic and risk-appropriate, not hard-coded to one browser tool
- [ ] Phase-end future-plan revision is explicitly required
- [ ] Final multi-pass review is included
- [ ] The PRD is compact, executable, and suitable for a junior developer or AI agent

After saving, reply with the exact created or updated file path(s) and a brief
summary of the structure.
