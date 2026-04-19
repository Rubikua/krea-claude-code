# UGC product selfie — character + product workflow

**Use when:** The user wants to generate a UGC-style selfie image of one of their AI influencers holding/using a product. Combines a character reference and product photo into a single Nano Banana generation.

## Required inputs

| Input | Source | Role |
|-------|--------|------|
| **Character reference URL** | `list_assets` or `references/influencers/{name}/01-hero-front.jpg` (hosted) | Identity anchor |
| **Product description** | User describes it, or product photo is available | What they're holding |
| **Style aesthetic** | `references/aesthetics/ugc-selfie/` for inspiration | Visual vibe |

Since Krea MCP accepts one `image_url`, pass the character as the reference and describe the product verbally in the prompt. If the product has distinctive packaging, describe label color, shape, size, and material explicitly.

---

## Prompt formula

### Structure
```
[Camera hardware] + [Framing] + [Character] + [Skin realism] +
[Action with product] + [Expression] + [Outfit] + [Setting] +
[Imperfection block] + [Negative cues]
```

### The imperfection block (CRITICAL)

Without this, the output looks too polished. Include at least 4–5:

- `slight motion blur on hair strands`
- `slightly overexposed highlights on forehead and nose`
- `visible image grain and noise`
- `iPhone front camera wide-angle lens distortion on the extended arm`
- `slightly off-center framing, tilted a few degrees`
- `washed out flat color grading`
- `soft focus — nothing is tack sharp`
- `uneven ambient indoor lighting with one side of face slightly in shadow`
- `caught mid-blink or mid-word, not a perfect expression`

### Skin realism block (CRITICAL — always include)

Pick 3–4 and place inline with the character description:

- `natural skin with visible pores`
- `slight unevenness in skin tone`
- `minor undereye shadows`
- `a hint of shine on the nose and forehead from natural oils`
- `slight pinkness on cheeks and nose` (fair skin)
- `minor skin texture variation`
- `faint undereye shadows`
- `the kind of skin you see on a real person's unfiltered front camera`

**Do NOT use:** acne, pimples, breakouts, blemishes, redness.

### Negative cues (always include)
```
No retouching, no beauty filter, no studio lighting, not a professional photo,
not overly polished, not perfectly composed, not tack sharp.
No airbrushed skin, no flawless complexion.
```

---

## Krea MCP call

```
generate_image(
  prompt = composed_ugc_prompt,
  model = "nano-banana",
  image_url = character_hero_url,    # from list_assets or references/
  width = 768,
  height = 1344,
  negative_prompt = "deformed hands, extra fingers, merged limbs, plastic skin,
                     studio lighting, overly saturated, AI-looking, watermark, text",
)
```

Default to **3 variations** — fire sequentially, poll each to completion.

---

## Example prompt (tested formula)

```
Raw iPhone front-camera selfie video frame grab. A 25-year-old mixed race
woman with voluminous curly honey-brown hair, warm tan skin with visible
pores, slight unevenness in skin tone, minor undereye shadows, a hint of
shine on the nose and forehead from natural oils — beauty mark on right
cheek, green eyes. She is on her couch holding up a tall purple and gold
serum bottle, talking mid-sentence to camera with a candid unposed
expression — mouth slightly open, caught between words, not smiling perfectly.

Casual oversized beige hoodie. Cozy messy apartment background —
houseplants, throw pillows, warm lamp glow — slightly out of focus.

CRITICAL STYLE: This must look like an unedited frame pulled from a real
iPhone selfie video, NOT a professional photo. Include these imperfections:
slight motion blur on hair strands, slightly overexposed highlights on
forehead and nose, visible image grain and noise, iPhone front camera
wide-angle lens distortion on the arm holding the phone, slightly
off-center framing tilted a few degrees, washed out flat color grading,
soft focus — nothing is tack sharp, uneven ambient indoor lighting with
one side of face slightly in shadow. No retouching, no beauty filter,
no studio lighting, no airbrushed skin, no flawless complexion. The image
should feel raw, unpolished, and authentically amateur.
```

---

## Step-by-step flow

1. **Ask which influencer** — load their hero URL from `MASTER_CONTEXT.md` or `list_assets`
2. **Ask which product** — check `references/products/` or ask user to paste a URL/description
3. **Ask for the scene** — bedroom, bathroom, kitchen, car, etc. Default: living room couch
4. **Compose the prompt** using the formula above
5. **Generate 3 variations** — `generate_image` × 3, poll each to completion
6. **QA each** for anatomy issues (hands holding product are the most common problem area)
7. **Present numbered list** — ask user which they prefer or if they want adjustments

---

## Scene suggestions

| Scene | Background details | Outfit suggestion |
|-------|-------------------|------------------|
| **Living room couch** | Throw pillows, houseplants, warm lamp, slightly messy | Oversized hoodie or loungewear |
| **Bedroom** | Rumpled sheets, nightstand, fairy lights | Tank top, casual tee |
| **Car** | Leather seats, sunroof visible, buildings through window | Sweater, jacket |
| **Kitchen** | Coffee mug, cutting board, morning light through window | Robe, casual tee |
| **Bathroom mirror** | Mirror selfie, bathroom counter, towels | Getting-ready outfit |
| **Outdoor cafe** | Table, coffee cup, street in background | Casual date outfit |
| **Desk/office** | Laptop, notebook, desk lamp | Work-from-home casual |

---

## Combining with video

Once the user approves a UGC still, use its Krea result URL as `image_url` in `generate_video`:

```
generate_video(
  prompt = ugc_video_prompt,   # from ugc-selfie-style.md
  model = "kling",             # or "seedance" for ByteDance quality
  image_url = approved_still_url,
  aspect_ratio = "9:16",
  duration = 5,
)
```

See [ugc-selfie-style.md](ugc-selfie-style.md) for the full UGC video prompting formula.
