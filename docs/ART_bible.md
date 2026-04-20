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
| RegionMap (custom draw) | Ver sección 7 |

**Pipeline generador** (`python tools/art_gen/build_all.py`) regenera toda la galería desde código.

---

## 7. Mapamundi continental (`scripts/ui/region_map.gd`)

El mapa se ha reescrito para leerse como un mapamundi tipo Risk/Imperialism,
no como un enjambre de blobs aislados.

### 7.1 Topología
Tres bandas latitudinales con seas entre ellas. Las 12 regiones se distribuyen
siguiendo el `CONTINENT_LAYOUT`:

```
Row 0 (Norte):       [r01, r02, r03, r04]  -> un solo continente Eurasia-like
Row 1 (Ecuador):     [r05, r06] | [r07, r08]  -> dos continentes con golfo atlántico
Row 2 (Sur):         [r09] | [r10] | [r11, r12]  -> isla, archipiélago, continente
```

- Las regiones de un mismo grupo **comparten costa interior**: el polígono de
  `r02` empieza exactamente donde acaba el de `r01`, sin hueco oceánico.
- Los bordes internos (p.ej. r01|r02) se dibujan como **línea dorada
  punteada** (`INTERNAL_BORDER`, O3 alpha 0.70), para que se lean como
  frontera política y no como costa.
- Los bordes exteriores de cada continente se dibujan como polyline oscura
  gruesa (`COAST_COLOR` 1.6 px) con halo cream (`COAST_GLOW` 3.2 px) debajo,
  imitando pintura a mano sobre pergamino.

### 7.2 Geometría de costa
Para cada continente se muestrean 12 puntos por columna a lo largo del top y
bottom. La ordenada aplica tres sinusoidales superpuestas:
- **Continental** (0.75 ciclos por grupo, amp 0.018-0.055): curvatura grande.
- **Media** (2.0-2.2 ciclos, amp 0.014): bahías y cabos.
- **Fina** (4.1-4.7 ciclos, amp 0.006): detalle costero.

Además se aplica un **eje continental** (sin amp 0.010-0.040, phase por-continente)
que desplaza **TODO** el continente arriba/abajo a lo largo de su largo → el
resultado es un continente que serpentea, no una barra horizontal.

Los extremos se tapera (smoothstep 12%) para que las costas norte/sur se unan
limpiamente con las costas laterales (oeste/este) que se generan como curvas
verticales con indentación SIDE_COAST_INDENT = 0.014.

### 7.3 Océano animado (5 pases `_draw`)
1. `_draw_ocean_gradient` — bandas horizontales D1→D0 arriba y cálida abajo.
2. `_draw_latitude_lines` — 3 líneas punteadas (tropics + ecuador) a 23%/50%/77%.
3. `_draw_ocean_flecks` — chispas sal deterministas (36 puntos, seed 0xC1A7E).
4. `_draw_ocean_currents` — 5 curvas sinusoidales horizontales que fluyen con
   `_time`; cada una con fase y amplitud distintas (gold alpha 0.16 pulsante).
5. `_draw_cloud_shadows` — 3 nubes cream drift con velocidades 7.5/12/15 px/s,
   wrap horizontal.

### 7.4 Islotes decorativos
`_generate_ocean_islets()` siembra 11 blobs pequeños no-interactivos en los
mares (entre filas) para romper la sensación de rectángulos vacíos. Usan la
misma doble-costa (halo + dark) y shadow offset que los continentes.

### 7.5 Animaciones de juego
- **Halo de shelf** (`_draw_shelf_halos`): expand 1.2% de cada continente en
  `OCEAN_SHELF` → plataforma continental soft que ancla la tierra al mar.
- **Flash de turno** (`trigger_turn_flash`): invocado desde
  `run_scene._finalize_turn()`. 0.65s de fade-out dorado en bandas verticales
  + sheen horizontal que sube desde 45% de altura.
- **Pulse de target activo** (existente): anillo dorado con seno 2.8 Hz sobre
  la región afectada por el evento actual.
- **Pulse de sigilo de plaga** (existente): halo rojo palpitando 3.5 Hz sobre
  la región más infectada.
- **Tween de color de tierra** (existente): influencia se interpola con
  `TWEEN_SPEED=6.5`, para que la transición neutral → rival sea suave.
- **Flash de pérdida de control** (existente): anillo R4 que fade over 1.2s.

### 7.6 Layout final
- `Vector2(0, 220)` altura mínima del RegionMap en RunScene (ajustada para
  que cabecera + HUD + evento + footer fit en 720p sin overflow).
