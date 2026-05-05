# Requirements — template baseline stabilization

## Problem

A repository created via "Use this template" must pass `pnpm run check` without any product code added. Today that baseline is not reliable:

1. `tsconfig.json` formatting is not Biome-compliant out of the box.
2. `playwright.config.ts` does not align cleanly with the template's strict TypeScript settings.
3. `vitest.config.ts` requires `jsdom`, but the dependency is not declared.
4. The template contains no executable unit test, so `vitest run --coverage` exits with code `1`.
5. Additional failures may appear once the full quality loop is re-run end to end.

## Goals

- Make `pnpm run check` pass on a freshly bootstrapped repo after `pnpm install`.
- Limit every code change to a baseline defect that directly blocks the check.
- Keep the template generic: no business logic, no product assumptions, no feature additions.
- Preserve the current intent of the quality loop: lint, typecheck, coverage, security.

## Non-goals

- No template redesign.
- No production feature work.
- No changes inside `experiments/` unrelated to the baseline defect.
- No dependency upgrades unless a missing or incompatible dependency is the direct root cause.

## Acceptance Criteria

- `pnpm run check` passes with zero errors on the delivery branch.
- A fresh clone of the post-merge template passes `pnpm run check` after `pnpm install`.
- The baseline fix does not rely on a permanent placeholder source file that future projects must keep alive artificially.
- Every dependency added is justified by a check failure and verified against npm health rules.
- The final change set can be explained as a small set of root-cause fixes, not a broad cleanup.

## Notes

- A local Paperclip harness permission problem on `/paperclip/.cache/node/corepack` was observed during diagnosis. Treat it as an environment artifact unless it reproduces on a clean bootstrap outside the harness. Do not change the template for that alone.
