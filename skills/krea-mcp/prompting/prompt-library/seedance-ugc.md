# UGC video prompt formula — Seedance

**Use when:** You need a UGC-style product review/testimonial video. Output should feel like a real person filmed a casual selfie video on their phone.

**Read first:** [seedance.md](seedance.md) for platform rules, timing guide, and the adaptation checklist.

---

## The anatomy of a UGC video prompt

Every effective UGC Seedance prompt has **9 layers**, stacked in order:

```
 1. FORMAT HEADER       — duration, style, device, lighting, angle
 2. PERSON              — appearance, skin texture, clothing
 3. SETTING             — lived-in environment, specific clutter details
 4. PRODUCT INTRO       — how they hold/show the product to camera
 5. SCRIPT BEATS        — jump-cut scenes with dialogue + actions
 6. TONE DIRECTION      — personality, pacing, energy
 7. EDIT STYLE          — jump cuts, angles, take selection
 8. TECHNICAL FLAWS     — camera quality, audio, lighting imperfections
 9. VIBE STATEMENT      — one-sentence emotional anchor
```

---

## Layer-by-layer formula

### Layer 1: Format header

```
{{DURATION}} UGC style {{CONTENT_TYPE}} video, filmed on smartphone,
{{LIGHTING_SOURCE}}, {{CAMERA_ANGLE}}.
```

| Variable | Options |
|----------|---------|
| `DURATION` | 10 seconds, 15 seconds |
| `CONTENT_TYPE` | skincare review, product unboxing, morning routine, honest review, first impression, haul |
| `LIGHTING_SOURCE` | natural bedroom window lighting, bathroom vanity mirror lighting, golden hour balcony light, overhead kitchen light |
| `CAMERA_ANGLE` | casual handheld selfie angle, phone propped on counter, mirror selfie angle |

**Duration guide:**
| Duration | Jump cuts | Dialogue guidance |
|----------|-----------|-------------------|
| **10s** | 2–3 cuts | 1–2 spoken lines max + one silent beat |
| **15s** | 3–4 cuts | Mix spoken and silent beats. Read aloud at natural pace — if you have to rush, cut words |

**THE REAL RULE:** Read every dialogue line out loud at a natural, unhurried pace with pauses. Time yourself. If it doesn't fit the duration comfortably, shorten it.

---

### Layer 2: Person

```
A {{AGE_RANGE}} {{GENDER}} with {{HAIR}}, {{SKIN_TEXTURE}}, wearing {{CLOTHING}},
```

**Skin reality cue bank** (pick 2–3 — CRITICAL):
- `natural skin with visible texture`
- `visible pores across nose and cheeks`
- `slight unevenness in skin tone`
- `minor undereye shadows`
- `a hint of shine on forehead from natural oils`
- `a few expression lines when smiling`

**Do NOT use:** acne, pimples, breakouts, blemishes.

---

### Layer 3: Setting

Describe 3–4 specific objects that make it feel lived-in.

```
in {{THEIR_SPACE}} — {{DETAIL_1}}, {{DETAIL_2}}, {{DETAIL_3}}, {{ATMOSPHERE}} and real.
```

| Setting | Specific clutter | Atmosphere |
|---------|----------------|------------|
| **Bedroom** | books on shelves, plants on windowsill, clothes on a chair | cozy, lived-in |
| **Bathroom** | towels hanging, skincare bottles on counter, foggy mirror edge | steamy, morning |
| **Kitchen** | coffee mug, cutting board, fruit bowl, morning light through blinds | warm, morning routine |
| **Living room** | throw blanket, candle on coffee table, shoes by the door | relaxed, casual |
| **Car** | coffee in cupholder, sunglasses on dash, parking lot through windshield | on-the-go |

---

### Layer 4: Product introduction

```
{{PRONOUN}} holds the @(img1) ({{PRODUCT_DESCRIPTION}}) {{HOW}}.
```

