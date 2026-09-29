# Changelog

## 1.1.0

- Recurring stops on legitimate work, or a request to make them stop, now trigger
  the fix for the cause (the always-loaded context), not only rewind and /clear.
- Memory indexes and summaries (such as MEMORY.md) are named as part of the
  always-loaded surface: one line there loads in every session.
- Safe audit technique: measure with file names and counts (`grep -il`, `grep -c`),
  edit only the flagged lines, never read the suspected content into the chat.
- Example of a memory index line rewritten by its purpose.
- New eval case `treats-recurring-cause`: 0-67% without the plugin, 100% with it.

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
