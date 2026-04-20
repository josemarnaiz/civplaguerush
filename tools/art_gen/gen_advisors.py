"""Generate 64x64 advisor portraits (6 council archetypes).

Pixel-art busts on transparent backgrounds, palette-locked to Ashen Fresco,
with consistent framing so they composite cleanly into event cards or
advisor slots in the HUD.

Produces:
  advisor_chancellor.png   - diplomat / stability (crowned)
  advisor_plaguewright.png - medic / plague (beak mask)
  advisor_marshal.png      - military / crisis (steel helm)
  advisor_arcanist.png     - science / tech (hooded scholar)
  advisor_shadow.png       - espionage / sabotage (deep hood)
  advisor_architect.png    - resources / logistics (goggled engineer)
"""
from __future__ import annotations

from pathlib import Path

from PIL import Image

from palette import c
from primitives import fill_rect, hline, new_image, put, rect, vline

OUT_DIR = Path(__file__).resolve().parents[2] / "assets" / "art" / "advisors"
SZ = 64

# Portrait framing: head centred at x=32, shoulder line pushed up so the
# head naturally connects to the torso via a short neck.
CX = 32
HEAD_TOP = 6        # y where headwear starts
FACE_TOP = 12       # y where skin starts (below headwear)
FACE_BOT = 26       # y of chin
NECK_TOP = 27       # y where neck begins (just below chin)
NECK_BOT = 32       # y where neck meets collarbone
SHOULDER_Y = 32     # y of shoulder peak (now connected to neck)
COLLAR_Y = 40       # y where collar insignia sits


# ---------------------------------------------------------------------------
# Shared geometry
# ---------------------------------------------------------------------------

def _shoulders(img: Image.Image, robe: str, robe_hi: str, robe_lo: str,
               outline: str = "D0") -> None:
    """Draw a symmetrical sloped-shoulders bust that meets the neck.

    The shape peaks at y=SHOULDER_Y on each side and flares outward toward
    y=63. Shoulders open at the top (x=28..36) to receive the neck so the
    head connects cleanly without a floating gap.
    """
    # Row-by-row half-width of the torso silhouette from centre.
    profile = [
        6, 9, 12, 15, 18, 20, 22, 23, 24, 25, 26, 26, 27, 27, 28, 28,
        29, 29, 30, 30, 30, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
    ]
    for i, half in enumerate(profile):
        y = SHOULDER_Y + i
        if y >= SZ:
            break
        fill_rect(img, CX - half, y, CX + half, y, c(robe))

    # Top highlight band (catching the light).
    hline(img, CX - 14, CX + 14, SHOULDER_Y + 1, c(robe_hi))
    hline(img, CX - 16, CX + 16, SHOULDER_Y + 2, c(robe_hi))
    # Bottom shadow band (bottom 3 rows).
    for y in (SZ - 3, SZ - 2, SZ - 1):
        if y < SZ:
            hline(img, 0, SZ - 1, y, c(robe_lo))

    # Outline the shoulder silhouette.
    for i, half in enumerate(profile):
        y = SHOULDER_Y + i
        if y >= SZ:
            break
        put(img, CX - half - 1, y, c(outline))
        put(img, CX + half + 1, y, c(outline))

    # Neckline V: a small dip in the centre so the robe opens around the neck.
    for k in range(5):
        put(img, CX - 3 + k, SHOULDER_Y + k, c(outline))
        put(img, CX + 3 - k, SHOULDER_Y + k, c(outline))
        fill_rect(img, CX - 2 + k, SHOULDER_Y + k, CX + 2 - k,
                  SHOULDER_Y + k, c(robe_lo))


def _neck(img: Image.Image, skin: str = "C2", shade: str = "C1",
          outline: str = "D0") -> None:
    """Short cylindrical neck connecting head to shoulders."""
    fill_rect(img, CX - 3, NECK_TOP, CX + 3, NECK_BOT, c(skin))
    # Right-side shading (light from top-left).
    vline(img, CX + 3, NECK_TOP, NECK_BOT, c(shade))
    # Outline the sides.
    vline(img, CX - 4, NECK_TOP, NECK_BOT, c(outline))
    vline(img, CX + 4, NECK_TOP, NECK_BOT, c(outline))
    # Soft shadow under the chin.
    hline(img, CX - 3, CX + 3, NECK_TOP, c(shade))


