"""Preview sheet of all biome icons at 4x zoom with labels."""
from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

from palette import c
from primitives import fill_rect, new_image

ART_DIR = Path(__file__).resolve().parents[2] / "assets" / "art"
OUT = ART_DIR / "map" / "_biomes_preview.png"
ZOOM = 4


def build() -> Path:
    names = [
        "arcology", "coast", "wasteland",
        "tundra", "factory", "tech",
        "ruins", "veil", "drylands",
        "islands", "jungle", "volcano",
    ]
    cols, rows = 4, 3
    cell_w, cell_h = 40, 44   # 24 icon + padding + label
    canvas = new_image(cols * cell_w, rows * cell_h, c("D1"))
    try:
        font = ImageFont.truetype("consola.ttf", 9)
    except OSError:
        font = ImageFont.load_default()
    draw = ImageDraw.Draw(canvas)
    for i, name in enumerate(names):
        col = i % cols
        row = i // cols
        cx = col * cell_w
        cy = row * cell_h
        # Dark tile background
        fill_rect(canvas, cx + 2, cy + 2, cx + cell_w - 3, cy + 30, c("D2"))
        # Center icon (24x24 at cx+8..cx+31)
        icon = Image.open(ART_DIR / "map" / f"biome_{name}.png").convert("RGBA")
        canvas.paste(icon, (cx + 8, cy + 4), icon)
        # Label
        draw.text((cx + 2, cy + 32), name, fill=(232, 212, 180, 255), font=font)

    scaled = canvas.resize((canvas.width * ZOOM, canvas.height * ZOOM), Image.NEAREST)
    scaled.save(OUT)
    return OUT


if __name__ == "__main__":
    print(f"Wrote {build()}")
