# Krea AI — Agent Skill Pack

Create AI marketing images and videos using your [Krea](https://krea.ai) account, powered by AI agents in **Claude Code** or **Cursor**. Supports Flux, Flux Pro, Imagen 4, Krea-1, Nano Banana, Seedream, Hailuo, Kling, Veo 3, Sora, Runway, Pika, Luma, and Wan.

## Get started (3 minutes)

### 1. Clone this repo

```bash
git clone https://github.com/YOUR_USERNAME/krea-claude-code
cd krea-claude-code
```

### 2. Connect Krea MCP

Add the Krea MCP server to Claude Code:

```bash
claude mcp add krea-mcp
```

Or add it manually to your Claude Code MCP config. No API key setup in `.env` is needed — the MCP server handles Krea authentication.

### 3. Run setup

```bash
./scripts/setup.sh
```

This will:
- Create your personal `MASTER_CONTEXT.md` workspace file
- Sync the skill to `.claude/skills/` and `.cursor/skills/`

### 4. Open in your AI editor

**Claude Code:** Open the folder. The agent loads the Krea skill automatically via `CLAUDE.md`.

**Cursor:** Open the folder. The skill is at `.cursor/skills/krea-mcp/`.

### 5. Start creating

The agent handles MCP tool calls, polling, prompt engineering, and file organization. Here are the main workflows:

#### Generate a marketing image

> "Generate a product hero image for this skincare serum — clean white studio, soft light"

Uses Flux Pro or Imagen 4 for photorealistic product shots. The agent picks the best model for your brief, crafts the prompt, polls until complete, and saves the URL to `MASTER_CONTEXT.md`.

#### Create an AI influencer (character sheet)

> "Create a new AI influencer — a 25-year-old barista with warm brown eyes and natural hair"

Uses Nano Banana for consistent character generation. Generates a hero portrait first for approval, then 9 additional angles (3/4 views, profile, closeup, lifestyle). All saved to `references/influencers/`.

#### Generate a UGC selfie still

> "Generate a UGC selfie of Maya holding the serum bottle in her bathroom"

Combines your character reference + product photo using Nano Banana or Krea-1 with UGC camera imperfection prompting. Result is an authentic-looking iPhone frame grab.

#### Animate a still into video

> "Turn this selfie into a 5-second video — she's smiling and looking at the product"

Uses Kling or Veo 3 with `image_url` (image-to-video). The agent animates from your approved UGC still with natural human motion cues.

#### Quick video ad from text

> "Generate a 9-second UGC video ad for this product" + drop a product photo URL

Uses Hailuo or Sora with your brief. Faster than the two-step image→video flow.

#### Style-consistent content

> "Find a cinematic film grain style and generate 3 product shots in that style"

Agent uses `search_styles` to find matching LoRAs, picks the best `style_id`, and applies it across all generations.

#### Other things to try

- "Recreate this influencer's look from a reference photo"
- "Generate 5 ad variations with different compositions"
- "Make a Nano Banana product hero image"
- "Generate an image with text — use Ideogram"
- "Create a short Runway cinematic clip for the hero section"

---

## What's in the box

| Path | What it does |
|------|-------------|
| `skills/krea-mcp/` | The skill: tool reference, prompting guide, per-model prompt library |
| `MASTER_CONTEXT.template.md` | Template for your workspace context (brand voice, style IDs, learnings) |
| `MASTER_CONTEXT.md` | Your personalized copy (created by setup, not committed to git) |
| `scripts/setup.sh` | One-time setup |
| `scripts/sync-skill.sh` | Copies skill edits to `.claude/` and `.cursor/` directories |
| `references/` | Drop reference images/URLs here (influencers, products, aesthetics) — gitignored |

---

## Models

### Image models

| Model | Best for |
|-------|---------|
| `flux` | Fast, general-purpose images (default) |
| `flux-pro` | Higher quality, photorealistic scenes |
| `ideogram` | Images with readable text overlays |
| `imagen-4` | Google's model — photorealistic product shots |
| `krea-1` | Krea's own model — great for stylized/artistic |
| `chatgpt-image` | GPT-4o image — complex compositions, text |
| `nano-banana` | Consistent character generation and UGC stills |
| `seedream` | ByteDance's model — portraits and lifestyle |

### Video models

| Model | Best for | Duration |
|-------|---------|---------|
| `hailuo` | General UGC, fast (default) | 5s |
| `kling` | High-quality character animation | 5–10s |
| `runway` | Cinematic, creative motion | 4–10s |
| `pika` | Fast clips, motion FX | 3–5s |
| `veo-3` | Best quality, audio-aware | 8s |
| `sora` | Longer videos, complex scenes | up to 20s |
| `luma` | Photorealistic, smooth motion | 5s |
| `wan` | Artistic, anime-style | 5s |

### Aspect ratios

| Ratio | Use case |
|-------|---------|
| `16:9` | YouTube, desktop hero (default) |
| `9:16` | Reels, TikTok, Stories |
| `1:1` | Feed posts, product squares |

---

## Styles / LoRAs

Krea supports styles (LoRAs) you can search and apply to any image generation:

```
> "Search for a vintage film grain style and apply it to this product shot"
```

The agent calls `search_styles`, picks the best match, then passes `style_id` into `generate_image`. Save useful `style_id` values to `MASTER_CONTEXT.md` so you never search again.

---

## Reference images

Drop images (or paste URLs) into the `references/` folder and mention them when prompting:

- **`references/influencers/`** — Character reference photos
- **`references/products/`** — Product photos for showcase workflows
- **`references/aesthetics/`** — Mood boards and style references

The agent uses reference image URLs in `image_url` (image-to-image or image-to-video) and uploads them via `upload_asset` when Krea needs a hosted URL.

---

## Project memory

`MASTER_CONTEXT.md` is your workspace's living memory. The agent reads it at the start of every session and writes learnings back. It stores:

- **Default style IDs** — saved after first style search so you're never asked again
- **Preferred models** — per use-case defaults (e.g. "always use kling for character video")
- **Brand voice** — tone, audience, word preferences
- **API learnings** — Krea quirks discovered during sessions
- **Changelog** — dated notes from each session

---

## Editing the skill

The canonical skill source lives in `skills/krea-mcp/`. After editing any file there, run:

```bash
./scripts/sync-skill.sh
```

This copies your changes to `.claude/skills/` and `.cursor/skills/` (which are gitignored — they're generated copies).

---

## Security

- `MASTER_CONTEXT.md` is gitignored — contains your style IDs and workspace data
- `references/` is gitignored — keeps your client assets local
- `logs/` is gitignored
- Never paste Krea session tokens in GitHub issues or public chats

---

## Vendor prompting guides

| Model | Guide |
|-------|--------|
| Flux | [Black Forest Labs — Flux docs](https://blackforestlabs.ai/docs) |
| Veo 3 | [Google Cloud — Veo 3 prompting guide](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-veo-3) |
| Kling | [Kling AI — user guide](https://kling.ai/quickstart) |
| Sora | [OpenAI — Sora prompting guide](https://developers.openai.com/cookbook/examples/sora/sora2_prompting_guide) |
| Ideogram | [Ideogram docs](https://developer.ideogram.ai/docs) |
| Runway | [Runway AI — docs](https://docs.runwayml.com) |
| Luma | [Luma AI — docs](https://lumalabs.ai/api/docs) |

---

## Other AI assistants (Manus, Copilot, etc.)

Point your assistant at [AGENTS.md](AGENTS.md) and `MASTER_CONTEXT.md` + the skill path at `skills/krea-mcp/`.
