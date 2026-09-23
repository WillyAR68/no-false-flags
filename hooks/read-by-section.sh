#!/usr/bin/env bash
# PreToolUse(Read): a whole-file read of a long document is redirected to a
# section read. Everything read stays in the conversation for the whole session.
# Tune with NO_FALSE_FLAGS_MAX_LINES (default 150); disable with NO_FALSE_FLAGS_READ_GUARD=0.
[ "${NO_FALSE_FLAGS_READ_GUARD:-1}" = "0" ] && exit 0
input=$(cat)
case "$input" in *'"offset"'*|*'"limit"'*) exit 0 ;; esac
path=$(printf '%s' "$input" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
path=${path//\\//}
[ -n "$path" ] || exit 0
case "$path" in
  *.md|*.MD|*.mdx|*.markdown|*.txt|*.rst|*.adoc) ;;
  *) exit 0 ;;
esac
[ -f "$path" ] || exit 0
lines=$(wc -l < "$path" | tr -d ' ')
max=${NO_FALSE_FLAGS_MAX_LINES:-150}
[ "$lines" -gt "$max" ] 2>/dev/null || exit 0
printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"no-false-flags: this document has %s lines. Do not read it whole. Grep its headings (^#) and the task keywords with line numbers, then Read only the relevant sections with offset and limit."}}\n' "$lines"
