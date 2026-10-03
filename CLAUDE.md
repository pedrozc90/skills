# CLAUDE.md

Collection of agente skills

## Markdown

- Keep the tables well formatted: pad every cell with spaces so all `|` line up vertically in the raw markdown (column width = longest cell, separator dashes match).
- Add `:` to align column text

## Rules

- Git is **read-only** for you. I will handle all writes myself.
- Allowed: `status`, `diff`, `log`, `show`, `blame`, `branch` (listing only),
  `submodule status`.
- Forbidden: `push`, `commit`, `add`, `pull`, `merge`, `rebase`, `checkout`, `switch`,
  `stash`, `tag`, `cherry-pick`, `reset`, `restore`, `revert`, `clean`, and
  `submodule update/init/sync/add`.
- Do not use the GitHub CLI (`gh`).