# Tasks — template baseline stabilization

- [x] Re-read the ticket in `mode:prod` and confirm the governing scope.
- [x] Undo session changes that were made under the wrong mode without reverting unrelated local work.
- [x] Write the three spec documents in `specs/template-baseline-stabilization/`.
- [x] Submit the spec set for board validation before implementation.
- [x] Isolate the implementation on `fix/ticket-107-template-baseline-stabilization`.
- [x] Verify `jsdom` against `CHARTER-CORE` rule 6: package age, weekly downloads, and recent maintenance.
- [x] Fix the formatting-only `tsconfig.json` baseline defect.
- [x] Fix the strict-typing Playwright baseline defect.
- [x] Add only the missing test dependency and configure the Vitest baseline to tolerate the empty-template state without a permanent placeholder source file.
- [x] If another bootstrap-blocking defect is discovered, comment in this ticket before committing the fix, explaining the blocker and why it is absorbed into `LIMA-107`.
- [x] Re-run `pnpm run check` and capture any remaining baseline blocker discovered end to end.
- [x] Split the delivery into atomic commits by fix category: `tsconfig` formatting, Playwright strict typing, Vitest baseline (`jsdom` + empty-template handling), and any explicitly approved absorbed blocker.
- [x] Create or update the mirrored GitHub issue and open a PR titled `[PC-107] Stabilize template baseline for fresh bootstrap check`.
- [ ] Close the loop on `LIMA-105` and `LIMA-106` once the merge commit is known.
