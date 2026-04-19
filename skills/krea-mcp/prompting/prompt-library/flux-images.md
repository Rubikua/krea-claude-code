# Flux / Flux Pro / Imagen 4 — image prompt library

Use these as starting templates. Always adapt to the brand voice in `MASTER_CONTEXT.md`.

---

## Product hero shot (studio)

**Model:** `flux-pro` or `imagen-4`

```
[Product name] on a [surface: white marble / slate / linen cloth], 
soft diffused studio lighting from the left, macro lens, 
shallow depth of field, clean white background, 
product label perfectly readable, no reflections on product, 
professional product photography
```

**Negative:** `text, watermark, hands, deformed product, cluttered background, shadows that obscure label`

---

## Product lifestyle shot (in-context)

**Model:** `flux-pro`

```
[Product] sitting on a [bathroom shelf / kitchen counter / bedside table], 
morning golden hour light streaming from window, 
soft bokeh background, 
complementary props (plant, towel, glass of water), 
warm lifestyle photography, editorial feel
```

**Negative:** `text, watermark, excessive props, cluttered, artificial lighting`

---

## UGC selfie still (person + product)

**Model:** `nano-banana` (with `image_url` if character reference exists)

```
[Character description: age, features, style — from MASTER_CONTEXT.md], 
visible pores, slight unevenness in skin tone, minor undereye shadows, hint of shine from natural oils,
holding [product name] with one hand, bathroom selfie,
shot on iPhone, handheld, slight motion blur, off-center framing, 
overexposed highlights, film grain, soft focus edges, 
natural lens distortion, casual everyday outfit
```

**Negative:** `deformed hands, extra fingers, plastic skin, studio lighting, overly saturated, watermark, text, AI-looking`

---

## Character hero portrait (influencer creation — step 1)

**Model:** `nano-banana`

```
Full body portrait of [age]-year-old [ethnicity/description], 
[hair color and style], [eye color], 
[skin description with realism cues: visible pores, slight unevenness in skin tone, minor undereye shadows],
wearing [casual outfit description], 
standing in [neutral indoor location], 
soft natural window light, 
photo from a mirrorless camera, 85mm portrait lens, 
clean background, documentary style
```

**Negative:** `deformed, plastic skin, anime, illustration, studio backdrop, text, watermark`

---

## Character angle variation (influencer creation — follow-up shots)

**Model:** `nano-banana` (with hero image as `image_url`)

Variations to generate (one prompt each):

```
// 3/4 angle
Same person as reference, 3/4 angle from the right, 
soft natural light, same outfit, documentary portrait style

// Profile
Same person as reference, side profile view,
looking slightly forward, soft backlight, same outfit

// Close-up face
Same person as reference, tight face crop, 
direct eye contact with camera, golden hour light from the left

// Looking away
Same person as reference, looking slightly off-camera to the left,
candid expression, natural light, slight smile forming
```

---

## Artistic / stylized (with LoRA)

**Model:** `krea-1` + `style_id` from `search_styles`

```
[Subject], [scene description], 
[style name applied via style_id] aesthetic, 
[additional mood words]
```

Note: Search styles first with `search_styles("your aesthetic query")` and set `style_id` in the tool call.

---

## Text-in-image (ad creative)

**Model:** `ideogram`

```
Clean product advertisement layout, 
[product] in center, soft gradient background in [color],
bold sans-serif headline text: "[your text here]",
minimal supporting text: "[supporting copy]",
bottom-right: small brand logo placeholder,
professional ad design, modern typography
```

**Negative:** `messy layout, illegible text, distorted letters, hand-drawn, rough`

---

## Sizes cheatsheet

| Use case | width | height |
|---------|-------|--------|
| Reels / TikTok cover | 768 | 1344 |
| Feed square | 1024 | 1024 |
| Feed portrait | 819 | 1024 |
| YouTube thumbnail | 1344 | 768 |
| Story background | 768 | 1344 |
