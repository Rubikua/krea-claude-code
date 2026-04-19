# Veo 3 — prompt guide

**Krea MCP model name:** `veo-3`
**Best for:** Highest quality output with native audio generation. Veo 3 generates video AND synchronized audio (ambient sound, foley, even dialogue) in a single pass. Best for premium brand content, narrative scenes, and anything where sound matters.

---

## When to use Veo 3

| Use case | Why Veo 3 |
|----------|---------|
| Premium brand video | Best visual quality on the platform |
| Content that needs ambient sound | Native audio — no separate post |
| Dialogue scenes | Can generate lip-synced voice |
| Cinematic lifestyle | Rich depth and lighting |
| High-end product hero | Detail fidelity |

**Cost note:** Veo 3 is among the most expensive models. Always confirm user awareness before generating. Run the still-first workflow (nano-banana or flux-pro) to verify concept before committing.

---

## Krea MCP call

```
generate_video(
  prompt    = "...",          # see prompt formula below
  model     = "veo-3",
  image_url = "...",          # optional start frame reference
  aspect_ratio = "9:16",      # or "16:9"
  duration  = 8,              # 5–15s; sweet spot is 8–12s
)
```

Poll `get_job(job_id)` until `status == "completed"`. Veo 3 takes 5–15 min.

---

## Audio: Veo 3's key differentiator

Veo 3 generates audio natively. Describe it explicitly in the prompt.

### Audio layers to specify

```
Audio: {{AMBIENT_SOUND}}, {{FOLEY_SOUNDS}}, {{MUSIC_OR_VOICE}}.
```

**Ambient sound examples:**
- `quiet morning apartment — distant traffic, faint birdsong`
- `café interior — low murmur of conversation, espresso machine hiss`
- `outdoor market — ambient chatter, light breeze`
- `bathroom morning — water running faintly, tile echo`

**Foley (action sounds):**
- `glass bottle setting on marble counter`
- `liquid pouring into a glass`
- `light footsteps on hardwood`
- `paper bag rustling`
- `cap clicking open on a bottle`

**Voice / dialogue:**
- `She speaks in a warm, unhurried voice: "{{LINE}}"` — Veo 3 can lip-sync
- `No dialogue — ambient sound only`
- `Soft voiceover (off-screen): "{{LINE}}"` — voice without lip sync

**Keep dialogue short.** Veo 3 handles 1–2 sentences reliably. More than that risks drift.

---

## Prompt formula

```
{{SCENE_DESCRIPTION}} — {{ATMOSPHERE}}.

{{SUBJECT}} {{ACTION}}. {{CONTINUED_ACTION}}.

Camera: {{CAMERA_MOVE}}.
Lighting: {{LIGHTING}}.
Audio: {{AMBIENT}}, {{FOLEY}}.
{{CONSISTENCY_CONSTRAINTS}}.
```

### Visual quality cues
Veo 3 responds well to quality anchors that other models ignore:

- `sharp focus on subject, soft background bokeh`
- `skin texture visible — real, not retouched`
- `product label legible, colors true to reference`
- `depth of field: shallow — subject sharp, background dreamy`

---

## Scene types

### Lifestyle — person + product

```
{{LOCATION}} with {{ATMOSPHERE}}. A {{SUBJECT_DESCRIPTION}}.

She {{ACTION}} — {{MOTION_DETAIL}}. The @(img1) product is
{{PRODUCT_PLACEMENT}}.

Camera: {{CAMERA_MOVE}}.
Lighting: {{LIGHTING}}.
Audio: {{AMBIENT_SOUND}}, {{FOLEY}}.
Maintain face and product consistency throughout.
```

### Product hero with ambient audio

```
{{PRODUCT_DESCRIPTION}} — {{PLACEMENT}} — {{ATMOSPHERE}}.
{{ELEMENTAL_EFFECT}}.

Camera: {{CAMERA_MOVE}}.
Lighting: {{LIGHTING}}.
Audio: {{AMBIENT}}, {{FOLEY}}.
No dialogue. No text. Product is the only subject.
```

### Dialogue / testimonial

```
A {{SUBJECT_DESCRIPTION}} facing camera, in {{ENVIRONMENT}}.
She speaks: "{{DIALOGUE_LINE}}"

Her expression is {{EXPRESSION}}. The delivery is {{PACE}}.

Camera: static, medium shot.
Lighting: {{LIGHTING}}.
Audio: her natural voice, room ambience — {{AMBIENT_DETAIL}}.
```

---

## Motion specificity

Like all Krea models, be explicit about degree and direction:

| Vague | Specific |
|-------|---------|
| "she moves" | "she slowly shifts her weight from right to left" |
| "she picks it up" | "she reaches across with her right hand, lifts the bottle by the neck" |
| "she looks at the camera" | "she turns toward camera, a small, knowing smile forming" |

---

## Camera language

Veo 3 executes camera instructions precisely:

| Call | Effect |
|------|--------|
| `static wide shot` | Environmental, scene-setting |
| `slow dolly-in from medium to close-up` | Builds intimacy |
| `gentle handheld — slight organic drift` | Authentic, UGC-adjacent |
| `overhead top-down, slowly rotating` | Product hero, abstract |
| `rack focus: foreground product → background subject` | Cinematic reveal |

---

## Example: Skincare testimonial with audio

```
A sunlit studio apartment, late morning — white walls, warm timber
floors, a trailing plant by the window. The light is soft and natural,
coming from the right.

A woman in her early 30s with dark wavy hair, olive skin with visible
pores and minor undereye shadows, wearing a relaxed white linen shirt.
She faces camera, holding the @(img1) product (glass dropper bottle)
loosely in one hand.

She speaks directly to camera, unhurried: "I've tried everything, and
this is the one I actually kept using."

She sets the bottle on the windowsill gently, looks out the window for
a moment, then back to camera — a small, easy smile.

Camera: static medium shot, slightly below eye level.
Lighting: soft natural window light from the right, warm morning tone.
Audio: quiet apartment ambience — faint birdsong outside, the soft
click of the bottle on the windowsill, her warm natural voice.
Maintain face and product consistency. Skin texture visible — real,
not retouched. Duration: 10 seconds.
```

---

## QA checklist

- [ ] Face matches reference image (if provided)
- [ ] Product label legible and unchanged
- [ ] Audio layers described (ambient + foley)
- [ ] Dialogue is short (1–2 sentences max)
- [ ] Camera move is specified and consistent
- [ ] Lighting is defined — no void / undefined light
- [ ] Skin texture described as real, not retouched
- [ ] Duration specified in prompt
