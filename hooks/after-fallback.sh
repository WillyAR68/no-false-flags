#!/usr/bin/env bash
# PostModelSwitch: after an automatic model change (source "auto", which includes
# a safety-check fallback), tell Claude to recover instead of carrying on.
input=$(cat)
printf '%s' "$input" | grep -Eq '"source"[[:space:]]*:[[:space:]]*"auto"' || exit 0
echo 'no-false-flags: the model was switched automatically. If a safety check caused it, apply the no-false-flags skill now: do not keep working in this conversation; offer /rewind to before the turn that brought in unneeded material, or write a pointer-only handoff and ask for /clear; then /model to return.'
