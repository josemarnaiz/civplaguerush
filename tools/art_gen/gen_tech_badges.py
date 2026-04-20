"""Small 20x20 badge icons for MetaHub tech cards.

Three states map to three emblems:

- `badge_unlocked` — gilded five-point star (acquired upgrade)
- `badge_affordable` — stacked coin rim with gold sheen (ready to unlock)
- `badge_locked` — broken chain link in cold ash (unaffordable / future)

All three share the same 20x20 dark-plum circle chassis with a tarnished
gold ring, so they read as a family in the tech list.
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import fill_rect, hline, new_image, put, vline


SIZE = 20
OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "icons"


def _chassis(img: Image.Image, ring: str = "O3", core: str = "D2") -> None:
    # Round-ish plate (no antialiasing — pixel stairstep)
    rows = [
        (6, 13),   # y=2
        (4, 15),
        (3, 16),
        (2, 17),
        (2, 17),
        (2, 17),
        (2, 17),
        (2, 17),
        (2, 17),
        (2, 17),
        (3, 16),
        (4, 15),
        (6, 13),
    ]
    # Core fill
    for (x_off, (a, b)) in zip(range(2, 2 + len(rows)), rows):
        fill_rect(img, a, x_off, b, x_off, c(core))
    # Ring outline
    ring_pixels = [
        (6, 2), (7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2), (13, 2),
        (4, 3), (5, 3), (14, 3), (15, 3),
        (3, 4), (16, 4),
        (2, 5), (17, 5),
        (2, 6), (17, 6),
        (2, 7), (17, 7),
        (2, 8), (17, 8),
        (2, 9), (17, 9),
        (2, 10), (17, 10),
        (2, 11), (17, 11),
        (2, 12), (17, 12),
        (3, 13), (16, 13),
        (4, 14), (5, 14), (14, 14), (15, 14),
        (6, 15), (7, 15), (8, 15), (9, 15), (10, 15), (11, 15), (12, 15), (13, 15),
    ]
    for (x, y) in ring_pixels:
        put(img, x, y, c(ring))
    # Inner highlight (top-left rim)
    for (x, y) in [(7, 3), (8, 3), (5, 4), (6, 4), (4, 5), (3, 6), (3, 7), (3, 8)]:
        put(img, x, y, c("O4"))


def _unlocked(img: Image.Image) -> None:
    _chassis(img, ring="O3", core="D2")
    # Five-point star (approximation in 20x20) — center at (10, 9)
    star = [
        (10, 4),              # top tip
        (9, 5), (10, 5), (11, 5),
        (6, 6), (7, 6), (8, 6), (9, 6), (10, 6), (11, 6), (12, 6), (13, 6), (14, 6),  # arms
        (7, 7), (8, 7), (9, 7), (10, 7), (11, 7), (12, 7), (13, 7),
        (8, 8), (9, 8), (10, 8), (11, 8), (12, 8),
        (8, 9), (9, 9), (10, 9), (11, 9), (12, 9),
        (7, 10), (8, 10), (12, 10), (13, 10),                         # legs flare
        (6, 11), (7, 11), (13, 11), (14, 11),
        (5, 12), (6, 12), (14, 12), (15, 12),
    ]
    for (x, y) in star:
        put(img, x, y, c("O5"))
    # Star core
    for (x, y) in [(10, 6), (9, 7), (10, 7), (11, 7), (10, 8)]:
        put(img, x, y, c("O4"))
    # Bottom shadow of star
    for (x, y) in [(6, 13), (7, 13), (13, 13), (14, 13)]:
        put(img, x, y, c("O3"))


def _affordable(img: Image.Image) -> None:
    _chassis(img, ring="O3", core="D2")
    # Stacked coin: three oval coins
    # Top coin (smallest, highest)
    fill_rect(img, 7, 6, 12, 7, c("O4"))
    put(img, 6, 7, c("O4"))
    put(img, 13, 7, c("O4"))
    # Middle coin
    fill_rect(img, 6, 8, 13, 9, c("O3"))
    put(img, 5, 8, c("O3"))
    put(img, 14, 8, c("O3"))
    # Bottom coin (widest)
    fill_rect(img, 5, 10, 14, 11, c("O2"))
    put(img, 4, 10, c("O2"))
    put(img, 15, 10, c("O2"))
    # Highlights top-left
    hline(img, 7, 11, 6, c("O5"))
    hline(img, 6, 12, 8, c("O4"))
    hline(img, 5, 13, 10, c("O3"))
    # Rim shadows bottom-right
    hline(img, 8, 13, 7, c("O3"))
    hline(img, 7, 14, 9, c("O2"))
    hline(img, 6, 15, 11, c("O1"))
    # Sigil on top coin (tiny red chip)
    put(img, 9, 6, c("R3"))
    put(img, 10, 6, c("R3"))


def _locked(img: Image.Image) -> None:
    _chassis(img, ring="D4", core="D1")
    # Broken chain link (two half circles intersecting diagonally)
    # Upper-left link
    link_upper = [
        (6, 4), (7, 4), (8, 4),
        (5, 5), (9, 5),
        (5, 6), (9, 6),
        (5, 7), (9, 7),
        (6, 8), (7, 8),
    ]
    for (x, y) in link_upper:
        put(img, x, y, c("B2"))
    # Lower-right link (offset, broken)
    link_lower = [
        (11, 10), (12, 10), (13, 10),
        (10, 11), (14, 11),
        (10, 12), (14, 12),
        (10, 13), (14, 13),
        (11, 14), (12, 14),
    ]
    for (x, y) in link_lower:
        put(img, x, y, c("B2"))
    # Chain breakage diagonal (jagged edge)
    for (x, y) in [(8, 8), (9, 9), (10, 9)]:
        put(img, x, y, c("C1"))
    for (x, y) in [(9, 8), (10, 10)]:
        put(img, x, y, c("D3"))
    # Highlights
    for (x, y) in [(6, 4), (7, 4), (11, 10), (12, 10)]:
        put(img, x, y, c("B3"))
    # Ash specks
    for (x, y) in [(7, 11), (15, 7), (4, 14)]:
        put(img, x, y, c("C1"))


def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for name, fn in [
        ("badge_unlocked", _unlocked),
        ("badge_affordable", _affordable),
        ("badge_locked", _locked),
    ]:
        img = new_image(SIZE, SIZE)
        fn(img)
        out = OUT_DIR / f"{name}.png"
        img.save(out)
        print(f"  -> {out.relative_to(OUT_DIR.parents[2])}")


if __name__ == "__main__":
    generate()
