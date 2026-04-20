"""Generate additional decorative ornaments for the world map.

Produces:
  compass_rose.png   — 48x48 art-deco compass rose (N/S/E/W + diagonals).
  header_cartouche.png — 160x40 9-slice frame for section headers (gold rim,
                         dark parchment interior, stepped corners).
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import (fill_rect, hline, new_image, put, rect,
                        stepped_triangle, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "map"
UI_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "ui"


# ----------------------------------------------------------------- compass rose

def compass_rose() -> Image.Image:
    sz = 48
    img = new_image(sz, sz)
    cx, cy = 23, 23

    # Outer ring (thin gold).
    outer_r = 22
    # Draw outer ring as parametric circle (integer shell).
    for ang in range(0, 360, 2):
        import math
        rad = math.radians(ang)
        x = round(cx + math.cos(rad) * outer_r)
        y = round(cy + math.sin(rad) * outer_r)
        put(img, x, y, c("O3"))
    # Inner ring (darker).
    inner_r = 18
    for ang in range(0, 360, 3):
        import math
        rad = math.radians(ang)
        x = round(cx + math.cos(rad) * inner_r)
        y = round(cy + math.sin(rad) * inner_r)
        put(img, x, y, c("O1"))

    # Cardinal arms: 4 long diamond spears (N, S, E, W).
    # North (up): tip at (cx, cy-20), base at cy-4 spanning 3 wide, filled O4 with O5 highlight.
    def cardinal_arm(dx, dy, length, width_base=3):
        # Draw a tapered spear from center to (cx+dx*length, cy+dy*length).
        import math
        # Triangular spear: linear interpolation of width from 0 (tip) to width_base (near center).
        for t in range(length + 1):
            # Current point along axis.
            tx = cx + dx * t
            ty = cy + dy * t
            # Width at this t (wide near center, thin at tip).
            if t == length:
                w = 0
            else:
                w = int(round(width_base * (1 - t / length)))
            # Perpendicular direction.
            px, py = -dy, dx
            for off in range(-w, w + 1):
                ax = tx + px * off
                ay = ty + py * off
                # Fill color: brighter at edges for light-from-top-left.
                base_col = c("O4")
                if (dx, dy) in ((0, -1), (-1, 0)):
                    base_col = c("O5")  # N/W lit
                elif (dx, dy) in ((0, 1), (1, 0)):
                    base_col = c("O2")  # S/E shadow
                put(img, int(ax), int(ay), base_col)
        # Tip highlight: single bright pixel.
        put(img, cx + dx * length, cy + dy * length, c("O5"))

    cardinal_arm(0, -1, 20)  # N
    cardinal_arm(0, 1, 20)   # S
    cardinal_arm(1, 0, 20)   # E
    cardinal_arm(-1, 0, 20)  # W

    # Diagonals: shorter, thinner triangles in O2.
    def diag_arm(dx, dy, length):
        for t in range(length + 1):
            tx = cx + dx * t
            ty = cy + dy * t
            if t == length or t == 0:
                w = 0
            else:
                w = int(round(1.8 * (1 - t / length)))
            for off in range(-w, w + 1):
                ax = tx - dy * off
                ay = ty + dx * off
                put(img, int(ax), int(ay), c("O2"))

    diag_arm(1, -1, 14)   # NE
    diag_arm(-1, -1, 14)  # NW
    diag_arm(1, 1, 14)    # SE
    diag_arm(-1, 1, 14)   # SW

    # Outline spears with D0.
    for (dx, dy, length) in [(0, -1, 20), (0, 1, 20), (1, 0, 20), (-1, 0, 20)]:
        # Tip.
        put(img, cx + dx * length, cy + dy * length, c("D0"))
        # Edges (left/right of the axis near the base).
        put(img, cx + dx * 3 - dy * 3, cy + dy * 3 + dx * 3, c("D0"))
        put(img, cx + dx * 3 + dy * 3, cy + dy * 3 - dx * 3, c("D0"))

    # Center hub: small dark disc with gold dot.
    for y in range(cy - 3, cy + 4):
        for x in range(cx - 3, cx + 4):
            d = (x - cx) ** 2 + (y - cy) ** 2
            if d <= 9:
                put(img, x, y, c("D0"))
            elif d <= 12:
                put(img, x, y, c("D2"))
    # Gold core.
    fill_rect(img, cx - 1, cy - 1, cx + 1, cy + 1, c("O4"))
    put(img, cx, cy, c("O5"))

    # "N" marker above the north tip.
    # Use a tiny 3x5 bitmap "N".
    nx, ny = cx - 1, 1
    # 3x5 N:
    n_rows = [
        "X.X",
        "X.X",
        "XXX",
        "X.X",
        "X.X",
    ]
    for ry, row in enumerate(n_rows):
        for rx, ch in enumerate(row):
            if ch == "X":
                put(img, nx + rx, ny + ry, c("O5"))

    return img


# ----------------------------------------------------------------- header cartouche
# 9-slice friendly, 160x40, corners 16px.

def header_cartouche() -> Image.Image:
    w, h = 160, 40
    img = new_image(w, h)

    # Outer outline.
    rect(img, 0, 0, w - 1, h - 1, c("D0"))
    # Inner parchment fill (dark).
    fill_rect(img, 2, 2, w - 3, h - 3, c("D1"))

    # Double gold border.
    rect(img, 1, 1, w - 2, h - 2, c("O3"))
    rect(img, 3, 3, w - 4, h - 4, c("O1"))

    # Studs every 8 pixels on inner gold row.
    for x in range(10, w - 10, 8):
        put(img, x, 1, c("D2"))
        put(img, x, h - 2, c("D2"))

    # Stepped corner ornaments (ziggurats).
    stepped_triangle(img, (6, 6), 4, c("O4"), "br")
    put(img, 6, 6, c("O2"))
    stepped_triangle(img, (w - 7, 6), 4, c("O4"), "bl")
    put(img, w - 7, 6, c("O2"))
    stepped_triangle(img, (6, h - 7), 4, c("O4"), "tr")
    put(img, 6, h - 7, c("O2"))
    stepped_triangle(img, (w - 7, h - 7), 4, c("O4"), "tl")
    put(img, w - 7, h - 7, c("O2"))

    # Two small vertical gold studs centered (decorative).
    put(img, w // 2 - 1, h // 2, c("O4"))
    put(img, w // 2, h // 2, c("O5"))

    return img


# ---------------------------------------------------------------------- build

def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    UI_DIR.mkdir(parents=True, exist_ok=True)
    rose = compass_rose()
    rose_path = OUT_DIR / "compass_rose.png"
    rose.save(rose_path)
    print(f"Wrote {rose_path}")

    cart = header_cartouche()
    cart_path = UI_DIR / "header_cartouche.png"
    cart.save(cart_path)
    print(f"Wrote {cart_path}")


if __name__ == "__main__":
    generate()
