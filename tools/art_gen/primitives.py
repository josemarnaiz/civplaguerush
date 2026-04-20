"""Shared primitives for pixel-art generation.

All draw helpers here are 1px-precise. No anti-aliasing. Coordinates are inclusive
integer pixel positions.
"""
from __future__ import annotations

from PIL import Image, ImageDraw

from palette import TRANSPARENT, c


def new_image(w: int, h: int, fill=TRANSPARENT) -> Image.Image:
    return Image.new("RGBA", (w, h), fill)


def put(img: Image.Image, x: int, y: int, color) -> None:
    """Set a single pixel (bounds-checked)."""
    if 0 <= x < img.width and 0 <= y < img.height:
        img.putpixel((x, y), color)


def hline(img: Image.Image, x0: int, x1: int, y: int, color) -> None:
    for x in range(min(x0, x1), max(x0, x1) + 1):
        put(img, x, y, color)


def vline(img: Image.Image, x: int, y0: int, y1: int, color) -> None:
    for y in range(min(y0, y1), max(y0, y1) + 1):
        put(img, x, y, color)


def rect(img: Image.Image, x0: int, y0: int, x1: int, y1: int, color) -> None:
    """Outlined rectangle, 1px."""
    hline(img, x0, x1, y0, color)
    hline(img, x0, x1, y1, color)
    vline(img, x0, y0, y1, color)
    vline(img, x1, y0, y1, color)


def fill_rect(img: Image.Image, x0: int, y0: int, x1: int, y1: int, color) -> None:
    for y in range(min(y0, y1), max(y0, y1) + 1):
        for x in range(min(x0, x1), max(x0, x1) + 1):
            put(img, x, y, color)


def checker(img: Image.Image, x0: int, y0: int, x1: int, y1: int, a, b,
            phase: int = 0) -> None:
    """Fill a region with 1px checker pattern using two colors."""
    for y in range(y0, y1 + 1):
        for x in range(x0, x1 + 1):
            put(img, x, y, a if (x + y + phase) % 2 == 0 else b)


def stepped_triangle(img: Image.Image, origin: tuple[int, int],
                     size: int, color, direction: str = "br") -> None:
    """Art-deco stepped triangle (ziggurat).

    origin = inner corner of the triangle (where the right-angle sits).
    direction = which diagonal the triangle extends toward: 'br','bl','tr','tl'.
    """
    ox, oy = origin
    dx = 1 if "r" in direction else -1
    dy = 1 if "b" in direction else -1
    for i in range(size):
        # at step i, draw a horizontal line of length (size - i)
        length = size - i
        y = oy + dy * i
        x_start = ox
        x_end = ox + dx * (length - 1)
        hline(img, min(x_start, x_end), max(x_start, x_end), y, color)


def stepped_ray(img: Image.Image, origin: tuple[int, int],
                length: int, color) -> None:
    """Draw a 2px-thick diagonal ray going from origin toward bottom-right.
    Used for art-deco sun-burst corners.
    """
    ox, oy = origin
    for i in range(length):
        put(img, ox + i, oy + i, color)
        put(img, ox + i + 1, oy + i, color)
