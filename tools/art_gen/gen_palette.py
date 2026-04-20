"""Generate palette.png — reference swatch of all 24 palette colors.

Output: assets/art/palette/palette.png (384x240, 6 rows x 5 cols, 64px per swatch)
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

from palette import PALETTE, RAMPS, hex_to_rgba

SWATCH = 64
LABEL_H = 16
COLS = 5
OUT = Path(__file__).resolve().parents[2] / "assets" / "art" / "palette" / "palette.png"


def _label_font() -> ImageFont.ImageFont:
    try:
        return ImageFont.truetype("consola.ttf", 10)
    except OSError:
        return ImageFont.load_default()


def generate() -> Path:
    rows = list(RAMPS.items())
    width = COLS * SWATCH
    height = len(rows) * (SWATCH + LABEL_H)
    img = Image.new("RGBA", (width, height), hex_to_rgba("#1F1520"))
    draw = ImageDraw.Draw(img)
    font = _label_font()

    for row_i, (ramp_name, keys) in enumerate(rows):
        y = row_i * (SWATCH + LABEL_H)
        draw.text((4, y + 2), ramp_name.upper(), fill=hex_to_rgba("#E8D4B4"), font=font)
        for col_i, key in enumerate(keys):
            x = col_i * SWATCH
            y_swatch = y + LABEL_H
            draw.rectangle([x, y_swatch, x + SWATCH - 1, y_swatch + SWATCH - 1],
                           fill=hex_to_rgba(PALETTE[key]))
            draw.text((x + 3, y_swatch + 2), key, fill=hex_to_rgba("#0F0A0E"), font=font)
            draw.text((x + 3, y_swatch + SWATCH - 12),
                      PALETTE[key], fill=hex_to_rgba("#0F0A0E"), font=font)

    OUT.parent.mkdir(parents=True, exist_ok=True)
    img.save(OUT)
    return OUT


if __name__ == "__main__":
    print(f"Wrote {generate()}")
