# Proof provenance and geometric scope

**Project:** Annular Obstructions and Skew-Shape Block Identities
**Repository:** https://github.com/adamtilepe/Annular_Obstructions_and_Skew-Shape_Block_Identities

## Scope of the formalization

The Lean source develops weighted ideal enumerators, the algebraic rank-two mutation calculations, canonical skew-shape blocks, tableau-transfer matrices, ordered-root integral identities and the bivariate corollary.

The annular exchange calculations are algebraic. Their interpretation for a particular triangulation and a single geometric lamination requires a separate verification of the shear-coordinate vector and arc ordering. The Lean source does not establish that geometric identification.

The block-statistic result corresponds to Kahane's **Conjecture 4.7 in arXiv:2607.11225v2**, using explicit exclusion of the root from strict boundary inequalities. The paper's Lemma 5.3 selects top-down prefixes, and Lemma 6.1 constructs lower-ideal chains with **decreasing** root values, subsequently reordering the commuting kernels. Galashin–Grinberg–Liu's published **Lemma 7** supplies the two-color involution behind Lemma 5.1.

## Source changes in this distribution

- The main `.lean` filename and project descriptions use the current title.
- The isolated Lean namespace `ChainObstruction` replaces its former label. This changes declaration names in that namespace; no proof tactics or theorem propositions were rewritten.
- A long documentation line for Corollary 6.3 was shortened for the style linter.
- All remaining mathematical statements and tactics are carried over from the bundled cumulative source. The publication helper prefers the user's newer local source when it exists.

**No fresh full Lean compilation was performed while assembling this ZIP.** Optional verification remains available through `scripts/verify.sh`.
