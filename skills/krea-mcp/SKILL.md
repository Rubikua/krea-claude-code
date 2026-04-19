---
name: krea-mcp
description: >-
  Creates AI images and videos via the Krea MCP tools (mcp__krea-mcp__*). Supports Flux, Flux Pro, Ideogram, Imagen 4, Krea-1, ChatGPT Image, Nano Banana, Seedream (images) and Hailuo, Kling, Runway, Pika, Veo 3, Sora, Luma, Wan (video). Handles style/LoRA search, asset upload, job polling, and UGC workflows. Use when the user mentions Krea, AI image generation, AI video generation, UGC content, influencer creation, or marketing creative.
---

# Krea MCP skill

## Configuration

All Krea capabilities are accessed through MCP tools (`mcp__krea-mcp__*`). No API key or `.env` setup is required — the MCP server handles authentication.

If MCP tools are unavailable, inform the user and point them to the Krea MCP setup guide. Do not attempt REST API fallback without explicit user instruction.

## Read order

1. Repo root **`MASTER_CONTEXT.md`** (brand voice, saved style IDs, model preferences, learnings).
2. This file for the decision tree and tool usage.
3. **[reference.md](reference.md)** for full tool parameter reference.
4. **[prompting/guide.md](prompting/guide.md)** for universal prompting rules.
5. The right **`prompting/prompt-library/`** file for the chosen model.

---

## Decision tree: which flow?

```
User wants IMAGE?
├── Need text in image?                     → model: ideogram
├── Need consistent character?              → model: nano-banana
│   └── Reference photo provided?          → use image_url for likeness
├── Need photorealistic product/person?    → model: flux-pro or imagen-4
├── Artistic / stylized?                    → model: krea-1
│   └── Want a specific aesthetic style?  → search_styles → style_id
├── Complex composition + text?            → model: chatgpt-image
├── Portrait / lifestyle (fast)?           → model: seedream
└── General purpose (default)             → model: flux

User wants VIDEO?
├── Animate an existing image (start frame)?
│   ├── Character with natural motion?     → model: kling  (image_url)
│   ├── Best quality + audio?             → model: veo-3  (image_url)
│   └── General / fast?                   → model: hailuo (image_url)
├── Cinematic camera move?                → model: runway
├── Longer scene (>10s)?                  → model: sora
├── Artistic / anime?                     → model: wan
├── Photorealistic smooth motion?         → model: luma
└── Fast UGC / reactive clip?            → model: pika

User wants CONSISTENT CHARACTER ACROSS SHOTS?
└── Two-step flow: still → approve → video (see Character workflow below)

User wants A STYLE APPLIED?
└── search_styles → pick style_id → generate_image with style_id

User needs to UPLOAD a local/external image?
└── upload_asset(url) → use returned URL as image_url in generation
```

---

## Core workflows

### 1. Generate an image

```
1. Determine best model from decision tree above.
2. Read prompting/guide.md + prompting/prompt-library/<model>.md.
3. Call generate_image(prompt, model, width, height, image_url?, style_id?, negative_prompt?).
4. Call get_job(job_id) in a polling loop until status == "completed".
5. Return result URL to user. Offer to save to MASTER_CONTEXT.md.
6. QA: note any defects (hands, faces, text errors). Regenerate if needed (max 3 attempts).
```

### 2. Generate a video

```
1. Determine best model from decision tree above.
2. Read prompting/guide.md + prompting/prompt-library/video.md.
3. If user provides an image: ensure it's a hosted URL (upload via upload_asset if needed).
4. Call generate_video(prompt, model, aspect_ratio, duration, image_url?).
5. Poll get_job(job_id) until status == "completed" (videos take 1–5 min).
6. Return result URL to user.
```

### 3. Character consistency (two-step flow)

```
STEP 1 — Still (cheap):
  1. generate_image with nano-banana (or flux-pro). Use image_url if reference photo provided.
  2. Poll and show result. Ask user: "Does this look right? Approve to continue to video."
  3. If rejected: regenerate with refined prompt (max 3 attempts).

STEP 2 — Video (expensive):
  4. Only after approval: upload approved image via upload_asset if not already hosted.
  5. Call generate_video with the approved image URL as image_url.
  6. Poll until complete.

NEVER skip the approval step. Video generation is slow and costly.
```

### 4. Style / LoRA workflow

```
1. Call search_styles(query) — e.g. search_styles("vintage film grain").
2. Review results. If uncertain, call get_style(style_id) for full details and previews.
3. Apply via style_id in generate_image.
4. Save the style_id + name to MASTER_CONTEXT.md under "Saved style IDs".
```

### 5. Asset upload

```
Use upload_asset(url) when:
  - The user has a local image path (convert to a hosted URL first, or ask user to upload somewhere accessible).
  - You need to reuse an output image as input in a subsequent generation.
  - A model requires a Krea-hosted URL rather than an external URL.

After upload: use the returned asset URL as image_url in generate_image / generate_video.
```

---

## Polling pattern

```
job = generate_image(...)  # or generate_video
job_id = job.job_id

# Poll every 10–15s for images, every 20–30s for videos
while True:
    result = get_job(job_id)
    if result.status == "completed":
        url = result.result_url  # or result.output_url depending on response shape
        break
    elif result.status == "failed":
        raise error with result.error message
    else:
        wait(15)  # images; wait(25) for video
```

Always inform the user that generation is in progress and give an estimated wait time.

---

## Credit / cost awareness

Krea charges credits per generation. Before generating expensive video, confirm the user is aware. Always prefer the cheaper still-first workflow for character work.

| Type | Relative cost |
|------|-------------|
| Image (flux, seedream) | Low |
| Image (flux-pro, imagen-4, chatgpt-image) | Medium |
| Video (hailuo, pika, wan) | Medium |
| Video (kling, runway, luma, veo-3) | High |
| Video (sora) | Highest |

---

## Error handling

- **Job failed:** Report the error message from `get_job` result. Ask user if they want to retry with a modified prompt.
- **MCP tool unavailable:** Tell user to check Krea MCP server connection in Claude Code settings.
- **Image defects on QA:** Regenerate up to 2 more times with refined prompt. Log in MASTER_CONTEXT.md changelog if persistent.
