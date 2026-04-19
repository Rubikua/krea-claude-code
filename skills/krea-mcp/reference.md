# Krea MCP — tool reference

All tools are accessed as MCP tools (`mcp__krea-mcp__*`). Parameters marked `*` are required.

---

## generate_image

Generate an image. Returns `job_id` — poll with `get_job`.

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `prompt` * | string | — | Text description of the image |
| `model` | string | `flux` | See model table below |
| `width` | number | 1024 | Pixels. Common: 768, 1024, 1344 |
| `height` | number | 1024 | Pixels. Common: 768, 1024, 1344 |
| `image_url` | string | — | Source image URL for image-to-image |
| `style_id` | string | — | LoRA style ID from `search_styles` |
| `negative_prompt` | string | — | What to avoid in the image |

**Image models:**

| Model | Description |
|-------|-------------|
| `flux` | General-purpose, fast (default) |
| `flux-pro` | Higher quality, photorealistic |
| `ideogram` | Best for images with text |
| `imagen-4` | Google — photorealistic product/people |
| `krea-1` | Krea's own model — stylized/artistic |
| `chatgpt-image` | GPT-4o — complex compositions + text |
| `nano-banana` | Consistent character generation, UGC stills |
| `seedream` | ByteDance — portraits and lifestyle |

**Common size presets:**

| Ratio | Width | Height | Use |
|-------|-------|--------|-----|
| 1:1 | 1024 | 1024 | Square feed |
| 9:16 | 768 | 1344 | Reels / Stories |
| 16:9 | 1344 | 768 | YouTube / desktop |
| 4:5 | 819 | 1024 | Instagram portrait |

---

## generate_video

Generate a video. Returns `job_id` — poll with `get_job`.

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `prompt` * | string | — | Text description of the video |
| `model` | string | `hailuo` | See model table below |
| `aspect_ratio` | string | `16:9` | `16:9`, `9:16`, `1:1` |
| `duration` | number | 5 | Duration in seconds |
| `image_url` | string | — | Starting frame for image-to-video |

**Video models:**

| Model | Best for | Max duration |
|-------|---------|-------------|
| `hailuo` | General UGC (default) | 5s |
| `kling` | Character animation, natural motion | 10s |
| `runway` | Cinematic camera moves | 10s |
| `pika` | Fast, short clips, motion FX | 5s |
| `veo-3` | Best quality, audio-aware | 8s |
| `sora` | Long scenes, complex briefs | ~20s |
| `luma` | Photorealistic smooth motion | 5s |
| `wan` | Artistic, anime-style | 5s |

---

## get_job

Check the status and result of a generation job.

| Param | Type | Notes |
|-------|------|-------|
| `job_id` * | string | Returned by `generate_image` or `generate_video` |

**Response shape (approximate):**

```json
{
  "job_id": "...",
  "status": "scheduled | processing | completed | failed",
  "result_url": "https://...",   // present when completed
  "error": "..."                 // present when failed
}
```

Poll every 10–15s for images; every 20–30s for videos. Status flow: `scheduled` → `processing` → `completed | failed`.

---

## search_styles

Search for LoRA styles to apply to image generations.

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `query` * | string | — | Search term (e.g. "vintage film", "watercolor") |
| `limit` | number | 10 | Max results (1–1000) |

Returns a list of styles with `id`, `name`, `description`, and preview info.

---

## get_style

Get full details of a specific style.

| Param | Type | Notes |
|-------|------|-------|
| `style_id` * | string | Style ID from `search_styles` |

---

## upload_asset

Upload an image or video to Krea for use as a reference in generations.

| Param | Type | Notes |
|-------|------|-------|
| `url` * | string | Publicly accessible URL of the image or video |
| `name` | string | Optional display name |

Returns asset details including a Krea-hosted URL to use in `image_url`.

---

## list_assets

List previously uploaded assets.

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `limit` | number | 100 | Max results (1–1000) |

---

## get_asset

Get details of a specific uploaded asset.

| Param | Type | Notes |
|-------|------|-------|
| `asset_id` * | string | The asset ID |

---

## list_jobs

List generation jobs with optional filtering.

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `limit` | number | 100 | Max results (1–1000) |
| `status` | string | — | Filter: `scheduled`, `processing`, `completed`, `failed` |
| `types` | string | — | Comma-separated model names (e.g. `flux,kling`) |
