#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
FILE="Annular_Obstructions_and_Skew-Shape_Block_Identities.lean"
[ -f "$FILE" ] || { echo "Lean source missing: $FILE" >&2; exit 2; }
command -v lake >/dev/null || { echo 'Lake/elan not on PATH. Try: export PATH="$HOME/.elan/bin:$PATH"' >&2; exit 2; }
mkdir -p audit
printf 'Verifying %s with pinned Lake environment...\n' "$FILE"
lake env lean --version | tee audit/lean-version.txt
shasum -a 256 "$FILE" | tee audit/source.sha256
if [ -f .lake/packages/mathlib/.git/HEAD ]; then
  git -C .lake/packages/mathlib rev-parse HEAD > audit/mathlib-revision.txt || true
fi
if lake env lean "$FILE" >audit/compile.log 2>&1; then
  echo 'PASS: lean exited 0. Full log in audit/compile.log'
  tail -n 15 audit/compile.log
else
  echo 'FAIL: Lean compilation. Last 50 lines:' >&2
  tail -n 50 audit/compile.log >&2
  exit 1
fi
