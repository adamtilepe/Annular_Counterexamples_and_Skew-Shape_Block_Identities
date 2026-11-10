# Annular Counterexamples and Skew-Shape Block Identities

**Lean 4 / Mathlib formalization accompanying the research manuscript**  
*Annular Counterexamples and Skew-Shape Block Identities: Weighted Order Ideals and a Lean-Verified Refinement*

This repository develops a common order-ideal framework for two apparently different questions in enumerative combinatorics:

1. **What happens to coefficient-shape properties such as unimodality and log-concavity when order ideals receive nonuniform integer weights?**
2. **Can the order polynomial of a skew Young diagram be expressed through a positive statistic on its bijective labelings?**

The first question leads to explicit algebraic counterexamples to unimodality and log-concavity. The second leads to a formal proof of a **skew-shape block-statistic identity**, using canonical block partitions and commuting tableau-transfer matrices. A bivariate refinement connects the two specializations.

> **Scope of the claims (updated 10 November 2026).** The Lean theorems certify the statements encoded in this repository. In direct correspondence, **Yakob Kahane** confirmed that the strict inequalities in Definition 4.2 of his arXiv v1 manuscript should be weak, or equivalently should exclude the block root; this matches our explicit statistic. **Anna Felikson** confirmed the sign reversal and that the individual depicted curves are laminations. **Wonwoo Kang** confirmed the unpunctured-surface scope and the specialization of Definition 20, while noting the alternating constraint for one lamination. These replies clarify the underlying conventions, **not** the proofs: Lean checks the algebra and corrected block statistic, not geometric realizability or the private correspondence. None of the three authors is thereby claimed to have endorsed or independently verified our counterexamples or proof.

## 1. The common object: weighted order ideals

Let $P$ be a finite poset, $J(P)$ its set of lower ideals, and $w:P\to\mathbb Z$ an integer weighting. Write $w(I)=\sum_{p\in I}w(p)$. The weighted rank enumerator is

$$
R_{P,w}(q)=\sum_{I\in J(P)}q^{w(I)}.
$$

Its order-polynomial counterpart counts isotone maps $P\to[m]$, denoted $\Omega(P;m)$. Both arise as specializations of

$$
H_{P,w}(t;q)=\sum_{I\in J(P)}q^{w(I)}\,\Omega(P\setminus I;t-1),
$$

with

$$
H_{P,w}(t;1)=\Omega(P;t),\qquad H_{P,w}(2;q)=R_{P,w}(q).
$$

The Lean development implements these finite enumerations and their evaluations (`FinitePoset.H`, `FinitePoset.omega`, `FinitePoset.weightedRank`). Signed exponents are handled via integer powers of rational values; the development does **not** define a general two-variable Laurent polynomial object for $H$.

It also proves a **no-gap support criterion** for ideal weights with $|w(p)|\le1$: every integer between the minimum and maximum ideal weights occurs. This does not imply unimodality.

## 2. Algebraic obstructions to unimodality and log-concavity

The surface-motivated part studies specialized cluster exchange relations with two mutable variables and one frozen row, as in the manuscript's annular examples.

**First mutation — equation (3.3).** For every integer $r\ge2$, the specified algebraic exchange specializes to

$$
c_r(q)=1+q^r.
$$

Its complete coefficient sequence contains internal zeros and is **not unimodal**. At $r=2$, its coefficients $(1,0,1)$ also fail log-concavity:

$$
a_1^2=0<a_0a_2=1.
$$

The file proves the polynomial identity, all coefficients, non-unimodality, and the strict log-concavity violation (`AnnularFirstMutation.firstPolynomial_not_unimodal`, `AnnularFirstMutation.firstPolynomial_two_not_logConcave`).

**Four-mutation example — equation (3.4).** A second algebraic calculation, with frozen row $(1,-2)$ and mutation sequence $(1,2,1,2)$, produces

$$
1+2q+7q^2+10q^3+9q^4+4q^5+q^6.
$$

