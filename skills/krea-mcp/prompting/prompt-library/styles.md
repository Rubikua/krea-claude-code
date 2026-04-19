# Styles / LoRAs — search guide

Krea's style system lets you apply trained LoRAs to any image generation. This file helps you find and use them effectively.

---

## How to use styles

```
1. Call search_styles("your aesthetic description") — be specific.
2. Review returned styles (name, description, previews).
3. If uncertain between options, call get_style(style_id) for full detail.
4. Pass style_id to generate_image.
5. Save the winner to MASTER_CONTEXT.md under "Saved style IDs".
```

Styles apply to **images only** — they have no effect on video generation.

---

## Effective search queries by category

### Film / photography aesthetics

| What you want | Search query |
|--------------|-------------|
| Analog film look | `"35mm film grain analog photography"` |
| Vintage Polaroid | `"polaroid vintage instant photo"` |
| Lo-fi disposable camera | `"disposable camera lo-fi candid"` |
| Cinematic movie still | `"cinematic film still anamorphic"` |
| Black and white documentary | `"black white documentary portrait"` |

### Art styles

| What you want | Search query |
|--------------|-------------|
| Watercolor illustration | `"watercolor illustration soft"` |
| Ink / pen drawing | `"ink line art pen drawing"` |
| Oil painting | `"oil painting impressionist"` |
| Anime / manga | `"anime manga illustration"` |
| Retro 80s | `"retro 80s synthwave neon"` |

### Commercial / brand

| What you want | Search query |
|--------------|-------------|
| Clean minimal product | `"clean minimal product commercial"` |
| Luxury editorial | `"luxury editorial fashion magazine"` |
| Earthy organic | `"earthy organic natural muted tones"` |
| Bold graphic poster | `"bold graphic design poster"` |
| Soft pastel lifestyle | `"soft pastel lifestyle light airy"` |

### Content creator aesthetics

| What you want | Search query |
|--------------|-------------|
| iPhone UGC look | `"iphone ugc authentic candid"` |
| GRWM vlog style | `"vlog beauty grwm selfie"` |
| Dark moody aesthetic | `"dark moody cinematic shadow"` |
| Cottagecore / soft | `"cottagecore soft dreamy warm"` |
| Streetwear / urban | `"streetwear urban editorial gritty"` |

---

## Tips

- **Be specific in search queries.** "vintage" returns too many results. "vintage Kodak 400 film grain" is better.
- **Preview before applying.** Use `get_style(style_id)` to see example images before spending a generation.
- **Combine with prompting.** Styles add texture and aesthetic — you still need a strong base prompt. The style amplifies, not replaces.
- **Save everything you like.** Write winning `style_id` + name + use-case to `MASTER_CONTEXT.md`. Style search results can change as new LoRAs are published.
- **Try negative prompts with styles.** If a style bleeds into unwanted areas, use `negative_prompt` to suppress (e.g., `negative_prompt: "film grain on product"` when you want grain on the person but not the product).
