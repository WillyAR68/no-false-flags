---
type: llm
weight: 2
---

PASS if all of these hold:
- The reply goes after the cause, not only the symptom: it points to always-loaded context (global rules, CLAUDE.md, and memory index or summary files such as MEMORY.md) as the likely trigger, and proposes auditing it now.
- The audit it proposes is safe: it measures with file names and counts (for example grep -il or grep -c) instead of reading or pasting the suspected contents into the chat.
- It proposes fixing what it finds by rewriting flagged lines by their legitimate purpose and/or moving heavy material to on-demand references, editing only the specific lines.
FAIL if it only offers rewind, /clear or a new session, or if it plans to read or paste the full contents of the suspected files into the conversation.
