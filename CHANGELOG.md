# Changelog

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
