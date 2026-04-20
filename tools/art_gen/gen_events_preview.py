"""Preview sheet of all event icons at 4x zoom with labels."""
from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

from palette import c
from primitives import fill_rect, new_image

ART_DIR = Path(__file__).resolve().parents[2] / "assets" / "art"
OUT = ART_DIR / "events" / "_events_preview.png"
ZOOM = 4


def build() -> Path:
    names = [
        "outbreak", "famine", "uprising",
        "espionage", "opportunity", "relief",
        "sabotage", "science", "migration",
    ]
    cols, rows = 3, 3
    cell_w, cell_h = 64, 70
    canvas = new_image(cols * cell_w, rows * cell_h, c("D1"))
    try:
        font = ImageFont.truetype("consola.ttf", 10)
    except OSError:
        font = ImageFont.load_default()
    draw = ImageDraw.Draw(canvas)
    for i, name in enumerate(names):
        col = i % cols
        row = i // cols
        cx = col * cell_w
        cy = row * cell_h
        fill_rect(canvas, cx + 2, cy + 2, cx + cell_w - 3, cy + 53, c("D2"))
        icon = Image.open(ART_DIR / "events" / f"event_{name}.png").convert("RGBA")
        canvas.paste(icon, (cx + 8, cy + 4), icon)
        draw.text((cx + 4, cy + 56), name, fill=(232, 212, 180, 255), font=font)

    scaled = canvas.resize((canvas.width * ZOOM, canvas.height * ZOOM), Image.NEAREST)
    scaled.save(OUT)
    return OUT


if __name__ == "__main__":
    print(f"Wrote {build()}")
