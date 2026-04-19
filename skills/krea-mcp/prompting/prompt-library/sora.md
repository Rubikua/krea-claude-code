# Sora — prompt guide

**Krea MCP model name:** `sora`
**Best for:** Longer scenes (>10 seconds), complex camera choreography, multi-location narratives, cinematic atmosphere. Sora excels at sustained motion over longer durations and handles scene continuity better than shorter-form models.

---

## When to use Sora

| Use case | Why Sora |
|----------|---------|
| Scene longer than 10 seconds | Best sustained motion fidelity |
| Complex camera choreography | Handles multi-move sequences |
| Establishing shots / environments | Rich background detail |
| Brand film / narrative clip | Cinematic feel, scene continuity |
| Multi-character scenes | Better at maintaining multiple subjects |

**Don't use Sora for:** Quick 5s social clips (overkill + slower), UGC-style selfie content (Kling or Seedance are better), image-to-video start-frame animation (Kling is stronger here).

---

## Krea MCP call

```
generate_video(
  prompt    = "...",          # see prompt formula below
  model     = "sora",
  image_url = "...",          # optional start frame
  aspect_ratio = "16:9",      # Sora excels at landscape; 9:16 also supported
  duration  = 10,             # 10–20s; default to 10 for social
)
```

Poll `get_job(job_id)` until `status == "completed"`. Sora takes longer — expect 5–15 min per clip.

---

## Prompt formula

Sora responds best to scene-based, narrative prompts. Think: film script action line.

```
{{SCENE_DESCRIPTION}} — {{ATMOSPHERE}}.

{{SUBJECT}} {{ACTION}}. {{SECONDARY_ACTION}}.

Camera {{CAMERA_MOVE}} — {{CAMERA_DETAIL}}.

The scene feels {{VIBE}}.
```

### Scene description
Set the world first. Sora builds environments richly — give it something to work with.

```
A quiet coastal town at dusk, warm amber light catching the rooftops,
narrow cobblestone streets mostly empty.
```

### Subject + action
Keep action continuous — Sora handles sustained motion better than quick cuts.

```
A woman in a linen dress walks slowly down the street, a paper bag
of groceries in her right arm, glancing into shop windows as she passes.
She pauses at a flower stand, leans in to smell a bunch of white freesias.
```

### Camera move
Sora can execute complex, multi-step camera movements within a single clip.

| Camera pattern | Effect |
|---------------|--------|
| `slow tracking shot following subject from behind` | Immersive, environmental |
| `wide establishing, then push-in to medium` | Scene → character |
| `low angle looking up, camera rises slowly` | Dramatic reveal |
| `handheld, slightly unstable — journalistic` | Raw, documentary |
| `orbiting around the subject` | Hero moment |

---

## Scene continuity tips

Sora holds scene continuity longer than other models — use this:

1. **Describe where the scene starts AND where it ends.** Frame 0 and final frame.
2. **Name environmental details that should persist:** lighting direction, specific props, background elements.
3. **Describe sustained vs. momentary motion:** "she walks slowly" (sustained) vs. "she pauses briefly" (momentary).

```
[Scene opens:] The kitchen is warm with morning light from the east window.
She's at the counter, coffee in hand.
[Scene ends:] She's moved to the table, setting her mug down, looking out.
The light has shifted only slightly — early morning, continuous.
```

---

## Atmosphere building

Sora is exceptional at atmosphere — exploit this for brand film content.

**Weather / time:**
- `golden hour, long shadows from the right`
- `overcast morning, diffused even light`
- `blue hour, city lights beginning to appear`
- `midday, harsh sun softened by light cloud cover`

**Environment movement:**
- `leaves drift gently in a light breeze`
- `steam rises from a coffee cup on the table`
- `soft reflections shimmer on wet pavement`
- `curtains sway near an open window`

**Sound-image alignment (describe as image cues):**
- `her footsteps imply a quiet rhythm — describe the ground texture`
- `waves are visible in the background, low and unhurried`

---

## Duration guidance

| Duration | Scene type |
|----------|-----------|
| 10s | Single continuous scene, one location |
| 15s | Scene with movement arc (A → B) |
| 20s | Full narrative beat (setup → action → moment) |

For social content, 10–12s is optimal. Longer clips are for brand film or B-roll.

---

## Prompt templates

### Lifestyle / brand film scene

```
{{LOCATION}} at {{TIME_OF_DAY}}, {{ATMOSPHERE}}.

A {{SUBJECT_DESCRIPTION}} {{INITIAL_ACTION}}.
{{CONTINUED_ACTION}}. {{FINAL_BEAT}}.

Camera: {{CAMERA_MOVE}}, {{CAMERA_DETAIL}}.
The lighting is {{LIGHTING}}. The scene feels {{VIBE}} — sustained,
unhurried, real. No sudden cuts. No quick movements.
```

### Environmental / product establishing shot

```
{{ENVIRONMENT}} — {{ATMOSPHERE}}. No person on screen.

The @(img1) product sits {{PLACEMENT}}. {{ENVIRONMENT_MOTION}}.
Camera: {{CAMERA_MOVE}}, revealing the full scene slowly.

The feel is {{MOOD}}. Light catches {{PRODUCT_DETAIL}}.
No text overlays. No cuts — one continuous camera move.
```

---

## Example: Brand film moment

```
A modern apartment at golden hour — warm amber light flooding through
floor-to-ceiling windows, plants casting long shadows across white oak
floors.

A woman in her early 30s stands at the kitchen island, back to camera,
slowly arranging flowers in a ceramic vase. She pauses, steps back to
assess, adjusts one stem. The @(img1) product (amber glass serum bottle)
sits on the counter beside her, catching the window light.

She turns slowly, notices the bottle, picks it up and carries it toward
the window — holds it up so light passes through the amber glass, studies
it for a moment, then sets it on the windowsill.

Camera: slow arc from behind, gradually circling to a 3/4 profile view.
The lighting is warm golden-hour from the right — no artificial light
visible. The scene feels quiet, domestic, aspirational — unhurried and
real. Continuous take, no cuts. Duration: 12 seconds.
```

---

## QA checklist

- [ ] Scene continuity: same lighting direction throughout
- [ ] Subject: no identity drift, no costume change
- [ ] Camera move: smooth, no snap or stutter
- [ ] Environment: background objects consistent
- [ ] Product (if present): shape and label unchanged
- [ ] Duration: motion fills the full clip, no dead freeze at the end
