#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -Eq '(^|[;&|()`[:space:]])(npm|pnpm|pmpm|yarn)([[:space:]]|$)'; then
  echo "Blocked: use bun as the package manager, not npm, pnpm, pmpm, or yarn." >&2
  exit 2
fi

exit 0
