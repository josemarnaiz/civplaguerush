"""Generate 48x48 event category icons.

Each icon maps one or more event ids (see data/events.json) to an icon.
The run_scene script applies the mapping via EVENT_ICON_BY_ID in the
scripts side; keep this list in sync with that mapping.

Event archetypes:
  outbreak    -> pandemic_wave, outbreak_focus
  famine      -> food_shortage
  uprising    -> border_uprising, frontier_uprising
  espionage   -> info_leak, defector_cell
  opportunity -> golden_opportunity
  relief      -> relief_mission
  sabotage    -> sabotage_strike
  science     -> cure_trial
  migration   -> mass_migration
"""
from __future__ import annotations

import math
from pathlib import Path

from PIL import Image

from palette import c
from primitives import (fill_rect, hline, new_image, put, rect,
                        stepped_triangle, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "events"
SZ = 48


def _put_circle(img, cx, cy, r, color):
    for y in range(cy - r - 1, cy + r + 2):
        for x in range(cx - r - 1, cx + r + 2):
            if 0 <= x < img.width and 0 <= y < img.height:
                d = (x - cx) ** 2 + (y - cy) ** 2
                if d <= r * r:
                    put(img, x, y, color)


def _ring(img, cx, cy, r, color, thickness=1):
    """Filled ring: r_outer=r, r_inner=r-thickness."""
    r_out = r * r
    r_in = (r - thickness) * (r - thickness)
    for y in range(cy - r - 1, cy + r + 2):
        for x in range(cx - r - 1, cx + r + 2):
            if 0 <= x < img.width and 0 <= y < img.height:
                d = (x - cx) ** 2 + (y - cy) ** 2
                if r_in < d <= r_out:
                    put(img, x, y, color)


def _outline(img, color_key="D0"):
    w, h = img.size
    src = img.copy()
    col = c(color_key)
    for y in range(h):
        for x in range(w):
            if src.getpixel((x, y))[3] == 0:
                has = False
                for dy in (-1, 0, 1):
                    for dx in (-1, 0, 1):
                        if dx == 0 and dy == 0:
                            continue
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < w and 0 <= ny < h and src.getpixel((nx, ny))[3] > 0:
                            has = True
                            break
                    if has:
                        break
                if has:
                    put(img, x, y, col)


def _frame(img):
    """Add art-deco corner ornaments so the event icon feels like its own cartouche."""
    # Corner stepped triangles (3x3 L-shape pointing to corner)
    for (ox, oy, dx, dy) in [(1, 1, 1, 1), (SZ - 2, 1, -1, 1),
                              (1, SZ - 2, 1, -1), (SZ - 2, SZ - 2, -1, -1)]:
        put(img, ox, oy, c("O3"))
        put(img, ox + dx, oy, c("O3"))
        put(img, ox, oy + dy, c("O3"))


# ---------- outbreak: biohazard trefoil -------------------------------------

def outbreak() -> Image.Image:
    img = new_image(SZ, SZ)
    cx, cy = 24, 25
    # Three blades first, then the inner gap circle cuts through them.
    blades = []
    for angle_deg in (-90, 30, 150):
        ang = math.radians(angle_deg)
        bx = int(round(cx + math.cos(ang) * 12))
        by = int(round(cy + math.sin(ang) * 12))
        blades.append((bx, by, ang))
        _put_circle(img, bx, by, 7, c("R3"))
        _put_circle(img, bx, by, 5, c("R4"))
    # Central dark disc (the gap between blades) — punches through blades.
    for y in range(cy - 9, cy + 10):
        for x in range(cx - 9, cx + 10):
            dx = x - cx; dy = y - cy
            d = dx * dx + dy * dy
            if d <= 56:
                # Clear to transparent if in this inner zone
                img.putpixel((x, y), (0, 0, 0, 0))
    # Central inner ring
    _put_circle(img, cx, cy, 4, c("D2"))
    _put_circle(img, cx, cy, 3, c("R4"))
    _put_circle(img, cx, cy, 1, c("O5"))
    # Re-draw blades with inner notch toward center to create trefoil "ears".
    for bx, by, ang in blades:
        # Tiny notch between blade and center (dark triangle)
        notch_x = int(round(cx + math.cos(ang) * 7))
        notch_y = int(round(cy + math.sin(ang) * 7))
        put(img, notch_x, notch_y, c("D1"))
    _outline(img)
    _frame(img)
    return img


# ---------- famine: empty bowl + wheat -------------------------------------

def famine() -> Image.Image:
    img = new_image(SZ, SZ)
    cx, cy = 24, 28
    r = 13
    # Bowl (filled semicircle open upward) in ceramic cream
    for y in range(cy - 2, cy + r + 1):
        for x in range(cx - r, cx + r + 1):
            d = (x - cx) ** 2 + (y - cy) ** 2
            if d <= r * r:
                if y >= cy:
                    if d >= (r - 3) * (r - 3):
                        put(img, x, y, c("C3"))
                    else:
                        put(img, x, y, c("C4"))  # inside wall
    # Inside shadow (bowl is empty — dark pit)
    for y in range(cy + 1, cy + r - 1):
        for x in range(cx - r + 4, cx + r - 3):
            d = (x - cx) ** 2 + (y - cy) ** 2
            if d <= (r - 4) * (r - 4):
                put(img, x, y, c("D2"))
    # Rim (gold band)
    hline(img, cx - r, cx + r, cy - 2, c("O3"))
    hline(img, cx - r, cx + r, cy - 1, c("O2"))
    # Dust motes rising from empty bowl
    put(img, cx - 4, cy + 2, c("C1"))
    put(img, cx + 5, cy + 4, c("C1"))
    # Withered wheat stalks leaning (symbolic of lost harvest)
    stalks = [(15, 7, -1), (24, 4, 0), (33, 7, 1)]
    for sx, sy, lean in stalks:
        # Stalk (7 tall, slightly leaning)
        for h in range(9):
            lx = sx + (h * lean) // 3
            put(img, lx, sy + h, c("O2"))
            put(img, lx, sy + h + 1, c("O1"))
        # Leaves
        lx0 = sx + (3 * lean) // 3
        put(img, lx0 - 2, sy + 4, c("G1"))
        put(img, lx0 + 2, sy + 6, c("G1"))
        # Head (empty / broken)
        head_x = sx
        put(img, head_x, sy - 1, c("O2"))
        put(img, head_x - 1, sy, c("O2"))
        put(img, head_x + 1, sy, c("O2"))
        put(img, head_x, sy + 1, c("O3"))
        # Falling grains
        put(img, head_x + 2 + lean, sy + 2, c("O1"))
    _outline(img)
    _frame(img)
    return img


# ---------- uprising: flag + raised fist silhouette ------------------------

def uprising() -> Image.Image:
    img = new_image(SZ, SZ)
    # Flag pole
    vline(img, 20, 8, 40, c("D4"))
    vline(img, 21, 8, 40, c("D3"))
    # Flag (tattered, red, angled)
    for y in range(8, 20):
        for x in range(21, 38):
            # Tattered right edge
            noise = (x + y * 3) % 5
            if x <= 36 - (noise // 2) and x > 21:
                t = (x - 21) / 15.0
                if y > 8 + t * 3:
                    put(img, x, y, c("R3"))
                    if y == 9 or x == 22:
                        put(img, x, y, c("R4"))
    # Emblem on flag (black circle)
    _put_circle(img, 28, 13, 2, c("D0"))
    # Raised fist at base of pole
    # Arm
    fill_rect(img, 18, 30, 22, 38, c("C2"))
    vline(img, 18, 30, 38, c("C3"))
    # Fist
    fill_rect(img, 15, 26, 23, 31, c("C3"))
    vline(img, 15, 26, 31, c("C4"))
    # Knuckle lines
    put(img, 16, 27, c("D4")); put(img, 19, 27, c("D4"))
    # Thumb
    put(img, 23, 28, c("C3"))
    put(img, 24, 28, c("C3"))
    # Wrist band
    hline(img, 18, 22, 32, c("O3"))
    _outline(img)
    _frame(img)
    return img


# ---------- espionage: watchful eye -----------------------------------------

def espionage() -> Image.Image:
    img = new_image(SZ, SZ)
    cx, cy = 24, 24
    # Almond eye shape — wider than tall
    # Parametric: two arcs meeting at (cx-15, cy) and (cx+15, cy)
    for y in range(cy - 9, cy + 10):
        for x in range(cx - 16, cx + 17):
            dx = (x - cx) / 15.0
            dy = (y - cy) / 8.0
            d = dx * dx + dy * dy
            if d <= 1.0:
                put(img, x, y, c("C4"))
            elif d <= 1.12:
                put(img, x, y, c("C3"))
    # Iris (gold)
    _put_circle(img, cx, cy, 7, c("O3"))
    _put_circle(img, cx, cy, 5, c("O4"))
    _ring(img, cx, cy, 7, c("O2"), 1)
    # Pupil
    _put_circle(img, cx, cy, 3, c("D0"))
    # Catchlight
    put(img, cx - 2, cy - 2, c("C4"))
    put(img, cx - 1, cy - 2, c("O5"))
    # Upper lid shadow
    for x in range(cx - 14, cx + 15):
        dx_n = (x - cx) / 14.0
        top_y = cy - int(round(8 * math.sqrt(max(0.0, 1.0 - dx_n * dx_n))))
        if top_y >= 0:
            put(img, x, top_y, c("D2"))
            if top_y + 1 < SZ:
                put(img, x, top_y + 1, c("D3"))
    # Brow above (arc of short strokes)
    brow_pts = [(-12, -12), (-9, -13), (-5, -14), (0, -14), (5, -14), (9, -13), (12, -12)]
    for dx, dy in brow_pts:
        put(img, cx + dx, cy + dy, c("D2"))
        put(img, cx + dx, cy + dy + 1, c("D2"))
    _outline(img)
    _frame(img)
    return img


# ---------- opportunity: coin with crown mark ------------------------------

def opportunity() -> Image.Image:
    img = new_image(SZ, SZ)
    cx, cy = 24, 24
    # Coin
    _put_circle(img, cx, cy, 14, c("O2"))
    _put_circle(img, cx, cy, 12, c("O3"))
    _ring(img, cx, cy, 13, c("O4"), 1)
    _ring(img, cx, cy, 10, c("O4"), 1)
    # Emboss a little crown: 3 triangles inside
    # Base line
    hline(img, cx - 6, cx + 6, cy + 4, c("O1"))
    # Crown tines (stepped triangles)
    for i, tx in enumerate((cx - 5, cx, cx + 5)):
        h = 4 if i == 1 else 3
        for dy in range(h):
            w = h - dy - 1
            for dx in range(-w, w + 1):
                put(img, tx + dx, cy + 3 - dy, c("O1"))
    # Gem in center tine
    put(img, cx, cy + 1, c("R4"))
    # Sparkles outside
    put(img, 6, 10, c("O5")); put(img, 7, 9, c("O5"))
    put(img, 40, 36, c("O5")); put(img, 41, 37, c("O5"))
    put(img, 8, 38, c("O4"))
    _outline(img)
    _frame(img)
    return img


# ---------- relief: heart held in cupped hands -----------------------------

def relief() -> Image.Image:
    img = new_image(SZ, SZ)
    # Two cupped hands forming a bowl (bottom of image)
    # Left palm
    for y in range(24, 38):
        for x in range(6, 24):
            dx = (x - 16) / 10.0
            dy = (y - 30) / 7.0
            d = dx * dx + dy * dy
            if d <= 1.0 and x <= 24 and y >= 26:
                put(img, x, y, c("C3"))
            elif d <= 1.15 and y >= 26:
                put(img, x, y, c("C2"))
    # Right palm
    for y in range(24, 38):
        for x in range(24, 42):
            dx = (x - 32) / 10.0
            dy = (y - 30) / 7.0
            d = dx * dx + dy * dy
            if d <= 1.0 and y >= 26:
                put(img, x, y, c("C3"))
            elif d <= 1.15 and y >= 26:
                put(img, x, y, c("C2"))
    # Highlight on palms
    hline(img, 9, 22, 27, c("C4"))
    hline(img, 26, 39, 27, c("C4"))
    # Thumb hints
    put(img, 22, 24, c("C3")); put(img, 23, 24, c("C3"))
    put(img, 24, 24, c("C3")); put(img, 25, 24, c("C3"))
    # Heart above hands
    # Heart made from two circles + triangle base
    _put_circle(img, 20, 18, 5, c("R3"))
    _put_circle(img, 28, 18, 5, c("R3"))
    # Triangle down
    for y in range(18, 28):
        t = (y - 18) / 10.0
        half_w = int(round(8 * (1.0 - t)))
        for x in range(24 - half_w, 24 + half_w + 1):
            put(img, x, y, c("R3"))
    # Heart highlights
    _put_circle(img, 19, 16, 2, c("R4"))
    _put_circle(img, 27, 16, 1, c("R4"))
    put(img, 18, 15, c("O5"))   # shine dot
    # Glow sparkles around heart
    put(img, 10, 10, c("O4")); put(img, 11, 11, c("O5"))
    put(img, 38, 8, c("O4")); put(img, 37, 9, c("O5"))
    put(img, 32, 6, c("O5"))
    put(img, 16, 6, c("O4"))
    _outline(img)
    _frame(img)
    return img


# ---------- sabotage: cracked target ---------------------------------------

def sabotage() -> Image.Image:
    img = new_image(SZ, SZ)
    cx, cy = 24, 24
    # Target rings
    _ring(img, cx, cy, 16, c("C3"), 2)
    _ring(img, cx, cy, 12, c("R3"), 2)
    _ring(img, cx, cy, 8, c("C3"), 2)
    _put_circle(img, cx, cy, 4, c("R4"))
    _put_circle(img, cx, cy, 2, c("D0"))
    # Crack running diagonally
    crack = [(16, 10), (17, 11), (18, 13), (19, 15), (20, 17),
             (22, 19), (23, 22), (25, 25), (27, 28), (28, 30),
             (30, 32), (31, 34), (33, 36)]
    for x, y in crack:
        put(img, x, y, c("D0"))
        put(img, x + 1, y, c("D0"))
    # Small jagged offshoots
    put(img, 21, 20, c("D0"))
    put(img, 26, 24, c("D0"))
    # Shards flying
    put(img, 8, 30, c("C2")); put(img, 7, 31, c("C2"))
    put(img, 40, 14, c("C2")); put(img, 41, 15, c("C2"))
    _outline(img)
    _frame(img)
    return img


# ---------- science: flask with bubbles ------------------------------------

def science() -> Image.Image:
    img = new_image(SZ, SZ)
    # Flask shape (triangle flask) — neck at top, wide base
    # Neck
    fill_rect(img, 21, 6, 27, 12, c("C4"))
    # Rim
    hline(img, 20, 28, 6, c("O3"))
    hline(img, 20, 28, 7, c("C3"))
    # Body (triangular flask)
    for y in range(12, 40):
        t = (y - 12) / 28.0
        half_w = int(round(3 + t * 12))
        for x in range(24 - half_w, 24 + half_w + 1):
            # Liquid fills lower 65%
            if y >= 22:
                put(img, x, y, c("G2"))  # glowing green potion
            else:
                put(img, x, y, c("C4"))
        # Glass edges
        put(img, 24 - half_w, y, c("C1"))
        put(img, 24 + half_w, y, c("C1"))
    # Liquid surface highlight
    hline(img, 16, 32, 22, c("G3"))
    # Bubbles
    _put_circle(img, 22, 30, 1, c("G3"))
    _put_circle(img, 26, 34, 1, c("G3"))
    _put_circle(img, 20, 36, 1, c("G3"))
    # Steam/vapor
    put(img, 22, 4, c("C2"))
    put(img, 24, 3, c("C3"))
    put(img, 26, 4, c("C2"))
    put(img, 23, 2, c("C3"))
    _outline(img)
    _frame(img)
    return img


# ---------- migration: caravan arrow over dunes ----------------------------

def migration() -> Image.Image:
    img = new_image(SZ, SZ)
    # Dune background
    for y in range(28, 42):
        t = (y - 28) / 14.0
        half_w = int(round(18 + t * 6))
        for x in range(24 - half_w, 24 + half_w + 1):
            put(img, x, y, c("O2"))
    # Dune ridge
    hline(img, 6, 42, 28, c("O4"))
    # Three walking figures (silhouettes)
    figures_x = [14, 22, 30]
    for i, fx in enumerate(figures_x):
        # Head
        _put_circle(img, fx, 24, 2, c("D2"))
        # Body
        vline(img, fx, 26, 33, c("D2"))
        # Pack on back
        fill_rect(img, fx - 2, 27, fx - 1, 30, c("D3"))
        # Legs stride
        stride_l = 1 if i % 2 == 0 else -1
        put(img, fx - 1, 34, c("D2")); put(img, fx + 1, 34, c("D2"))
        put(img, fx - 2 * stride_l, 35, c("D2"))
        put(img, fx + 2 * stride_l, 35, c("D2"))
    # Sun (gold)
    _put_circle(img, 38, 10, 4, c("O4"))
    _put_circle(img, 38, 10, 2, c("O5"))
    # Rays
    for (dx, dy) in [(0, -6), (6, 0), (0, 6), (-6, 0), (4, -4), (4, 4), (-4, 4), (-4, -4)]:
        put(img, 38 + dx, 10 + dy, c("O4"))
    # Arrow showing direction (left to right curved trail)
    for i in range(5):
        put(img, 8 + i * 2, 20 - i // 2, c("C3"))
    # Arrowhead
    put(img, 18, 19, c("C4"))
    put(img, 17, 18, c("C4")); put(img, 17, 20, c("C4"))
    _outline(img)
    _frame(img)
    return img


ICONS = {
    "event_outbreak.png": outbreak,
    "event_famine.png": famine,
    "event_uprising.png": uprising,
    "event_espionage.png": espionage,
    "event_opportunity.png": opportunity,
    "event_relief.png": relief,
    "event_sabotage.png": sabotage,
    "event_science.png": science,
    "event_migration.png": migration,
}


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for filename, factory_fn in ICONS.items():
        img = factory_fn()
        path = OUT_DIR / filename
        img.save(path)
        print(f"Wrote {path}")


if __name__ == "__main__":
    generate()
