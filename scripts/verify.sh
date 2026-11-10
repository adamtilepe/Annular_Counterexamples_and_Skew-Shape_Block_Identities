#!/usr/bin/env bash
# Lean proof verification and reproducibility audit for the publication repository.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SOURCE="Annular_Counterexamples_and_Skew-Shape_Block_Identities.lean"
if [[ ! -f "$SOURCE" ]]; then
  echo "ERROR: $SOURCE not found in $ROOT" >&2
  exit 1
fi
mkdir -p audit
printf '\n=== Source checksum ===\n'
shasum -a 256 "$SOURCE" | tee audit/source.sha256
printf '\n=== Version ===\n'
lake env lean --version | tee audit/lean-version.txt
printf '\n=== Mathlib revision (if downloaded) ===\n'
if [[ -d .lake/packages/mathlib/.git ]]; then
  git -C .lake/packages/mathlib rev-parse HEAD | tee audit/mathlib-revision.txt
else
  echo 'Mathlib Git checkout not yet present; check lake-manifest.json.'
fi
printf '\n=== Exact Lean kernel check and axiom audit ===\n'
set -o pipefail
lake env lean "$SOURCE" 2>&1 | tee audit/compile.log
printf '\n=== Axioms of the main theorem ===\n'
if ! grep -F 'skew_shape_block_statistic_identity' audit/compile.log; then
  echo 'ERROR: the expected #print axioms output is missing.' >&2
  exit 1
fi
if grep -E 'sorryAx|admit|unknownIdentifier|unsolved goals|error:' audit/compile.log; then
  echo 'ERROR: unexpected output in kernel audit.' >&2
  exit 1
fi
printf '\n=== Publication file inventory ===\n'
find . -maxdepth 2 -type f ! -path './.lake/*' | LC_ALL=C sort
printf '\nPASS: source compiled successfully, and the axiom audit was printed.\n'
