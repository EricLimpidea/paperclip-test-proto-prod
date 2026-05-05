# Design — template baseline stabilization

## Scope

This work only touches files that are directly involved in the bootstrap quality loop:

- `tsconfig.json`
- `playwright.config.ts`
- `package.json`
- `pnpm-lock.yaml`
- `vitest.config.ts`
- optional ignore/config files only if generated artifacts are proven to pollute the check

## Approach

### 1. Normalize the TypeScript baseline

- Keep the current `tsconfig.json` scope.
- Reformat it so `biome check .` passes without changing the compiler surface.

### 2. Make the Playwright config strict-safe

- Keep the current runtime behavior for CI and local runs.
- Shape optional fields conditionally so strict TypeScript accepts the config.
- Prefer explicit Node typing support over custom environment indirection if a package addition is required.

### 3. Restore the Vitest execution baseline

- Add the missing test environment dependency required by `environment: 'jsdom'`.
- Use `passWithNoTests: true` in `vitest.config.ts` so a fresh bootstrap with zero unit tests is a supported baseline state.
- Do not add a permanent placeholder file under `src/` only to satisfy the empty-template check.
- When a real project adds product code, it will also add real colocated tests; the template baseline should not force teams to keep a fake `src/baseline.ts` appendix forever.

### 4. Re-run the full quality loop and only then widen scope

- After the known defects are fixed, run `pnpm run check`.
- If another failure appears, only absorb it into this ticket if it is another baseline blocker on a fresh template.
- Before committing any such absorbed bug fix, post a ticket comment describing the blocker and why it belongs in `LIMA-107`.
- Document any newly discovered blocker before changing scope.

## Tradeoffs

- `passWithNoTests: true` is less strict than a smoke test, but it avoids introducing a permanent fake source artifact whose lifecycle would be awkward in every real project created from the template.
- Declaring required dependencies explicitly is preferable to relying on transitive typings or environments.

## Risks

- Existing local uncommitted work in this repository may not belong to `LIMA-107`; changes must be isolated carefully.
- The untracked `pnpm-lock.yaml` means dependency changes must be reviewed explicitly before delivery.
- The local corepack cache permission issue belongs to Paperclip workspace infrastructure, not this template ticket, and can obscure real template failures if not isolated from the workspace.

## Verification

- Run `pnpm run lint`.
- Run `pnpm run typecheck`.
- Run `pnpm run test:coverage`.
- Run `pnpm run security`.
- Run `pnpm run check`.
- If needed for reproducibility in this harness only, set `COREPACK_HOME` outside the repo while verifying. Do not encode that workaround into the template unless it is shown to be a template defect.
