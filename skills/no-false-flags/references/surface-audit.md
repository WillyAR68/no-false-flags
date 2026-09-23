# Auditing your always-loaded surface

On-demand reference for the no-false-flags skill. How to take stock of everything
that loads into every session and shrink it to what earns its place.

## Why

The always-loaded surface — global rules, any always-on project memory, and the
root `CLAUDE.md` — is paid by every session. It grows silently: rules get added,
rarely removed. An audit finds what no longer earns its slot and, in doing so,
cuts the surface a safety check can react to on legitimate work.

## The audit

1. **List everything that always loads.** The global rules directory, the root
   `CLAUDE.md`, any always-on memory.
2. **Measure the size.** A rough line/token count per file and the total. If the
   total is large, that is the budget spent on every task, relevant or not.
3. **Run the four checklist questions on each file** (short? cross-cutting?
   explicit intent? right layer?). Flag any that fail. See
   [../examples/checklist.md](../examples/checklist.md).
4. **Flag three problems specifically:**
   - **Overlap** — two files covering the same thing. Merge them; one owner per
     topic.
   - **Stale** — refers to things that no longer exist. Delete or update.
   - **Accidentally global** — only matters in one project or one domain. Demote
     to `references/` or to that project's memory.
   - **Sensitive / dual-use always loaded** — specialized-vocabulary material
     sitting in the always-loaded layer. This is the surface that most often
     causes false positives on capable models. Demote it to `references/`.
5. **Propose, do not apply silently.** For each flagged file give a verdict:
   keep / shorten / demote to `references/` / move to project memory / turn into a
   hook or permission / delete.

## Output

A short list: `file -> verdict -> where it should go`. Then move them following
[demotion.md](demotion.md).

## Cadence

Run it when the always-loaded surface feels heavy, when sessions start flagging
legitimate work, or periodically. It is cheaper than letting the surface rot.
