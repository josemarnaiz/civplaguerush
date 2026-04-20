"""Generate decorative UI elements: dividers, corner flourishes, stat badge panel.

Produces:
  divider_horizontal.png  — tiling horizontal art-deco divider (96x8, slice 12)
  flourish_corner.png     — 32x32 ornamental corner flourish (overlay art)
  badge_frame.png         — smaller 9-slice frame (48x48, slice 8) for HUD stats
  badge_frame_dark.png    — dark variant
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import (fill_rect, hline, new_image, put, rect,
                        stepped_triangle, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "ui"


# ---------- Horizontal divider ----------------------------------------------

def divider_horizontal() -> Image.Image:
    """96x8 horizontal divider: two gold lines with a central diamond motif.

    Tileable horizontally — the ends are empty 12px to match button slice margins.
    """
    w, h = 96, 8
    img = new_image(w, h)

    # Two thin gold lines running horizontally at y=3 and y=5
    for x in range(w):
        put(img, x, 3, c("O3"))
        put(img, x, 4, c("O1"))
        put(img, x, 5, c("O3"))
    # Dark outlines above/below
    hline(img, 0, w - 1, 2, c("D0"))
    hline(img, 0, w - 1, 6, c("D0"))

    # Central diamond motif at x=48
    cx = 48
    put(img, cx, 1, c("D0"))
    put(img, cx - 1, 2, c("D0"))
    put(img, cx + 1, 2, c("D0"))
    put(img, cx - 2, 3, c("D0"))
    put(img, cx + 2, 3, c("D0"))
    put(img, cx - 3, 4, c("D0"))
    put(img, cx + 3, 4, c("D0"))
    put(img, cx - 2, 5, c("D0"))
    put(img, cx + 2, 5, c("D0"))
    put(img, cx - 1, 6, c("D0"))
    put(img, cx + 1, 6, c("D0"))
    put(img, cx, 7, c("D0"))
    # Fill diamond with gold hi + sheen
    put(img, cx, 2, c("O4"))
    put(img, cx - 1, 3, c("O4")); put(img, cx, 3, c("O5")); put(img, cx + 1, 3, c("O4"))
    put(img, cx - 2, 4, c("O4")); put(img, cx - 1, 4, c("O5")); put(img, cx, 4, c("O5")); put(img, cx + 1, 4, c("O5")); put(img, cx + 2, 4, c("O4"))
    put(img, cx - 1, 5, c("O4")); put(img, cx, 5, c("O5")); put(img, cx + 1, 5, c("O4"))
    put(img, cx, 6, c("O4"))

    return img


# ---------- Corner flourish (overlay art) -----------------------------------

def flourish_corner() -> Image.Image:
    """32x32 corner ornament — art-deco fan/ray radiating from top-left.

    Drawn transparent outside the ornament; meant to be placed over other art.
    """
    img = new_image(32, 32)
    # Main diagonal rays (3 rays fanning out from (2,2))
    # Ray 1: pure diagonal
    for i in range(22):
        put(img, 2 + i, 2 + i, c("O4"))
        put(img, 3 + i, 2 + i, c("O5"))
    # Ray 2: flatter (1 down per 2 right)
    for i in range(24):
        x = 2 + i
        y = 2 + i // 2
        put(img, x, y, c("O3"))
    # Ray 3: steeper (2 down per 1 right)
    for i in range(12):
        x = 2 + i
        y = 2 + i * 2
        put(img, x, y, c("O3"))

    # Radial arc — small stepped arc connecting tips of rays
    # Simple: put dots along a quarter-circle
    for i in range(8):
        ang = i / 7 * 1.5708  # 0..pi/2
        import math
        x = 2 + int(round(18 * math.cos(ang)))
        y = 2 + int(round(18 * math.sin(ang)))
        put(img, x, y, c("O5"))
        put(img, x - 1, y, c("O4"))
        put(img, x, y - 1, c("O4"))

    # Anchor jewel at origin
    fill_rect(img, 0, 0, 3, 3, c("R3"))
    put(img, 1, 1, c("R4"))
    put(img, 2, 2, c("R4"))
    rect(img, 0, 0, 3, 3, c("D0"))

    return img


# ---------- Smaller badge frame (HUD stat) ----------------------------------

def badge_frame(variant: str = "light") -> Image.Image:
    """48x48, slice margin 8 — smaller panel for HUD stat badges."""
    w, h = 48, 48
    img = new_image(w, h)

    # Outer outline
    rect(img, 0, 0, w - 1, h - 1, c("D0"))

    # 2px gold band
    for i in range(w):
        put(img, i, 1, c("O1"))
        put(img, i, 2, c("O3"))
        put(img, i, h - 2, c("O1"))
        put(img, i, h - 3, c("O3"))
    for j in range(h):
        put(img, 1, j, c("O1"))
        put(img, 2, j, c("O3"))
        put(img, w - 2, j, c("O1"))
        put(img, w - 3, j, c("O3"))
    for (cx, cy) in [(0, 0), (w - 1, 0), (0, h - 1), (w - 1, h - 1)]:
        put(img, cx, cy, c("D0"))

    # Inner outline
    rect(img, 3, 3, w - 4, h - 4, c("D0"))

    # Interior fill
    if variant == "light":
        fill_rect(img, 4, 4, w - 5, h - 5, c("C3"))
        hline(img, 4, w - 5, 4, c("C4"))
        vline(img, 4, 4, h - 5, c("C4"))
    else:
        fill_rect(img, 4, 4, w - 5, h - 5, c("D1"))
        hline(img, 4, w - 5, 4, c("D2"))
        vline(img, 4, 4, h - 5, c("D2"))

    # Tiny 2-step corner ornaments
    for (ox, oy, direction) in [(5, 5, "br"), (w - 6, 5, "bl"),
                                 (5, h - 6, "tr"), (w - 6, h - 6, "tl")]:
        stepped_triangle(img, origin=(ox, oy), size=2, color=c("O4"), direction=direction)
        put(img, ox, oy, c("O2"))

    return img


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    outputs = {
        "divider_horizontal.png": divider_horizontal(),
        "flourish_corner.png": flourish_corner(),
        "badge_frame.png": badge_frame("light"),
        "badge_frame_dark.png": badge_frame("dark"),
    }
    for filename, img in outputs.items():
        path = OUT_DIR / filename
        img.save(path)
        print(f"Wrote {path}")


if __name__ == "__main__":
    generate()
