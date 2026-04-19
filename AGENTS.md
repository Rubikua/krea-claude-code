# Agent instructions

This repository is set up for AI coding agents (Cursor, Claude Code, Copilot-style tools, etc.).

## First-time setup

If `MASTER_CONTEXT.md` does not exist, run `./scripts/setup.sh` or copy `MASTER_CONTEXT.template.md` to `MASTER_CONTEXT.md` manually.

Krea is accessed via **Krea MCP** tools (`mcp__krea-mcp__*`). No API key setup is required — the MCP server handles authentication. If MCP tools are unavailable in your environment, use the Krea REST API documented in `skills/krea-mcp/reference.md` as a fallback.

## Every session

1. Read **[MASTER_CONTEXT.md](MASTER_CONTEXT.md)** for brand voice, saved style IDs, and session learnings.
2. Follow the skill at `.cursor/skills/krea-mcp/` or `.claude/skills/krea-mcp/` (synced from `skills/krea-mcp/` via `scripts/sync-skill.sh`).
3. If `MASTER_CONTEXT.md` has empty fields (default style, brand voice), offer to populate them and write back.
4. After material changes, add a dated entry to **MASTER_CONTEXT.md** Changelog.
