"""Single image that stacks all five tag chips scaled 4x with labels."""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

NAMES = ["tag_force", "tag_diplomacy", "tag_science", "tag_sacrifice", "tag_economy"]
SRC = Path(__file__).resolve().parents[2] / "assets" / "art" / "icons"
OUT = Path(__file__).resolve().parents[2] / "assets" / "art" / "preview_chips.png"
SCALE = 4
PAD = 14
BG = (15, 10, 14, 255)

imgs = [Image.open(SRC / f"{n}.png").convert("RGBA") for n in NAMES]
cell_w = 24 * SCALE + PAD * 2
label_h = 22
cell_h = 24 * SCALE + PAD * 2 + label_h
W = len(imgs) * cell_w
H = cell_h
out = Image.new("RGBA", (W, H), BG)
draw = ImageDraw.Draw(out)
try:
    font = ImageFont.truetype("arial.ttf", 14)
except Exception:
    font = ImageFont.load_default()

for i, (img, name) in enumerate(zip(imgs, NAMES)):
    scaled = img.resize((24 * SCALE, 24 * SCALE), Image.NEAREST)
    x = i * cell_w + PAD
    y = PAD
    out.paste(scaled, (x, y), scaled)
    draw.text((x, y + 24 * SCALE + 4), name.replace("tag_", ""), fill=(232, 212, 180), font=font)

OUT.parent.mkdir(parents=True, exist_ok=True)
out.save(OUT)
print(OUT)
