#!/usr/bin/env bash
# Renames this template project. Run once after cloning.
# Usage: ./rename.sh <new-project-name>
#   <new-project-name> must be kebab-case (e.g. my-cool-project)

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <new-project-name>" >&2
  echo "Example: $0 my-cool-project" >&2
  exit 1
fi

NEW_KEBAB="$1"

if ! [[ "$NEW_KEBAB" =~ ^[a-z][a-z0-9]*(-[a-z0-9]+)*$ ]]; then
  echo "Error: name must be kebab-case (lowercase, digits, hyphens; start with letter)" >&2
  exit 1
fi

OLD_KEBAB="sveltekit-template"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# In-place sed that works on both macOS (BSD) and Linux (GNU).
sed_inplace() {
  if sed --version >/dev/null 2>&1; then
    sed -i "$@"
  else
    sed -i '' "$@"
  fi
}

echo "Renaming '$OLD_KEBAB' -> '$NEW_KEBAB'"

for file in package.json bun.lock src/routes/+layout.svelte README.md; do
  if [ -f "$file" ]; then
    sed_inplace "s/${OLD_KEBAB}/${NEW_KEBAB}/g" "$file"
  fi
done

# Regenerate lock file if Bun is available.
if command -v bun >/dev/null 2>&1; then
  echo "Running 'bun install' to regenerate lock file..."
  bun install
else
  echo "Warning: 'bun' not found; skipping lock regeneration. Run 'bun install' manually." >&2
fi

# Self-delete.
rm -- "$0"

echo "Done. Project renamed to '$NEW_KEBAB'."
