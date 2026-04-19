# UGC selfie-style video — cross-model prompting guide

**Applies to:** Kling, Veo 3, Hailuo, Seedance (via Krea MCP `generate_video`)
**Aesthetic:** iPhone-shot, Instagram Reels, unpolished realism

Use this guide when the user wants **authentic-looking UGC** — selfie angles, handheld shake, imperfect lighting, casual speech. The biggest mistake is letting the AI produce polished cinematic output; UGC works because it feels real.

---

## Core principles (all models)

### 1. Camera physics — simulate a smartphone

Stop using "cinematic," "8k," or "award-winning." Instead:

- **Lens:** "iPhone 15 Pro front camera in selfie mode," "native wide lens (~26 mm)," "f/2.2 aperture"
- **Focus:** "Autofocus micro-pulses," "deep focus (everything sharp)," "no artificial blur"
- **Lighting:** "Unbalanced exposure," "slight overexposure in bright areas," "auto white balance with a slight blue cast"
- **Imperfections:** "Subtle edge distortion," "natural micro lens flare," "rolling-shutter micro-artifacts," "mild luminance grain"

### 2. "Accidental" composition

- "Awkward angle," "messy crop," "deliberately mediocre framing"
- "Unpolished casual home environment," "cluttered background"
- Avoid "centered framing" or "perfect composition"

### 3. Natural human motion (CRITICAL)

AI video defaults to a frozen mannequin staring at camera. Real people are constantly moving, distracted, and imperfect. **Always include at least 3–4 of these cues** in every UGC video prompt:

**Eye behavior:**
- "Briefly breaks eye contact with the camera, glances down or to the side, then looks back"
- "Eyes dart to something off-screen for a moment before refocusing on the lens"
- "Looks at the product in their hand, then back to camera"
- "Blinks naturally, not a fixed stare"

**Head and face:**
- "Slight head tilts while talking, not perfectly still"
- "Nods along with their own words"
- "Raises eyebrows for emphasis mid-sentence"
- "Purses lips or pauses to think before continuing"

**Body movement:**
- "Shifts weight from one foot to the other"
- "Leans toward camera for emphasis, then leans back"
- "Adjusts grip on the product"
- "Fidgets with hair or touches face briefly"
- "Turns the product to show a different angle"

**Selfie arm:**
- "Holding the camera at arm's length, arm extended naturally, clearly visible in the frame"
- "Adjusts phone angle mid-video"
- "Quick handheld adjustments, slightly shaky one-hand grip"

### 4. Negative prompts to always include

```
studio lighting, professional photography, stock photo, perfect skin,
heavy makeup, centered framing, staged, cinematic, LUT, color graded,
stabilization, subtitles, captions, text overlays, on-screen text
```

---

## Model-specific strategies

### Kling — character animation (recommended for start-frame UGC)

**Best for:** Animating an approved UGC still into a talking-head video.

**Formula:** `[Camera] + [Subject] + [Action] + [Context/Lighting] + [Style/Imperfections] + [Dialogue]`

- Describe physics: Not "she turns her head" but "She turns her head slowly left to right. Her hair follows just behind, catches the light. Slight tension in her neck."
- Anchor hands to objects to avoid AI hand morphing: "holding a phone," "gripping a coffee cup"
- Emphasize texture: "visible skin pores," "fabric sheen," "condensation," "natural sweat"

**Example:**
```
Medium close-up mirror selfie. A woman in a white dressing room holding
a phone at arm's length. Handheld smartphone drift, subtle sway. Natural
overhead fluorescent lighting casting slight shadows. She looks into the
mirror, waves her hand casually. Motion details: natural wrist rotation,
fabric of her sleeve moves with the gesture. Texture: visible skin pores,
slight grain of phone camera. She speaks softly: "Just testing this out."
Tone is breathy and impressed. Realistic facial motion, subtle eye blinks.
No subtitles, no captions, no text overlays.
```

**Krea MCP call:**
```
generate_video(
  prompt = kling_ugc_prompt,
  model = "kling",
  image_url = approved_ugc_still_url,
  aspect_ratio = "9:16",
  duration = 5,
)
```

---

### Veo 3 — highest quality + audio

**Best for:** Best overall quality. Veo 3 understands ambient audio and lip sync.

**Formula:** `[Camera] + [Subject] + [Action + Dialogue/Audio] + [Context/Lighting] + [Style]`

- Start with **"A selfie video of..."** to trigger correct framing
- Lock perspective with `(that's where the camera is)` syntax
- **ALWAYS end with:** `"No subtitles, no captions, no text overlays."` — Veo 3 will burn subtitles if not excluded
- Describe the environment soundscape: "ambient coffee shop sounds," "soft outdoor breeze"
- Sweet spot: **75–125 words**

**Example:**
```
A selfie video of a 25-year-old woman in her messy apartment holding
the camera at arm's length (that's where the camera is). Her right arm
is clearly visible in the frame. Natural lighting from a large window
creates unbalanced, soft shadows. She is casually talking — she briefly
breaks eye contact to glance down at the product in her hand, then
looks back at camera. She tilts her head slightly, nods along with her
own words, raises her eyebrows for emphasis. She shifts her weight and
leans toward the camera, then adjusts her phone angle. The image is
slightly grainy, documentary-style handheld camera work, completely
unedited vlog aesthetic. Background sounds of city traffic. She speaks
in a casual tone: "Okay so nobody talks about this." No subtitles, no
captions, no text overlays.
```

---

### Hailuo — fast general UGC

**Best for:** Quick UGC clips without a start frame. Text-prompt only.

- Keep prompts conversational and action-oriented
- Same imperfection and motion cue rules apply
- Good for rapid testing before committing to Kling/Veo 3

---

### Seedance — ByteDance quality UGC

See [seedance-ugc.md](seedance-ugc.md) for the full 9-layer Seedance UGC formula.

---

## Instagram Reels checklist (final pass)

- [ ] **Aspect ratio:** `9:16`
- [ ] **Hook:** First 2 seconds have dynamic motion or strong facial expression
- [ ] **Lighting:** "Natural," "window light," or "room lighting" — NOT "studio" or "cinematic"
- [ ] **Camera:** "iPhone front camera," "selfie-style," "handheld shake" stated
- [ ] **Flaws:** At least two imperfections included (grain, overexposure, focus hunting, messy background)
- [ ] **Motion cues:** 3–4 natural human movement cues included
- [ ] **No text overlays:** Explicitly excluded in the prompt

---

## References

- [Kling 3.0 realistic motion](https://www.atlascloud.ai/blog/guides/mastering-kling-3.0-10-advanced-ai-video-prompts-for-realistic-human-motion)
- [Veo 3 prompting guide](https://github.com/snubroot/Veo-3-Prompting-Guide)
- [UGC AI prompting guide](https://adlibrary.com/guides/ai-prompting-guide-ugc-content-creators)
