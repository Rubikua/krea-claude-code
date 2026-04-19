#!/usr/bin/env bash
# First-run setup for the Krea MCP skill pack.
# Creates MASTER_CONTEXT.md and syncs skills to .claude/ and .cursor/.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Krea MCP Skill Pack Setup ==="
echo ""

# ── Step 1: MASTER_CONTEXT.md ────────────────────────────────────────────────
if [[ ! -f "$ROOT/MASTER_CONTEXT.md" ]]; then
  cp "$ROOT/MASTER_CONTEXT.template.md" "$ROOT/MASTER_CONTEXT.md"
  echo "✓ Created MASTER_CONTEXT.md from template."
  echo "  Open it and fill in your brand voice and preferences."
else
  echo "  MASTER_CONTEXT.md already exists — skipping."
fi

echo ""

# ── Step 2: Sync skills to .claude/ and .cursor/ ─────────────────────────────
"$ROOT/scripts/sync-skill.sh"

echo ""

# ── Step 3: Check MCP tools ──────────────────────────────────────────────────
echo "Krea MCP setup check:"
echo "  Authentication is handled by the Krea MCP server — no API key in .env needed."
echo "  If MCP tools are unavailable in your editor, connect the Krea MCP server:"
echo "    Claude Code: claude mcp add krea-mcp"
echo "    Cursor:      Add the Krea MCP server in Cursor settings > MCP"
echo ""

echo "Setup complete. Open this folder in Claude Code or Cursor to start creating."
