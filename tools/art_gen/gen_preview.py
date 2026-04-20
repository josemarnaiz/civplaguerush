"""Composite preview of all UI assets at 3x zoom — validation/mockup tool.

Output: assets/art/ui/_preview.png (not referenced by the game, just for review)
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import fill_rect, new_image

ART_DIR = Path(__file__).resolve().parents[2] / "assets" / "art"
OUT = ART_DIR / "ui" / "_preview.png"
ZOOM = 3


def _load(name: str) -> Image.Image:
    return Image.open(ART_DIR / "ui" / name).convert("RGBA")


def _scale(img: Image.Image, z: int = ZOOM) -> Image.Image:
    return img.resize((img.width * z, img.height * z), Image.NEAREST)


def _stretch_9slice(img: Image.Image, target_w: int, target_h: int,
                    slice_px: int) -> Image.Image:
    """Godot-style 9-slice stretch at source pixel resolution (no scaling yet)."""
    sw, sh = img.size
    s = slice_px
    out = Image.new("RGBA", (target_w, target_h), (0, 0, 0, 0))

    # Corners
    out.paste(img.crop((0, 0, s, s)), (0, 0))
    out.paste(img.crop((sw - s, 0, sw, s)), (target_w - s, 0))
    out.paste(img.crop((0, sh - s, s, sh)), (0, target_h - s))
    out.paste(img.crop((sw - s, sh - s, sw, sh)), (target_w - s, target_h - s))

    # Edges (tile the source edge over the stretched target edge)
    src_top = img.crop((s, 0, sw - s, s))
    src_bot = img.crop((s, sh - s, sw - s, sh))
    src_lef = img.crop((0, s, s, sh - s))
    src_rig = img.crop((sw - s, s, sw, sh - s))
    dst_edge_w = target_w - 2 * s
    dst_edge_h = target_h - 2 * s

    # For clean art we tile horizontally/vertically rather than stretch
    def tile(src: Image.Image, w: int, h: int) -> Image.Image:
        t = Image.new("RGBA", (w, h), (0, 0, 0, 0))
        if src.width == 0 or src.height == 0:
            return t
        for xi in range(0, w, src.width):
            for yi in range(0, h, src.height):
                t.paste(src, (xi, yi))
        return t.crop((0, 0, w, h))

    out.paste(tile(src_top, dst_edge_w, s), (s, 0))
    out.paste(tile(src_bot, dst_edge_w, s), (s, target_h - s))
    out.paste(tile(src_lef, s, dst_edge_h), (0, s))
    out.paste(tile(src_rig, s, dst_edge_h), (target_w - s, s))

    # Center (stretched)
    center = img.crop((s, s, sw - s, sh - s))
    out.paste(center.resize((dst_edge_w, dst_edge_h), Image.NEAREST), (s, s))
    return out


def build_preview() -> Path:
    canvas_w, canvas_h = 760, 360
    canvas = new_image(canvas_w, canvas_h, c("D1"))

    # Title bar area (just background gradient effect with D2)
    fill_rect(canvas, 0, 0, canvas_w - 1, 24, c("D2"))

    # Stretched panel showcases on left (200x120 light) and right (200x120 dark)
    panel_light = _stretch_9slice(_load("panel_frame.png"), 200, 120, 16)
    panel_dark = _stretch_9slice(_load("panel_frame_dark.png"), 200, 120, 16)
    canvas.paste(panel_light, (20, 40), panel_light)
    canvas.paste(panel_dark, (240, 40), panel_dark)

    # Buttons: two sizes (96 native, 160 stretched)
    button_files = ["button_normal.png", "button_hover.png",
                    "button_pressed.png", "button_disabled.png"]
    y = 180
    for i, name in enumerate(button_files):
        btn = Image.open(ART_DIR / "ui" / name).convert("RGBA")
        x = 20 + i * 180
        canvas.paste(btn, (x, y), btn)
        stretched = _stretch_9slice(btn, 160, 28, 12)
        canvas.paste(stretched, (x, y + 40), stretched)

    final = _scale(canvas, ZOOM)
    final.save(OUT)
    return OUT


if __name__ == "__main__":
    print(f"Wrote {build_preview()}")
