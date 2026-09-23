# Contributing

Thanks for helping. This skill is small on purpose, so changes need evidence.

## Reporting a case

Open an issue with the "Real case" template. Describe the situation, what Claude did,
and what you expected. **Do not paste the content that got flagged**, and remove
anything private. A file name and a one-line description of its topic are enough.

## Changing the skill

The skill is built test-first. For any change to `SKILL.md`:

1. Add or update a case under `evals/` that fails without your change.
2. Make the change.
3. Run `claude plugin eval . --trust-plugin --scaffold` and include the before/after scores in the PR.

Keep `SKILL.md` short and every example in a neutral domain (billing, data
deletion, account management). Changes whose goal is to get content past a safety
check, rather than to state legitimate work clearly, will not be accepted.

## Translations and other languages

The skill works in any conversation language. A new eval case in your language
(like `evals/restates-terse-request-es`) is a welcome contribution.

## Style

English, plain words, short sections. One idea per bullet.
