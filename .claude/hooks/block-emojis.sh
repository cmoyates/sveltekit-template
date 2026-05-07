#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

HAS_EMOJI=$(printf '%s' "$COMMAND" | perl -CS -Mutf8 -ne 'exit(/[😀-🙏🌀-🗿🚀-🛿☀-⛿✀-➿]/ ? 0 : 1)' && echo yes || echo no)
TOUCHES_MARKDOWN=$(echo "$COMMAND" | grep -Eiq '(^|[[:space:]/])[^[:space:]]+\.md([[:space:]]|$|[;&|])' && echo yes || echo no)
IS_COMMIT_MESSAGE=$(echo "$COMMAND" | grep -Eq '(^|[;&|()`[:space:]])git[[:space:]]+commit([^;&|`]*[[:space:]])(-m|--message)([=[:space:]]|$)' && echo yes || echo no)

if [ "$HAS_EMOJI" = "yes" ] && { [ "$TOUCHES_MARKDOWN" = "yes" ] || [ "$IS_COMMIT_MESSAGE" = "yes" ]; }; then
  echo "Blocked: emojis are not allowed in commit messages or Markdown files." >&2
  exit 2
fi

exit 0
