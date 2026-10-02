#!/usr/bin/env bash
# PostModelSwitch: after an automatic model change (source "auto", which includes
# a safety-check fallback), tell Claude how to recover. If a SessionStart hook
# loaded text from an earlier stopped session into this one (a saved session
# summary, say), also tell the user directly: /clear will not help while that
# hook keeps loading it.
input=$(cat)
printf '%s' "$input" | grep -Eq '"source"[[:space:]]*:[[:space:]]*"auto"' || exit 0
ctx='no-false-flags: the model was switched automatically. If a safety check caused it, apply the no-false-flags skill now: say what was cut and check whether an interrupted tool call left anything behind; if the stopped step was legitimate work, hand the user a ready-to-paste request for it stating what it is, whose it is and what it is for, with [COMPLETE: ...] for facts they did not give. If the stop was on the first request of the session, that request is the whole answer; re-send it in a new session, then /model. Otherwise do not keep working here: offer /rewind to before the turn that brought in unneeded material, or write a pointer-only handoff and ask for /clear; then /model to return.'

tp=$(printf '%s' "$input" | sed -n 's/.*"transcript_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
tp=${tp//\\\\//}
line=""
if [ -n "$tp" ] && [ -f "$tp" ]; then
  line=$(grep -E '"hookEvent":[[:space:]]*"SessionStart' "$tp" 2>/dev/null \
    | grep -E 'stopped by a safety classifier|safeguards (flagged|stopped)|was withheld' | head -1)
fi
if [ -z "$line" ]; then
  echo "$ctx"
  exit 0
fi
file=$(printf '%s' "$line" | grep -oiE '[A-Za-z]:[^" ]*session[^" ]*\.(tmp|md|json|txt)|/[^" ]*session[^" ]*\.(tmp|md|json|txt)' | head -1)
msg="no-false-flags: a hook that runs at session start loaded text from an earlier stopped session into this one${file:+ (from $file)}. /clear and new sessions will not help while it keeps loading it: move that saved file out of the way or turn that hook off, then start a new session. claude --safe-mode (no hooks) confirms it."
printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"PostModelSwitch","additionalContext":"%s Tell the user this first. %s"}}\n' "$msg" "$msg" "$ctx"
