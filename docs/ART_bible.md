# Biblia de Arte — CivPlagueRush

**Dirección artística:** *Ashen Fresco* — pixel art de alta fidelidad (64px base), art-deco decadente post-caída. Cremas manchadas, oros empañados, rojo infección. La civilización fue hermosa y ahora se desmorona con elegancia.

**Referencias visuales de mood (no imitar, respirar):**
- *Cultist Simulator* — decadencia elegante
- *Blasphemous* — pixel art ornamentado
- *Hades* (UI art-deco)
- Frescos pompeyanos erosionados
- Carteles art-deco de los años 20 cubiertos de polvo

---

## 1. Paleta maestra "Ashen Fresco"

Paleta limitada de **24 colores**, agrupada en 6 rampas temáticas. Todo asset debe usar exclusivamente estos colores. No hay "color libre".

### 1.1 Sombras profundas (cool dark ramp)
Usadas para outlines, sombras, fondos de paneles.

| Rol | Hex | Nombre | Uso principal |
|-----|-----|--------|---------------|
| D0 | `#0F0A0E` | Noche ceniza | Outline mínimo, texto sombra |
| D1 | `#1F1520` | Sepulcro | Fondo de paneles profundos |
| D2 | `#2E2228` | Umbría | Sombra propia de sprites |
| D3 | `#43303A` | Crepúsculo rosa | Media sombra |
| D4 | `#5C4551` | Piedra malva | Borde suave entre sombra y midtone |

### 1.2 Cremas & pergamino (warm midtone ramp)
El "papel viejo" del juego. Dominante en UI y arquitectura.

| Rol | Hex | Nombre | Uso |
|-----|-----|--------|-----|
| C1 | `#7A6560` | Piedra envejecida | Midtone oscuro |
| C2 | `#A08878` | Tan polvoriento | Midtone medio |
| C3 | `#C5AB8E` | Crema pergamino | Midtone claro (fondo UI principal) |
| C4 | `#E8D4B4` | Crema luz | Highlight cálido |

### 1.3 Ocres & oro manchado (accent warm)
La identidad del juego. Art-deco oxidado.

| Rol | Hex | Nombre | Uso |
|-----|-----|--------|-----|
| O1 | `#6E4E1C` | Ocre profundo | Sombras de oro |
| O2 | `#9C732A` | Ocre bruñido | Midtone oro |
| O3 | `#C79A3C` | Oro manchado | **Color signature** — marcos, botones |
| O4 | `#E8C068` | Oro brillante | Highlight oro |
| O5 | `#F7E6A8` | Sheen pálido | Brillo especular oro |

### 1.4 Rojos sangre (infection/crisis ramp)
Solo para indicar crisis, infección, peligro, daño. **Prohibido usar fuera de esos contextos.**

| Rol | Hex | Nombre | Uso |
|-----|-----|--------|-----|
| R1 | `#4A0F14` | Sangre seca | Sombra de rojo |
| R2 | `#7A1A24` | Oxblood | Base de infección |
| R3 | `#B22A34` | Rojo sangre | Midtone crisis |
| R4 | `#D9544E` | Herida viva | Highlight urgente |

### 1.5 Verdes tóxicos (contrast pop)
Uso escaso — solo para plaga activa, biohazard, toxinas. Contraste con el rojo para legibilidad.

| Rol | Hex | Nombre | Uso |
|-----|-----|--------|-----|
| G1 | `#2F4A2B` | Musgo profundo | Sombra tóxico |
| G2 | `#6B8A3C` | Oliva enferma | Base tóxico |
| G3 | `#A8C25A` | Pop tóxico | Highlight plaga |

### 1.6 Azules cenizos (cool accents)
Balance frío para frescos fríos, metales, cielo, UI secundaria.

| Rol | Hex | Nombre | Uso |
|-----|-----|--------|-----|
| B1 | `#3C4A55` | Ceniza pizarra | Sombra fría |
| B2 | `#6C7D88` | Acero frío | Metales, stat icons fríos |
| B3 | `#A8B8BF` | Ceniza pálida | Highlight frío |

**Color signature del juego:** `#C79A3C` (O3 — oro manchado). Cualquier elemento "dorado" de UI debe usar la rampa O1→O5.

---

## 2. Reglas de composición

### 2.1 Resolución y escala
- **Base lógica:** 64×64 por tile, 32×32 por icon pequeño, 16×16 por micro-icon.
- **Viewport Godot:** 1280×720. El pixel se escala con `canvas_items` + render filter `nearest`.
- **Regla de oro:** nunca escalar sprites por valores no enteros. Preferible rediseñar a otra resolución.

### 2.2 Outlines
- Sprites de entidad y iconos: **outline 1px** color D0 (`#0F0A0E`) o D1 (`#1F1520`) según contraste.
- Tiles de mapa: **sin outline duro**. Se unen por gradiente de color.
- UI (botones/paneles): outline doble — 1px D0 exterior, 1px O1 interior (el "marco de oro").

