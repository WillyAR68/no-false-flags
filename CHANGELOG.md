# Changelog

## 1.3.0

- Correctness fix. The fallback hook no longer asserts that a reloaded
  previous-session summary caused the stop. It names that file only as a possible
  contributor, and only after verifying the file still exists on disk and still
  contains the stop text — which removes a false positive where the hook blamed a
  summary that no longer carried any stop.
- The skill no longer tells Claude to "turn the reload off yourself" as if the
  cause were known. It verifies before blaming, does only the safe local fix
  (moving a confirmed file), and asks before any global settings change.
- Both the skill and the hook now state the honest order of likely contributors
  and that a sensitive conversation topic trips the check on the top model with
  no setting or skill able to prevent it — the fallback model is where such work
  continues.

## 1.2.3

- Fix, do not assign: after a stop, Claude does every reversible fix itself and
  asks the user only for what only they can do (Esc, `/rewind`, `/clear`, facts
  only they know). Found in real use: a correct diagnosis read as homework.
- When a session-start hook reloaded an earlier stopped session, Claude now turns
  that reload off itself: it moves the saved files that carry the stop to a backup
  folder and turns off the hook's start-up load. For everything-claude-code the
  fallback hook names the switch (`ECC_DISABLED_HOOKS=session:start`), because
  that hook saves a new summary at every session end and moving files alone does
  not last.

## 1.2.2

- The fallback hook checks whether a `SessionStart` hook loaded text from an
  earlier stopped session into this one (a saved session summary, say). If so, it
  tells the user directly, not only Claude, which file it came from and that
  `/clear` will not help until that file is moved aside or the hook is off. Found
  in real use: a session-summary hook reloaded a stopped session after `/clear`,
  and a plain first message was stopped again.
- The skill and the surface audit count `SessionStart` hook output as
  always-loaded surface.

## 1.2.1

- After any stop, not only on the first request, Claude says what was cut (the
  step or tool call that did not finish; the withheld text cannot be recovered),
  checks what an interrupted tool call left behind, and hands back a
  ready-to-paste request for that step: the same action stated plainly, with what
  it is, whose it is and what it is for, and `[COMPLETE: ...]` for facts the user
  did not give. The fallback hook says the same.
- New eval case `hands-back-stopped-step`: 3 of 3 with the plugin and 3 of 3
  without when the user asks what was cut; the change makes it the default when
  the user does not ask.

## 1.2.0

- The read hook now works for whole folders in any language: it redirects
  whole-file reads of docs over 80 lines (was 150), a second whole-file read from
  the same folder, and whole-file reads past 300 lines per session.
- A stop on the first request of a session is answered with the confirmable task
  line instead of abandoning the request; the fallback hook says so.
- The list of sensitive domains now covers servers, remote access, migrations,
  credentials, third-party sites, security testing, monitoring, and financial,
  health or legal data. Project docs read at every start and pasted kickoff
  prompts count as always-loaded surface; new kickoff prompt example.
- Four new eval cases. Measured on Opus 5.5: a short infrastructure request was
  stopped on the first response in 12 of 12 runs with or without the plugin; the
  same request with its context written in it, 0 of 6; with that context only in
  CLAUDE.md or added by a hook, 6 of 6. The context has to be in the request.

## 1.1.0

- Recurring stops on legitimate work, or a request to make them stop, now trigger
  the fix for the cause (the always-loaded context), not only rewind and /clear.
- Memory indexes and summaries (such as MEMORY.md) are named as part of the
  always-loaded surface: one line there loads in every session.
- Safe audit technique: measure with file names and counts (`grep -il`, `grep -c`),
  edit only the flagged lines, never read the suspected content into the chat.
- Example of a memory index line rewritten by its purpose.
- New eval case `treats-recurring-cause`: 0-80% without the plugin, 100% with it
  (5 of 5 runs).

## 1.0.0

- First public release as `no-false-flags`.
- The skill covers: bringing material into the conversation by section, delivering
  the request as a confirmable task line, shaping the response, recovering when a
  response is stopped (rewind, clean session with a pointer-only handoff, `/model`
  after fallback, `/feedback`), and keeping always-loaded context small.
- Recovery steps based on the official Claude Code documentation.
- Eval suite with five with-vs-without cases, one of them in Spanish.
- Hooks: `PreToolUse` read-by-section guard for long documents, and
  `PostModelSwitch` recovery prompt after an automatic model fallback.
- Skill body trimmed to about 500 words.
- Installable from GitHub as a Claude Code plugin marketplace.
