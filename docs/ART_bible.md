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
| RunScene | Mapa orgánico con 12 biomas + sigilo de plaga + rosa de los vientos, HUD de 5 badges con icons (columna, corona, cáliz, calavera, estandarte), panel de evento con **retrato de consejero 64×64** + icon 36×36, footer con `Main Menu` |
| MetaHub | Título `ASHEN ARCHIVE`, cáliz + créditos, 2× divisores, tech list en panel dark, `Play Again` / `Main Menu` |
| RegionMap (custom draw) | Ver sección 7 |
| Consejeros (EventPanel) | Ver sección 8 |

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
- `Vector2(0, 190)` altura mínima del RegionMap en RunScene (ajustada para
  que cabecera + HUD + evento con consejero + footer fit en 720p sin overflow).

---

## 8. Consejo — retratos 64×64 (`tools/art_gen/gen_advisors.py`)

Seis arquetipos del Consejo Ashen. Todos comparten un mismo framing (cabeza
centrada en x=32, cuello y hombros anclados en y=32) y una **medalla colgante
dorada** en el centro del pecho (`_collar_insignia`) — esto los une como casta
decadente unificada. La piedra central del medallón cambia según el rol
(R3 para diplomacia, R4 para peste, B3 para guerra, O4 para arcano, D3 para
sombra, O2 para ingeniería).

### 8.1 Roster

| Slug | Arquetipo | Silueta distintiva | Eventos que "habla" |
|------|-----------|--------------------|---------------------|
| `chancellor` | Diplomático / Canciller | Circlete dorado de 3 picos + barba + cadena de oficio | `golden_opportunity`, `mass_migration` |
| `plaguewright` | Doctor de la peste | Máscara de cuero con pico + lentes de latón + capucha | `pandemic_wave`, `outbreak_focus` |
| `marshal` | Mariscal militar | Yelmo acero con penacho R3 + cicatriz + pauldrones | `border_uprising`, `frontier_uprising` |
| `arcanist` | Arcanista / Científico | Capucha oscura + tercer ojo dorado + lapels bordados | `cure_trial` |
| `shadow` | Jefe de espías | Capucha profunda que traga la cara + 2 destellos rojos | `info_leak`, `defector_cell`, `sabotage_strike` |
| `architect` | Ingeniero / Logística | Gorra cuero + goggles redondos de latón + bigote + arneses | `food_shortage`, `relief_mission` |

Archivos: `assets/art/advisors/advisor_<slug>.png`.

### 8.2 Construcción técnica
- Piel: `C2`/`C3` con sombra `C1` en el lado derecho (luz top-left coherente).
- Cuello: cilindro 7 px ancho × 6 px alto entre mentón y clavícula.
- Hombros: perfil gradiente (half-width 6→31 px) con highlight `robe_hi` en las
  dos primeras filas y shadow `robe_lo` en las tres finales.
- Escote V: notch de 5 px en el centro que abre la túnica al cuello.
- Iluminación consistente: todo lo que mira arriba a la izquierda se highlight
  un tono, lo que mira al suroeste se sombrea.

### 8.3 Integración en RunScene
Cada evento mapea 1:1 a un advisor vía `ADVISOR_PATH_BY_ID` en
`scripts/run_scene.gd`. El retrato se pinta en un **PanelContainer 72×72** a la
izquierda del título del evento; el event_icon (36×36) sigue funcionando como
etiqueta de categoría a la derecha.

### 8.4 Animación de reveal (`_animate_event_reveal`)
Cada vez que `_render_current_event()` construye un evento nuevo:
1. **EventRow** entra desde la derecha (+24 px → 0 px, 0.34 s, cubic-out) con
   fade 0 → 1 en 0.28 s.
2. **AdvisorPortrait** pulsa con back-out de 0.86 → 1.0 en 0.42 s (pequeño
   pop de entrada que llama la atención al narrador).
3. **Botones de choice** se revelan en cascada: cada uno fade 0 → 1 y sube
   +8 px → 0 px con delay `0.10 + 0.08 × índice` s. Lee el ojo de arriba
   abajo sin robarle protagonismo al retrato.

El efecto conjunto es el de una carta girándose y revelando quién habla +
qué opciones tienes, manteniendo el mood "barajando el destino" sin cruzar
a animación caricaturesca.

### 8.5 Nota de implementación: no tocar `position` en children de VBox
El tween inicial usaba `position:y` para hacer un "slide up" de cada botón,
pero un botón que vive dentro de un `VBoxContainer` pierde esa posición en
cuanto el contenedor reordena (todos los botones colapsan a `y=0`). Desde
que el chip es un `Button.icon`, incluso la fuerza del tween deja ver la
colisión. Por eso la animación final **sólo** usa `modulate:a` — el layout
lo decide el `VBoxContainer` y el chip/texto viajan limpios.

---

## 9. Floaters de stats, pantalla de fin de run, chips de choice y fondo de menú

