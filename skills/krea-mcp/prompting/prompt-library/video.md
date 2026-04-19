# Video prompt library — all models

Use these templates for `generate_video`. Always include human motion cues for people, UGC imperfection block for creator content. Adapt to brand voice in `MASTER_CONTEXT.md`.

---

## Model selection quick-ref

| Need | Model | image_url? |
|------|-------|-----------|
| Character animation from still | `kling` | YES (start frame) |
| Highest quality + audio | `veo-3` | YES or NO |
| Fast general UGC | `hailuo` | YES or NO |
| Cinematic camera move | `runway` | YES or NO |
| Long scene / multi-shot | `sora` | optional |
| Smooth photorealistic | `luma` | YES or NO |
| Artistic / stylized | `wan` | YES or NO |
| Fast reactive clip | `pika` | YES or NO |

---

## UGC talking-head video (person holding product)

**Model:** `kling` | **image_url:** approved still from character workflow

```
[Character: age, features — match the still] talks directly to camera, 
holding [product] in one hand,
natural authentic delivery, like a creator making content at home,
breaking eye contact briefly to glance down at product, 
slight head tilt, shifting weight, 
natural blink cadence, genuine expression,
bathroom or bedroom background slightly out of focus,
shot on iPhone, handheld movement, 
overexposed highlights, film grain, off-center framing,
no subtitles, no captions, no text overlays
```

**Negative prompt (in prompt text):** `no subtitles, no captions, no burned-in text, no freeze frames`

---

## UGC product unboxing / showcase (no face)

**Model:** `hailuo` or `kling`

```
Close-up of hands unboxing [product name],
brown cardboard box on wooden table,
natural daylight from window, warm morning light,
one hand lifts product out of tissue paper, 
slow deliberate movement, slight camera shake,
shot on iPhone, handheld, film grain,
no face in frame
```

---

## Cinematic product reveal

**Model:** `runway`

```
Cinematic slow push-in on [product] sitting on [surface],
[lighting: soft morning light / dramatic side lighting / golden hour],
shallow depth of field, 4K film look,
[optional camera move: slow dolly forward / pan left to right / tilt up]
```

**Aspect ratio:** `16:9` | **Duration:** 5–8s

---

## Lifestyle B-roll (person, no direct address)

**Model:** `kling` or `luma` | **image_url:** character reference

```
[Character description], 
[activity: applying product in mirror / drinking coffee / walking outdoors], 
casual and unaware of camera,
soft natural light, realistic skin, 
slight camera movement as if handheld observer,
golden hour tones, lifestyle editorial feel,
no subtitles, no text
```

---

## Quick social clip — product motion

**Model:** `pika`

```
[Product] on a [surface], 
slow 360-degree rotation, 
soft studio light, clean white background,
smooth continuous motion
```

**Aspect ratio:** `1:1` | **Duration:** 5s

---

## Long-form scene / multi-shot brief

**Model:** `sora`

```
[Scene description across multiple beats]:
Opening: [beat 1]
Middle: [beat 2]
End: [beat 3]
Overall tone: [cinematic / UGC / documentary]
Lighting: [description]
No text overlays, no subtitles
```

**Duration:** 10–20s (longer = more Sora advantage over other models)

---

## Veo 3 (best quality + audio-aware)

**Model:** `veo-3` | **image_url:** optional start frame

```
[Character] in [setting],
[what they are doing / saying — veo-3 can render ambient audio],
[lighting description],
cinematic camera work,
[motion cues if character is present],
no subtitles, no captions, no text overlays
```

Note: Veo 3 can generate synchronized ambient audio and lip movement. Describe the environment soundscape in the prompt for best results (e.g., "ambient coffee shop sounds", "soft outdoor breeze").

---

## Anime / artistic motion

**Model:** `wan`

```
[Character or scene in anime art style],
[action description with fluid motion],
[lighting: soft cel shading / dramatic rim light],
[color palette],
smooth animation, high detail
```

---

## Aspect ratio guide for video

| Platform | aspect_ratio |
|---------|------------|
| Reels, TikTok, Stories | `9:16` |
| YouTube, desktop | `16:9` |
| Feed square | `1:1` |