def _collar_insignia(img: Image.Image, emblem_color: str,
                     border: str = "O3") -> None:
    """Art-deco stepped medallion at the collar (3x3 gold frame with emblem).

    This anchors every advisor visually with the same gold accent, so the
    council reads as a unified cast. The emblem colour differentiates roles.
    """
    cx, cy = CX, COLLAR_Y + 6
    # Outer stepped frame.
    fill_rect(img, cx - 4, cy - 3, cx + 4, cy + 3, c("D0"))
    fill_rect(img, cx - 3, cy - 2, cx + 3, cy + 2, c(border))
    # Inner disc.
    fill_rect(img, cx - 2, cy - 1, cx + 2, cy + 1, c(emblem_color))
    # Top notch highlight.
    put(img, cx, cy - 2, c("O5"))
    put(img, cx - 1, cy - 2, c("O4"))
    put(img, cx + 1, cy - 2, c("O4"))


def _oval_head(img: Image.Image, top: int = FACE_TOP, bot: int = FACE_BOT,
               skin: str = "C3", shade: str = "C2",
               outline: str = "D0") -> None:
    """Head oval. Row-by-row widths hand-tuned for a soft aristocratic shape."""
    widths = [4, 6, 7, 7, 7, 7, 7, 7, 7, 7, 6, 6, 5, 4, 3]
    n = bot - top + 1
    for i in range(min(n, len(widths))):
        y = top + i
        w = widths[i]
        fill_rect(img, CX - w, y, CX + w, y, c(skin))
        # Right-side shadow (light from top-left).
        if w >= 3:
            vline(img, CX + w, y, y, c(shade))
            if i > 3:
                put(img, CX + w - 1, y, c(shade))
    # Outline.
    for i in range(min(n, len(widths))):
        y = top + i
        w = widths[i]
        put(img, CX - w - 1, y, c(outline))
        put(img, CX + w + 1, y, c(outline))
    # Cap top and bottom rows.
    hline(img, CX - widths[0], CX + widths[0], top - 1, c(outline))
    hline(img, CX - widths[min(n, len(widths)) - 1],
          CX + widths[min(n, len(widths)) - 1],
          bot + 1, c(outline))


def _face_features(img: Image.Image, eye_y: int = 20,
                   eye_color: str = "D0",
                   mouth_color: str = "D2") -> None:
    """Minimal face: two 1x1 eyes, tiny nose notch, subtle mouth."""
    # Eyes: at x=29 and x=35.
    put(img, 29, eye_y, c(eye_color))
    put(img, 35, eye_y, c(eye_color))
    # Brow shadow just above.
    put(img, 29, eye_y - 1, c("C2"))
    put(img, 35, eye_y - 1, c("C2"))
    # Nose: small vertical mark.
    put(img, 32, eye_y + 2, c("C2"))
    put(img, 32, eye_y + 3, c("C2"))
    # Mouth: 3px line.
    hline(img, 30, 34, eye_y + 5, c(mouth_color))


# ---------------------------------------------------------------------------
# Archetypes
# ---------------------------------------------------------------------------

