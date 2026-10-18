#!/usr/bin/env bash
# PostModelSwitch: after an automatic model change (source "auto", which includes
# a safety-check fallback), give Claude honest recovery guidance. It does NOT
# assert a cause: what the classifier reacted to is not knowable from here. It
# only names a reloaded previous-session summary as a POSSIBLE contributor, and
# only when that file still exists on disk and still contains the stop text.
input=$(cat)
printf '%s' "$input" | grep -Eq '"source"[[:space:]]*:[[:space:]]*"auto"' || exit 0

flag='stopped by a safety classifier|safeguards (flagged|stopped)|was withheld'
ctx='no-false-flags: the model was switched automatically; a safety check likely stopped the previous response. Apply the no-false-flags skill. Never reword anything to get past the check. Do the reversible fixes yourself and ask the user only for what only they can do. (1) Tell the user in one line it was the safety check, not a tool error. (2) Say what was cut and check whether an interrupted tool call left anything behind, reporting it by name. (3) If the stopped step was legitimate work, hand the user a ready-to-paste request for it stating what it is, whose it is and what it is for, with [COMPLETE: ...] for facts you do not have. Do NOT assert a single cause: the trigger cannot be known from here. Contributors to consider, honestly: material from another task still in this conversation (name files only); the TOPIC of the conversation itself being a sensitive domain (security, credentials, software protection or anti-tamper, biology) trips the check on the top model and no setting or skill prevents it; the fallback model you are on now does not run that classifier, so continuing here is often the way through; and, less often, a previous-session summary reloaded at startup. Act only on what you verify.'

tp=$(printf '%s' "$input" | sed -n 's/.*"transcript_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
tp=${tp//\\\\//}
file=""
if [ -n "$tp" ] && [ -f "$tp" ]; then
  cand=$(grep -E '"hookEvent":[[:space:]]*"SessionStart' "$tp" 2>/dev/null \
    | grep -E "$flag" \
    | grep -oiE '[A-Za-z]:[^" ]*session[^" ]*\.(tmp|md|json|txt)|/[^" ]*session[^" ]*\.(tmp|md|json|txt)' | head -1)
  if [ -n "$cand" ]; then
    disk=${cand//\\\\//}; disk=${disk//\\//}
    # Blame it only if the file ON DISK still carries the stop text.
    [ -f "$disk" ] && grep -qE "$flag" "$disk" 2>/dev/null && file="$disk"
  fi
fi

if [ -z "$file" ]; then
  echo "$ctx"
  exit 0
fi

note="no-false-flags: one thing to check (not necessarily the cause): a previous-session summary that still contains a past stop is being reloaded at session start, from ${file}."
act="no-false-flags: you may do this reversible local fix now and report it: move that file to a backup folder so it stops being reloaded. It regenerates at session end, so the lasting fix is a global switch (everything-claude-code: ECC_DISABLED_HOOKS=session:start under env in ~/.claude/settings.json) — ASK the user before changing global settings; it affects every project. Tell the user plainly this may not be the cause: a sensitive conversation topic trips the check regardless, and no setting fixes that."
printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"PostModelSwitch","additionalContext":"%s %s %s"}}\n' "$note" "$ctx" "$note" "$act"