Cuatro capas de feedback visual que convierten cada decisión en un pequeño
teatro cinematográfico.

### 9.1 Stat floaters (`run_scene.gd::_emit_stat_floaters`)
Cuando una elección modifica `world_state`, se dispara un floater por cada
stat que cambia, anclado encima del icono HUD correspondiente:

- **Verde G3** para positivos (salud/poder suben); **rojo R4** para negativos.
- **Invertido** para `crisis`: subir crisis es rojo, bajarla es verde.
- Outline D0 grueso (4 px) para que el número se lea sobre cualquier panel.
- Anim 1.10 s: subida 42 px (cubic-out), fade tras 0.55 s.
- Se parentan a un `CanvasLayer` con `layer=50` creado lazy, así nunca los
  tapan overlays ni la run-end screen.

### 9.2 Run-end overlay (`scripts/ui/run_end_overlay.gd` + `scenes/RunEndOverlay.tscn`)
Pantalla dramática que se instancia como hijo del RunScene y permanece
`visible = false` hasta que `_finish_run` llama `show_outcome(outcome)`:

- **Victoria** → Canciller + título `VICTORY` (O4) + subtítulo narrativo.
- **Derrota** → Plaguewright + título `DEFEAT` (R4) + rayos rojos girando.
- **Timeout** → Arcanist + título `TIME OUT` (C4) en tono neutro.

El overlay pinta en `_draw()` un abanico de rayos girando lentamente desde
el centro (velocidad +0.15 rad/s en victoria, -0.10 rad/s en derrota) y
anillos concéntricos con fade radial (O4/R4 según outcome). Tras 2.8 s de
hold, o al hacer click/key, emite `finished` y RunScene cambia a MetaHub.

### 9.3 Choice-tag chips (24×24, `tools/art_gen/gen_choice_chips.py`)
Cinco emblemas octagonales con un ring dorado unificado. La cara D2
aloja la silueta del arquetipo y todos comparten notches dorados en los
puntos cardinales para que, pegados uno encima de otro en botones
verticales, creen un ritmo visible:

| Slug | Emblema | Momento de uso |
|------|--------|----------------|
| `tag_force` | Lanzas cruzadas sobre escudo R2 con remaches dorados | Opción agresiva: crisis ≥ +5 o controla regiones por la fuerza |
| `tag_diplomacy` | Laurel verde + paloma C4 con ojo | Ganancia de estabilidad/influencia sin penalización |
| `tag_science` | Retorta G2 con burbujas subiendo | Gastas recursos (-6 o más) para bajar crisis |
| `tag_sacrifice` | Columna rota C3 + humo B3 ascendiendo | Pérdida explícita (stab ≤ -4 o regiones -1) |
| `tag_economy` | Stack de 3 monedas con muesca de corona | Movimientos puramente económicos |

La inferencia de tag vive en `_infer_choice_tag(choice)`; eventos
existentes sin campo `tag` se categorizan solos. Cuando un evento futuro
incluya un `"tag"` explícito en `data/events.json`, el script respeta ese
valor sin re-inferir.

### 9.4 Fondo de MainMenu (`tools/art_gen/gen_menu_backdrop.py`)
Mural de 640×360 (x2 para llegar a 1280×720 nearest-neighbor) compuesto
en cuatro bandas parallax-ready: cielo agrietado con chispazos O4,
cinco arcos art-deco escalonados con el Canciller iluminado bajo el
central, friso de doce peregrinos (uno por región del consejo) con
ojos-speck O3, y piso de cenizas con grietas radiales. Sobre esto va un
`BackdropShade` D0 α=0.35 para garantizar lectura del título.

El backdrop se renderiza detrás del título vía `TextureRect` con
`texture_filter = 1` (nearest) y `modulate` 0.78 para que las columnas
respiren pero no compitan con el logo central.

### 9.5 MetaHub — archivo y tarjetas de tecnología
`scenes/MetaHub.tscn` reutiliza el `menu_backdrop` con `modulate` 0.55 y un
`BackdropShade` D0 α=0.55 encima para que la lectura de texto denso
prevalezca. Las techs se renderizan ahora como tarjetas horizontales con
cuatro zonas:

1. **Badge** — icono 20×20 en placa circular (ver 9.7).
2. **Info** — nombre a 18 pt + descripción autowrap a 13 pt modulate 0.82.
3. **Pill de coste** — "NN cr" en O3/D3 según affordability.
4. **Botón** — "UNLOCKED" (disabled) o "Unlock" (activo sólo si hay créditos).

### 9.6 Tendrils de plaga animados (`region_map.gd::_draw_plague_tendrils`)
Para cada región con infección ≥ 50%, el mapa pinta una corona de 4-7
strands rojos curvos que emanan del centroide. Características:

