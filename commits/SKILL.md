---
name: commits
description: Suggest how to split pending git changes into commits. Outputs a table of very short commit messages and the files to add to each, handling submodules first. Use when the user runs /commits or asks how to group/split their changes into commits.
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git submodule status:*), Bash(git -C:*), Read
---

# commits

Suggest commits for the current working tree. **Read-only**: never run `git add`, `git commit`, or any other git write command. Only propose.

## Steps

1. Run `git status --porcelain --untracked-files=all` and `git submodule status --recursive`.
2. For each submodule with changes (`+` prefix in submodule status, or listed as modified), run `git -C <path> status --porcelain --untracked-files=all` and `git -C <path> diff HEAD`. Handle nested submodules deepest first.
3. Read `git diff HEAD` in the main repo, and read untracked files, to understand each change.
4. Group files into logical commits (one concern per commit). Put files with similar or related changes in the same commit (e.g. a feature and its docs/tests, the same fix across files); don't split into one commit per file. Never mix submodule-internal files and parent-repo files in one commit.
5. Order: submodule commits first (deepest first), then a parent-repo commit that includes the submodule path (pointer bump), then the other parent-repo commits.

## Message format

Keep it short and concise — never a paragraph.

- **Default** — one short line naming what changed and where:

  ```
  changed feature x in file core/init.lua
  ```

- **Several distinct changes one line can't summarize** — a short summary line, then a dash list, one short item per change:

  ```
  fixes
  - changed file a.lua
  - fixed bug X
  - added file b.lua
  ```

The summary line is free text (e.g. `fixes`, `changes`, `refactored parser`); no fixed keyword is required.
Lowercase, no trailing periods, no body.
If one line covers the commit, stop there. Never add dash items that just restate the files (e.g. `added file x`, `updated README.md`) — the Files column already shows them.
Name only the main change. Don't mention supporting changes that exist because of it (its docs, README/index entry, tests, config) — e.g. `added commits skill`, not `added commits skill and readme index`.

## Output

Only the table — no preamble or recap:

| Order | Repo       | Commit message              | Files           |
|:-----:|:-----------|:----------------------------|:----------------|
| 1     | `libs/foo` | added parser                | `src/parser.ts` |
|       |            |                             | `src/index.ts`  |
| 2     | `.`        | updated foo submodule       | `libs/foo`      |
| 3     | `.`        | fixed empty config handling | `config.ts`     |

- One line per row: the first row of a commit holds Order, Repo, the message's first line and the first file; each extra message line or file goes in its own row below, with the other cells empty. Never use `<br>`.
- Omit the `Repo` column when no submodule has changes (everything is in the main repo).
- Files: paths relative to that repo. A parent commit following a submodule commit must include the submodule path.
- Keep the table well formatted: pad every cell so all `|` line up vertically in the raw markdown (column width = longest cell, separator dashes match).
- If there are no changes, reply "No changes."
