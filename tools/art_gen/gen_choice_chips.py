"""Generate 24x24 "tag chip" icons for choice buttons.

Each chip is a small, silhouetted emblem framed by a tarnished-gold ring so the
player can read the intent of a choice at a glance:

- tag_force       — crossed spears over a shield         (aggressive action)
- tag_diplomacy   — laurel branch wreath + dove silhouette(negotiation)
- tag_science     — retort/flask with three bubbles       (scientific investment)
- tag_sacrifice   — broken column with wisp               (accept a loss)
- tag_economy     — stacked coin with crown notch         (resource trade-off)

All chips share the same 24x24 chassis: transparent margin, gold ring with
ornamental notches at the cardinal points, and a D2 inner face that the emblem
is drawn on top of. This keeps them harmonised with the advisor medallions.
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import fill_rect, hline, new_image, put, vline


SIZE = 24
OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "icons"


def _chip_base(img: Image.Image, ring: str = "O3", face: str = "D2",
               core: str = "D1", outline: str = "D0") -> None:
    """Shared pentagonal medallion chassis: octagonal gold ring on a dark face.
    Leaves an 18x18 inner area (y=3..20) for the emblem.
    """
    # outer dark halo (for crispness on cream panels)
    for (x, y) in [(4, 1), (19, 1), (1, 4), (22, 4), (1, 19), (22, 19), (4, 22), (19, 22)]:
        put(img, x, y, c(outline))
    # gold ring (octagonal outline)
    corners = [
        (4, 2, 19, 2),   # top
        (2, 4, 2, 19),   # left
        (21, 4, 21, 19), # right
        (4, 21, 19, 21), # bottom
    ]
    for (x0, y0, x1, y1) in corners:
        hline(img, x0, x1, y0, c(ring)) if y0 == y1 else vline(img, x0, y0, y1, c(ring))
    # diagonal connectors (gold)
    for (x, y) in [(3, 3), (20, 3), (3, 20), (20, 20)]:
        put(img, x, y, c(ring))
    # inner highlight
    for (x, y) in [(4, 3), (19, 3), (3, 4), (3, 19), (20, 4), (20, 19), (4, 20), (19, 20)]:
        put(img, x, y, c("O4"))
    # inner face fill
    fill_rect(img, 4, 4, 19, 19, c(face))
    # soft inner gradient (top lit)
    hline(img, 5, 18, 4, c("D3"))
    hline(img, 5, 18, 5, c("D3"))
    fill_rect(img, 5, 6, 18, 8, c(face))
    # cardinal notches (O4 dots) — adds art-deco rhythm
    put(img, 11, 1, c("O4"))
    put(img, 12, 1, c("O4"))
    put(img, 11, 22, c("O4"))
    put(img, 12, 22, c("O4"))
    put(img, 1, 11, c("O4"))
    put(img, 1, 12, c("O4"))
    put(img, 22, 11, c("O4"))
    put(img, 22, 12, c("O4"))


def _force(img: Image.Image) -> None:
    """Crossed spears over a small shield."""
    _chip_base(img, ring="O3", face="D2")
    # shield silhouette
    fill_rect(img, 9, 10, 14, 15, c("R2"))
    put(img, 9, 15, c("R1"))
    put(img, 14, 15, c("R1"))
    put(img, 10, 16, c("R1"))
    put(img, 13, 16, c("R1"))
    put(img, 11, 17, c("R1"))
    put(img, 12, 17, c("R1"))
    put(img, 11, 12, c("O4"))  # rivet
    put(img, 12, 12, c("O4"))
    # left spear
    for i in range(12):
        put(img, 5 + i, 17 - i, c("C3"))
        put(img, 6 + i, 17 - i, c("C2"))
    # right spear (mirror)
    for i in range(12):
        put(img, 18 - i, 17 - i, c("C3"))
        put(img, 17 - i, 17 - i, c("C2"))
    # spear tips
    put(img, 6, 5, c("O4"))
    put(img, 6, 6, c("O3"))
    put(img, 17, 5, c("O4"))
    put(img, 17, 6, c("O3"))


def _diplomacy(img: Image.Image) -> None:
    """Laurel branch arc + dove silhouette."""
    _chip_base(img, ring="O3", face="D2")
    # dove silhouette (central)
    body = [
        (10, 13), (11, 13), (12, 13), (13, 13),
        (9, 12), (10, 12), (11, 12), (12, 12), (13, 12),
        (10, 11), (11, 11), (12, 11),
        (11, 10),
    ]
    for (x, y) in body:
        put(img, x, y, c("C4"))
    # head
    put(img, 14, 11, c("C4"))
    put(img, 14, 12, c("C4"))
    put(img, 15, 11, c("C3"))
    put(img, 15, 10, c("C3"))
    # beak
    put(img, 16, 11, c("O4"))
    # wing shadow
    put(img, 11, 12, c("C3"))
    put(img, 12, 12, c("C3"))
    # eye
    put(img, 15, 11, c("D0"))
    # laurel left arc
    for (x, y) in [(5, 8), (4, 10), (4, 12), (4, 14), (5, 16), (7, 17), (9, 17)]:
        put(img, x, y, c("G2"))
    # laurel right arc
    for (x, y) in [(18, 8), (19, 10), (19, 12), (19, 14), (18, 16), (16, 17), (14, 17)]:
        put(img, x, y, c("G2"))
    # laurel leaves (tiny buds)
    for (x, y) in [(5, 9), (4, 11), (4, 13), (5, 15), (18, 9), (19, 11), (19, 13), (18, 15)]:
        put(img, x, y, c("G3"))


def _science(img: Image.Image) -> None:
    """Retort flask with three bubbles rising."""
    _chip_base(img, ring="O3", face="D2")
    # flask neck
    fill_rect(img, 11, 5, 12, 8, c("C4"))
    # stopper
    fill_rect(img, 10, 4, 13, 4, c("O4"))
    # flask body (triangular)
    for y in range(9, 18):
        t = (y - 9) / 8
        half = 2 + int(t * 5)
        fill_rect(img, 12 - half, y, 11 + half, y, c("G2"))
    # liquid highlight
    fill_rect(img, 10, 14, 13, 16, c("G3"))
    # flask outline
    for y in range(9, 18):
        t = (y - 9) / 8
        half = 2 + int(t * 5)
        put(img, 12 - half - 1, y, c("D0"))
        put(img, 12 + half, y, c("D0"))
    hline(img, 7, 16, 18, c("D0"))  # bottom
    # rising bubbles
    put(img, 8, 7, c("G3"))
    put(img, 9, 5, c("G3"))
    put(img, 15, 8, c("G3"))
    put(img, 16, 6, c("C3"))


def _sacrifice(img: Image.Image) -> None:
    """Broken column with wisp."""
    _chip_base(img, ring="O3", face="D2")
    # base plinth
    fill_rect(img, 7, 17, 16, 18, c("C2"))
    fill_rect(img, 8, 16, 15, 16, c("C3"))
    # column shaft (broken diagonally)
    for y in range(9, 16):
        half_width = 2
        cx_offset = int((y - 9) * 0.3)
        fill_rect(img, 10 + cx_offset, y, 13 + cx_offset, y, c("C3"))
    # capital (before break)
    fill_rect(img, 9, 8, 14, 9, c("C4"))
    # broken top diagonal edge (chipped)
    put(img, 12, 6, c("C3"))
    put(img, 13, 7, c("C3"))
    put(img, 14, 8, c("C2"))
    # flutes (verticals on shaft)
    for y in range(10, 15):
        cx_offset = int((y - 9) * 0.3)
        put(img, 11 + cx_offset, y, c("C1"))
        put(img, 13 + cx_offset, y, c("C1"))
    # ash wisp rising
    for (x, y) in [(7, 7), (6, 5), (7, 4), (17, 6), (16, 4), (15, 3)]:
        put(img, x, y, c("B3"))
    put(img, 6, 6, c("B2"))
    put(img, 16, 5, c("B2"))
    # outline
    put(img, 8, 9, c("D0"))
    put(img, 15, 9, c("D0"))
    put(img, 9, 16, c("D0"))
    put(img, 14, 16, c("D0"))


def _economy(img: Image.Image) -> None:
    """Stacked coin with crown notch."""
    _chip_base(img, ring="O3", face="D2")
    # coin stack (3 coins)
    # bottom coin
    fill_rect(img, 6, 15, 17, 17, c("O3"))
    hline(img, 7, 16, 14, c("O4"))
    hline(img, 7, 16, 18, c("O2"))
    # middle coin
    fill_rect(img, 7, 12, 16, 14, c("O3"))
    hline(img, 8, 15, 12, c("O4"))
    # top coin (largest front)
    fill_rect(img, 8, 8, 15, 11, c("O4"))
    hline(img, 9, 14, 8, c("O5"))
    hline(img, 9, 14, 11, c("O3"))
    # crown notch on top
    for x in [9, 11, 13]:
        put(img, x, 7, c("O5"))
        put(img, x, 6, c("O4"))
    put(img, 10, 7, c("O3"))
    put(img, 12, 7, c("O3"))
    # central sigil on top coin
    put(img, 11, 9, c("R3"))
    put(img, 12, 9, c("R3"))
    put(img, 11, 10, c("R2"))
    put(img, 12, 10, c("R2"))
    # coin outlines
    for y in [8, 11, 12, 14, 15, 17]:
        x0 = 8 if y == 8 or y == 11 else (7 if y in (12, 14) else 6)
        x1 = 15 if y == 8 or y == 11 else (16 if y in (12, 14) else 17)
        put(img, x0 - 1, y, c("D0"))
        put(img, x1 + 1, y, c("D0"))


GENERATORS = {
    "tag_force": _force,
    "tag_diplomacy": _diplomacy,
    "tag_science": _science,
    "tag_sacrifice": _sacrifice,
    "tag_economy": _economy,
}


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for name, fn in GENERATORS.items():
        img = new_image(SIZE, SIZE)
        fn(img)
        out = OUT_DIR / f"{name}.png"
        img.save(out)
        print(f"  -> {out.relative_to(OUT_DIR.parents[2])}")


if __name__ == "__main__":
    generate()
