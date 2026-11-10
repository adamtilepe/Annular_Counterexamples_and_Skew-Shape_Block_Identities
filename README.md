# Order-Ideal Specializations Beyond Unimodality

A Lean 4 / Mathlib formal development accompanying the research manuscript
*Order-Ideal Specializations Beyond Unimodality*.

## Mathematical scope

The development includes weighted ideals and order polynomials, algebraic
specializations related to surface coefficients, canonical block constructions,
tableau transfer matrices, the ordered-root identity, the skew-shape
block-statistic theorem, a bivariate refinement, and their specializations.

The skew-shape result uses the explicitly stated root-exclusion convention.
Its identification with the precise statistic in Kahane's original manuscript
requires a separate source-version comparison. The algebraic surface
specializations are conditional on the stated poset and shear-data hypotheses;
this source does not itself establish geometric realizability of the laminations.

## Reproducibility

The `lean-toolchain`, `lakefile.*`, and `lake-manifest.json` record the versioned
environment copied from a working local Lean project. On a Mac with Lean / Lake:

```sh
lake exe cache get
lake env lean Order_Ideal_Specializations_Beyond_Unimodality.lean
```

The file ends with `#print axioms` for the primary theorem, and the expected
foundational axioms are `propext`, `Classical.choice`, and `Quot.sound`.

Run `bash scripts/verify.sh` to create a local audit log and checksum.

## Attribution

The block-statistic conjecture originated in Yakob Kahane,
*Combinatorial interpretation of the coefficients of the order polynomial of fence posets*,
arXiv:2607.11225. Its original definitions and conventions should be compared
against the version cited by the manuscript.