- **Intensidad escalar** con la infección desplegada (0 a 1 entre 50% y 100%).
- **Seed por-región** `id.hash() & 0xFFFF` para que las regiones ondulen
  desfasadas entre sí y no parezcan un efecto global.
- Cada strand es una polyline de 6 segmentos siguiendo
  `ang0 + sin(t*1.8 + i*0.7 + s*4.5) * 0.45`, con pull-back del 60% en el
  último 20% del recorrido → se curvan como serpientes.
- Doble stroke (R4 outer 2.2 px α 0.25-0.70, R3 core 1.0 px α 0.40-0.95)
  para profundidad sin costar draw calls extra.
- **Pústula central** pulsando a 3.1 Hz con highlight R4 interior, sirve
  de "ombligo" de la infección incluso cuando la región está fría.

Se dibuja como Pass 2d (después de coastlines y rings, antes de iconos de
bioma y labels) para que los strands atraviesen el borde de la región pero
queden bajo el texto y los biome icons.

### 9.7 Tech badges 20×20 (`tools/art_gen/gen_tech_badges.py`)
Sustituyen los placeholders `* / $ / -` por tres emblemas sobre placa
circular plum con ring dorado tarnished. Cada badge comunica un estado sin
necesidad de leer el coste:

| Slug | Emblema | Estado |
|------|--------|--------|
| `badge_unlocked` | Estrella de cinco puntas O5 con corazón O4 | Tech ya adquirida — trofeo |
| `badge_affordable` | Stack de tres monedas O2→O4 con chip R3 | Tienes créditos suficientes |
| `badge_locked` | Eslabón de cadena B2/B3 partido + polvo C1 | Fuera de alcance / bloqueada |

En `meta_hub.gd` el badge es un `TextureRect` 32×32 con
`texture_filter = NEAREST`, así la escala preserva el pixel clean. El
`stretch_mode = KEEP_ASPECT_CENTERED` permite que si algún día reescalamos
la fila a 40 px, el badge no deforme.

### 9.8 Title pulse del MainMenu (`main_menu.gd::_process`)
El `TitleRow/Title` TextureRect respira con un sine de 1.4 rad/s:

- **Escala** `1.0 ± 1.2%` (imperceptible hasta que los ojos se aclimatan).
- **Modulate** tinte cálido variable sobre canales G/B, simulando el
  resplandor O2 → O4 de una brasa asentándose. Nunca satura de color.
- Pivot center recalculado en `resized` signal para que el pulse no empuje
  el logo del eje cuando el layout responde a tamaños distintos.

Combinado con el mural `menu_backdrop`, el resultado es que incluso en
idle la pantalla inicial se siente como un fresco vivo donde la luz oscila
lentamente sobre el Canciller.

### 9.9 Region-pick mode (selector de región activo)
Durante `player_chooses`, la UI tenía un problema de lectura: los botones
quedaban deshabilitados (gris) y el único pista era un `>` al final de la
descripción (ver QA BUG-005). La nueva capa añade tres señales
redundantes para que el jugador no dude:

1. **Hint banner** en gold O4 al principio del `Choices` VBox
   (`[!] Pick a region on the map.`) con outline D0 4 px, breath loop 0.72
   ↔ 1.0 a ~0.8 Hz, fade-in 0.28 s cubic-out.
2. **Ring pulsante** en las regiones elegibles: `RING_SELECTABLE` ahora
   modula alfa entre 0.65 y 1.0 y grosor 2.6 → 3.8 con sine `4.2 rad/s`,
   destacando sobre el ruido del mapa sin sobre-animar el resto.
3. Los botones deshabilitados permanecen visibles debajo, mostrando las
   opciones sintácticamente pero claramente secundarias.

El banner vive el ciclo de vida del pick: se añade en
`_begin_region_pick_mode`, se libera automáticamente por el `queue_free`
de children en el próximo `_render_current_event`, y el tween de breath se
almacena como meta por si hubiera que cortarlo antes.

### 9.10 Etiquetas del mapa + legenda (`I:V:` → `INF/PLG`)
Las etiquetas de región usaban `I:NN V:NN` — ambiguas (QA BUG-008). El
nuevo formato es `INF NN . PLG NN` en dos mitades pintadas con color:

- **INF** en cream TOOLTIP_TEXT (influencia política del jugador).
- Separador `" . "` en alpha 0.45 para crear ritmo sin ruido.
- **PLG** en R4 rose-red, bumpeado a R4+0.07 luminosidad cuando la región
  ≥ 50% de plaga (refuerzo visual con los tendrils de 9.6).

En la esquina inferior izquierda del mapa vive una mini-legenda de 10 pt:
`INF influence · PLG plague` (siglas en su color real, glosas en alpha
0.55) para que la primera vez que se vea la UI, el significado quede claro
sin necesidad de hover.

El tooltip se alineó al nuevo vocabulario (`Plague` en vez de
`Infection`) para que la palabra que ve el jugador al hoverar coincida
con la abreviatura que lee en el label.
