# Influencer recreation from reference image

**Use when:** The user provides a photo of a real person and wants to recreate that person in AI-generated content via Krea.

## Required flow (do NOT skip steps)

1. User provides a reference image (URL or local path)
2. Agent analyzes the image systematically
3. Agent writes a Nano Banana recreation prompt
4. **Generate a still image** using `generate_image` with `model: nano-banana` and the reference as `image_url`
5. **User approves** the still image
6. **Only after approval** → generate video using the approved image URL as `image_url` in `generate_video`

---

## Step 1: Analyze the reference image

Dissect the image systematically. Describe what you see — do not invent details not visible.

**Face and features:**
- Estimated age range
- Skin tone (light / medium / olive / tan / deep / dark)
- Face shape (oval, round, square, heart)
- Distinctive features (dimples, freckles, beauty marks, jawline)

**Hair:**
- Color (specific: "warm chestnut brown," not just "brown")
- Length (above shoulder / shoulder-length / mid-back / long)
- Texture and style (straight, wavy, curly; loose, pulled back, braided)
- Parting (center, side, none visible)

**Eyes and brows:**
- Eye color if visible
- Brow shape (arched, straight, thick, thin)
- Makeup if present

**Makeup and skin:**
- Level (bare-faced, natural/minimal, glam, editorial)
- Lip color
- Skin finish (dewy, matte, natural)

**Body and pose:**
- Build (petite, slim, athletic, curvy)
- Posture (relaxed, confident, leaning)
- Hand position and gestures

**Clothing and accessories:**
- Garment type, color, fabric (e.g., "cream satin button-up blouse")
- Jewelry (earrings, necklace — material and style)

**Lighting and environment:**
- Light direction and quality (golden hour, window light, ring light)
- Background (blurred, studio, street, nature)
- Color temperature (warm, neutral, cool)

---

## Step 2: Write the recreation prompt

One dense paragraph (80–150 words):

```
[Subject description with physical features] in [setting/environment].
[Clothing and accessories described specifically].
[Pose and expression]. [Lighting described as physical properties].
[Camera and style]. [Skin and texture realism cues].
```

**Rules:**
- Use specific visual language ("soft directional golden-hour light from camera-left creating gentle shadows," not "nice lighting")
- Include at least one texture cue: "visible skin texture," "fabric sheen," "individual hair strands catching light"
- Do NOT use celebrity names or real people's names in the prompt
- State framing: close-up, medium shot, full body, etc.

---

## Step 3: Present for prompt approval

Show the user:
1. Your analysis breakdown
2. The recreation prompt
3. Ask if anything needs adjusting before generating

---

## Step 4: Generate the still image

```
generate_image(
  prompt = recreation_prompt,
  model = "nano-banana",
  image_url = reference_image_url,   # reference for likeness
  width = 768,
  height = 1344,
)
```

Poll `get_job(job_id)` until `status == "completed"`.

**Post-generation QA:** Inspect for defects (extra fingers, bad hands, distorted face). Regenerate with refined prompt if needed — up to 2 retries. Do not show the user a defective still as "the result" without at least one retry.

---

## Step 5: User approves the still image

- Show the recreation result alongside the original reference
- **Wait for explicit approval** before proceeding to video
- If the user is not satisfied, iterate on the prompt and regenerate

---

## Step 6: Generate video from approved image

Only after the user approves:

```
generate_video(
  prompt = video_prompt,    # from ugc-selfie-style.md or product-showcase.md
  model = "kling",          # or veo-3 for best quality
  image_url = approved_still_url,
  aspect_ratio = "9:16",
  duration = 5,
)
```

Poll until `status == "completed"`.

---

## Example

**Reference analysis:**
> Woman in her mid-20s, medium olive skin, oval face with subtle dimples. Warm chestnut brown wavy hair, shoulder-length, center-parted. Hazel-green eyes, natural arched brows, minimal makeup, nude lip, dewy skin finish. Slim build, relaxed posture. Cream satin button-up blouse, small gold hoop earrings. Soft golden-hour light from camera-left, shallow depth of field, blurred urban rooftop background.

**Recreation prompt:**
```
A woman in her mid-20s with medium olive skin, oval face, and subtle
dimples. Warm chestnut brown wavy hair, shoulder-length, center-parted,
individual strands catching golden light. Hazel-green eyes, natural
arched brows, minimal makeup with nude lip and dewy skin. She wears a
cream satin button-up blouse and small gold hoop earrings. Relaxed
upright posture, warm confident smile with direct eye contact. Soft
directional golden-hour light from camera-left creates gentle shadows.
Shallow depth of field, blurred urban rooftop background. Medium
close-up, editorial portrait style. Visible skin texture, fabric
sheen on blouse. Photorealistic.
```

---

## Tips for consistency across multiple generations

- Save the approved prompt text in `MASTER_CONTEXT.md` under a heading like **"Influencer: [name/alias]"**
- Save the Krea result URL (from `list_assets`) as the primary reference URL for future sessions
- Small wording changes between generations will drift the face — keep the core description frozen and only vary pose, clothing, or setting
