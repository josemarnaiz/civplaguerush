"""Master generator — regenerates every art asset from source.

Run:  python tools/art_gen/build_all.py

Equivalent to running each gen_*.py in order.
"""
from __future__ import annotations

import gen_palette
import gen_panel
import gen_buttons
import gen_icons
import gen_decor
import gen_biomes
import gen_event_icons
import gen_infection
import gen_title
import gen_ornaments
import gen_advisors
import gen_menu_backdrop
import gen_choice_chips
import gen_tech_badges
import gen_preview


def main() -> None:
    print("== palette ==")
    gen_palette.generate()
    print("== panels ==")
    for v in ("light", "dark"):
        gen_panel.generate(v)
    print("== buttons ==")
    gen_buttons.generate_all()
    print("== icons ==")
    gen_icons.generate()
    print("== decor ==")
    gen_decor.generate()
    print("== biomes ==")
    gen_biomes.generate()
    print("== event icons ==")
    gen_event_icons.generate()
    print("== infection ==")
    gen_infection.generate()
    print("== title logo ==")
    gen_title.build()
    print("== ornaments ==")
    gen_ornaments.generate()
    print("== advisors ==")
    gen_advisors.generate()
    print("== menu backdrop ==")
    gen_menu_backdrop.generate()
    print("== choice chips ==")
    gen_choice_chips.generate()
    print("== tech badges ==")
    gen_tech_badges.generate()
    print("== preview ==")
    gen_preview.build_preview()
    print("\nAll art regenerated.")


if __name__ == "__main__":
    main()
