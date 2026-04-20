"""Generate 24x24 biome icons for the 12 regions.

Each region in data/regions.json maps to a distinctive silhouette drawn
inside its polygon on the world map. Icons use the Ashen Fresco palette
and are designed to read at small scale against darkened land fills.

Naming convention: biome_<archetype>.png

Regions -> biome mapping (see region_map.gd BIOME_BY_REGION):
  r01 Northern Arcology -> arcology
  r02 Coastal Spires    -> coast
  r03 Ashen Plains      -> wasteland
  r04 Frozen Wastes     -> tundra
  r05 Rustbelt Hubs     -> factory
  r06 Silica Valley     -> tech
  r07 Cradle of Ruins   -> ruins
  r08 The Veil          -> veil
  r09 Southern Drylands -> drylands
  r10 Sunken Archipelago-> islands
  r11 Deep Equator      -> jungle
  r12 Scorched Peaks    -> volcano
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import (fill_rect, hline, new_image, put, rect,
                        stepped_triangle, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "map"
SZ = 24


def _outline(img):
    """Add 1-pixel D0 outline around every non-transparent pixel (8-neighbor)."""
    w, h = img.size
    src = img.copy()
    for y in range(h):
        for x in range(w):
            if src.getpixel((x, y))[3] == 0:
                has_neighbor = False
                for dy in (-1, 0, 1):
                    for dx in (-1, 0, 1):
                        if dx == 0 and dy == 0:
                            continue
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < w and 0 <= ny < h and src.getpixel((nx, ny))[3] > 0:
                            has_neighbor = True
                            break
                    if has_neighbor:
                        break
                if has_neighbor:
                    put(img, x, y, c("D0"))
    return img


# ---------- arcology: three tall spires (frozen city) -----------------------

def arcology() -> Image.Image:
    img = new_image(SZ, SZ)
    # Ground line
    hline(img, 4, 19, 20, c("B2"))
    hline(img, 4, 19, 21, c("B1"))
    # Center tallest spire
    fill_rect(img, 11, 4, 12, 20, c("B3"))
    put(img, 11, 3, c("B3")); put(img, 12, 3, c("B3"))
    put(img, 11, 2, c("C4"))  # top highlight
    put(img, 11, 4, c("C4"))  # highlight ridge
    # Left spire
    fill_rect(img, 6, 8, 7, 20, c("B2"))
    put(img, 6, 7, c("B2")); put(img, 7, 7, c("B2"))
    put(img, 6, 9, c("C3"))
    # Right spire
    fill_rect(img, 16, 10, 17, 20, c("B2"))
    put(img, 16, 9, c("B2")); put(img, 17, 9, c("B2"))
    put(img, 16, 11, c("C3"))
    # Snow flakes (dots)
    put(img, 4, 5, c("C4"))
    put(img, 20, 12, c("C4"))
    put(img, 3, 13, c("B3"))
    put(img, 19, 6, c("B3"))
    _outline(img)
    return img


# ---------- coast: lighthouse on rock + wave --------------------------------

def coast() -> Image.Image:
    img = new_image(SZ, SZ)
    # Rock base
    fill_rect(img, 9, 15, 14, 17, c("C1"))
    put(img, 8, 16, c("C1")); put(img, 15, 16, c("C1"))
    # Lighthouse body
    fill_rect(img, 10, 7, 13, 14, c("C4"))
    # Red stripes
    hline(img, 10, 13, 9, c("R3"))
    hline(img, 10, 13, 12, c("R3"))
    # Lantern housing
    fill_rect(img, 10, 5, 13, 6, c("O4"))
    # Cap (dome)
    fill_rect(img, 9, 4, 14, 4, c("O3"))
    put(img, 11, 3, c("O3")); put(img, 12, 3, c("O3"))
    # Light beam (dots)
    put(img, 15, 5, c("O5"))
    put(img, 17, 5, c("O4"))
    put(img, 7, 5, c("O5"))
    put(img, 5, 5, c("O4"))
    # Wave below
    for i in range(0, 24, 2):
        put(img, i, 20, c("B2"))
        put(img, i + 1, 21, c("B2"))
    hline(img, 0, 23, 22, c("B1"))
    _outline(img)
    return img


# ---------- wasteland: dead twisted tree + ash ------------------------------

def wasteland() -> Image.Image:
    img = new_image(SZ, SZ)
    # Ground ash
    for x in range(2, 22):
        put(img, x, 20, c("C1"))
        if x % 3 == 0:
            put(img, x, 21, c("D4"))
    # Trunk
    vline(img, 12, 9, 20, c("D4"))
    vline(img, 13, 10, 20, c("D3"))
    # Branches (twisted)
    put(img, 11, 12, c("D4")); put(img, 10, 11, c("D4")); put(img, 9, 10, c("D4"))
    put(img, 8, 10, c("D4")); put(img, 7, 11, c("D4"))
    put(img, 14, 9, c("D4")); put(img, 15, 8, c("D4")); put(img, 16, 9, c("D4"))
    put(img, 17, 10, c("D4"))
    # Small twig ends
    put(img, 6, 12, c("D4"))
    put(img, 17, 11, c("D4"))
    # Ash particles floating
    put(img, 5, 4, c("C2"))
    put(img, 19, 6, c("C2"))
    put(img, 15, 3, c("C3"))
    _outline(img)
    return img


# ---------- tundra: triangular mountain + snow ------------------------------

def tundra() -> Image.Image:
    img = new_image(SZ, SZ)
    # Mountain triangle outline + fill
    # Left slope: (4,20) -> (12,4)
    # Right slope: (12,4) -> (20,20)
    # Fill mountain
    for y in range(4, 21):
        t = (y - 4) / 16.0
        left = int(round(12 - t * 8))
        right = int(round(12 + t * 8))
        fill_rect(img, left, y, right, y, c("B1"))
        put(img, left, y, c("B2"))      # left edge highlight
        put(img, right, y, c("D2"))     # right edge shadow
    # Snowy cap
    for y in range(4, 9):
        t = (y - 4) / 5.0
        left = int(round(12 - t * 2.5))
        right = int(round(12 + t * 2.5))
        fill_rect(img, left, y, right, y, c("C4"))
    # Snow flakes
    put(img, 3, 6, c("C4"))
    put(img, 21, 10, c("C4"))
    put(img, 2, 14, c("C3"))
    put(img, 22, 17, c("C3"))
    _outline(img)
    return img


# ---------- factory: smokestack + plume ------------------------------------

def factory() -> Image.Image:
    img = new_image(SZ, SZ)
    # Base building
    fill_rect(img, 4, 14, 20, 20, c("O1"))
    # Roof line
    hline(img, 4, 20, 13, c("O2"))
    # Windows (dark squares)
    for wx in (6, 10, 14, 18):
        fill_rect(img, wx, 16, wx + 1, 17, c("D1"))
        put(img, wx, 16, c("O4"))  # tiny glow
    # Smokestack
    fill_rect(img, 9, 5, 11, 13, c("O2"))
    vline(img, 9, 5, 13, c("O3"))   # highlight
    # Stack top band
    hline(img, 8, 12, 5, c("O1"))
    # Smoke plume (puffs)
    put(img, 10, 3, c("C2"))
    put(img, 9, 2, c("C2")); put(img, 11, 2, c("C2"))
    put(img, 8, 1, c("C3")); put(img, 10, 1, c("C3")); put(img, 12, 1, c("C3"))
    put(img, 13, 3, c("C1"))
    put(img, 14, 2, c("C2"))
    _outline(img)
    return img


# ---------- tech: circuit pattern ------------------------------------------

def tech() -> Image.Image:
    img = new_image(SZ, SZ)
    # Base PCB background (subtle)
    fill_rect(img, 4, 4, 19, 19, c("G1"))
    # Circuit traces (gold)
    hline(img, 5, 18, 6, c("O3"))
    hline(img, 5, 18, 17, c("O3"))
    vline(img, 7, 6, 17, c("O3"))
    vline(img, 16, 6, 17, c("O3"))
    # Central chip
    fill_rect(img, 10, 10, 13, 13, c("D2"))
    rect(img, 10, 10, 13, 13, c("O3"))
    # Pins
    put(img, 9, 11, c("O4")); put(img, 9, 12, c("O4"))
    put(img, 14, 11, c("O4")); put(img, 14, 12, c("O4"))
    put(img, 11, 9, c("O4")); put(img, 12, 9, c("O4"))
    put(img, 11, 14, c("O4")); put(img, 12, 14, c("O4"))
    # Corner diodes
    put(img, 5, 5, c("R3")); put(img, 18, 5, c("R3"))
    put(img, 5, 18, c("G3")); put(img, 18, 18, c("G3"))
    _outline(img)
    return img


# ---------- ruins: broken column fragments ---------------------------------

def ruins() -> Image.Image:
    img = new_image(SZ, SZ)
    # Ground line
    hline(img, 2, 21, 20, c("C1"))
    hline(img, 2, 21, 21, c("D4"))
    # Standing column (left) - partial
    fill_rect(img, 6, 7, 8, 20, c("C3"))
    vline(img, 6, 7, 20, c("C4"))
    vline(img, 8, 7, 20, c("C1"))
    # Broken top (jagged)
    put(img, 6, 6, c("C3")); put(img, 7, 5, c("C3"))
    # Capital base line
    hline(img, 5, 9, 9, c("C1"))
    # Fallen column segments
    fill_rect(img, 11, 18, 18, 19, c("C3"))
    hline(img, 11, 18, 18, c("C4"))
    # Broken piece standing upright (half column)
    fill_rect(img, 15, 14, 16, 17, c("C3"))
    vline(img, 15, 14, 17, c("C4"))
    put(img, 15, 13, c("C3"))   # jagged break
    # Rubble chunks
    put(img, 12, 19, c("C3"))
    put(img, 19, 19, c("C3"))
    put(img, 20, 19, c("C1"))
    put(img, 3, 19, c("C1"))
    _outline(img)
    return img


# ---------- veil: closed eye with eyelashes --------------------------------

def veil() -> Image.Image:
    img = new_image(SZ, SZ)
    # Almond eye outline — centered closed eye
    # Upper lid curve (14 wide, subtle arc)
    curve = [(5, 13), (6, 12), (7, 11), (9, 10), (11, 10),
             (13, 10), (15, 11), (17, 12), (18, 13)]
    for x, y in curve:
        put(img, x, y, c("C3"))
    # Lower lid
    lower = [(5, 13), (6, 14), (7, 14), (9, 15), (11, 15),
             (13, 15), (15, 14), (17, 14), (18, 13)]
    for x, y in lower:
        put(img, x, y, c("C3"))
    # Fill inside (shadow)
    fill_rect(img, 7, 12, 16, 13, c("D2"))
    # Eyelashes (upper)
    put(img, 7, 9, c("D0")); put(img, 9, 8, c("D0"))
    put(img, 11, 8, c("D0")); put(img, 13, 8, c("D0"))
    put(img, 15, 9, c("D0"))
    # Slit of gold (hint of something watching)
    put(img, 11, 12, c("O4"))
    put(img, 12, 12, c("O5"))
    # Mist / veil strands
    hline(img, 2, 21, 3, c("C1"))
    for x in range(2, 22, 3):
        put(img, x, 4, c("C2"))
    _outline(img)
    return img


# ---------- drylands: dune + cactus ----------------------------------------

def drylands() -> Image.Image:
    img = new_image(SZ, SZ)
    # Large dune
    for y in range(12, 21):
        t = (y - 12) / 9.0
        left = int(round(2 - t * 0))
        right = int(round(22 + t * 0))
        fill_rect(img, left, y, right, y, c("O2"))
    # Dune highlight ridge
    for x in range(4, 20):
        put(img, x, 12, c("O4"))
    # Cactus
    fill_rect(img, 13, 8, 14, 17, c("G2"))
    vline(img, 13, 8, 17, c("G3"))
    # Cactus arms
    fill_rect(img, 11, 10, 12, 12, c("G2"))
    fill_rect(img, 15, 9, 16, 12, c("G2"))
    # Cactus arm connects
    put(img, 12, 10, c("G2"))
    put(img, 15, 10, c("G2"))
    # Sun dots (suggest heat)
    put(img, 5, 5, c("O5"))
    put(img, 19, 4, c("O5"))
    _outline(img)
    return img


# ---------- islands: three small island shapes -----------------------------

def islands() -> Image.Image:
    img = new_image(SZ, SZ)
    # Water ripples top/bottom
    for x in range(1, 23, 2):
        put(img, x, 3, c("B2"))
        put(img, x + 1, 20, c("B2"))
    # Island 1 (left)
    fill_rect(img, 3, 12, 8, 14, c("O2"))
    hline(img, 3, 8, 12, c("O4"))
    fill_rect(img, 5, 9, 6, 11, c("G2"))   # palm cluster
    # Island 2 (center, bigger)
    fill_rect(img, 9, 10, 15, 13, c("O2"))
    hline(img, 9, 15, 10, c("O4"))
    fill_rect(img, 11, 6, 12, 9, c("G2"))
    put(img, 10, 7, c("G2")); put(img, 13, 7, c("G2"))
    # Island 3 (right, small)
    fill_rect(img, 17, 14, 21, 16, c("O2"))
    hline(img, 17, 21, 14, c("O4"))
    put(img, 19, 13, c("G2"))
    # Water between
    for x in range(2, 23, 3):
        put(img, x, 18, c("B2"))
    _outline(img)
    return img


# ---------- jungle: palm tree + foliage ------------------------------------

def jungle() -> Image.Image:
    img = new_image(SZ, SZ)
    # Ground
    hline(img, 2, 21, 20, c("G1"))
    hline(img, 2, 21, 21, c("G2"))
    # Trunk (curved)
    trunk = [(13, 19), (13, 18), (13, 17), (12, 16), (12, 15),
             (12, 14), (11, 13), (11, 12), (11, 11), (10, 10)]
    for x, y in trunk:
        put(img, x, y, c("O1"))
        put(img, x + 1, y, c("O2"))
    # Fronds (radiating from top)
    for (dx, dy) in [(-5, -2), (-5, 0), (-5, 2), (-3, -4), (-2, 4),
                     (2, -4), (2, 4), (5, -2), (5, 0), (5, 2)]:
        # Draw a small palm blade from top at (10,10)
        x, y = 10, 10
        for i in range(3):
            nx = x + int(round(dx * (i + 1) / 3))
            ny = y + int(round(dy * (i + 1) / 3))
            if 0 <= nx < SZ and 0 <= ny < SZ:
                put(img, nx, ny, c("G2"))
        # Tip
        tx = x + dx
        ty = y + dy
        if 0 <= tx < SZ and 0 <= ty < SZ:
            put(img, tx, ty, c("G3"))
    # Coconut dots
    put(img, 11, 10, c("D4"))
    put(img, 9, 11, c("D4"))
    # Tiny second bush in background
    fill_rect(img, 18, 16, 20, 19, c("G2"))
    put(img, 19, 15, c("G3"))
    _outline(img)
    return img


# ---------- volcano: cone + lava plume -------------------------------------

def volcano() -> Image.Image:
    img = new_image(SZ, SZ)
    # Cone
    for y in range(8, 21):
        t = (y - 8) / 13.0
        left = int(round(12 - t * 9))
        right = int(round(12 + t * 9))
        fill_rect(img, left, y, right, y, c("D2"))
        put(img, left, y, c("D3"))
        put(img, right, y, c("D4"))
    # Crater top (dark notch)
    hline(img, 9, 15, 8, c("D0"))
    put(img, 10, 7, c("D0")); put(img, 14, 7, c("D0"))
    # Lava in crater
    fill_rect(img, 10, 8, 14, 8, c("R4"))
    # Lava flow down the side
    put(img, 12, 9, c("R4"))
    put(img, 13, 10, c("R3"))
    put(img, 14, 11, c("R3"))
    put(img, 15, 12, c("R2"))
    # Smoke plume
    put(img, 10, 6, c("D4"))
    put(img, 12, 5, c("D4")); put(img, 14, 5, c("D4"))
    put(img, 11, 4, c("C1")); put(img, 13, 4, c("C1"))
    put(img, 12, 3, c("C2"))
    # Ember sparks
    put(img, 16, 8, c("O4"))
    put(img, 8, 10, c("O4"))
    _outline(img)
    return img


BIOMES = {
    "biome_arcology.png": arcology,
    "biome_coast.png": coast,
    "biome_wasteland.png": wasteland,
    "biome_tundra.png": tundra,
    "biome_factory.png": factory,
    "biome_tech.png": tech,
    "biome_ruins.png": ruins,
    "biome_veil.png": veil,
    "biome_drylands.png": drylands,
    "biome_islands.png": islands,
    "biome_jungle.png": jungle,
    "biome_volcano.png": volcano,
}


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for filename, factory_fn in BIOMES.items():
        img = factory_fn()
        path = OUT_DIR / filename
        img.save(path)
        print(f"Wrote {path}")


if __name__ == "__main__":
    generate()
