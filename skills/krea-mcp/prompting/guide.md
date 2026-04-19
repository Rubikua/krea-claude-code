# Krea prompting guide — universal rules

These rules apply to all models and workflows. Read this before building any prompt.

---

## Prompt structure

Every prompt should follow this order:

```
[SUBJECT] — who or what is in the frame
[ACTION / EXPRESSION] — what they are doing
[ENVIRONMENT] — setting, background, lighting
[CAMERA] — lens, angle, format cues
[STYLE] — aesthetic, mood, post-processing
[NEGATIVE] — what to exclude (use negative_prompt param)
```

Not every section is needed for every prompt. Prioritize subject and environment. Add camera and style for precision.

---

## UGC imperfection block

Every UGC image or video prompt MUST include camera imperfections to fight Krea's polished default:

```
shot on iPhone, handheld, slight motion blur, off-center framing, overexposed highlights, film grain, soft focus edges, natural lens distortion
```

Without this, output looks like a studio render, not a creator's phone video.

---

## Skin realism block (for people)

Include 3–4 subtle skin cues inline with character description. DO NOT use: acne, pimples, breakouts, blemishes, redness, imperfections. Those trigger filters.

Use instead:
```
visible pores, slight unevenness in skin tone, minor undereye shadows, hint of shine from natural oils
```

Goal: "real person, not retouched" — not "person with skin problems."

---

## Human motion cues (for video)

Without motion language, subjects look frozen. Include 3–4 cues per video prompt:

**Good cues:**
- breaking eye contact briefly, glancing down
- slight head tilt to the left
- shifting weight between feet
- adjusting grip on product
- tucking hair behind ear
- natural blink cadence
- subtle smile forming at corner of mouth

**Bad (overused / triggers stiffness):**
- "looking at camera" (says nothing about motion)
- "smiling" alone
- "standing" alone

---

## Negative prompts to always include

For **UGC / realistic people:**
```
deformed hands, extra fingers, merged limbs, plastic skin, studio lighting, overly saturated, AI-looking, text overlay, watermark, logo
```

For **product shots:**
```
cluttered background, text, watermark, deformed product, blurry product, reflections on product
```

For **video with people:**
```
subtitles, captions, text overlay, burned-in text
```

---

## Aspect ratio sizing

Always set `width` and `height` to match intended platform, not just `aspect_ratio`. Models generate better at native resolution than scaled:

| Platform | width | height |
|---------|-------|--------|
| Instagram Reels / TikTok / Stories | 768 | 1344 |
| Instagram feed square | 1024 | 1024 |
| Instagram feed portrait | 819 | 1024 |
| YouTube thumbnail / desktop | 1344 | 768 |

---

## Reference image strategy

When the user provides a reference image:

1. **Character likeness:** Pass as `image_url` in `generate_image` with nano-banana or flux-pro. The model uses it as a face/body reference.
2. **Style/mood:** Pass as `image_url` with flux or krea-1. The model borrows aesthetic, not identity.
3. **Start frame for video:** Pass as `image_url` in `generate_video`. The video begins from this exact image.

If the reference is a local file path, ask the user to share a hosted URL, or use `upload_asset` first.

---

## Multi-shot consistency

To keep a character consistent across multiple generations:

1. Generate the hero shot first (nano-banana is best for this).
2. Save the resulting image URL.
3. Use it as `image_url` in all follow-up generations.
4. Upload via `upload_asset` to get a stable Krea-hosted URL that won't expire.
5. Save this URL in `MASTER_CONTEXT.md` for future sessions.

---

## Style IDs

When a user wants a specific aesthetic:

1. Call `search_styles(query)` — be specific ("vintage 35mm film grain" beats "retro").
2. If multiple matches, call `get_style(style_id)` on the top 2–3 to compare previews.
3. Apply the best match via `style_id` in `generate_image`.
4. Save the winner to `MASTER_CONTEXT.md` under "Saved style IDs".

Styles apply to images only — not to video generation.
