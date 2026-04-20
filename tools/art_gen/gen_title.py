"""Generate the game title cartouche — large art-deco plaque with
'CIV PLAGUE RUSH' rendered inside in pixel-style text.

Output: assets/art/ui/title_logo.png at 640x128 (native), pre-scaled 2x
so it already has the chunky pixel feel when Godot displays it.

Design:
- Double border: dark outline + gold art-deco frame
- Stepped-triangle corner ornaments
- Central nameplate: two rows ("CIV" "PLAGUE RUSH" stacked)
- Subtle drip marks (plague motif)
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

from palette import c
from primitives import fill_rect, hline, new_image, put, rect, vline

ART_DIR = Path(__file__).resolve().parents[2] / "assets" / "art"
OUT = ART_DIR / "ui" / "title_logo.png"

# Native pixel grid (will be 2x scaled at save time for crunchier presence).
BASE_W = 240
BASE_H = 56
SCALE = 3


def _find_pixel_font(size: int) -> ImageFont.ImageFont:
    # Prefer Consolas (fixed-width, nice at low sizes). Fallbacks otherwise.
    for candidate in ("consolab.ttf", "consola.ttf", "cour.ttf"):
        try:
            return ImageFont.truetype(candidate, size)
        except OSError:
            continue
    return ImageFont.load_default()


def _stamp_text_pixel(canvas: Image.Image, text: str, y: int, font_size: int,
                      color_rgba: tuple, shadow_rgba: tuple) -> None:
    font = _find_pixel_font(font_size)
    # Render on an offscreen transparent image so we can drop it onto canvas
    # with crisp pixel edges. No scaling here — font chosen to match pixel grid.
    tmp = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    dr = ImageDraw.Draw(tmp)
    # Measure text
    bbox = dr.textbbox((0, 0), text, font=font)
    tw = bbox[2] - bbox[0]
    x = (canvas.width - tw) // 2 - bbox[0]
    # Shadow
    dr.text((x + 1, y + 1), text, font=font, fill=shadow_rgba)
    # Main
    dr.text((x, y), text, font=font, fill=color_rgba)
    canvas.alpha_composite(tmp)


def build() -> Path:
    img = new_image(BASE_W, BASE_H)

    # Outer darkest shadow (drop shadow for whole plate)
    fill_rect(img, 2, 2, BASE_W - 1, BASE_H - 1, c("D0"))
    # Gold double frame
    fill_rect(img, 0, 0, BASE_W - 3, BASE_H - 3, c("O2"))
    fill_rect(img, 1, 1, BASE_W - 4, BASE_H - 4, c("O3"))
    # Inner dark nameplate
    fill_rect(img, 4, 4, BASE_W - 7, BASE_H - 7, c("D1"))
    # Parchment sub-plate
    fill_rect(img, 6, 6, BASE_W - 9, BASE_H - 9, c("D2"))

    # Corner stepped triangles (art-deco)
    # Top-left
    for (cx, cy, dx, dy) in [(3, 3, 1, 1),
                              (BASE_W - 6, 3, -1, 1),
                              (3, BASE_H - 6, 1, -1),
                              (BASE_W - 6, BASE_H - 6, -1, -1)]:
        put(img, cx, cy, c("O4"))
        put(img, cx + dx, cy, c("O4"))
        put(img, cx, cy + dy, c("O4"))
        put(img, cx + 2 * dx, cy, c("O5"))
        put(img, cx, cy + 2 * dy, c("O5"))
        put(img, cx + dx, cy + dy, c("O5"))

    # Horizontal dividers above/below text (gold hairlines)
    hline(img, 14, BASE_W - 15, 11, c("O3"))
    hline(img, 14, BASE_W - 15, BASE_H - 12, c("O3"))
    # Center zig-zag glyph (top)
    for i, x in enumerate(range(BASE_W // 2 - 10, BASE_W // 2 + 11, 3)):
        put(img, x, 10, c("O4"))
        put(img, x + 1, 9, c("O4"))
        put(img, x + 2, 10, c("O4"))
    # Bottom zig-zag
    for i, x in enumerate(range(BASE_W // 2 - 10, BASE_W // 2 + 11, 3)):
        put(img, x, BASE_H - 11, c("O4"))
        put(img, x + 1, BASE_H - 10, c("O4"))
        put(img, x + 2, BASE_H - 11, c("O4"))

    # Text rendered with a pixel-leaning font. We pick small sizes so the
    # glyphs stay crisp before we NEAREST-scale the whole image.
    gold = c("O5")
    gold_shadow = c("D0")
    title_text = "CIVPLAGUERUSH"

    # Single-row title in the middle.
    _stamp_text_pixel(img, title_text, 20, 16, gold, gold_shadow)

    # Drip marks below the title text (plague motif)
    drip_xs = [28, 56, 96, 128, 158, 188, 210]
    for dx in drip_xs:
        put(img, dx, BASE_H - 16, c("R3"))
        put(img, dx, BASE_H - 15, c("R3"))
        put(img, dx, BASE_H - 14, c("R4"))

    # Scale up with NEAREST for chunky presence.
    final = img.resize((BASE_W * SCALE, BASE_H * SCALE), Image.NEAREST)
    final.save(OUT)
    return OUT


if __name__ == "__main__":
    print(f"Wrote {build()}")
