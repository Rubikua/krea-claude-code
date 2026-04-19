# Product showcase — AI person with product

**Use when:** The user wants to generate a video of an AI person holding, using, or demonstrating a physical product.

## Workflow

```
User provides product image URL + description
        |
        v
Agent writes Nano Banana prompt
(AI person + product interaction)
        |
        v
generate_image(model="nano-banana", image_url=product_url)
        |
        v
Nano Banana generates still image
(person holding/using product)
        |
        v
User approves still image
        |
        v
generate_video(image_url=approved_still_url)
(Kling / Veo 3 / Seedance)
        |
        v
Final product showcase video
```

---

## Step-by-step

### 1. Collect product info

Ask the user for:
- **Product image URL** — photo of the item (or describe it visually if no photo)
- **Product context** — what it is, key features, target audience (check `MASTER_CONTEXT.md`)
- **Video intent** — UGC selfie-style? Polished ad? Unboxing?
- **Person description** — what should the AI person look like? (Or reuse an existing influencer from `MASTER_CONTEXT.md`)
- **Image model** — default `nano-banana`, use `flux-pro` or `imagen-4` for polished product shots

### 2. Compose the image prompt

The prompt must describe:
1. **The person** — age, gender, appearance, wardrobe, expression, pose
2. **The product interaction** — how they hold it, where it sits in frame, what angle
3. **Match the video intent** — if the final video is UGC selfie-style, the still should already look like a selfie
4. Pass the product image as `image_url` so Nano Banana can composite it correctly

### 3. Generate the still image

```
generate_image(
  prompt = product_showcase_prompt,
  model = "nano-banana",
  image_url = product_photo_url,
  width = 768,
  height = 1344,
  negative_prompt = "studio lighting, floating product, unnatural hand pose, extra fingers, text, watermark",
)
```

Poll `get_job(job_id)` until complete.

**Post-generation QA:** Inspect for defects (hands, product edges, merged geometry). Regenerate with refined prompt if needed — up to 2 retries.

### 4. User approves the still

- Show the result — **after** internal QA
- **Wait for explicit approval** before proceeding to video

### 5. Generate video from approved still

```
generate_video(
  prompt = video_prompt,          # from ugc-selfie-style.md or seedance-ugc.md
  model = "kling",                # or "veo-3" / "seedance"
  image_url = approved_still_url,
  aspect_ratio = "9:16",
  duration = 5,
)
```

Include dialogue/script in the video prompt. Poll until complete.

---

## Prompt template

```
{{PERSON_DESCRIPTION}} with {{SKIN_REALISM_CUES}}.
They are {{INTERACTION}} a {{PRODUCT_DESCRIPTION}}.
Setting: {{SETTING}}. Camera: {{CAMERA}}. Lighting: {{LIGHTING}}.
The product is {{PRODUCT_PLACEMENT}} — clearly visible, in-focus, natural grip.
Style: {{STYLE}}. Avoid: studio lighting, floating product, unnatural hand pose.
```

## Example

```
A 25-year-old woman with shoulder-length brown hair, warm tan skin with
visible pores, slight unevenness in skin tone, minor undereye shadows,
in a casual white t-shirt, smiling warmly at camera. She is holding a
small amber glass skincare bottle in her right hand at chin height,
label facing camera. Setting: bright modern bathroom, morning light
through frosted window. Camera: front-facing selfie angle, slightly
above eye level. The product is centered in the lower third of frame —
clearly visible, natural grip with fingertips around the bottle.
Style: authentic, unfiltered, soft natural tones. Avoid: studio
lighting, floating product, perfect skin retouching.
```

---

## Video prompt template (after still approval)

```
{{PERSON}} holds {{PRODUCT}} and speaks directly to camera. {{ACTION_BEATS}}.
Product details: {{KEY_FEATURES}}. Tone: {{TONE}}. Setting: {{SETTING}}.
Camera: {{CAMERA}}. Dialogue: "{{SCRIPT}}". {{STYLE_AND_IMPERFECTIONS}}.
No subtitles, no captions, no text overlays.
```

---

## Tips

- **Product fidelity:** If the generated still distorts the product label or color, try a cleaner product photo with white/neutral background, and describe the product's colors and shape explicitly in the prompt
- **Hand pose:** "natural grip with fingertips" in the prompt helps avoid unnatural hand poses
- **Consistency:** Save the approved person prompt in `MASTER_CONTEXT.md` for reuse across multiple product shoots with the same AI influencer
- **Image URL workaround:** If the product photo is local, host it publicly (Imgur, Dropbox direct link) before passing to Krea MCP
