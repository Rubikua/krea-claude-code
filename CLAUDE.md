# Claude Code — project instructions

## First-time setup

If `MASTER_CONTEXT.md` does not exist, copy `MASTER_CONTEXT.template.md` to `MASTER_CONTEXT.md`.

Krea is accessed via the **Krea MCP** (`mcp__krea-mcp__*` tools) — no API key in `.env` is required.
If the MCP tools are unavailable, tell the user to connect the Krea MCP server in Claude Code settings.

## Every session

1. Read **[MASTER_CONTEXT.md](MASTER_CONTEXT.md)** for brand voice, default style IDs, and accumulated learnings.
2. Use the **`krea-mcp`** skill (`.claude/skills/krea-mcp/SKILL.md`) for all generation workflows.
3. If `MASTER_CONTEXT.md` has empty fields (default style IDs, brand voice), offer to populate them and **write the values back** so future sessions have them.

## After significant changes

Append a short dated note to **MASTER_CONTEXT.md** under Changelog (Decision / What changed / Why).

## Skill edits

Edit the canonical source at `skills/krea-mcp/`. Run `./scripts/sync-skill.sh` to copy changes to `.claude/skills/` and `.cursor/skills/`.
