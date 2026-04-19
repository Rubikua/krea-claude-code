# Seedance — model guide

**Krea MCP model name:** `seedance`
**Job type in response:** `videoV2`

## Overview

Seedance is ByteDance's video generation model. It excels at UGC-style content, product reveals, and lifestyle videos. Key differentiators:
- Supports image-to-video via `image_url`
- Responds well to timestamp-based prompt structure for multi-beat sequences
- Supports explicit dialogue embedding in the prompt

## Krea MCP call

```
generate_video(
  prompt = "...",         # 100–260 words sweet spot
  model = "seedance",
  image_url = "...",      # optional: character or product reference
  aspect_ratio = "9:16",  # or "16:9" — no "1:1" support
  duration = 5,           # up to ~15s; use 5 for social
)
```

Poll `get_job(job_id)` until `status == "completed"` (type will show `videoV2`).

---

## Prompt length

Keep prompts between **100 and 260 words**. Shorter = vague. Longer = model loses focus.

## Prompt structure

Seedance responds best to:

```
Subject + Action + Camera + Style + Constraints
```

- **Subject** — who/what is in the scene, age, clothing, expression, posture
- **Action** — what happens, present tense, one primary movement per shot
- **Camera** — framing (wide, medium, close-up) and movement (dolly-in, pan, handheld)
- **Style** — visual tone: lighting, color, atmosphere
- **Constraints** — reduce artifacts: "maintain face consistency," "steady motion," "no distortion"

## Motion specificity

Be explicit about degree and direction. Instead of "she picks up the bottle," write "she slowly picks up the bottle with her right hand, turning it toward the camera." Degree adverbs — **slowly, gently, quickly, casually, deliberately** — make a noticeable difference.

## Timestamps for multi-beat sequences

```
[00:00] A woman sits in her kitchen holding an electrolyte packet. Medium shot, morning light.
[00:05] She pours the packet into her water bottle and shakes it. Close-up on hands.
[00:09] She takes a sip, pauses, nods with raised eyebrows. Back to medium shot.
[00:13] She holds the packet up to the camera, half-smile. "Yeah these are legit."
```

Use timestamps for:
- Multi-shot sequences with clear choreography
- Controlling pacing (preventing the model from rushing)
- Style or camera transitions within a single clip

Keep each segment focused on **one main action**.

## Reference image mapping (`image_url`)

Pass one reference image via `image_url`. When referencing it in the prompt, use `@(img1)` — this is Seedance's native notation for the reference image:

```
She holds the @(img1) (amber glass skincare bottle) up to the camera.
```

Tell the model to keep it consistent:
- "The product from @(img1) must remain visually unchanged in every shot."
- "Maintain outfit unchanged across all cuts."

> **Note:** `@(img1)` is Seedance-native. Krea's wrapper passes `image_url` to Seedance as the first reference. If a generation ignores the reference, try removing the @(img1) token and relying on the description + image_url alone.

## Style keywords

Always include at least one style anchor:
- `documentary` — natural, observational feel
- `photorealistic` — grounded in reality
- `commercial` — polished but natural (use sparingly for UGC)
- `handheld` — reinforces phone-filmed look

**Avoid in UGC prompts:** `cinematic`, `anime`, `studio` — these pull away from authenticity. For premium/product-hero styles, use `dramatic` or `premium` instead of `cinematic`.

## Forbidden words (UGC context)

Never use in UGC Seedance prompts: `cinematic`, `professional`, `stunning`, `8k`, `studio`, `perfect`.

## Duration and dialogue

| Script word count | Duration |
|-------------------|---------|
| 1–8 words | 4–5s |
| 9–15 words | 6–8s |
| 16–25 words | 9–12s |
| 26–35 words | 13–15s |
| **36+ words** | **Too long** — split into multiple clips |

For no-dialogue styles (product hero, premium reveal), default to **15s** for maximum visual impact.

Embed dialogue in the prompt using natural phrasing: `She speaks: "text here"` or `He says: "text here"`.

## Style template directory

Choose the template file that matches the user's goal:

| User goal | Template file |
|-----------|--------------|
| UGC selfie product review / testimonial | [seedance-ugc.md](seedance-ugc.md) |
| Dark background premium product reveal (no person) | [seedance-premium-reveal.md](seedance-premium-reveal.md) |
| Elemental product hero — splash, mist, effects | [seedance-product-hero.md](seedance-product-hero.md) |
| Studio lookbook with voiceover | [seedance-studio-lookbook.md](seedance-studio-lookbook.md) |
| Fast-paced feature walkthrough / demo | [seedance-feature-walkthrough.md](seedance-feature-walkthrough.md) |

All five style templates are written specifically for Seedance via Krea MCP and follow the 100–260 word prompt constraint.

## Adaptation checklist (all styles)

Before calling `generate_video` with Seedance, verify:

- [ ] **Word count** — prompt is 100–260 words
- [ ] **Duration** — set based on dialogue word count, or default duration for no-dialogue styles
- [ ] **Aspect ratio** — `9:16` (social) or `16:9` (landscape) — no `1:1`
- [ ] **Motion specificity** — actions describe degree/direction, not just "moves"
- [ ] **Consistency anchors** — product/outfit described as unchanged across shots
- [ ] **No forbidden words** — no "cinematic," "professional," "stunning," "8k," "studio," "perfect"
- [ ] **@(img1) included** — if reference image provided, referenced in prompt text
- [ ] **Style anchor** — at least one style keyword (documentary, photorealistic, etc.)
- [ ] **Timestamps** — used for multi-beat sequences to control pacing

## Iteration tips

If a generation is close but not right, adjust **one element at a time**:
1. Action looks good but framing is off → adjust camera description
2. Pacing is rushed → add timestamps or reduce dialogue
3. Product drifts between shots → add consistency constraint
4. Motion is too stiff → add degree adverbs (slowly, casually, deliberately)
