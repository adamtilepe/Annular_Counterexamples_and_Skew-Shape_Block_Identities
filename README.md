# Annular Obstructions and Skew-Shape Block Identities

**Weighted Order Ideals and a Lean-Verified Refinement**
**Adam Tilèpe — 11 November 2026**

**Manuscript:** [arXiv:2611.14506](https://arxiv.org/abs/2611.14506) · **Lean 4 / Mathlib formalization** · [Kahane's conjecture, arXiv:2607.11225v2](https://arxiv.org/abs/2607.11225v2)

## 1. Results and exact status

The development connects two specializations of weighted order ideals of a finite poset, through

$$
H_{P,w}(t;q)=\sum_{I\in J(P)}q^{w(I)}\,\Omega(P\setminus I;t-1),
$$

where $J(P)$ consists of lower ideals, $w(I)$ is the total weight and $\Omega$ is the order polynomial. Its coordinate specializations give the weighted ideal enumerator and the order polynomial.

### Annular algebraic obstructions (§3)

For the explicit rank-two extended matrix with frozen row $(r,-r-1)$, the first specialized exchange gives $1+q^r$. When $r\ge2$ its coefficient sequence is not unimodal; $1+q^2$ also violates log-concavity. A four-mutation algebraic calculation with frozen row $(1,-2)$ gives

$$
1+2q+7q^2+10q^3+9q^4+4q^5+q^6,
$$

which has full support but fails log-concavity. The Lean file checks the matrix/exchange calculations and polynomial inequalities. The manuscript's table records the active frozen rows and $q$ exponents (in the third mutation the active frozen entry $-1$ yields a factor $q^1$ beside the squared cluster term; in the fourth the frozen entry $0$ yields $q^0=1$). The Laurent phenomenon guarantees the relevant cluster variables are Laurent polynomials in the initial mutable variables over the coefficient ring, so evaluation at $x_1=x_2=1$ is legitimate in that Laurent ring; the displayed specialized quotients are exact polynomial identities.

**Essential distinction:** these statements do **not**, by themselves, establish counterexamples for single laminations in Kang–Lee–Lim, Theorem 14 or Conjecture 1. That conclusion additionally requires matching the chosen frozen row, its shear-coordinate ordering and principal exchange matrix to **one lamination in the same annular triangulation**, including all necessary restrictions. That geometric realization is not a theorem of this Lean file. The correspondence with Felikson–Tumarkin and Kang clarifies conventions, not the missing geometric proof or the validity of the manuscript's stronger interpretations.

### Kahane's skew-shape identity (§§4–6)

For any finite skew Young diagram $D$ of size $n$, including disconnected shapes, the main formal result corresponds to the block-statistic identity

$$
n!\,\Omega(P_D;t)=\sum_{\sigma:D\xrightarrow{\sim}[n]}t^{\widetilde{\mathrm{bl}}_D(\sigma)}.
$$

This is identified in the manuscript as **Kahane's Conjecture 4.7 in arXiv:2607.11225v2**, with the explicitly corrected *root-exclusion* convention. The source counterparts are Kahane's **Definition 3.2** (order of blocks), **Proposition 4.4** (leftmost corner), **Definition 4.5** (blocks), **Lemma 4.6** (uniqueness), and **Conjecture 4.7**. The earlier v1 uses different numbers; Kahane's email about Definition 4.2 referred to that earlier version.

The root in each connected block is its southwest corner. Nonroot cells at the left end of a row have a smaller label than the root; nonroot cells at the bottom of a column have a larger label. The root is excluded from its own strict comparisons. The development proves the equivalence between its local root-order condition and the globally ordered-block condition under stated shape and assignment hypotheses.

The paper's combinatorial proof uses a median construction, commuting tableau-transfer matrices, a connected-block inverse kernel and finite polynomial differential equations. Its **Lemma 5.3** selects vertical-strip prefixes *top to bottom* in groups of rows with the same left endpoint. Its **Lemma 6.1** builds chains of *lower ideals with decreasing root labels*; kernel commutativity then permits rewriting ordered integrals with increasing variables. The two-color switching step corresponds to **Lemma 7** of the *published* Galashin–Grinberg–Liu paper (2016, EJC 23(3), P3.14). In that same published version, Proposition 4(a) and Theorems 5–6 give contextual specialization/symmetry/involution results; other versions may number them differently.

**Corollary 6.3** is a bivariate consequence of the skew-shape identity, rather than an independent fourth main theorem. It gives a shifted coefficientwise-positive expansion, with a suitable common monomial factor in the weight variable when negative exponents occur. Corollary 6.4 records two specializations.

## 2. Main Lean declarations

All paths below are relative to `OrderIdealSpecializations` in the main file.

| Manuscript | Lean declaration |
|---|---|
| Theorem 3.2: non-unimodality (algebraic) | `AnnularFirstMutation.firstPolynomial_not_unimodal` |
| Proposition 3.4: log-concavity obstruction (algebraic) | `AnnularFourthMutation.D_not_logConcave` |
| Lemma 4.3: corrected valid block partition | `CanonicalBlocks.correctedKahaneBlocks_exists_unique` |
| Local/global correspondence | `CanonicalBlocks.rootLocallyOrdered_iff_kahaneGlobal` and `CanonicalBlocks.admissible_iff_kahaneOrdered` |
| Lemma 5.1: transfer commutation | `TableauTransfer.tableau_transfer_matrices_commute` |
| Lemma 5.3: inverse and derivative | `TableauTransfer.vertical_strip_inverse_and_log_derivative` |
| Proposition 5.4: commuting kernels | `TableauTransfer.connected_block_kernels_commute` |
| Lemma 6.1: ordered-root integral | `OrderedRootIntegral.ordered_root_integral_identity` |
| Theorem 6.2: Kahane 4.7 (v2), with corrected statistic | `OrderedRootIntegral.skew_shape_block_statistic_identity` |
| Corollary 6.3: bivariate refinement | `OrderedRootIntegral.weighted_block_refinement_identity` |
| Corollary 6.4: specializations | `OrderedRootIntegral.weighted_block_two_specializations` |

These are **formal statements in the code**, not a blanket assertion that the external geometric setup or every citation-to-literature equivalence has been formalized.

## 3. Reproduce the checks

This repository contains:

- `Annular_Obstructions_and_Skew-Shape_Block_Identities.lean`: the full cumulative Lean proof file;
- `lean-toolchain`, `lakefile.toml` or `lakefile.lean`, and `lake-manifest.json`: **copied unchanged or minimally retitled from the compiling original local repository** by the migration script, preserving the pinned dependencies;
- `scripts/verify.sh`: checks the exact file with `lake env lean`, writes `audit/compile.log` and source hashes;
- `.github/workflows/lean.yml`: repeatable GitHub Actions verification;
- `docs/PROVENANCE_AND_SCOPE.md`: migration constraints and publication caveats.

On a Mac with Lean/elan and Lake installed:

```bash
lake exe cache get
bash scripts/verify.sh
```

The Lean source retains an axiom audit at the end:

```lean
#print axioms OrderIdealSpecializations.OrderedRootIntegral.skew_shape_block_statistic_identity
```

In a previously reported local build, the axioms were `propext`, `Classical.choice` and `Quot.sound` (standard Lean foundations). **The archive itself does not establish a new successful compilation**: run the checks above and inspect the output on the new machine and toolchain before relying on this status.

## 4. Sources and attribution

- Y. Kahane, *Combinatorial interpretation of the coefficients of the order polynomial of fence posets*, [arXiv:2607.11225v2](https://arxiv.org/abs/2607.11225v2) (2 November 2026).
- W. Kang, K. Lee and E. Lim, *Unimodality and cluster algebras from surfaces*, *European Journal of Combinatorics* **136** (2026), 104392, [DOI](https://doi.org/10.1016/j.ejc.2026.104392).
- A. Felikson and P. Tumarkin, work on laminations and mutation-finite coefficients on surfaces, as cited in the manuscript.
- P. Galashin, D. Grinberg and G. Liu, *Refined dual stable Grothendieck polynomials and generalized Bender–Knuth involutions*, *Electronic Journal of Combinatorics* **23** (2016), P3.14, [DOI](https://doi.org/10.37236/5737).

Individual authors have clarified certain conventions in personal correspondence. **Those exchanges are not peer review, independent theorem verification, or an endorsement of the manuscript.**