| Style | When to use | Example |
|-------|-------------|---------|
| **Show to camera** | Review, first impression | "holds the bottle up to the camera" |
| **Already using** | Tutorial, routine | "is mid-application, product already on her skin" |
| **Unboxing reveal** | Haul, unboxing | "pulls it out of the box, eyes lighting up" |
| **In-hand casual** | Day-in-my-life | "has it sitting on her lap, picks it up" |

> Note: `@(img1)` maps to the image passed via `image_url`. See [seedance.md](seedance.md).

---

### Layer 5: Script beats

Each beat = one jump cut. Structure: **hook → demonstration → proof → verdict.**

Not every beat needs dialogue. Silent beats (inspecting product, sipping, reacting) feel more authentic.

**Beat framework:**

| Beat | Purpose | Framing | Example |
|------|---------|---------|---------|
| 1 (Hook) | Grab attention | Looking into camera | Expressive opener, holds product up |
| 2 (Show) | Product detail | Closer to lens | Tilts/turns product, shows label |
| 3 (Demo) | Proof of use | Extreme close-up | Applies product, shows texture |
| 4 (Result) | Evidence | Mirror/different angle | Points at skin/result |
| 5 (Verdict) | Final opinion | Back to original angle | Holds product up, delivers final line |

For 10s, pick 2–3 beats. For 15s, use 3–4.

**Jump cut language:** `Quick jump cut —`, `Jump cut —`, `Cut to —`, `Final shot —`

**Dialogue rules:**
- Written in quotes, casual spoken language
- Use filler words: "okay so," "literally," "I'm not even," "like," "you guys"
- End mid-thought or with a laugh, not a polished sign-off

---

### Layer 6: Tone direction

```
Throughout the video, the tone is {{EMOTION_1}}, {{EMOTION_2}}, {{EMOTION_3}} —
{{BEHAVIOR_DESCRIPTION}}.
```

**ALWAYS include a pacing cue:**
- `pauses between thoughts as if collecting the next word`
- `takes natural breaths between sentences, never rushing`
- `lets moments breathe — a sip, a glance down, a pause before speaking again`

| Vibe | Emotion words | Behavior |
|------|---------------|---------|
| **Excited fan** | genuine, excited, breathless | talks with energy but pauses, uses natural breaths |
| **Chill recommender** | relaxed, honest, conversational | speaks slowly, makes eye contact, shrugs casually |
| **Skeptic converted** | surprised, impressed, reluctant | raises eyebrows, pauses mid-sentence |
| **Best friend sharing** | warm, conspiratorial, intimate | lowers voice, leans in, takes her time |

---

### Layer 7: Edit style

```
Each jump cut is {{ANGLE_VARIATION}}. {{EDIT_FEEL}}.
```

**Default:** "Each jump cut is slightly closer or at a different angle, as if she filmed multiple takes and edited the best bits together."

---

### Layer 8: Technical flaws

Include ALL of these — every single one matters:

```
The lighting is {{LIGHT_TYPE}} — {{LIGHT_FLAW}}.
The image is slightly imperfect — {{CAMERA_FLAW_1}}, {{CAMERA_FLAW_2}}, {{CAMERA_FLAW_3}}.
The sound is {{AUDIO_SOURCE}} — {{AUDIO_DETAILS}}.
```

**Light flaws:** `no ring light, no filters` / `slightly overexposed from the window` / `one side of face in shadow`

**Camera flaws (pick 2–3):**
- `natural phone quality, not color graded`
- `slight motion blur on fast movements`
- `soft focus, nothing is tack sharp`
- `visible grain in darker areas`

**Audio options:**
- `direct from the phone mic` — natural voice, room ambience, no music underneath
- `front camera mic` — slightly tinny, room echo, background hum
- `car interior acoustics` — muffled, road noise underneath

---

### Layer 9: Vibe statement

```
The overall feel is {{ADJECTIVE_1}}, {{ADJECTIVE_2}}, {{ADJECTIVE_3}} — {{RELATABLE_METAPHOR}}.
```

Examples:
- `trustworthy, relatable, real — a friend telling you about something she genuinely likes.`
- `chaotic, genuine, fun — like a voice memo she sent to her group chat.`
- `calm, honest, intimate — like overhearing someone's morning routine.`

