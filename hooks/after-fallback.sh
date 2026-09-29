#!/usr/bin/env bash
# PostModelSwitch: after an automatic model change (source "auto", which includes
# a safety-check fallback), tell Claude how to recover.
input=$(cat)
printf '%s' "$input" | grep -Eq '"source"[[:space:]]*:[[:space:]]*"auto"' || exit 0
echo 'no-false-flags: the model was switched automatically. If a safety check caused it, apply the no-false-flags skill now. If the stopped turn answered the first request of the session, the request lacked context: answer it now with the confirmable task line (what it is, whose it is, what it is for, safeguards), and suggest re-sending the request with that context written in it, in a new session, then /model. Otherwise do not keep working here: offer /rewind to before the turn that brought in unneeded material, or write a pointer-only handoff and ask for /clear; then /model to return.'
