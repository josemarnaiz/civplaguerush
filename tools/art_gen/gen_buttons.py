"""Generate button 9-slice assets in four states.

Size: 96x28, slice margin 12 (corners keep tiny stepped ornaments).

States:
  button_normal.png   — parchment fill, O3 gold border, light top-left shadow
  button_hover.png    — C4 fill, O4 bright gold, slightly lifted feel
  button_pressed.png  — C2 fill, O1 dim gold, shadow flipped to bottom-right
  button_disabled.png — B3 fill, B2 border, fully desaturated
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import (fill_rect, hline, new_image, put, rect,
                        stepped_triangle, vline)

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "ui"
W, H = 96, 28


def _draw_button(outline: str, gold_dark: str, gold_mid: str, gold_hi: str,
                 fill: str, shadow_hi: str, shadow_lo: str,
                 ornament_hi: str, ornament_lo: str,
                 pressed: bool = False) -> Image.Image:
    img = new_image(W, H)
    # Outer outline
    rect(img, 0, 0, W - 1, H - 1, c(outline))

    # 2px gold border just inside
    for i in range(W):
        put(img, i, 1, c(gold_dark))
        put(img, i, 2, c(gold_mid))
        put(img, i, H - 2, c(gold_dark))
        put(img, i, H - 3, c(gold_mid))
    for j in range(H):
        put(img, 1, j, c(gold_dark))
        put(img, 2, j, c(gold_mid))
        put(img, W - 2, j, c(gold_dark))
        put(img, W - 3, j, c(gold_mid))
    for (cx, cy) in [(0, 0), (W - 1, 0), (0, H - 1), (W - 1, H - 1)]:
        put(img, cx, cy, c(outline))

    # Small gold stud rhythm on top/bottom middle rows (every 8px)
    for i in range(6, W - 6, 8):
        put(img, i, 1, c("D2"))
        put(img, i, H - 2, c("D2"))

    # Interior fill
    fill_rect(img, 3, 3, W - 4, H - 4, c(fill))

    # Inner highlight/shadow (bevel)
    if not pressed:
        # Light on top-left, shadow on bottom-right => raised
        hline(img, 3, W - 4, 3, c(shadow_hi))
        vline(img, 3, 3, H - 4, c(shadow_hi))
        hline(img, 3, W - 4, H - 4, c(shadow_lo))
        vline(img, W - 4, 3, H - 4, c(shadow_lo))
    else:
        # Reversed => pushed-in
        hline(img, 3, W - 4, 3, c(shadow_lo))
        vline(img, 3, 3, H - 4, c(shadow_lo))
        hline(img, 3, W - 4, H - 4, c(shadow_hi))
        vline(img, W - 4, 3, H - 4, c(shadow_hi))

    # Corner ornaments: tiny 3-step ziggurats in gold highlight
    stepped_triangle(img, origin=(4, 4), size=3, color=c(ornament_hi), direction="br")
    put(img, 4, 4, c(ornament_lo))
    stepped_triangle(img, origin=(W - 5, 4), size=3, color=c(ornament_hi), direction="bl")
    put(img, W - 5, 4, c(ornament_lo))
    stepped_triangle(img, origin=(4, H - 5), size=3, color=c(ornament_hi), direction="tr")
    put(img, 4, H - 5, c(ornament_lo))
    stepped_triangle(img, origin=(W - 5, H - 5), size=3, color=c(ornament_hi), direction="tl")
    put(img, W - 5, H - 5, c(ornament_lo))

    return img


def generate_all() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    variants = {
        "button_normal.png": dict(
            outline="D0", gold_dark="O1", gold_mid="O3", gold_hi="O4",
            fill="C3", shadow_hi="C4", shadow_lo="C1",
            ornament_hi="O4", ornament_lo="O2", pressed=False,
        ),
        "button_hover.png": dict(
            outline="D0", gold_dark="O2", gold_mid="O4", gold_hi="O5",
            fill="C4", shadow_hi="O5", shadow_lo="C2",
            ornament_hi="O5", ornament_lo="O3", pressed=False,
        ),
        "button_pressed.png": dict(
            outline="D0", gold_dark="O1", gold_mid="O2", gold_hi="O3",
            fill="C2", shadow_hi="C3", shadow_lo="D4",
            ornament_hi="O3", ornament_lo="O1", pressed=True,
        ),
        "button_disabled.png": dict(
            outline="D1", gold_dark="B1", gold_mid="B2", gold_hi="B3",
            fill="D4", shadow_hi="B2", shadow_lo="D2",
            ornament_hi="B2", ornament_lo="B1", pressed=False,
        ),
    }

    for filename, kwargs in variants.items():
        img = _draw_button(**kwargs)
        path = OUT_DIR / filename
        img.save(path)
        print(f"Wrote {path}")


if __name__ == "__main__":
    generate_all()
