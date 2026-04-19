# Reference images

Drop reference images here for the agent to use when generating Krea images and videos. The agent checks this folder automatically and uses image URLs in `generate_image` / `generate_video` calls.

## Folder structure

### `influencers/`
AI-generated character sheets — each influencer gets their own subfolder with 10 reference angles.

#### Folder naming convention

```
{name}-{descriptor1}-{descriptor2}-{descriptor3}-{descriptor4}-{descriptor5}
```

- **name:** A human first name (lowercase) — for easy reference in conversation
- **5 descriptors:** Visual architecture tags (lowercase, hyphenated) that identify the influencer at a glance

Descriptors in order:
1. **Hair color** — `redhead`, `blonde`, `brunette`, `black-hair`, `silver`, `auburn`
2. **Hair style** — `wavy`, `straight`, `curly`, `pixie`, `braided`, `bob`
3. **Distinguishing feature** — `freckles`, `dimples`, `sharp-jaw`, `high-cheeks`, `beauty-mark`, `clear-skin`
4. **Eye color** — `green-eyes`, `blue-eyes`, `brown-eyes`, `hazel-eyes`, `gray-eyes`
5. **Skin tone** — `fair`, `olive`, `tan`, `deep`, `medium`, `porcelain`

**Examples:**
- `emma-redhead-wavy-freckles-green-eyes-fair/`
- `sofia-brunette-straight-dimples-brown-eyes-olive/`
- `kai-blonde-curly-sharp-jaw-blue-eyes-tan/`
- `marcus-black-hair-buzz-sharp-jaw-brown-eyes-deep/`

#### File naming convention (inside each influencer folder)

```
01-hero-front.jpg      ← the approved anchor image (full body front)
02-3q-left.jpg
03-3q-right.jpg
04-profile-left.jpg
05-profile-right.jpg
06-face-closeup.jpg
07-back-shoulder.jpg
08-medium-portrait.jpg
09-full-body-3q.jpg
10-above-angle.jpg
```

The agent uses `01-hero-front.jpg` as the primary reference. When an influencer's images are hosted (e.g. previously generated via Krea and returned in `list_assets`), the agent saves those URLs to `MASTER_CONTEXT.md` for reuse across sessions without re-uploading.

### `products/`
Product photos for showcase videos and product hero images.
- Different angles, packaging, in-use shots, flat lays
- The agent uses these as `image_url` in `generate_image` calls (image-to-image)
- Tip: clean backgrounds (white/neutral) produce the best results
- Host images publicly (e.g. Dropbox link, Imgur, your own CDN) so the agent can pass the URL directly to Krea MCP

### `aesthetics/`
Style references organized into subfolders by vibe.

#### `aesthetics/ugc-selfie/`
iPhone selfie-style UGC — raw, unpolished, authentic-looking frame grabs. Drop 3-5 reference images showing the target aesthetic. The agent uses these as descriptive inspiration (describe the aesthetic in prompt text, since Krea MCP `generate_image` accepts only one `image_url`).

#### Adding new styles
Create a new subfolder (e.g., `aesthetics/cinematic/`, `aesthetics/studio/`) and populate with 3-5 reference images. The agent will ask which style to use when generating.

### `examples/ugc-stills/`
Example UGC product selfie outputs showing the target quality — character + product + scene with skin realism and camera imperfections baked in. Use these as a visual reference for what the UGC pipeline produces.

---

## Supported formats

JPEG, PNG, WebP. Shipped example images are JPEG. The agent will note image dimensions and may suggest using a higher-resolution source if your image is below 512px on either side.

## Hosting reference images

Krea MCP tools take `image_url` — a publicly accessible URL. Options:
- **Dropbox:** share link → change `dl=0` to `dl=1`
- **Google Drive:** public share link (direct download)
- **Imgur:** direct link to the image
- **Your own CDN / S3 bucket**
- **Previously generated Krea images:** URLs from `list_assets` are already hosted on Krea's CDN

## Privacy

Video files and PNG/raw formats in this folder are gitignored. JPEG images can be committed as examples. Your personal client images should stay local — only commit images you're comfortable making public.
