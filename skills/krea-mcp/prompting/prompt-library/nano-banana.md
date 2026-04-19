# Nano Banana — image generation guide

**Vendor guide:** [Google Cloud — Ultimate prompting guide for Nano Banana](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-nano-banana)

## When to use Nano Banana

Nano Banana is the preferred model for:
- **Consistent character generation** — best model for maintaining face/body identity across shots
- **UGC stills** — person + product selfie-style images
- **Influencer character sheets** — full 10-angle sets
- **Product showcase stills** — person holding/using a product

For pure product shots with no person, use `flux-pro` or `imagen-4`.

## Krea MCP call

```
generate_image(
  prompt = "...",
  model = "nano-banana",
  width = 768,         # 9:16 for UGC / portraits
  height = 1344,
  image_url = "...",   # optional: reference image URL for likeness/style
  negative_prompt = "...",
)
```

Poll `get_job(job_id)` until `status == "completed"`. Typical generation time: 30–60 seconds.

## Prompt template

```
{{SUBJECT}}. Style: {{STYLE}}. Composition: {{COMPOSITION}}.
Lighting: {{LIGHT}}. Background: {{BG}}. Avoid: {{AVOID}}.
```

## Checklist

- [ ] Subject described with specific visual language (age, hair, skin, eyes, build)
- [ ] Skin realism cues included (see below)
- [ ] State whether output is photoreal, illustration, product hero, etc.
- [ ] Negative prompt includes: deformed hands, extra fingers, plastic skin, text, watermark

## Post-generation QA (mandatory)

After receiving the result, check for:
- Extra or missing **hands** or **fingers**; wrong finger count; fused digits
- Wrong number of **limbs**; impossible joints or poses
- **Face:** duplicate features, asymmetry, distorted eyes or teeth
- **Objects:** merged geometry, floating items, melted product edges
- **Artifacts:** obvious seams, stray body parts at frame edges

If defective: compose a new prompt naming the fix ("exactly two hands visible, five fingers each"), regenerate — up to **2 retries** (3 total). After 3 attempts, describe remaining issues and ask the user how to proceed.

## Reference image strategy (`image_url`)

- **Character likeness:** pass the hero portrait as `image_url` — model uses it as face/body reference
- **Product composite:** pass the product photo as `image_url` — model uses it as object to place in scene
- **Style reference:** pass a mood/aesthetic image as `image_url` — borrows look, not identity

When you need both character AND product references in one image, describe the product visually in the prompt and pass the character as `image_url`. Mention the product's colors, shape, label, and size explicitly.

## Skin realism block (mandatory for people)

Include 3–4 of these inline with the character description:

```
visible pores, slight unevenness in skin tone, minor undereye shadows,
a hint of shine on nose and forehead from natural oils
```

**Do NOT use:** acne, pimples, breakouts, blemishes, redness — those trigger content filters. Goal: "real person, not retouched" — not "person with skin problems."

## Example — product hero image

```
Minimal product hero: matte black earbuds on concrete, soft studio
three-point lighting, subtle reflection, no people, no extra props.
```

## Example — character portrait

```
Full body front view, head to toe. A 23-year-old woman with warm
auburn wavy hair past her shoulders, fair skin with light freckles
across her nose, visible pores, slight unevenness in skin tone,
minor undereye shadows, green eyes, slim build, soft natural makeup,
wearing a fitted white t-shirt. Clean white studio background,
photorealistic, individual hair strands catching light.
Camera at eye level, soft even studio lighting from both sides.
Relaxed stance, weight on one hip, warm confident expression.
```