def chancellor() -> Image.Image:
    img = new_image(SZ, SZ)
    _shoulders(img, robe="C2", robe_hi="C3", robe_lo="C1")
    # Gold chain of office draping across shoulders.
    for x in range(18, 46, 2):
        put(img, x, SHOULDER_Y + 6, c("O3"))
        put(img, x + 1, SHOULDER_Y + 7, c("O4"))
    _neck(img, skin="C3", shade="C2")
    _oval_head(img, skin="C3", shade="C2")
    _face_features(img, eye_y=18)
    # Pointed aristocratic beard.
    for row in range(3):
        hline(img, 30 - row // 2, 34 + row // 2, 24 + row, c("C1"))
    hline(img, 31, 33, 27, c("D3"))
    # Three-peaked gold circlet above brow.
    peaks = [(CX - 6, 10), (CX, 8), (CX + 6, 10)]
    for tip_x, tip_y in peaks:
        for row in range(3):
            y = tip_y + row
            half = row
            fill_rect(img, tip_x - half, y, tip_x + half, y, c("O4"))
            put(img, tip_x - half - 1, y, c("O1"))
            put(img, tip_x + half + 1, y, c("O1"))
    # Band connecting peaks.
    fill_rect(img, CX - 8, 13, CX + 8, 14, c("O3"))
    hline(img, CX - 8, CX + 8, 13, c("O4"))
    hline(img, CX - 8, CX + 8, 15, c("O1"))
    put(img, CX, 7, c("O5"))   # centre pearl
    # Gem in centre band.
    put(img, CX, 14, c("R3"))
    _collar_insignia(img, emblem_color="R3")
    return img


def plaguewright() -> Image.Image:
    img = new_image(SZ, SZ)
    _shoulders(img, robe="D2", robe_hi="D3", robe_lo="D0")
    # Wide hood framing the head: covers top of head and drapes onto shoulders.
    fill_rect(img, CX - 12, 7, CX + 12, 14, c("D1"))
    hline(img, CX - 12, CX + 12, 6, c("D0"))
    vline(img, CX - 13, 7, 30, c("D0"))
    vline(img, CX + 13, 7, 30, c("D0"))
    fill_rect(img, CX - 12, 15, CX - 10, NECK_BOT, c("D1"))
    fill_rect(img, CX + 10, 15, CX + 12, NECK_BOT, c("D1"))
    # Hood highlight top-left + shadow right.
    hline(img, CX - 11, CX - 4, 8, c("D2"))
    vline(img, CX + 12, 8, 29, c("D0"))
    _neck(img, skin="C2", shade="C1")
    _oval_head(img, skin="C2", shade="C1")
    # Leather mask covering the face: full lower-face coverage below brow.
    fill_rect(img, CX - 7, 15, CX + 7, 25, c("D2"))
    hline(img, CX - 7, CX + 7, 14, c("D0"))
    hline(img, CX - 7, CX + 7, 26, c("D0"))
    vline(img, CX - 8, 15, 26, c("D0"))
    vline(img, CX + 8, 15, 26, c("D0"))
    # Brass lenses (circular eye holes) centred at y=18.
    for dx in (-4, 4):
        fill_rect(img, CX + dx - 2, 17, CX + dx + 2, 19, c("O2"))
        rect(img, CX + dx - 2, 17, CX + dx + 2, 19, c("O1"))
        # Dark pupil and tiny glint.
        put(img, CX + dx, 18, c("D0"))
        put(img, CX + dx - 1, 17, c("O5"))
    # Lens bridge connecting the two lenses.
    hline(img, CX - 1, CX + 1, 18, c("O1"))
    # Beak: large triangle from centre-face pointing down-right (~45 degrees).
    # The beak silhouette uses each row moving 1px right and 1px narrower.
    beak_fill = "D2"
    for i in range(14):
        y = 20 + i
        if y >= SZ:
            break
        x_left = CX - 6 + (i // 2)
        x_right = CX + 6 - (i // 2) + (i // 3)
        if x_left > x_right:
            break
        fill_rect(img, x_left, y, x_right, y, c(beak_fill))
        put(img, x_left - 1, y, c("D0"))
        put(img, x_right + 1, y, c("D0"))
    # Beak top ridge highlight (runs along the upper curve).
    for i in range(10):
        put(img, CX - 5 + i // 2, 20 + i, c("D3"))
    # Red ember deep inside the beak opening.
    put(img, CX - 2, 24, c("R4"))
    put(img, CX - 1, 25, c("R3"))
    put(img, CX, 24, c("R4"))
    _collar_insignia(img, emblem_color="R4")
    return img


def marshal() -> Image.Image:
    img = new_image(SZ, SZ)
    _shoulders(img, robe="B1", robe_hi="B2", robe_lo="D1")
    # Oxblood sash across the chest (diagonal from left shoulder to right hip).
    for k in range(20):
        y = SHOULDER_Y + 4 + k
        if y >= SZ:
            break
        x = CX - 14 + k
        fill_rect(img, x, y, x + 1, y, c("R3"))
        put(img, x, y + 1, c("R2"))
    # Steel pauldrons overlay shoulders.
    fill_rect(img, 6, SHOULDER_Y + 3, 14, SHOULDER_Y + 7, c("B2"))
    fill_rect(img, 49, SHOULDER_Y + 3, 57, SHOULDER_Y + 7, c("B2"))
    rect(img, 6, SHOULDER_Y + 3, 14, SHOULDER_Y + 7, c("D0"))
    rect(img, 49, SHOULDER_Y + 3, 57, SHOULDER_Y + 7, c("D0"))
    # Rivets on pauldrons.
    put(img, 10, SHOULDER_Y + 5, c("B3"))
    put(img, 53, SHOULDER_Y + 5, c("B3"))
    _neck(img, skin="C2", shade="C1")
    _oval_head(img, skin="C2", shade="C1")
    _face_features(img, eye_y=18)
    # Scar across right eye (diagonal red line).
    for k in range(4):
        put(img, 34 + k, 16 + k, c("R3"))
    # Jaw shading (stubble).
    hline(img, 29, 35, 24, c("C1"))
    hline(img, 30, 34, 25, c("D3"))
    # Steel helm: dome covering top of head + nose guard.
    fill_rect(img, CX - 9, 6, CX + 9, 13, c("B2"))
    # Dome highlight on top-left.
    fill_rect(img, CX - 7, 6, CX - 3, 7, c("B3"))
    put(img, CX - 6, 5, c("B3"))
    # Dome shadow on right.
    vline(img, CX + 8, 7, 12, c("D1"))
    vline(img, CX + 9, 7, 12, c("D1"))
    # Helmet outline.
    hline(img, CX - 9, CX + 9, 5, c("D0"))
    vline(img, CX - 10, 6, 13, c("D0"))
    vline(img, CX + 10, 6, 13, c("D0"))
    hline(img, CX - 10, CX + 10, 14, c("D0"))
    # Red crest (vertical plume on top).
    for y in range(1, 6):
        put(img, CX, y, c("R3"))
        put(img, CX + 1, y, c("R4"))
        put(img, CX - 1, y + 1, c("R2"))
    put(img, CX, 0, c("R2"))
    # Nose guard: narrow strip from helm down between the eyes.
    vline(img, CX, 14, 20, c("B2"))
    vline(img, CX + 1, 14, 20, c("D1"))
    put(img, CX - 1, 14, c("D0"))
    put(img, CX + 2, 14, c("D0"))
    _collar_insignia(img, emblem_color="B3")
    return img


def arcanist() -> Image.Image:
    img = new_image(SZ, SZ)
    _shoulders(img, robe="D3", robe_hi="D4", robe_lo="D1")
    # Gold-embroidered lapel edges (chest lapels descend from neckline).
    for y in range(SHOULDER_Y + 2, SHOULDER_Y + 18):
        if y < SZ:
            put(img, CX - 5, y, c("O2"))
            put(img, CX + 5, y, c("O2"))
    # Gold geometric motif on chest (stepped triangle).
    for k in range(5):
        hline(img, CX - k, CX + k, 50 + k, c("O3"))
    _neck(img, skin="C2", shade="C1")
    _oval_head(img, skin="C2", shade="C1")
    _face_features(img, eye_y=19, mouth_color="D3")
    # Hood draped over head (fabric folds at temples).
    fill_rect(img, CX - 11, 7, CX + 11, 13, c("D2"))
    # Hood highlight on top-left.
    hline(img, CX - 10, CX - 3, 9, c("D3"))
    # Hood outline.
    hline(img, CX - 11, CX + 11, 6, c("D0"))
    vline(img, CX - 12, 7, 30, c("D0"))
    vline(img, CX + 12, 7, 30, c("D0"))
    # Hood falls behind shoulders (covering the neck sides).
    fill_rect(img, CX - 11, 14, CX - 9, NECK_BOT, c("D2"))
    fill_rect(img, CX + 9, 14, CX + 11, NECK_BOT, c("D2"))
    # Third-eye sigil on forehead (vertical almond + gold iris).
    fill_rect(img, CX - 1, 12, CX + 1, 15, c("D0"))
    put(img, CX, 13, c("O4"))
    put(img, CX, 14, c("O3"))
    _collar_insignia(img, emblem_color="O4")
    return img


def shadow() -> Image.Image:
    img = new_image(SZ, SZ)
    _shoulders(img, robe="D1", robe_hi="D2", robe_lo="D0")
    # Deep hood dominating the portrait: large fabric mass with void inside.
    fill_rect(img, CX - 13, 6, CX + 13, NECK_BOT, c("D1"))
    # Inner face void (darker, where the face would be).
    fill_rect(img, CX - 8, 13, CX + 8, 28, c("D0"))
    # Hood folds highlight on top-left (catching light).
    hline(img, CX - 12, CX - 6, 7, c("D2"))
    hline(img, CX - 12, CX - 8, 8, c("D2"))
    put(img, CX - 11, 9, c("D3"))
    put(img, CX - 12, 10, c("D2"))
    # Hood folds on right (deeper shadow).
    vline(img, CX + 12, 8, 30, c("D0"))
    vline(img, CX + 13, 7, 30, c("D0"))
    # Hood outline.
    hline(img, CX - 13, CX + 13, 5, c("D0"))
    vline(img, CX - 14, 6, NECK_BOT, c("D0"))
    vline(img, CX + 14, 6, NECK_BOT, c("D0"))
    # Two glinting red eye dots in the shadow.
    put(img, 29, 18, c("R4"))
    put(img, 35, 18, c("R4"))
    put(img, 29, 19, c("R3"))
    put(img, 35, 19, c("R3"))
    # Subtle cream mouth slit (barely visible).
    hline(img, 30, 34, 23, c("D2"))
    _collar_insignia(img, emblem_color="D3")
    return img


def architect() -> Image.Image:
    img = new_image(SZ, SZ)
    _shoulders(img, robe="O1", robe_hi="O2", robe_lo="D1")
    # Leather apron cross-straps converging at a copper ring.
    for k in range(12):
        put(img, CX - 10 + k, SHOULDER_Y + 4 + k, c("D2"))
        put(img, CX + 10 - k, SHOULDER_Y + 4 + k, c("D2"))
    # Copper rivets on shoulders.
    put(img, 14, SHOULDER_Y + 5, c("O4"))
    put(img, 50, SHOULDER_Y + 5, c("O4"))
    put(img, 14, SHOULDER_Y + 6, c("O1"))
    put(img, 50, SHOULDER_Y + 6, c("O1"))
    _neck(img, skin="C2", shade="C1")
    _oval_head(img, skin="C2", shade="C1")
    # Round goggles covering eyes.
    for dx in (-5, 5):
        rect(img, CX + dx - 2, 16, CX + dx + 2, 19, c("O1"))
        fill_rect(img, CX + dx - 1, 17, CX + dx + 1, 18, c("B2"))
        put(img, CX + dx - 1, 17, c("B3"))
        put(img, CX + dx + 1, 18, c("D0"))
    # Strap connecting the two lenses.
    hline(img, CX - 3, CX + 3, 17, c("O1"))
    # Nose under goggles.
    put(img, CX, 20, c("C1"))
    put(img, CX, 21, c("C1"))
    # Moustache.
    hline(img, 29, 35, 22, c("C1"))
    hline(img, 30, 34, 23, c("D2"))
    # Leather cap: curved dome in warm copper.
    fill_rect(img, CX - 10, 7, CX + 10, 13, c("O1"))
    hline(img, CX - 10, CX + 10, 6, c("D0"))
    vline(img, CX - 11, 7, 14, c("D0"))
    vline(img, CX + 11, 7, 14, c("D0"))
    # Cap highlight.
    hline(img, CX - 8, CX - 2, 7, c("O2"))
    hline(img, CX - 8, CX - 4, 8, c("O2"))
    # Bill of the cap shading forehead.
    hline(img, CX - 10, CX + 10, 14, c("D1"))
    hline(img, CX - 11, CX + 11, 15, c("D0"))
    # Side strap clamp behind cap.
    put(img, CX - 11, 12, c("O2"))
    put(img, CX + 11, 12, c("O2"))
    _collar_insignia(img, emblem_color="O2")
    return img


# ---------------------------------------------------------------------------
# Master

def generate() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    portraits = [
        ("chancellor", chancellor),
        ("plaguewright", plaguewright),
        ("marshal", marshal),
        ("arcanist", arcanist),
        ("shadow", shadow),
        ("architect", architect),
    ]
    for name, fn in portraits:
        img = fn()
        path = OUT_DIR / f"advisor_{name}.png"
        img.save(path)
        print(f"Wrote {path}")


if __name__ == "__main__":
    generate()
