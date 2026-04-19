# Kling — prompt guide

**Krea MCP model name:** `kling`
**Best for:** Animating still images with natural character motion. Fluid human movement, facial expressions, body language. Excellent at image-to-video (start frame). Handles both vertical (9:16) and horizontal (16:9) formats.

---

## When to use Kling

| Use case | Why Kling |
|----------|-----------|
| UGC selfie animation | Best natural-looking face + body motion |
| Character holding/using a product | Handles hand motion well |
| Lifestyle scene animation | Natural camera + subject movement |
| Portrait-to-video | Excellent facial expression fidelity |
| Brand lifestyle content | Polished motion, not jumpy |

---

## Krea MCP call

```
generate_video(
  prompt    = "...",          # see prompt formula below
  model     = "kling",
  image_url = "...",          # strongly recommended — start frame reference
  aspect_ratio = "9:16",      # or "16:9"
  duration  = 5,              # 5–10s; default 5 for social
)
```

Poll `get_job(job_id)` until `status == "completed"`.

---

## Prompt formula

```
{{SUBJECT}} {{STARTING_POSITION}}, {{ENVIRONMENT}}.

{{MAIN_ACTION}} — {{MOTION_DETAIL}}.
{{SECONDARY_MOTION}}.

Camera: {{CAMERA_MOVE}}.
Lighting: {{LIGHTING}}.
{{CONSTRAINTS}}.
```

### Subject line
Define appearance + position at the start of the clip. Kling needs a clear anchor because it's animating FROM the reference image — don't re-describe what's already in the image in detail. Just confirm position and context.

```
A woman in her late 20s standing in a sunlit kitchen, facing camera,
holding a coffee mug with both hands.
```

### Action (the most important part)
Be specific about movement direction and degree. Kling responds well to:
- **Degree adverbs:** slowly, gently, slightly, deliberately, casually
- **Direction:** left/right, toward/away from camera, up/down
- **Body part specificity:** right hand, left shoulder, lower lip, corner of mouth

```
She slowly lifts the mug toward her lips with both hands, eyes closing
briefly as she takes a sip, a slight smile forming at the corners of
her mouth as she lowers it back.
```

### Camera
Kling handles subtle camera motion well. Keep it understated.

| Camera call | Effect |
|-------------|--------|
| `static camera, no shake` | Clean, editorial |
| `subtle dolly-in` | Intimate, builds connection |
| `gentle handheld drift` | UGC, authentic |
| `slow pan left to right` | Environmental reveal |

### Constraints
Always end with stabilization and consistency anchors:

```
Maintain face and outfit consistency throughout. Smooth, natural motion
— no jerky transitions. No camera shake unless specified.
```

---

## Motion cue bank

**Eyes / face:**
- `eyes drift down to the product, then back to camera`
- `a slight smile forms and fades naturally`
- `she blinks once slowly, expression softens`
- `eyebrows raise briefly in mild surprise`

**Head / neck:**
- `she tilts her head slightly to the right`
- `a slow, gentle nod`
- `she glances off-screen left, then returns gaze to camera`

**Hands / arms:**
- `right hand lifts the bottle slowly toward camera`
- `she turns the product in her hands, inspecting it casually`
- `left hand tucks hair behind ear`
- `she sets the product down gently on the counter`

**Body:**
- `she shifts weight slightly to her left hip`
- `a natural inhale — shoulders rise and fall`
- `she leans forward slightly toward the lens`

---

## Image-to-video tips

When providing a reference image via `image_url`:

1. **Don't re-describe the image contents in detail.** Kling already sees it. Use the prompt to direct the MOTION from that starting state.
2. **Describe where the clip ENDS, not just what happens.** Kling uses the image as frame 0 — tell it what frame 5 looks like.
3. **Keep expression changes subtle.** Dramatic expression changes (neutral → laughing) can cause face inconsistency.
4. **Hair and loose elements will move.** If hair is long, expect it to drift. You can suppress this: `hair remains mostly still, minimal movement`.

---

## Duration guidance

| Duration | Best for |
|----------|---------|
| 5s | Single action (one motion, one beat) |
| 7–8s | Two beats (action + reaction) |
| 10s | Full mini-scene (action + dialogue gesture + close) |

For social UGC content, 5s clips that loop cleanly are most reusable.

---

## Quality / consistency QA

After generation, check:
- [ ] Face matches reference image (no drift, no age shift)
- [ ] Outfit unchanged
- [ ] Hands look natural (Kling handles hands well but verify for complex grips)
- [ ] Motion feels real — not floaty or AI-glitchy
- [ ] Product (if present) maintains shape and label

If face drifts: add `maintain facial identity, no face morphing` to constraints.
If motion is floaty: add `grounded, weighted motion` to action description.

---

## Example: Lifestyle product moment (image-to-video)

```
A woman in her late 20s seated on a light linen couch, holding the
@(img1) product (green glass serum bottle) loosely in her right hand,
facing camera. Bright afternoon light from the left window.

She slowly lifts the bottle, tilts it slightly toward camera as if
showing it to someone, then turns it gently to the side — examining
it. Her left hand comes up and she taps the dropper cap twice with
one finger, a quiet, habitual gesture. She glances at the bottle,
then back to camera with a soft, easy expression.

Camera: subtle dolly-in, closing slightly over the duration.
Lighting: soft natural window light, warm afternoon.
Maintain face and outfit consistency throughout. Natural weighted
motion — no floaty transitions. Hair drifts minimally.
```
