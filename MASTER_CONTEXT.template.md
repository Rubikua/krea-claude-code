# Master context (Krea + agents)

**Purpose:** One place for humans and AI agents to capture **decisions**, **brand voice**, **style IDs**, **Krea quirks**, and **what we learned** while using this repo.

## How agents should use this file

- **At the start of every substantive session:** Read this file for project-specific context not in the skill.
- **After meaningful changes:** Append a new **dated entry** under [Changelog](#changelog).
- **If fields are empty:** Offer to populate them (search for styles, ask user for brand preferences).

## Project snapshot

- **Generation method:** Krea MCP tools (`mcp__krea-mcp__*`).
- **Skill:** `.claude/skills/krea-mcp/` and `.cursor/skills/krea-mcp/` (sync from `skills/krea-mcp/` via `scripts/sync-skill.sh`).

## My workspace

- **Default image model:** _(fill in — e.g. flux-pro)_
- **Default video model:** _(fill in — e.g. kling)_
- **Default aspect ratio:** _(fill in — e.g. 9:16 for Reels)_

## Saved style IDs

_Fill in after first `search_styles` call. Agent references this before searching again._

| Style name | Style ID | Best for |
|-----------|---------|---------|
| _(e.g. vintage film grain)_ | _(style_id)_ | product shots |

## Brand (optional)

_Edit or replace with your real brand blocks (see `skills/krea-mcp/prompting/brand-voice-starter.md`)._

- **Tone:**
- **Audience:**
- **Words to use / avoid:**
- **Visual aesthetic:**

## Reference images

Drop reference images into the `references/` folder at the repo root, or paste hosted URLs here:

- `references/influencers/` — Character photos to recreate as AI people
- `references/products/` — Product photos for showcase workflows
- `references/aesthetics/` — Mood boards, lighting references, style inspiration

The agent uses these as `image_url` in `generate_image` / `generate_video`, or uploads via `upload_asset` when a hosted URL is needed.

## Model learnings (universal)

These are confirmed Krea MCP behaviors. They apply to all workspaces.

### MCP tool flow

- All generation tools return a `job_id` immediately — never a final URL.
- Poll with `get_job(job_id)` until `status == "completed"`. Statuses: `scheduled` → `processing` → `completed` | `failed`.
- Typical times: images ~15–45s, videos ~60–300s depending on model and duration.

### Image generation

- `generate_image` requires only `prompt`. All other params are optional.
- `image_url` enables image-to-image (style transfer or face/scene reference).
- `style_id` applies a LoRA — use `search_styles` + `get_style` to discover IDs.
- Default size is 1024×1024. Change `width`/`height` for different ratios (e.g., 768×1344 for 9:16 portrait).

### Video generation

- `generate_video` requires only `prompt`. Model defaults to `hailuo`.
- `image_url` enables image-to-video (animate a specific starting frame).
- `aspect_ratio` accepts `16:9`, `9:16`, `1:1`.
- `duration` accepts seconds (typically 5 or 10 depending on model).
- **kling / veo-3:** Best for character animation with natural motion. Include 3–4 human motion cues.
- **sora:** Best for longer scenes (up to ~20s) and complex multi-shot briefs.
- **runway:** Best for cinematic motion, camera moves (zoom, dolly, pan).
- **pika:** Fast turnaround for short reactive clips.

### Asset upload

- `upload_asset(url)` takes a publicly accessible image/video URL and uploads it to Krea's storage.
- Returns an asset with its own hosted URL — use this when a model needs a Krea-hosted reference.
- Use `list_assets` to browse previously uploaded assets.

### Styles / LoRAs

- `search_styles(query)` returns style metadata including `id`, `name`, `description`.
- `get_style(style_id)` returns full details and preview images.
- Save `style_id` values in **Saved style IDs** above so the agent never re-searches for the same style.
- Apply via `style_id` param in `generate_image` — does NOT apply to video generation.

### UGC prompting

- **Imperfection block (camera):** Every UGC image/video prompt must include camera imperfections: motion blur, overexposure, grain, lens distortion, off-center framing, soft focus. Without this, output looks too polished.
- **Skin realism block (mandatory for people):** Include 3–4 subtle skin cues: "visible pores, slight unevenness in skin tone, minor undereye shadows, hint of shine from natural oils." Goal: real person, not retouched.
- **Human motion cues for video:** Without motion language, subjects look frozen. Include 3–4 cues per prompt: breaking eye contact, head tilt, shifting weight, adjusting grip.

### Image QA

- Agents must visually note defects (hands, fingers, face merge, artifacts) when reviewing still outputs.
- If defective, regenerate with a refined prompt — up to 2 retries (3 total attempts).
- Append a QA note to the session changelog if retries were needed.

### Character consistency

- **Two-step flow mandatory for expensive video:** (1) generate still → (2) user approves → (3) animate. Never skip approval — videos are slow and costly.
- **Nano Banana** is the preferred model for consistent character stills when identity needs to hold across multiple shots.
- Upload approved character stills via `upload_asset` so the hosted URL can be reused across sessions.

## Changelog

### YYYY-MM-DD — Template entry

- **Decision:**
- **Change:**
- **Why:**
