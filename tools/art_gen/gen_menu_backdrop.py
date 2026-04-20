"""Generate the MainMenu fresco backdrop.

A 640x360 pixel art mural that gets drawn behind the title card. The mural is
composed of four parallax-friendly bands:

1. Ceiling — cracked deep-plum sky with ochre star-sparks and dripping fissures.
2. Fresco arches — five stepped art-deco sunburst arches (the decadent council
   hall), with the central arch housing a haloed silhouette of the Chancellor.
3. Middle band — a frieze of twelve pilgrim silhouettes, one per region, with
   subtle plague sores bleeding through.
4. Floor — ashen tile plane with cracks fanning out toward the camera.

The final PNG is 640x360 and is exported with nearest-neighbor scaling in mind
(Godot uses CANVAS_ITEM_TEXTURE_FILTER_NEAREST via project setting). Godot then
displays it at 1280x720 via stretch in the MainMenu scene, keeping every pixel
crunchy.
"""
from __future__ import annotations

import math
from pathlib import Path

from PIL import Image

from palette import c
from primitives import fill_rect, hline, new_image, put, rect, vline


W = 640
H = 360
OUT = Path(__file__).resolve().parents[2] / "assets" / "art" / "ui" / "menu_backdrop.png"


def _gradient_band(img: Image.Image, y0: int, y1: int, top: str, bottom: str) -> None:
    """Vertical dither gradient from `top` to `bottom` palette colors."""
    top_rgba = c(top)
    bot_rgba = c(bottom)
    span = max(1, y1 - y0)
    for y in range(y0, y1 + 1):
        t = (y - y0) / span
        mixed = tuple(int(top_rgba[i] * (1 - t) + bot_rgba[i] * t) for i in range(4))
        # 1px row fill
        for x in range(img.width):
            put(img, x, y, mixed)


def _ceiling(img: Image.Image) -> None:
    _gradient_band(img, 0, 110, "D0", "D1")
    # ochre "star-sparks" — cracked fresco specks of gilded sky
    rng_seeds = [
        (24, 14), (78, 6), (132, 22), (198, 10), (246, 28),
        (308, 16), (360, 8), (412, 24), (472, 12), (534, 26), (598, 18),
        (58, 46), (154, 38), (232, 50), (314, 40), (402, 52), (498, 36), (578, 48),
        (88, 70), (202, 78), (330, 66), (448, 74), (542, 62), (612, 82),
    ]
    for (x, y) in rng_seeds:
        put(img, x, y, c("O4"))
        put(img, x + 1, y, c("O3"))
        put(img, x, y + 1, c("O3"))
    # Dripping fissures (vertical cracks)
    for (cx, depth) in [(96, 88), (208, 60), (320, 74), (446, 92), (560, 70)]:
        for y in range(0, depth):
            jitter = int(math.sin(y * 0.55 + cx * 0.11) * 1.6)
            put(img, cx + jitter, y, c("D0"))
            put(img, cx + jitter + 1, y, c("D2"))


