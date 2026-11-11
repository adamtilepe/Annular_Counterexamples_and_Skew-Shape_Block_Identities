# Provenance, proof preservation, manuscript alignment

This package is an **in-place update of an existing GitHub repository**, not a new repository. The origin remote must remain `https://github.com/adamtilepe/Annular_Counterexamples_and_Skew-Shape_Block_Identities` (or its `.git`/SSH equivalent).

## Verified source preservation

Source for the migration: the latest provided full cumulative Lean code from 11 November 2026, with 30,039 lines prior to the final documentation addition. The shipped file has 30,055 lines. A local, syntax-aware comparison stripping nested Lean comments and whitespace gives **690,041 unchanged code characters** (SHA-256 `df45499d5cbc2499b836d6926a396f9cf2b2d54ab3f28b2a6af7138bb4ad91cb`). Therefore no declarations, statements, or tactics were modified in the packaged Lean relative to this exact source. The migration script re-checks equivalence against the user's CURRENT local Lean and refuses changes when they differ.

Note: equivalence of *code text* is not a fresh Lean compilation or independent mathematical peer review. Run `lake exe cache get` and `bash scripts/verify.sh` locally before pushing.

## Document correspondence

- Title: *Annular Obstructions and Skew-Shape Block Identities: Weighted Order Ideals and a Lean-Verified Refinement*, 11 November 2026.
- §3: scalar rank-two annular exchange polynomials are Lean verified; correspondence to an actual single lamination for the same triangulation is not formalized. The paper therefore limits its surface application conditionally. In its mutation table the active frozen entries at steps 3 and 4 give respectively $q^1$ and $q^0$. The Laurent phenomenon justifies specializing the mutable variables at 1.
- §§4–6: the corrected root-excluded block statistic targets Kahane's Conjecture **4.7 (v2)**, with source Definition 4.5 and Lemma 4.6. The *local/global root order bridge* is formalized under the Lean hypotheses. Lemmata 4.3 and 5.3 are oriented respectively by the left end/bottom end boundary conditions, and top-down row-prefixes. The lower ideal chain in Lemma 6.1 uses **descending root labels** and a later commuting-kernel reordering.
- Lemma 5.1: the relevant published reference is **Galashin–Grinberg–Liu, Lemma 7**, for two-color reverse plane partitions. Published Proposition 4(a) and Theorems 5–6 give companion results.
- Corollary 6.3 is a consequence of the main Theorem 6.2, not a separate fourth breakthrough.
- §7: carefully attributes author correspondence without claiming that external authors approved the proof; §8: contains the Lean correspondence and the standard-axioms audit. The external geometric realization, bibliographic equivalences and any author endorsements are not consequences of Lean compilation.

Mathematical declaration identifiers such as `ChainCounterexample` and ordinary uses of the English word *counterexample* are preserved: those are mathematically meaningful, not leftover document titles. The existing GitHub URL also deliberately retains the legacy slug by user choice.

## Pinned environment

`lean-toolchain`, `lakefile.toml`/`lakefile.lean`, and `lake-manifest.json` are taken **from the user's existing local Git checkout and preserved**, not invented by this archive. Local sources supplied in this chat did not include those original pins. A GitHub Actions workflow is included, but no build is asserted to have run in this environment.
