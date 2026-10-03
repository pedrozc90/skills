# skills

Collection of agent skills for Claude Code.

## Skills

| Skill     | Description                                                           |
|:----------|:----------------------------------------------------------------------|
| `commits` | Suggest how to split pending changes into commits (submodules first). |

## Install

Link a skill into `~/.claude/skills`:

```bash
make install <name>   # e.g. make install commits
```

List available skills:

```bash
make help
```

Then start a new Claude Code session and run `/<name>`.