Every displayed coefficient is positive, yet $2^2<1\cdot7$: **full support does not force log-concavity**. The successive exchange identities, coefficient positivity, and inequality are formalized in `AnnularFourthMutation`.

These computations motivate the manuscript's discussion of **Theorem 14 and Conjecture 1 of Kang–Lee–Lim**. The geometric sign, individual-curve and specialization conventions were clarified in correspondence with Felikson and Kang on 10 November 2026, as detailed above. The exchange computations themselves are Lean-verified; Lean does not formalize the annulus or the geometric shear realization.

## 3. Canonical blocks and the skew-shape identity

For a finite skew Young diagram $D$ with $n$ cells, the development constructs canonical connected blocks of a bijective cell labeling $\sigma$, and writes $\widetilde{\mathrm{bl}}_D(\sigma)$ for their number. In this formalization, the root is **excluded from its own strict boundary-label conditions**, as explained in the manuscript's Definition 4.1.

The principal result (Theorem 6.2 of the manuscript) is

$$
n!\,\Omega(P_D;t)=\sum_{\sigma:D\xrightarrow{\sim}[n]}t^{\widetilde{\mathrm{bl}}_D(\sigma)}.
$$

This applies to diagrams satisfying the explicit `SkewRowIntervals` hypothesis, including disconnected shapes. In Lean, the named theorem proves equality of the corresponding evaluations at every natural-number argument; the normalized block-generating expression is itself a rational polynomial.

The proof proceeds through:

- a canonical median construction and uniqueness of block partitions (§4);
- commuting tableau-transfer matrices $T_x$ and a vertical-strip inverse $Q_x$ (§5);
- connected-block kernels $A_z$, their commutation, and exact polynomial primitives (§§5–6);
- the ordered-root integral identity (Lemma 6.1), followed by a **finite** polynomial-matrix differential-equation argument identifying the result with powers of the zeta matrix (§6.2).

The formal statement is `OrderIdealSpecializations.OrderedRootIntegral.skew_shape_block_statistic_identity`.

**Relation to Kahane's conjecture.** The public arXiv version currently available is **v1** (Conjecture **4.4**, Definition **4.2**, Lemma **4.3**). On 10 November 2026, Kahane confirmed that the strict root comparisons in Definition 4.2 should be weak or should exclude the root, as in this repository; he stated that he would correct the definition in a future version. This resolves the specific root-exclusion ambiguity. The coordinate orientation is fixed explicitly by our definitions; that correspondence and the mathematical proof are separate from the author's clarification.

## 4. A bivariate refinement and two specializations

Theorem 6.3 expresses the weighted interpolation in terms of block statistics on the skew complements of ideals:

$$
n!\,H_{P_D,w}(t;q)
=\sum_{I\in J(P_D)}\frac{n!}{(n-|I|)!}\,q^{w(I)}
\sum_{\sigma:P_D\setminus I\,\xrightarrow{\sim}\,[n-|I|]}
(t-1)^{\widetilde{\mathrm{bl}}_{P_D\setminus I}(\sigma)}.
$$

Its finite expansion has **nonnegative integer coefficients in $t-1$** and, after a common exponent shift, in $q$ as well. Corollary 6.4 recovers the two coordinate specializations and the ideal count

$$
|J(P_D)|=\frac1{n!}\sum_\sigma 2^{\widetilde{\mathrm{bl}}_D(\sigma)}.
$$

The one-cell example has $H(t;q)=(t-1)+q^2$, giving the common smallest instance of both viewpoints. The fence/ribbon connection is formulated **conditionally on an explicit order isomorphism**; the existence of a particular surface-arc model is not deduced from the algebra.

## 5. Navigation: manuscript to Lean

