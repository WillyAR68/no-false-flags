---
name: no-false-flags
description: Use when a response was "stopped by a safety classifier" or "withheld", when a notice says "safeguards flagged this session" and another model "is answering instead", when legitimate work keeps getting flagged, or before reading a long document or acting on a terse request in a sensitive domain.
---

# No False Flags

The safety check reads the **whole conversation**, and everything read or pasted
stays in it for the session. Keep in it only what the task needs; state the task
plainly. Nothing here bypasses a check or guarantees zero stops.

## 1. When a response is stopped

A new message in the same session usually re-triggers the check, and so does
`--continue` / `--resume`. Recovery means removing content, not insisting.

1. Tell the user in one line: it was the safety check, not a tool error.
2. Find material the task does not need (a document from another task, long
   pastes). Refer to it **by file name only**; describing it puts it back in.
3. **Turn identifiable:** ask the user for Esc twice or `/rewind` to before it.
4. **Not identifiable, or second stop:** stop working here. Write a handoff (goal,
   decisions, state, pending; file pointers, never content; files NOT to open).
   Ask for `/clear` or a new session without `--continue`. Do not keep going here.
5. **First request of a session:** always-loaded context (CLAUDE.md, rules,
   memory) may be the trigger; suggest `claude --safe-mode` to confirm.
6. **After an automatic fallback:** once clean, `/model` returns to the original.
7. **Still stopped in a clean session:** suggest `/feedback`; for legitimate
   security work, Anthropic's Cyber Verification Program.

Never reword, use euphemisms, or obfuscate to get past the check. If asked, decline
and offer the clean path and section 3 instead.

## 2. Bringing material in

For a long document, or one from another task: Grep headings (`^#`) and task
keywords with line numbers, then Read only those sections with `offset`/`limit`.
Quote only the lines you act on. "It fits in one read" is not the test: every
section read stays in the conversation.

## 3. Delivering the request

If a short or ambiguous request touches a sensitive domain (deleting data,
suspending accounts, access control, licensing, bulk actions on people), restate
it first, in the user's language, as one confirmable line:

> Task: <action> on <object>, owned by <whom>, for <purpose>.
> Safeguards: <dry-run / confirmation / audit log / rollback>.

Use the domain's professional terms, not euphemisms. The purpose comes from the
user: if unstated, write it as a question. Ask about ownership if not evident.
Read-only exploration can proceed; nothing irreversible runs before confirmation.

## 4. Shaping the response

Answer at the scope asked, in the task's own domain. No unrequested background or
tutorials; no material from an earlier, unrelated task.

## 5. Clean from the start

Keep always-loaded rules short; move long or single-domain material to on-demand
references. See [loading layers](references/loading-layers.md),
[surface audit](references/surface-audit.md), [demotion](references/demotion.md),
[intent lines](references/framing-intent.md), [limits](references/false-positives.md).
Sources: [errors](https://code.claude.com/docs/en/errors),
[model fallback](https://code.claude.com/docs/en/model-config).
