"""Composite preview of all UI + icon assets at 4x zoom."""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import fill_rect, new_image

ART_DIR = Path(__file__).resolve().parents[2] / "assets" / "art"
OUT = ART_DIR / "ui" / "_preview.png"
ZOOM = 4


def _load(folder: str, name: str) -> Image.Image:
    return Image.open(ART_DIR / folder / name).convert("RGBA")


def _scale(img: Image.Image, z: int = ZOOM) -> Image.Image:
    return img.resize((img.width * z, img.height * z), Image.NEAREST)


def _stretch_9slice(img: Image.Image, target_w: int, target_h: int,
                    slice_px: int) -> Image.Image:
    sw, sh = img.size
    s = slice_px
    out = Image.new("RGBA", (target_w, target_h), (0, 0, 0, 0))
    out.paste(img.crop((0, 0, s, s)), (0, 0))
    out.paste(img.crop((sw - s, 0, sw, s)), (target_w - s, 0))
    out.paste(img.crop((0, sh - s, s, sh)), (0, target_h - s))
    out.paste(img.crop((sw - s, sh - s, sw, sh)), (target_w - s, target_h - s))

    src_top = img.crop((s, 0, sw - s, s))
    src_bot = img.crop((s, sh - s, sw - s, sh))
    src_lef = img.crop((0, s, s, sh - s))
    src_rig = img.crop((sw - s, s, sw, sh - s))
    dst_edge_w = target_w - 2 * s
    dst_edge_h = target_h - 2 * s

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

    center = img.crop((s, s, sw - s, sh - s))
    out.paste(center.resize((dst_edge_w, dst_edge_h), Image.NEAREST), (s, s))
    return out


def build_preview() -> Path:
    canvas_w, canvas_h = 420, 260
    canvas = new_image(canvas_w, canvas_h, c("D1"))

    fill_rect(canvas, 0, 0, canvas_w - 1, 14, c("D2"))

    # Panels
    panel_light = _stretch_9slice(_load("ui", "panel_frame.png"), 180, 80, 16)
    panel_dark = _stretch_9slice(_load("ui", "panel_frame_dark.png"), 180, 80, 16)
    canvas.paste(panel_light, (16, 24), panel_light)
    canvas.paste(panel_dark, (220, 24), panel_dark)

    # Icons row — each icon in a small badge frame
    icon_names = ["stat_influence.png", "stat_resources.png", "stat_crisis.png",
                  "stat_stability.png", "stat_control.png"]
    icon_y = 120
    for i, iname in enumerate(icon_names):
        x = 16 + i * 80
        bg = _load("ui", "badge_frame_dark.png")
        canvas.paste(bg, (x, icon_y), bg)
        icon = _load("icons", iname)
        canvas.paste(icon, (x + 8, icon_y + 8), icon)

    # Buttons row — stretched
    btn_y = 180
    for i, name in enumerate(["button_normal.png", "button_hover.png",
                              "button_pressed.png", "button_disabled.png"]):
        btn = _stretch_9slice(_load("ui", name), 96, 28, 12)
        canvas.paste(btn, (16 + i * 100, btn_y), btn)

    # Divider: 3-slice horizontally (stretch middle, keep ends as-is)
    div_src = _load("ui", "divider_horizontal.png")
    target_w, s = 300, 12
    divider = Image.new("RGBA", (target_w, div_src.height), (0, 0, 0, 0))
    divider.paste(div_src.crop((0, 0, s, div_src.height)), (0, 0))
    mid_src = div_src.crop((s, 0, div_src.width - s, div_src.height))
    mid_target_w = target_w - 2 * s
    divider.paste(mid_src.resize((mid_target_w, div_src.height), Image.NEAREST), (s, 0))
    divider.paste(div_src.crop((div_src.width - s, 0, div_src.width, div_src.height)),
                  (target_w - s, 0))
    canvas.paste(divider, (60, 214), divider)

    # Big stretched buttons at bottom
    big = _stretch_9slice(_load("ui", "button_normal.png"), 180, 32, 12)
    canvas.paste(big, (30, 228), big)
    big2 = _stretch_9slice(_load("ui", "button_hover.png"), 180, 32, 12)
    canvas.paste(big2, (220, 228), big2)

    final = _scale(canvas, ZOOM)
    final.save(OUT)
    return OUT


if __name__ == "__main__":
    print(f"Wrote {build_preview()}")
