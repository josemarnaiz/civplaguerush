"""Generate art-deco decadent 9-slice panels.

Produces:
  assets/art/ui/panel_frame.png       (96x96, slice margin 16) — parchment variant
  assets/art/ui/panel_frame_dark.png  (96x96, slice margin 16) — dark variant

Design philosophy: stepped-triangle corner ornaments (ziggurat), 3px stained-gold
ring with 1px dark studs for rhythm, parchment/dark interior with inner shadow.
Edges are designed to tile horizontally/vertically for 9-slice stretching.
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import (checker, fill_rect, hline, new_image, put, rect,
                        stepped_triangle, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "ui"
SIZE = 96
SLICE = 16  # 9-slice margin


def _draw_gold_band(img: Image.Image) -> None:
    """Draw the 3px-thick stained-gold ring just inside the outer D0 outline."""
    w, h = img.size
    # Outer outline (row/col 0)
    rect(img, 0, 0, w - 1, h - 1, c("D0"))

    # Gold band: rows 1..3 (thickness 3)
    # Top edge band
    for i in range(w):
        put(img, i, 1, c("O1"))
        put(img, i, 2, c("O3"))
        put(img, i, 3, c("O4"))
        put(img, i, h - 2, c("O1"))
        put(img, i, h - 3, c("O3"))
        put(img, i, h - 4, c("O4"))
    # Left/right edge bands
    for j in range(h):
        put(img, 1, j, c("O1"))
        put(img, 2, j, c("O3"))
        put(img, 3, j, c("O4"))
        put(img, w - 2, j, c("O1"))
        put(img, w - 3, j, c("O3"))
        put(img, w - 4, j, c("O4"))
    # Overwrite the corner pixel diagonals so the gold flows in L-shape
    for corner in [(0, 0), (w - 1, 0), (0, h - 1), (w - 1, h - 1)]:
        cx, cy = corner
        put(img, cx, cy, c("D0"))

    # Studs: 1px D2 accents on the O3 row every 8px, for art-deco rhythm.
    # Placed so they tile cleanly (spacing 8, offset 4).
    for i in range(4, w - 4, 8):
        put(img, i, 2, c("D2"))       # top
        put(img, i, h - 3, c("D2"))   # bottom
    for j in range(4, h - 4, 8):
        put(img, 2, j, c("D2"))       # left
        put(img, w - 3, j, c("D2"))   # right


def _draw_inner_border(img: Image.Image) -> None:
    """1px D0 inner outline at the cream/dark boundary (row 4 from edge)."""
    w, h = img.size
    rect(img, 4, 4, w - 5, h - 5, c("D0"))


def _draw_interior(img: Image.Image, fill_color: str, shadow_color: str) -> None:
    """Fill interior with parchment/dark color + 1px inner shadow for depth."""
    w, h = img.size
    fill_rect(img, 5, 5, w - 6, h - 6, c(fill_color))
    # Inner shadow: 1px line on top & left (casts depth from top-left light)
    hline(img, 5, w - 6, 5, c(shadow_color))
    vline(img, 5, 5, h - 6, c(shadow_color))


def _draw_corner_ornaments(img: Image.Image) -> None:
    """Art-deco stepped triangles + gem accents in each 16x16 corner region.

    Each corner gets a 4-step ziggurat in O4 with an O5 highlight tip,
    pointing diagonally inward from the corner.
    """
    w, h = img.size
    # Top-left: triangle growing to bottom-right from (6,6)
    stepped_triangle(img, origin=(6, 6), size=5, color=c("O4"), direction="br")
    stepped_triangle(img, origin=(6, 6), size=3, color=c("O5"), direction="br")
    put(img, 6, 6, c("O2"))  # apex shadow
    # Top-right: mirrored
    stepped_triangle(img, origin=(w - 7, 6), size=5, color=c("O4"), direction="bl")
    stepped_triangle(img, origin=(w - 7, 6), size=3, color=c("O5"), direction="bl")
    put(img, w - 7, 6, c("O2"))
    # Bottom-left
    stepped_triangle(img, origin=(6, h - 7), size=5, color=c("O4"), direction="tr")
    stepped_triangle(img, origin=(6, h - 7), size=3, color=c("O5"), direction="tr")
    put(img, 6, h - 7, c("O2"))
    # Bottom-right
    stepped_triangle(img, origin=(w - 7, h - 7), size=5, color=c("O4"), direction="tl")
    stepped_triangle(img, origin=(w - 7, h - 7), size=3, color=c("O5"), direction="tl")
    put(img, w - 7, h - 7, c("O2"))


def generate(variant: str = "light") -> Path:
    """variant: 'light' (parchment C3) or 'dark' (D1 with D2 shadow)."""
    img = new_image(SIZE, SIZE)
    _draw_gold_band(img)
    _draw_inner_border(img)
    if variant == "light":
        _draw_interior(img, fill_color="C3", shadow_color="C1")
        out_path = OUT_DIR / "panel_frame.png"
    else:
        _draw_interior(img, fill_color="D1", shadow_color="D0")
        out_path = OUT_DIR / "panel_frame_dark.png"
    _draw_corner_ornaments(img)

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    img.save(out_path)
    return out_path


if __name__ == "__main__":
    for variant in ("light", "dark"):
        path = generate(variant)
        print(f"Wrote {path}")
