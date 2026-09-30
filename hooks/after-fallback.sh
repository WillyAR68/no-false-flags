#!/usr/bin/env bash
# PostModelSwitch: after an automatic model change (source "auto", which includes
# a safety-check fallback), tell Claude how to recover.
input=$(cat)
printf '%s' "$input" | grep -Eq '"source"[[:space:]]*:[[:space:]]*"auto"' || exit 0
echo 'no-false-flags: the model was switched automatically. If a safety check caused it, apply the no-false-flags skill now: say what was cut and check whether an interrupted tool call left anything behind; if the stopped step was legitimate work, hand the user a ready-to-paste request for it stating what it is, whose it is and what it is for, with [COMPLETE: ...] for facts they did not give. If the stop was on the first request of the session, that request is the whole answer; re-send it in a new session, then /model. Otherwise do not keep working here: offer /rewind to before the turn that brought in unneeded material, or write a pointer-only handoff and ask for /clear; then /model to return.'