### 2.3 Anti-aliasing y dithering
- **NO anti-aliasing automático**. Pixel duro.
- **Dithering manual selectivo** (patrón bayer 2×2 o checker 1×1) solo para degradados largos (cielo, niebla, volumen). Nunca en superficies pequeñas.

### 2.4 Iluminación
- Luz principal desde **arriba-izquierda** (convención clásica pixel art).
- Sombra propia 1-2 tonos más oscuro en la rampa correspondiente.
- Highlight especular (1-2 píxeles) solo en metal/oro/cristal.

### 2.5 Proporciones arquitectónicas art-deco
- Simetría vertical dominante
- Líneas rectas y zig-zags (nunca curvas orgánicas en UI)
- Ornamentos en esquinas: triángulos escalonados, soles radiales, abanicos
- Tipografía de inspiración Broadway / Futura geometric

---

## 3. Estructura de archivos

```
assets/art/
├── palette/
│   └── palette.png              # Swatch de referencia
├── ui/
│   ├── panel_frame.png          # 9-slice decadente (96×96, margen 16)
│   ├── panel_frame_dark.png     # Variante oscura
│   ├── button_normal.png        # 9-slice (96×28, margen 12)
│   ├── button_hover.png
│   ├── button_pressed.png       # Fill D4 (hundido)
│   ├── button_disabled.png
│   ├── divider_horizontal.png   # 96×8 divisor tiling
│   ├── flourish_corner.png      # Ornamento esquinero 32×32
│   ├── badge_frame.png          # 48×48 9-slice (stat badges)
│   ├── badge_frame_dark.png
│   ├── title_logo.png           # Logo CIVPLAGUERUSH para MainMenu
│   ├── header_cartouche.png     # 160×40 marco decorativo (9-slice opc.)
│   └── ui_theme.tres            # Godot Theme
├── icons/
│   ├── stat_influence.png       # 32×32 corona con rubí
│   ├── stat_resources.png       # cáliz
│   ├── stat_crisis.png          # calavera simétrica
│   ├── stat_stability.png       # columna jónica
│   └── stat_control.png         # estandarte
├── events/                      # 9 iconos 64×64 de eventos
│   ├── event_outbreak.png
│   ├── event_famine.png
│   ├── event_uprising.png
│   ├── event_espionage.png
│   ├── event_opportunity.png
│   ├── event_relief.png
│   ├── event_sabotage.png
│   ├── event_science.png
│   └── event_migration.png
├── map/
│   ├── biome_*.png              # 24×24 × 12 biomas
│   ├── infection_noise.png      # Tile 32×32 de overlay
│   ├── plague_sigil.png         # Sigilo 16×16 pulsante
│   └── compass_rose.png         # Brújula art-deco 48×48
├── entities/                    # (futuro)
└── fx/                          # (futuro)
```

---

## 4. Proceso de producción

Todos los assets se generan desde `tools/art_gen/*.py`. Esto garantiza:
- Paleta exacta (colores hard-coded desde `palette.py`)
- Regeneración determinista
- Diffs legibles en git (código, no binarios ciegos)
- Ajustes rápidos (cambiar un hex regenera todo)

**Flujo:**
1. Diseño → Biblia de arte (este doc) actualizada.
2. Implementación → script Python que genera el PNG.
3. Integración → referenciado en Godot `Theme.tres` o escena.
4. Iteración → ajustar script, regenerar, commit.

---

## 5. Checklist de aprobación para cada asset

Antes de dar un asset por "done":

- [ ] Solo usa colores de la paleta maestra
- [ ] Outline consistente con la regla de sección 2.2
- [ ] Luz desde arriba-izquierda (si aplica)
- [ ] Legible a 1× en 1280×720
- [ ] Legible a 0.5× (móvil reducido)
- [ ] Fondo transparente donde corresponde
- [ ] Nombrado según convención de sección 3
- [ ] Script generador commiteado en `tools/art_gen/`

---

*Última revisión: 2026-04-20. Mantenedor: agente de arte.*

---

## 6. Estado de integración (2026-04-20)

| Escena | Elementos art-integrados |
|--------|--------------------------|
| MainMenu | `title_logo` (CIVPLAGUERUSH), 2× divisores, `ChapterPanel` con marco dark, botones gold |
| RunScene | Mapa orgánico con 12 biomas + sigilo de plaga + rosa de los vientos, HUD de 5 badges con icons (columna, corona, cáliz, calavera, estandarte), panel de evento con icon 40×40, footer con `Main Menu` |
| MetaHub | Título `ASHEN ARCHIVE`, cáliz + créditos, 2× divisores, tech list en panel dark, `Play Again` / `Main Menu` |
| RegionMap (custom draw) | Polígonos orgánicos tweened, dashed adjacency routes, infection tile overlay, plague sigil pulse, compass rose, biome icons sobre centroides |

**Pipeline generador** (`python tools/art_gen/build_all.py`) regenera toda la galería desde código.
