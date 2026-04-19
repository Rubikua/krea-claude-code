# Character sheet — generate an AI influencer from a text description

**Use when:** The user wants to create a new AI influencer from scratch. Generates a 10-image character sheet (multiple angles) that becomes the reference set for all future generations with that character.

## Required flow (do NOT skip steps)

1. User describes the influencer in plain English (e.g., "20-year-old female redhead")
2. Agent expands the description into a detailed visual prompt
3. Agent presents the expanded prompt for user review
4. **Generate 1 hero front portrait** — wait for approval
5. **User approves the hero image** — do NOT skip this step
6. **Generate 9 remaining angles** using the hero image URL as `image_url`
7. **QA all images**
8. **Save to `references/influencers/`** using the naming convention below

---

## Step 1: Expand the user's description

Fill in any unspecified details with natural, photorealistic defaults.

**Base prompt structure:**
```
A {age}-year-old {gender} with {hair color} {hair texture} {hair length} hair,
{skin tone} skin with {distinguishing features}, {eye color} eyes, {build} build,
{makeup level}, wearing {clothing}. Clean white studio background,
photorealistic, visible skin texture, individual hair strands catching light.
```

**What to specify:**
- **Age:** Exact number, not a range
- **Hair:** Color, texture (straight/wavy/curly), length (shoulder-length/long/short)
- **Skin:** Tone + one distinguishing feature (freckles, clear, beauty mark)
- **Eyes:** Color
- **Build:** Slim, athletic, curvy, etc.
- **Makeup:** Soft natural / minimal / none
- **Clothing:** Default to a fitted white t-shirt (neutral, doesn't distract from character)

**Rules:**
- Use specific visual language ("warm chestnut wavy hair past her shoulders", not "nice hair")
- Do NOT use celebrity names or real people's names
- Keep clothing simple — the character sheet is about the person, not the outfit
- Always include texture cues: "visible skin texture," "individual hair strands catching light"

---

## Step 2: Present the expanded prompt for approval

Show the user:
1. The expanded visual description
2. The 5 descriptor tags for the folder name (see naming convention below)
3. Ask if anything needs adjusting before generating

---

## Step 3: Generate the hero image (full body front)

This is the anchor image. All other angles will reference it. **Use a full-body shot as the hero.**

**Hero prompt:**
```
Full body front view, head to toe. {base_prompt}
She/He looks directly at camera with a warm, confident expression.
Relaxed stance, weight on one hip. Camera at eye level,
soft even studio lighting from both sides.
```

**Krea MCP call:**
```
generate_image(
  prompt = hero prompt above,
  model = "nano-banana",
  width = 768,
  height = 1344,   # 9:16 for full body
)
```

Then poll: `get_job(job_id)` until `status == "completed"`.

**Post-generation QA:** Inspect for anatomy defects (hands, fingers, face, limbs). Regenerate with refined prompt if needed — up to 2 retries (3 total).

Show the result to the user. **Wait for explicit approval before generating the remaining 9 angles.**

---

## Step 4: Generate 9 remaining angles

Once the hero is approved, use its result URL as `image_url` for all subsequent generations.

For each angle, compose a prompt that:
- Starts with the angle description
- References the hero: `"The exact same person from the reference image — same face, same {hair}, same {distinguishing features}, same {eye color} eyes, same {build}, same {clothing}."`
- Specifies white studio background, photorealistic
- Includes angle-specific lighting and pose

**Krea MCP call (per angle):**
```
generate_image(
  prompt = angle-specific prompt,
  model = "nano-banana",
  image_url = hero_result_url,
  width = 768,
  height = 1344,
)
```

Generate angles sequentially (not all at once), polling each to completion before starting the next to avoid overwhelming the job queue.

### The 10 angles

| # | File name | Angle | Prompt prefix | Notes |
|---|-----------|-------|---------------|-------|
| 1 | `01-hero-front.jpg` | Full body front (hero) | `Full body front view, head to toe.` | Direct eye contact, relaxed stance, full outfit |
| 2 | `02-3q-left.jpg` | 3/4 left | `Three-quarter view from the left.` | 45° to camera-left, looking toward lens |
| 3 | `03-3q-right.jpg` | 3/4 right | `Three-quarter view from the right.` | 45° to camera-right, looking toward lens |
| 4 | `04-profile-left.jpg` | Profile left | `Left profile view.` | Full side profile, rim light from behind |
| 5 | `05-profile-right.jpg` | Profile right | `Right profile view.` | Full side profile, rim light from behind |
| 6 | `06-face-closeup.jpg` | Face close-up | `Face close-up, tight crop.` | Forehead to chin, soft beauty lighting, catchlights |
| 7 | `07-back-shoulder.jpg` | Back/over shoulder | `Back view, looking over her/his shoulder.` | Playful glance back over right shoulder |
| 8 | `08-medium-portrait.jpg` | Medium portrait | `Front-facing medium portrait, waist up.` | Direct eye contact, warm expression |
| 9 | `09-full-body-3q.jpg` | Full body 3/4 | `Full body three-quarter view.` | Full length, 45° to camera-left, walking toward camera |
| 10 | `10-above-angle.jpg` | Above angle | `Slightly above angle, looking up at camera.` | Camera slightly above, chin tilted up, bright smile |

---

## Step 5: QA all images

Check each image:
- Anatomy: correct hand/finger count, no merged limbs, coherent face
- Consistency: same hair, face, skin tone, clothing across all 10
- If any image drifts significantly from the hero, note it when presenting results

---

## Step 6: Save to references folder

### Folder naming convention
```
references/influencers/{name}-{hair_color}-{hair_style}-{feature}-{eye_color}-{skin_tone}/
```

| Position | Category | Examples |
|----------|----------|---------|
| 1 | Name (human first name) | `emma`, `sofia`, `kai`, `marcus` |
| 2 | Hair color | `redhead`, `blonde`, `brunette`, `black-hair` |
| 3 | Hair style | `wavy`, `straight`, `curly`, `pixie`, `braided` |
| 4 | Distinguishing feature | `freckles`, `dimples`, `sharp-jaw`, `beauty-mark` |
| 5 | Eye color | `green-eyes`, `blue-eyes`, `brown-eyes`, `hazel-eyes` |
| 6 | Skin tone | `fair`, `olive`, `tan`, `deep`, `medium` |

**Examples:**
- `emma-redhead-wavy-freckles-green-eyes-fair/`
- `sofia-brunette-straight-dimples-brown-eyes-olive/`
- `kai-blonde-curly-sharp-jaw-blue-eyes-tan/`

### After saving

- Save the hero image Krea URL (from `list_assets`) to `MASTER_CONTEXT.md` under the influencer's name — this URL can be reused as `image_url` in future sessions without re-uploading
- Present results as a numbered list showing all 10 angles
- Open the folder for the user: `open references/influencers/{folder_name}/` (macOS)

---

## Using a character sheet for subsequent workflows

Once a character sheet exists, it becomes the input for:
- **UGC selfie still** → [ugc-product-selfie.md](ugc-product-selfie.md) — hero image + product photo
- **Influencer recreation** → [influencer-recreation.md](influencer-recreation.md) — skip the analysis step
- **Video** → use hero (or any angle) URL as `image_url` in `generate_video`
- **Seedance UGC** → [seedance-ugc.md](seedance-ugc.md)

Always use `01-hero-front.jpg` URL as the primary `image_url`. For maximum consistency, mention multiple angle descriptions in the prompt text alongside the reference image.

---

## Example

**User says:** "Create a 20-year-old female influencer redhead"

**Agent expands to:**
> A 20-year-old female with natural red wavy hair past her shoulders, fair skin with light freckles across her nose and cheeks, green eyes, slim build, soft natural makeup, wearing a fitted white t-shirt. Clean white studio background, photorealistic, visible skin texture, individual hair strands catching light.

**Folder name:** `emma-redhead-wavy-freckles-green-eyes-fair`

**Flow:** Generate hero → user approves → generate 9 angles with hero URL as image_url → QA → save → done.
