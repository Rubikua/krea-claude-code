---
name: krea-mcp
description: >-
  Creates AI images and videos via the Krea MCP tools (mcp__krea-mcp__*). Supports Flux, Flux Pro, Ideogram, Imagen 4, Krea-1, ChatGPT Image, Nano Banana, Seedream (images) and Hailuo, Kling, Runway, Pika, Veo 3, Sora, Luma, Wan, Seedance (video). Handles asset listing, job polling, and UGC workflows. Use when the user mentions Krea, AI image generation, AI video generation, UGC content, influencer creation, or marketing creative.
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
│   ├── Character with natural motion?     → model: kling  → [kling.md](prompting/prompt-library/kling.md)
│   ├── Best quality + audio?             → model: veo-3  → [veo-3.md](prompting/prompt-library/veo-3.md)
│   └── General / fast?                   → model: hailuo (image_url)
├── Cinematic camera move?                → model: runway
├── Longer scene (>10s)?                  → model: sora   → [sora.md](prompting/prompt-library/sora.md)
├── Artistic / anime?                     → model: wan
├── Photorealistic smooth motion?         → model: luma
├── Fast UGC / reactive clip?            → model: pika
└── ByteDance quality (Seedance)?        → model: seedance
    ├── Read [seedance.md](prompting/prompt-library/seedance.md) first, then pick style:
    ├── UGC selfie / testimonial          → [seedance-ugc.md](prompting/prompt-library/seedance-ugc.md)
    ├── Dark void product reveal          → [seedance-premium-reveal.md](prompting/prompt-library/seedance-premium-reveal.md)
    ├── Elemental product hero (splash)   → [seedance-product-hero.md](prompting/prompt-library/seedance-product-hero.md)
    ├── Studio lookbook with voiceover    → [seedance-studio-lookbook.md](prompting/prompt-library/seedance-studio-lookbook.md)
    └── Feature walkthrough / demo        → [seedance-feature-walkthrough.md](prompting/prompt-library/seedance-feature-walkthrough.md)

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
2. Read prompting/guide.md + the model-specific prompt library file:
   - kling:    prompting/prompt-library/kling.md
   - veo-3:    prompting/prompt-library/veo-3.md
   - sora:     prompting/prompt-library/sora.md
   - seedance: prompting/prompt-library/seedance.md → then pick sub-style file
   - others:   prompting/prompt-library/video.md (generic guidelines)
3. If user provides an image: ensure it's a hosted URL.
   (upload_asset is currently broken — use list_assets CDN URLs instead)
4. Call generate_video(prompt, model, aspect_ratio, duration, image_url?).
5. Poll get_job(job_id) until status == "completed" (videos take 1–15 min).
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

> **Status (tested 2026-04-19):** `search_styles` returns 404 on all queries — the endpoint appears non-functional. Do not attempt to use it. If the user requests a style, inform them the feature is currently unavailable via MCP and suggest using a strong descriptive prompt instead (e.g. describe the aesthetic in the prompt text itself).

### 5. Asset upload

> **Status (tested 2026-04-19):** `upload_asset` returns 500 Internal Error. Do not attempt to use it. Use `list_assets` to browse previously generated images — their `image_url` values are already hosted on Krea's CDN and can be passed directly into `image_url` in subsequent generations.

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
