#!/usr/bin/env bash
# PreToolUse(Read): a whole-file read of a long document is redirected to a
# section read. Everything read stays in the conversation for the whole session.
# Also redirected, in any language: a second whole read of a doc (over 40 lines)
# from the same folder, which is how "read the whole folder" shows up, and whole
# reads once this session's whole-document reads pass a budget.
# Tune with NO_FALSE_FLAGS_MAX_LINES (default 80) and
# NO_FALSE_FLAGS_SESSION_LINES (default 300); disable with NO_FALSE_FLAGS_READ_GUARD=0.
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
deny() {
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"no-false-flags: %s Grep its headings (^#) and the task keywords with line numbers, then Read only the relevant sections with offset and limit."}}\n' "$1"
  exit 0
}
max=${NO_FALSE_FLAGS_MAX_LINES:-80}
[ "$lines" -gt "$max" ] 2>/dev/null && deny "this document has $lines lines. Do not read it whole."
[ "$lines" -gt 40 ] 2>/dev/null || exit 0
session=$(printf '%s' "$input" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
[ -n "$session" ] || exit 0
dir="${TMPDIR:-${TEMP:-/tmp}}/no-false-flags"
mkdir -p "$dir" 2>/dev/null || exit 0
folder=$(dirname "$path")
if grep -qxF "$folder" "$dir/dirs-$session" 2>/dev/null; then
  deny "another whole document from this folder was already read. Do not read the folder whole: read only the sections the current task needs, and tell the user in one line that the rest will be read when a step needs it."
fi
total=$(cat "$dir/read-$session" 2>/dev/null || echo 0)
budget=${NO_FALSE_FLAGS_SESSION_LINES:-300}
[ $((total + lines)) -gt "$budget" ] 2>/dev/null && deny "whole-document reads this session already total $total lines."
echo $((total + lines)) > "$dir/read-$session" 2>/dev/null
echo "$folder" >> "$dir/dirs-$session" 2>/dev/null
exit 0
