"""Generate 32x32 stat icons for the HUD (procedural pixel-by-pixel).

Transparent background, D0 outlines, light from top-left, palette-locked.

Produces:
  stat_influence.png  — 3-peaked crown with ruby gem
  stat_resources.png  — ornate chalice
  stat_crisis.png     — skull
  stat_stability.png  — ionic column
  stat_control.png    — banner on staff
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import (fill_rect, hline, new_image, put, rect, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "icons"
SZ = 32


# ---------- CROWN (Influence) -----------------------------------------------

def crown() -> Image.Image:
    img = new_image(SZ, SZ)
    # Three peaks: left (x=7), center (x=15), right (x=23)
    # Each peak is a triangular spike with a pearl/gem at tip.
    peaks = [(7, 10), (15, 8), (23, 10)]  # (tip_x, tip_y) — center is tallest
    for tip_x, tip_y in peaks:
        # Spike outline & fill from tip down to y=15
        for row in range(6):
            y = tip_y + row
            half = row
            fill_rect(img, tip_x - half, y, tip_x + half, y, c("O4"))
        # Outline the spike
        for row in range(6):
            y = tip_y + row
            half = row
            put(img, tip_x - half - 1, y, c("D0"))
            put(img, tip_x + half + 1, y, c("D0"))
        put(img, tip_x, tip_y - 1, c("D0"))  # tip cap

    # Pearls on left/right peak tips (O5), ruby on center (R3)
    put(img, 7, 10, c("O5"))
    put(img, 23, 10, c("O5"))
    put(img, 15, 8, c("R3"))
    put(img, 15, 9, c("R4"))

    # Main crown band y=16..22, x=3..28
    band_top, band_bot = 16, 22
    # outline
    rect(img, 3, band_top, 28, band_bot, c("D0"))
    # fill
    fill_rect(img, 4, band_top + 1, 27, band_bot - 1, c("O3"))
    # top highlight row (O4)
    hline(img, 4, 27, band_top + 1, c("O4"))
    # bottom shadow row (O1)
    hline(img, 4, 27, band_bot - 1, c("O1"))
    # Decorative cross pattern: dots of O5 every 4px on mid row
    for x in range(6, 27, 4):
        put(img, x, band_top + 3, c("O5"))
    # Central ruby inset on band
    fill_rect(img, 14, band_top + 2, 17, band_bot - 2, c("R3"))
    rect(img, 14, band_top + 2, 17, band_bot - 2, c("D0"))
    put(img, 15, band_top + 3, c("R4"))

    return img


# ---------- CHALICE (Resources) ---------------------------------------------

def chalice() -> Image.Image:
    img = new_image(SZ, SZ)
    # Cup: wide top (x=8..23) narrowing to stem
    # Cup rim y=6..8
    rect(img, 8, 6, 23, 8, c("D0"))
    fill_rect(img, 9, 7, 22, 7, c("O4"))
    # Cup body y=8..14, slightly curved (narrow at bottom)
    for y in range(8, 15):
        t = (y - 8) / 6.0  # 0..1
        margin = int(t * 3)
        left = 8 + margin
        right = 23 - margin
        put(img, left, y, c("D0"))
        put(img, right, y, c("D0"))
        fill_rect(img, left + 1, y, right - 1, y, c("O3"))
        put(img, left + 1, y, c("O4"))  # highlight on left inner
        put(img, right - 1, y, c("O1"))  # shadow on right inner
    # Inner cup liquid (wine/blood): R3 at top
    fill_rect(img, 10, 8, 21, 9, c("R2"))
    hline(img, 10, 21, 8, c("R3"))
    put(img, 11, 8, c("R4"))

    # Decorative band mid-cup: dark notch around y=12
    hline(img, 12, 19, 12, c("O1"))
    put(img, 15, 12, c("O5"))
    put(img, 16, 12, c("O5"))

    # Stem y=15..22, x=14..17
    rect(img, 14, 15, 17, 22, c("D0"))
    fill_rect(img, 15, 15, 16, 22, c("O3"))
    vline(img, 15, 15, 22, c("O4"))
    vline(img, 16, 15, 22, c("O1"))
    # Knob on stem y=18
    put(img, 13, 18, c("D0"))
    put(img, 18, 18, c("D0"))
    put(img, 13, 19, c("D0"))
    put(img, 18, 19, c("D0"))
    fill_rect(img, 14, 18, 17, 19, c("O4"))

    # Base y=23..26, x=9..22 (wide trapezoid)
    rect(img, 9, 23, 22, 26, c("D0"))
    fill_rect(img, 10, 24, 21, 25, c("O3"))
    hline(img, 10, 21, 24, c("O4"))
    hline(img, 10, 21, 25, c("O1"))
    # Base extension
    hline(img, 8, 23, 26, c("D0"))

    return img


# ---------- SKULL (Crisis) --------------------------------------------------

def skull() -> Image.Image:
    """Symmetrical skull centered horizontally at x=15.5 (even-pixel grid 7..24).

    Anatomy plan:
      - Cranium dome: y=4..17, x=7..24, slightly squared on top.
      - Temple pinch at y=17..18 (brow ridge → cheekbones).
      - Zygomatic/jaw: tapered rows y=18..24.
      - Two big square eye sockets with tear drops.
      - Heart-shaped nasal cavity.
      - Four distinct upper teeth + chin seam.
      Light comes from top-left: left side gets C4, right gets C3/C2.
    """
    img = new_image(SZ, SZ)

    # --- Cranium silhouette (symmetric, precomputed row extents) ------------
    # Each row: (y, x_left, x_right)  inclusive.  Mirrored around center 15.5.
    cranium = [
        ( 4, 11, 20),
        ( 5, 10, 21),
        ( 6,  9, 22),
        ( 7,  8, 23),
        ( 8,  7, 24),
        ( 9,  7, 24),
        (10,  7, 24),
        (11,  7, 24),
        (12,  7, 24),
        (13,  7, 24),
        (14,  7, 24),
        (15,  8, 23),
        (16,  8, 23),
        (17,  9, 22),
    ]
    jaw = [
        (18,  9, 22),
        (19, 10, 21),
        (20, 10, 21),
        (21, 11, 20),
        (22, 12, 19),
        (23, 13, 18),
        (24, 14, 17),
    ]
    # Fill base (cream) and compute outline as 1px shell.
    for y, xl, xr in cranium + jaw:
        fill_rect(img, xl, y, xr, y, c("C4"))
    # Outline: any cream pixel with an empty neighbor becomes D0.
    shell = []
    for y, xl, xr in cranium + jaw:
        for x in (xl, xr):
            shell.append((x, y))
    for x, y in shell:
        put(img, x, y, c("D0"))
    # Also seal between cranium y=17 and jaw y=18 at inner edges (so it reads closed).
    put(img, 8, 17, c("D0"))   # extra temple dot
    put(img, 23, 17, c("D0"))

    # --- Light shading on right half (light from top-left) ------------------
    for y, xl, xr in cranium + jaw:
        for x in range(15, xr):
            if img.getpixel((x, y)) == c("C4"):
                rel = (x - 15) / max(1, xr - 15)
                if rel > 0.65:
                    put(img, x, y, c("C2"))
                elif rel > 0.3:
                    put(img, x, y, c("C3"))
    # Bottom-right of jaw deeper shadow.
    for y in (21, 22, 23, 24):
        for x in range(16, 20):
            if img.getpixel((x, y)) == c("C3") or img.getpixel((x, y)) == c("C2"):
                continue
            if img.getpixel((x, y)) == c("C4"):
                put(img, x, y, c("C3"))

    # --- Eye sockets (big, square, menacing) --------------------------------
    # Left socket x=9..13 y=9..13, right socket x=17..21 y=9..13.
    fill_rect(img,  9,  9, 13, 13, c("D0"))
    fill_rect(img, 10, 10, 12, 12, c("D2"))
    put(img, 10, 10, c("D4"))         # darker upper-left corner tear
    fill_rect(img, 17,  9, 21, 13, c("D0"))
    fill_rect(img, 18, 10, 20, 12, c("D2"))
    put(img, 20, 10, c("D4"))
    # Eye socket highlight dot (one tiny glint on upper-inner rim).
    put(img, 13,  9, c("C4"))
    put(img, 17,  9, c("C4"))

    # --- Nasal cavity: inverted heart ---------------------------------------
    # Two tiny circles joined into a V.
    fill_rect(img, 14, 15, 15, 16, c("D0"))
    fill_rect(img, 16, 15, 17, 16, c("D0"))
    fill_rect(img, 15, 17, 16, 17, c("D0"))
    put(img, 15, 18, c("D0"))
    put(img, 16, 18, c("D0"))
    # Tiny inner shadow hint.
    put(img, 15, 16, c("D2"))
    put(img, 16, 16, c("D2"))

    # --- Teeth (upper row on jaw seam at y=19) ------------------------------
    # Seam line under the nasal cavity.
    hline(img, 10, 21, 19, c("D0"))
    # Four teeth separators at x=12, 14, 17, 19 leaving gaps.
    for tx in (12, 14, 17, 19):
        put(img, tx, 20, c("D0"))
    # Teeth fill (cream between separators).
    for tx in (13, 15, 16, 18, 20):
        put(img, tx, 20, c("C3"))

    # --- Chin seam (subtle vertical shadow) ---------------------------------
    put(img, 15, 23, c("C2"))
    put(img, 16, 23, c("C2"))
    put(img, 15, 24, c("D2"))
    put(img, 16, 24, c("D2"))

    # --- Cranium detail: hairline crack from top-center drifting right ------
    put(img, 15,  5, c("D2"))
    put(img, 15,  6, c("D2"))
    put(img, 16,  7, c("D2"))
    put(img, 16,  8, c("D2"))
    put(img, 17,  9, c("D2"))

    # --- Top-left highlight on cranium (single sheen) -----------------------
    put(img,  9,  7, c("O5"))
    put(img, 10,  6, c("O5"))

    return img


# ---------- COLUMN (Stability) ----------------------------------------------

def column() -> Image.Image:
    img = new_image(SZ, SZ)
    # Capital (top): 3 stacked slabs widening upward
    # Top slab y=3..5, x=6..25
    rect(img, 6, 3, 25, 5, c("D0"))
    fill_rect(img, 7, 4, 24, 4, c("C3"))
    hline(img, 7, 24, 3, c("C4"))  # top highlight
    # Mid slab y=6..7, x=8..23
    rect(img, 8, 6, 23, 7, c("D0"))
    fill_rect(img, 9, 6, 22, 7, c("B3"))  # cool stone
    hline(img, 9, 22, 6, c("C4"))
    # Volutes (spiral scrolls) on mid slab
    put(img, 9, 6, c("D0"))
    put(img, 10, 7, c("D2"))
    put(img, 22, 6, c("D0"))
    put(img, 21, 7, c("D2"))

    # Shaft y=8..25, x=11..20, with vertical flutes
    rect(img, 11, 8, 20, 25, c("D0"))
    fill_rect(img, 12, 8, 19, 25, c("C3"))
    # Flutes (vertical grooves) every 2 px
    for fx in (13, 15, 17, 19):
        vline(img, fx, 9, 24, c("B2"))
        vline(img, fx - 1, 9, 24, c("C4"))  # highlight ridge
    # Restore cream on main body between flutes (override)
    # Actually: the pattern is ridge-groove alternating. Let me redo:
    fill_rect(img, 12, 8, 19, 25, c("C3"))
    for fx in range(12, 20, 2):
        vline(img, fx, 9, 24, c("B2"))      # groove shadow
        vline(img, fx + 1, 9, 24, c("C4"))  # ridge highlight
    # Left/right edges are shadow (darker)
    vline(img, 12, 9, 24, c("B2"))
    vline(img, 19, 9, 24, c("B1"))

    # Base (bottom): 2 slabs widening downward
    # Top base slab y=26..27, x=9..22
    rect(img, 9, 26, 22, 27, c("D0"))
    fill_rect(img, 10, 26, 21, 27, c("B3"))
    hline(img, 10, 21, 26, c("C4"))
    # Bottom base slab y=28..29, x=6..25
    rect(img, 6, 28, 25, 29, c("D0"))
    fill_rect(img, 7, 28, 24, 29, c("C3"))
    hline(img, 7, 24, 28, c("C4"))

    return img


# ---------- BANNER (Control) ------------------------------------------------

def banner() -> Image.Image:
    img = new_image(SZ, SZ)
    # Staff: vertical pole x=9..10, y=3..29
    rect(img, 9, 3, 10, 29, c("D0"))
    vline(img, 9, 3, 29, c("O1"))
    vline(img, 10, 3, 29, c("O3"))
    # Staff finial (top ornament): small cross/diamond
    put(img, 9, 2, c("D0"))
    put(img, 10, 2, c("D0"))
    put(img, 9, 1, c("O4"))
    put(img, 10, 1, c("O4"))
    put(img, 8, 2, c("D0"))
    put(img, 11, 2, c("D0"))
    # Staff bottom tapered point
    put(img, 9, 30, c("D0"))
    put(img, 10, 30, c("D0"))

    # Banner cloth: extending right from staff, y=5..20, x=11..27
    # Top edge slightly curved; bottom edge forks into two tails
    # Main rectangle outline
    ban_left = 11
    ban_right = 27
    ban_top = 5
    ban_mid_y = 17
    # Outline top
    hline(img, ban_left, ban_right, ban_top, c("D0"))
    # Outline right
    vline(img, ban_right, ban_top, ban_mid_y, c("D0"))
    # Fork tails at bottom: two triangular tails
    # Left tail from x=11 to x=18 pointing to x=14,y=22
    # Right tail from x=19 to x=27 pointing to x=23,y=22
    # Tails outline
    for i in range(7):
        y = ban_mid_y + i
        # left tail: goes from (11, ban_mid_y) outline down-right to (14, 22), then up-right to (18, ban_mid_y)
        pass
    # Simpler: one V-notch cut into the bottom edge
    # Bottom outline: (11,18) -> (15,21) -> (19,18) -> (23,21) -> (27,18) or single V (15,22)
    # Draw bottom with two V-notches:
    notches = [
        [(11, 18), (13, 20), (15, 18)],
        [(15, 18), (17, 20), (19, 18)],
        [(19, 18), (21, 20), (23, 18)],
        [(23, 18), (25, 20), (27, 18)],
    ]
    # That looks too busy. Let me do simpler: one big V tail.
    # Bottom outline points: (11,18) down-right to (14,22) up-right to (18,18) down-right to (22,22) up-right to (27,18)
    # Two fish-tail forks:
    def line_outline(p0, p1):
        x0, y0 = p0
        x1, y1 = p1
        steps = max(abs(x1 - x0), abs(y1 - y0))
        for s in range(steps + 1):
            t = s / max(steps, 1)
            x = round(x0 + (x1 - x0) * t)
            y = round(y0 + (y1 - y0) * t)
            put(img, x, y, c("D0"))

    line_outline((11, 18), (14, 21))
    line_outline((14, 21), (18, 18))
    line_outline((18, 18), (22, 21))
    line_outline((22, 21), (27, 18))

    # Fill banner interior with R3
    # Flood-fill-ish: scan between top outline and bottom outline
    for y in range(ban_top + 1, 22):
        for x in range(ban_left + 1, ban_right):
            # check if inside: simple approx using the fork geometry
            if y < 18:
                fill = True
            elif y == 18:
                # On the shoulder line
                fill = (x not in (14, 18, 22, 27))  # avoid outline crossings
            elif y == 19:
                # Inside only in parts above the V-slopes
                in_left = 12 <= x <= 13 or 15 <= x <= 17 or 19 <= x <= 21 or 23 <= x <= 26
                fill = in_left
            elif y == 20:
                in_left = x == 13 or x in (16, 17) or x == 21 or x in (24, 25, 26)
                fill = in_left
            elif y == 21:
                fill = False
            else:
                fill = False
            if fill and img.getpixel((x, y)) == (0, 0, 0, 0):
                put(img, x, y, c("R3"))

    # Shade banner: darker red toward bottom, highlight at top
    # Top highlight row
    hline(img, ban_left + 1, ban_right - 1, ban_top + 1, c("R4"))
    # Darker shadow on second-to-last content row
    hline(img, ban_left + 1, ban_right - 1, 17, c("R2"))

    # Gold emblem in center of banner (a stepped sun/diamond)
    # Simple gold diamond at (18, 11)
    ex, ey = 18, 11
    put(img, ex, ey - 2, c("O4"))
    put(img, ex - 1, ey - 1, c("O4")); put(img, ex, ey - 1, c("O5")); put(img, ex + 1, ey - 1, c("O4"))
    put(img, ex - 2, ey, c("O4")); put(img, ex - 1, ey, c("O5")); put(img, ex, ey, c("O5")); put(img, ex + 1, ey, c("O5")); put(img, ex + 2, ey, c("O4"))
    put(img, ex - 1, ey + 1, c("O4")); put(img, ex, ey + 1, c("O5")); put(img, ex + 1, ey + 1, c("O4"))
    put(img, ex, ey + 2, c("O4"))
    # outline the diamond
    for off in range(3):
        put(img, ex - 3 + off, ey - (2 - off), c("D0"))
        put(img, ex + 3 - off, ey - (2 - off), c("D0"))
        put(img, ex - 3 + off, ey + (2 - off), c("D0"))
        put(img, ex + 3 - off, ey + (2 - off), c("D0"))

    return img


# ---------- Orchestration ---------------------------------------------------

ICONS = {
    "stat_influence.png": crown,
    "stat_resources.png": chalice,
    "stat_crisis.png": skull,
    "stat_stability.png": column,
    "stat_control.png": banner,
}


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for filename, factory in ICONS.items():
        img = factory()
        path = OUT_DIR / filename
        img.save(path)
        print(f"Wrote {path}")


if __name__ == "__main__":
    generate()
