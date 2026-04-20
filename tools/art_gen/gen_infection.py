"""Generate the infection overlay texture + plague glyph.

* infection_noise.png — 32x32 seamless-tiling organic red/black splotches.
  Used by region_map as a repeating tinted fill over infected regions.
* plague_sigil.png — 20x20 marker drawn on very-infected regions (>=60%)
  to visually flag an outbreak focus.
"""
from __future__ import annotations

import math
import random
from pathlib import Path

from PIL import Image

from palette import c
from primitives import new_image, put

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "map"


# ---------- seamless infection noise ---------------------------------------

def infection_noise(size: int = 32, seed: int = 1337) -> Image.Image:
    """Seamless tiling noise using summed sines in 2D.

    Output alpha ~ high for splotch centers, transparent elsewhere. Color
    shifts from D0/R1 (deep rot) at centers to R3 (wound) at midtones.
    """
    rng = random.Random(seed)
    img = new_image(size, size)
    # Generate a few random gaussian blobs whose positions are tiled by
    # wrapping via sine functions so the result is seamless.
    blobs = []
    for _ in range(5):
        cx = rng.uniform(0, size)
        cy = rng.uniform(0, size)
        r = rng.uniform(size * 0.12, size * 0.22)
        blobs.append((cx, cy, r))

    def wrap_dist(x, bx, sz):
        d = abs(x - bx)
        return min(d, sz - d)

    for y in range(size):
        for x in range(size):
            val = 0.0
            for (bx, by, r) in blobs:
                dx = wrap_dist(x, bx, size)
                dy = wrap_dist(y, by, size)
                d = math.sqrt(dx * dx + dy * dy)
                if d < r:
                    t = 1.0 - d / r
                    val += t * t
            # Small swirl via sine modulation for organic shape.
            val += 0.08 * math.sin(x * 0.4 + y * 0.3)
            val = max(0.0, min(1.0, val))
            if val < 0.15:
                continue
            if val > 0.75:
                col = c("D0", 255)
            elif val > 0.55:
                col = c("R1", 240)
            elif val > 0.35:
                col = c("R2", 215)
            else:
                col = c("R3", 180)
            put(img, x, y, col)
    return img


# ---------- plague sigil ---------------------------------------------------

def plague_sigil(size: int = 20) -> Image.Image:
    """20x20 warding sigil: circle with X and dots (outbreak marker)."""
    img = new_image(size, size)
    cx = size // 2
    cy = size // 2
    r_out = 8
    r_in = 6
    # Outer ring
    for y in range(size):
        for x in range(size):
            d2 = (x - cx) ** 2 + (y - cy) ** 2
            if r_in * r_in < d2 <= r_out * r_out:
                put(img, x, y, c("R4"))
            elif d2 <= 4:
                put(img, x, y, c("D0"))
    # Diagonal cross (warded)
    for i in range(-5, 6):
        put(img, cx + i, cy + i, c("D0"))
        put(img, cx + i, cy - i, c("D0"))
    # Four cardinal dots
    for (dx, dy) in [(-7, 0), (7, 0), (0, -7), (0, 7)]:
        put(img, cx + dx, cy + dy, c("O4"))
        put(img, cx + dx, cy + dy, c("O4"))
    # Central gold spark
    put(img, cx, cy, c("O5"))
    return img


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    noise = infection_noise(32)
    n_path = OUT_DIR / "infection_noise.png"
    noise.save(n_path)
    print(f"Wrote {n_path}")

    sigil = plague_sigil(20)
    s_path = OUT_DIR / "plague_sigil.png"
    sigil.save(s_path)
    print(f"Wrote {s_path}")


if __name__ == "__main__":
    generate()