def _stepped_arch(img: Image.Image, cx: int, base_y: int, width: int, height: int,
                   ring: str = "O3", face: str = "D2", glow: str = "O2") -> None:
    """Art-deco stepped arch (zigurrat/sunburst), inspired by 1930s mural
    architecture. Width and height are full arch span; rendered as three
    concentric stepped frames (D2 face inside, O3 ring, O2 outer halo).
    """
    half = width // 2
    steps = 5
    step_h = max(2, height // steps)
    for s in range(steps):
        y_top = base_y - (s + 1) * step_h
        y_bot = base_y - s * step_h
        shrink = int(half * (1 - s / steps) ** 0.85)
        x0 = cx - shrink
        x1 = cx + shrink
        if s == steps - 1:
            fill = c(face)
        else:
            fill = c(glow) if s % 2 == 0 else c(face)
        fill_rect(img, x0, y_top, x1, y_bot - 1, fill)
        # ring edge
        vline(img, x0 - 1, y_top, y_bot, c(ring))
        vline(img, x1 + 1, y_top, y_bot, c(ring))
        hline(img, x0 - 1, x1 + 1, y_top - 1, c(ring))


def _central_chancellor(img: Image.Image) -> None:
    """A haloed silhouette under the central arch — the Chancellor in state."""
    cx = W // 2
    base_y = 272
    # Halo
    for r in range(30, 44):
        for a_deg in range(-95, 96, 2):
            a = math.radians(a_deg)
            x = cx + int(math.cos(a) * r)
            y = base_y - 70 + int(math.sin(a) * r * 0.6)
            put(img, x, y, c("O2"))
    for r in range(22, 32):
        for a_deg in range(-90, 91, 2):
            a = math.radians(a_deg)
            x = cx + int(math.cos(a) * r)
            y = base_y - 70 + int(math.sin(a) * r * 0.6)
            put(img, x, y, c("O3"))
    # Halo core (cream)
    for r in range(0, 20):
        for a_deg in range(-90, 91, 3):
            a = math.radians(a_deg)
            x = cx + int(math.cos(a) * r)
            y = base_y - 70 + int(math.sin(a) * r * 0.55)
            put(img, x, y, c("C3"))
    # Silhouette (robe — art-deco trapezoid)
    for i in range(60):
        y = base_y - 42 + i
        t = i / 60
        half_w = int(14 + t * 34)
        fill_rect(img, cx - half_w, y, cx + half_w, y, c("D1"))
    # Crown band
    fill_rect(img, cx - 10, base_y - 62, cx + 10, base_y - 58, c("O3"))
    for k in range(-3, 4):
        put(img, cx + k * 3, base_y - 64, c("O4"))
    # Chest sigil
    fill_rect(img, cx - 3, base_y - 30, cx + 3, base_y - 24, c("R3"))
    put(img, cx, base_y - 27, c("O5"))


def _arch_ensemble(img: Image.Image) -> None:
    base_y = 280
    # Side arches (smaller, further)
    _stepped_arch(img, 80, base_y, 110, 170, ring="O2", face="D1", glow="D2")
    _stepped_arch(img, W - 80, base_y, 110, 170, ring="O2", face="D1", glow="D2")
    # Mid arches
    _stepped_arch(img, 200, base_y, 140, 200, ring="O3", face="D2", glow="D1")
    _stepped_arch(img, W - 200, base_y, 140, 200, ring="O3", face="D2", glow="D1")
    # Central grand arch
    _stepped_arch(img, W // 2, base_y, 200, 240, ring="O3", face="D2", glow="O2")
    # Chancellor under central arch
    _central_chancellor(img)


def _pilgrim_frieze(img: Image.Image) -> None:
    """Twelve silhouettes along a low band — one per region of the council."""
    band_top = 288
    band_bot = 312
    # Base band: ashen cream stripe
    for y in range(band_top, band_bot + 1):
        t = (y - band_top) / max(1, band_bot - band_top)
        if t < 0.2:
            col = c("O2")
        elif t < 0.85:
            col = c("C2")
        else:
            col = c("C1")
        for x in range(img.width):
            put(img, x, y, col)
    # Horizontal seams (cracks) crossing the band
    for y in (band_top + 8, band_top + 14, band_top + 20):
        for x in range(0, W, 3):
            put(img, x, y, c("D2"))
    # Twelve pilgrims spaced evenly — alternating hood/tricorn silhouettes
    positions = [int(40 + i * ((W - 80) / 11)) for i in range(12)]
    for i, x in enumerate(positions):
        tall = (i % 3 == 0)
        hood = (i % 2 == 0)
        head_top = band_top - (20 if tall else 14)
        head_bot = band_top - 4
        # body (truncated trapezoid)
        for y in range(head_bot, band_bot):
            half = 3 + (y - head_bot) // 3
            fill_rect(img, x - half, y, x + half, y, c("D1"))
        # head
        for y in range(head_top, head_bot):
            half = 3
            fill_rect(img, x - half, y, x + half, y, c("D1"))
        # hood/tricorn cap
        if hood:
            put(img, x - 4, head_top, c("D2"))
            put(img, x + 4, head_top, c("D2"))
            hline(img, x - 3, x + 3, head_top - 1, c("D2"))
        else:
            hline(img, x - 5, x + 5, head_top, c("D2"))
            hline(img, x - 4, x + 4, head_top - 1, c("D2"))
        # ochre eye speck (so they "watch" you)
        put(img, x, head_top + (6 if tall else 4), c("O3"))


def _floor(img: Image.Image) -> None:
    _gradient_band(img, 312, H - 1, "D2", "D0")
    # radiating cracks on the floor from centre (art-deco vanishing point)
    cx = W // 2
    vy = 316
    for deg in range(-80, 81, 8):
        a = math.radians(deg)
        for step in range(0, 60):
            x = cx + int(math.cos(a) * step * 1.6)
            y = vy + int(math.sin(a) * step * 0.7) + step // 4
            if y < H:
                put(img, x, y, c("D1"))
                put(img, x, y + 1, c("D3"))
    # perspective floor-lines (horizontal)
    for k, y in enumerate([322, 332, 344, 356]):
        shade = c("D3") if k % 2 == 0 else c("D2")
        for x in range(img.width):
            put(img, x, y, shade)


def _corner_sunbursts(img: Image.Image) -> None:
    """Art-deco corner rays framing the mural."""
    rays = 12
    for corner in [(0, 0), (W - 1, 0), (0, H - 1), (W - 1, H - 1)]:
        cx, cy = corner
        for r in range(rays):
            t = r / rays
            length = 60
            ang_start = math.pi * (0 if cx == 0 else 1) * (0.5 if cy == 0 else -0.5)
            ang_base = 0.0
            if (cx, cy) == (0, 0):
                ang_base = 0.0
            elif (cx, cy) == (W - 1, 0):
                ang_base = math.pi * 0.5
            elif (cx, cy) == (W - 1, H - 1):
                ang_base = math.pi
            else:
                ang_base = math.pi * 1.5
            a = ang_base + (math.pi * 0.5) * (t)
            for s in range(length):
                x = cx + int(math.cos(a) * s) * (1 if cx == 0 else -1)
                y = cy + int(math.sin(a) * s) * (1 if cy == 0 else -1)
                put(img, x, y, c("O2" if r % 2 == 0 else "O1"))
    # corner tassels (small stepped triangles) — just make ornament feel
    for corner in [(0, 0), (W, 0), (0, H), (W, H)]:
        cx, cy = corner
        dx = 1 if cx == 0 else -1
        dy = 1 if cy == 0 else -1
        for i in range(8):
            length = 8 - i
            for j in range(length):
                put(img, cx + dx * (j + i), cy + dy * i, c("O3"))


def _ornamental_border(img: Image.Image) -> None:
    """Art-deco border frame: 2px inner line plus repeating zig-zag accents."""
    # outer frame
    rect(img, 1, 1, W - 2, H - 2, c("O3"))
    rect(img, 3, 3, W - 4, H - 4, c("O2"))
    # top zig-zag
    for x in range(10, W - 10, 10):
        put(img, x, 6, c("O4"))
        put(img, x + 2, 8, c("O4"))
        put(img, x + 4, 6, c("O4"))
    for x in range(10, W - 10, 10):
        put(img, x, H - 7, c("O4"))
        put(img, x + 2, H - 9, c("O4"))
        put(img, x + 4, H - 7, c("O4"))


def _central_emblem_overlay(img: Image.Image) -> None:
    """Twelve-point star emblem faintly gilded above the title area.
    Anchored so the title logo covers it, adding texture behind the text.
    """
    cx, cy = W // 2, 90
    for p in range(12):
        a = 2 * math.pi * p / 12
        for r in range(0, 28):
            x = cx + int(math.cos(a) * r)
            y = cy + int(math.sin(a) * r * 0.85)
            if r < 6:
                put(img, x, y, c("O4"))
            elif r < 14:
                put(img, x, y, c("O3"))
            elif r < 22:
                put(img, x, y, c("O2"))
    # center crown
    fill_rect(img, cx - 3, cy - 3, cx + 3, cy + 3, c("C4"))
    put(img, cx, cy, c("R3"))


def _plague_spores(img: Image.Image) -> None:
    """Sparse toxic-green spores drifting in the foreground air."""
    spots = [
        (72, 120), (118, 160), (176, 210), (230, 130), (276, 180), (340, 150),
        (380, 200), (442, 130), (500, 180), (548, 140), (596, 200),
        (90, 240), (200, 260), (312, 250), (420, 258), (530, 244),
    ]
    for (x, y) in spots:
        put(img, x, y, c("G2"))
        put(img, x + 1, y, c("G3"))
        put(img, x, y + 1, c("G1"))


def generate() -> None:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    img = new_image(W, H, c("D1"))
    _ceiling(img)
    _arch_ensemble(img)
    _pilgrim_frieze(img)
    _floor(img)
    _central_emblem_overlay(img)
    _plague_spores(img)
    _corner_sunbursts(img)
    _ornamental_border(img)
    img.save(OUT)
    print(f"  -> {OUT.relative_to(OUT.parents[3])}")


if __name__ == "__main__":
    generate()