| Manuscript result | Principal Lean declaration (within `OrderIdealSpecializations`) |
| --- | --- |
| Proposition 2.1 — two specializations | `FinitePoset.H_two`; related `FinitePoset.H_one_eq_omega_succ` |
| Theorem 3.2 — non-unimodality (algebraic) | `AnnularFirstMutation.firstPolynomial_not_unimodal` |
| Proposition 3.4 — failure of log-concavity (algebraic) | `AnnularFourthMutation.D_not_logConcave` |
| Lemma 5.1 — transfer commutation | `TableauTransfer.tableau_transfer_matrices_commute` |
| Lemma 5.3 — inverse/logarithmic derivative | `TableauTransfer.vertical_strip_inverse_and_log_derivative` |
| Proposition 5.4 — commuting block kernels | `TableauTransfer.connected_block_kernels_commute` |
| Lemma 6.1 — ordered-root integral | `OrderedRootIntegral.ordered_root_integral_identity` |
| Theorem 6.2 — block-statistic identity | `OrderedRootIntegral.skew_shape_block_statistic_identity` |
| Theorem 6.3 — bivariate refinement | `OrderedRootIntegral.weighted_block_refinement_identity` |
| Corollary 6.4 — two specializations | `OrderedRootIntegral.weighted_block_two_specializations` |

The complete development is in **`Annular_Counterexamples_and_Skew-Shape_Block_Identities.lean`**. The section and theorem numbering follows the accompanying research manuscript.

## 6. Reproduce the verification

Use the pinned Lean 4 / Mathlib environment recorded by `lean-toolchain`, the Lake configuration, and `lake-manifest.json`:

```bash
lake exe cache get
lake env lean Annular_Counterexamples_and_Skew-Shape_Block_Identities.lean
```

If the repository includes the verification script, it can also collect the compiler output, source checksum, toolchain information, and Mathlib revision:

```bash
bash scripts/verify.sh
```

The source ends with an axiom audit of the main theorem:

```lean
#print axioms OrderIdealSpecializations.OrderedRootIntegral.skew_shape_block_statistic_identity
```

In the verified local compilation, the reported dependencies were **`propext`, `Classical.choice`, and `Quot.sound`** — standard Lean foundational axioms. This certifies the **formal statements** relative to those foundations, not the independent literary or geometric identifications described above.

## 7. Scientific status and references

**Established by the Lean development:** the algebraic coefficient obstructions, the corrected canonical block constructions, the tableau-transfer and ordered-root identities, the skew-shape block identity as formalized, and the finite bivariate refinement and specializations.

**Clarified by the cited authors (personal correspondence, 10 November 2026):** Kahane confirmed root exclusion as the intended correction of his Definition 4.2; Felikson confirmed sign reversal and the individual-lamination status of the pictured curves; Kang confirmed the admissible surface setting and Definition 20's specialization, subject to an alternating constraint for a single lamination. **Not certified inside Lean:** the geometric/topological realization of a curve and its shear vector, or the accuracy of the source correspondence. These confirmations are not peer review or an endorsement of our conclusions.

**Related literature**

- Yakob Kahane, [*Combinatorial interpretation of the coefficients of the order polynomial of fence posets*](https://arxiv.org/abs/2607.11225). The numbering of the relevant conjecture differs by source version; the manuscript accompanying this code uses the v2 numbering.
- W. Kang, K. Lee and E. Lim, *Unimodality and cluster algebras from surfaces*, *European Journal of Combinatorics* **136** (2026), 104392. [DOI](https://doi.org/10.1016/j.ejc.2026.104392).
- P. Galashin, D. Grinberg and G. Liu, *Refined dual stable Grothendieck polynomials and generalized Bender–Knuth involutions*, *Electronic Journal of Combinatorics* **23** (2016), P3.14. [DOI](https://doi.org/10.37236/5737).
- S. Fomin and A. Zelevinsky, *Cluster algebras IV: Coefficients*, *Compositio Mathematica* **143** (2007), 112–164. [DOI](https://doi.org/10.1112/S0010437X06002521).

This README documents the formalized results and their boundaries. The source-interpretation updates are dated 10 November 2026; future author revisions and any journal referee comments should be tracked independently.
