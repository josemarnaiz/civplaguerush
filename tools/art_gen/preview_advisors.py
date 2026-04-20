"""Combine all 6 advisor portraits into a single preview image at 4x scale."""
from __future__ import annotations

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
SRC = ROOT / "assets" / "art" / "advisors"
OUT = ROOT / "assets" / "art" / "preview_advisors.png"
SCALE = 4
PAD = 8
COLS = 3
NAMES = ["chancellor", "plaguewright", "marshal",
         "arcanist", "shadow", "architect"]
BG = (31, 21, 32, 255)  # D1
LABEL_BG = (15, 10, 14, 255)  # D0


def main() -> None:
    imgs = [Image.open(SRC / f"advisor_{n}.png").convert("RGBA") for n in NAMES]
    cell = 64 * SCALE + PAD * 2
    label_h = 24
    cell_h = cell + label_h
    rows = (len(imgs) + COLS - 1) // COLS
    W = COLS * cell
    H = rows * cell_h
    out = Image.new("RGBA", (W, H), BG)

    from PIL import ImageDraw, ImageFont
    draw = ImageDraw.Draw(out)
    try:
        font = ImageFont.truetype("arial.ttf", 16)
    except OSError:
        font = ImageFont.load_default()

    for i, (img, name) in enumerate(zip(imgs, NAMES)):
        r = i // COLS
        col = i % COLS
        scaled = img.resize((64 * SCALE, 64 * SCALE), Image.NEAREST)
        x = col * cell + PAD
        y = r * cell_h + PAD
        out.alpha_composite(scaled, (x, y))
        # Label strip under the portrait.
        label_rect = (col * cell, r * cell_h + cell, (col + 1) * cell,
                      r * cell_h + cell_h)
        draw.rectangle(label_rect, fill=LABEL_BG)
        draw.text((col * cell + 12, r * cell_h + cell + 3), name,
                  fill=(231, 191, 87, 255), font=font)

    out.save(OUT)
    print(f"Wrote {OUT}")


if __name__ == "__main__":
    main()