---

## Complete template

```
{{DURATION}} UGC style {{CONTENT_TYPE}} video, filmed on smartphone,
{{LIGHTING_SOURCE}}, {{CAMERA_ANGLE}}. A {{AGE_RANGE}} {{GENDER}} with
{{HAIR}}, {{SKIN_TEXTURE}}, wearing {{CLOTHING}}, in {{THEIR_SPACE}} —
{{CLUTTER_1}}, {{CLUTTER_2}}, {{CLUTTER_3}}, {{ATMOSPHERE}} and real.
{{PRONOUN}} holds the @(img1) ({{PRODUCT_DESCRIPTION}}) {{INTRO_STYLE}}.

The video opens with {{PRONOUN}} {{HOOK_ACTION}}: "{{HOOK_LINE}}"

Quick jump cut — {{BEAT_2_FRAMING}}, {{BEAT_2_ACTION}}:
"{{BEAT_2_DIALOGUE}}"

Jump cut — {{BEAT_3_FRAMING}}, {{BEAT_3_ACTION}}.

Jump cut — {{BEAT_4_FRAMING}}, {{BEAT_4_ACTION}}:
"{{BEAT_4_DIALOGUE}}" {{CLOSING_ACTION}}.

Throughout the video, the tone is {{TONE_EMOTIONS}} —
{{TONE_BEHAVIOR}}. The pacing is natural and unhurried — {{PACING_CUE}}.
Each jump cut is {{ANGLE_VARIATION}}. {{EDIT_FEEL}}.

The lighting is {{LIGHT_TYPE}} — {{LIGHT_FLAW}}. The image is
slightly imperfect — {{CAMERA_FLAWS}}. The sound is {{AUDIO_SOURCE}} —
{{AUDIO_DETAILS}}.

The overall feel is {{VIBE_ADJECTIVES}} — {{RELATABLE_METAPHOR}}.
```

---

## Quick-start example — skincare serum (bedroom, excited fan)

```
15 seconds UGC style skincare review video, filmed on smartphone,
natural bedroom window lighting, casual handheld selfie angle. A young
woman with brown hair pulled back, natural skin with visible texture,
wearing a casual grey t-shirt, in her cozy bedroom — books on shelves,
plants on the windowsill, clothes on a chair, lived-in and real. She
holds the @(img1) (aurora serum bottle) up to the camera.

The video opens with her looking into the camera, excited expression:
"Okay, so I've been using this for two weeks, and I need to talk about it."

Quick jump cut — she's now showing the bottle closer to the lens,
tilting it so the label catches the light from the window:
"The texture is insane, it's like water but silky?"

Jump cut — extreme close-up of her pressing the dropper, the serum
dropping onto her fingertips, she rubs it between her fingers.

Jump cut — she leans into the camera, pointing at her cheek:
"Look, I actually have a glow right now, and I'm literally wearing nothing."
She laughs, the video cuts.

Throughout the video, the tone is genuine, unscripted-feeling, warm —
she talks fast, uses natural pauses, laughs at herself. Each jump cut is
slightly closer or at a different angle.

The lighting is soft natural daylight, no ring light, no filters. The
image is slightly imperfect — natural phone quality, not color graded,
soft focus. The sound is direct from the phone mic — room ambience,
her natural voice, no music underneath.

The overall feel is trustworthy, relatable, real — a friend telling you
about something she genuinely likes.
```

---

## Adaptation checklist

- [ ] Duration specified (10s or 15s)
- [ ] Person described with 2–3 skin reality cues
- [ ] Setting has 3+ specific clutter objects
- [ ] Product intro style chosen
- [ ] Beat count matches duration (10s = 2–3, 15s = 3–4)
- [ ] At least one silent action beat included
- [ ] Dialogue fits runtime when read aloud naturally
- [ ] Tone direction has 3 emotion words + pacing cue
- [ ] Technical flaws: lighting flaw + camera flaw + audio source
- [ ] Vibe statement present
- [ ] Word count 100–260 words
- [ ] No forbidden words (cinematic, professional, stunning, 8k, studio, perfect)
