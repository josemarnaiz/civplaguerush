"""Ashen Fresco palette — single source of truth for all art generation.

Any pixel rendered in the game comes from one of these 24 hex codes.
See docs/ART_bible.md for the full style guide.
"""
from __future__ import annotations


def hex_to_rgba(h: str, alpha: int = 255) -> tuple[int, int, int, int]:
    h = h.lstrip("#")
    return (int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16), alpha)


PALETTE: dict[str, str] = {
    # Deeps / shadows
    "D0": "#0F0A0E", "D1": "#1F1520", "D2": "#2E2228", "D3": "#43303A", "D4": "#5C4551",
    # Creams / parchment
    "C1": "#7A6560", "C2": "#A08878", "C3": "#C5AB8E", "C4": "#E8D4B4",
    # Ochres / stained gold (signature)
    "O1": "#6E4E1C", "O2": "#9C732A", "O3": "#C79A3C", "O4": "#E8C068", "O5": "#F7E6A8",
    # Blood reds
    "R1": "#4A0F14", "R2": "#7A1A24", "R3": "#B22A34", "R4": "#D9544E",
    # Toxic greens
    "G1": "#2F4A2B", "G2": "#6B8A3C", "G3": "#A8C25A",
    # Cool ash accents
    "B1": "#3C4A55", "B2": "#6C7D88", "B3": "#A8B8BF",
}


def c(name: str, alpha: int = 255) -> tuple[int, int, int, int]:
    """Return RGBA tuple for palette color name (e.g. 'O3')."""
    return hex_to_rgba(PALETTE[name], alpha)


TRANSPARENT = (0, 0, 0, 0)

RAMPS = {
    "deeps":  ["D0", "D1", "D2", "D3", "D4"],
    "creams": ["C1", "C2", "C3", "C4"],
    "gold":   ["O1", "O2", "O3", "O4", "O5"],
    "blood":  ["R1", "R2", "R3", "R4"],
    "toxic":  ["G1", "G2", "G3"],
    "ash":    ["B1", "B2", "B3"],
}
