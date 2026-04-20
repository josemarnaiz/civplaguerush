# Diseño: Mapa regional con propagación (tipo Plague Inc.)

**Estado**: Propuesta / esperando implementación.
**Objetivo**: Sustituir el contador abstracto `control_regions` por un **mini-mapa visual de 12 regiones** con influencia por región y **propagación de crisis** entre regiones vecinas.

---

## 1. Estado actual (resumen)

- `WorldSimulation` mantiene un `world_state` con 5 escalares globales: `stability`, `influence`, `resources`, `crisis`, `control_regions` (este último es un entero 0..12, sin geografía).
- `EventDirector` elige 3-4 eventos aleatorios por turno de un pool de 5 eventos genéricos (ver `data/events.json`).
- Los efectos de las decisiones suman/restan a los escalares globales. Ej. `control_regions: +1` incrementa el contador sin especificar qué región.
- La condición de victoria es `control_regions >= 8 && crisis <= 60`.
- No hay mapa visual. La UI (`RunScene.tscn`) solo muestra un `Label` con los stats.

**Limitaciones**:
- No hay decisiones espaciales ("¿qué región priorizo?").
- La crisis no tiene foco geográfico.
- El jugador no tiene una lectura visual del progreso.

---

## 2. Objetivos de diseño

1. **12 regiones visibles en una cuadrícula/hexrejilla** con nombre y estado propio.
2. **Cada región** tiene:
   - `influence` (0..100) — tu control en esa región.
   - `infection` (0..100) — nivel de crisis/plaga local.
   - `stability` (0..100) — salud política local.
   - `adjacency` — lista de vecinos.
3. **Propagación**: cada turno, la infección de una región contamina a sus vecinos proporcionalmente a la diferencia, modulada por tu `influence` en el destino (cuanta más influencia, más resistencia).
4. **Decisiones con objetivo regional**: muchas decisiones ahora piden elegir "en qué región aplicarla".
5. **Stats globales derivados** (no eliminados, pero calculados a partir de las regiones):
   - `control_regions` = nº de regiones con `influence >= 60`.
   - `crisis` global = media ponderada de `infection`.
   - `stability` global = media de `stability` regional.
   - `influence` y `resources` siguen siendo globales (pool del jugador).
6. **Condiciones de victoria/derrota** se mantienen pero usando los derivados.

---

## 3. Arquitectura propuesta

### 3.1 Datos

Nuevo archivo `data/regions.json`:

```json
{
  "regions": [
    { "id": "r01", "name": "Northern Arcology", "grid": [1, 0], "neighbors": ["r02", "r04"] },
    { "id": "r02", "name": "Ashen Plains",      "grid": [2, 0], "neighbors": ["r01", "r03", "r05"] },
    ...
  ]
}
```

Layout sugerido: **hex-grid 4x3** (12 celdas) o **rejilla rectangular 4x3** con adyacencias ortogonales+diagonales.

### 3.2 Nuevo sistema: `RegionGrid`

Archivo: `scripts/systems/region_grid.gd`.

```gdscript
class_name RegionGrid
extends RefCounted

var regions: Dictionary = {} # id -> Dictionary{influence, infection, stability, neighbors, name, grid}

func initialize(region_defs: Array, starting_state: Dictionary) -> void
func apply_regional_effect(region_id: String, effect: Dictionary) -> void
func propagate_infection(global_crisis_decay: int) -> void
func controlled_count(threshold: int = 60) -> int
func global_crisis() -> float
func global_stability() -> float
func snapshot() -> Array
```

**Algoritmo de propagación** (cada turno, tras resolver eventos):

```
for each region R:
    delta = 0
    for each neighbor N:
        diff = N.infection - R.infection
        if diff > 0:
            # resistance: 0 influence = 1.0 transfer, 100 influence = 0.2 transfer
            resistance = 1.0 - (R.influence / 100.0) * 0.8
            delta += diff * 0.10 * resistance
    R.infection = clamp(R.infection + delta - global_crisis_decay, 0, 100)
```

### 3.3 Integración con `WorldSimulation`

- `WorldSimulation` pasa a **componer** `RegionGrid`.
- `world_state.control_regions` y `world_state.crisis` se recalculan desde `region_grid.snapshot()`.
- `apply_effects()` soporta efectos regionales `{"region": "r03", "influence": 10, "infection": -5}` además de los globales.
- `apply_passive_turn_effects()` llama a `region_grid.propagate_infection(...)`.

### 3.4 Extensión de eventos

`events.json` gana un nuevo tipo de elección:

```json
{
  "id": "outbreak_focus",
  "title": "Outbreak in {region.name}",
  "template": "regional_random_infected",
  "choices": [
    {
      "label": "Quarantine the region",
      "effects_regional": { "infection": -15, "influence": -5 },
      "effects_global": { "resources": -6 }
    },
    {
      "label": "Invest in local medical grid",
      "effects_regional": { "infection": -8, "stability": 5 },
      "effects_global": { "resources": -10 }
    },
    {
      "label": "Ignore and build a cordon",
      "effects_adjacent": { "influence": -2 },
      "effects_regional": { "infection": 5 }
    }
  ]
}
```

`EventDirector` resuelve el `template` antes de mostrarlo (elige una región que cumpla criterios, p. ej. "la más infectada", "una fronteriza no controlada", etc.) y sustituye placeholders `{region.name}` en título/descripción.

### 3.5 UI: `RegionMap`

Nueva escena: `scenes/RegionMap.tscn` (control embebido en `RunScene` encima del panel de evento).

- `Control` de tamaño fijo que dibuja 12 celdas (Polygon2D o botones con estilos).
- Cada celda muestra color según:
  - **Verde → gris** en escala de `influence`.
  - **Overlay rojo translúcido** según `infection`.
  - Número/etiqueta con nombre abreviado.
- Click en celda → selección; si el evento pide objetivo regional, confirma selección.
- Tooltips con stats detallados.

Layout en `RunScene.tscn`:

```
Margin / VBox
├─ Header (Turn, Chapter)
├─ RegionMap (nuevo, ocupa ~40% alto)
├─ StatePanel (stats globales derivados)
├─ EventPanel (igual pero con soporte de selección regional)
└─ Footer (Progress, Back)
```

---

## 4. Datos iniciales sugeridos (12 regiones)

Mapa narrativo temático "Echoes of Ash":

| id  | nombre              | grid  | notas                                  |
|-----|---------------------|-------|----------------------------------------|
| r01 | Northern Arcology   | (0,0) | Start player region. Influence 70.    |
| r02 | Coastal Spires      | (1,0) | Start player region. Influence 60.    |
| r03 | Ashen Plains        | (2,0) | Neutral. Medium infection 30.         |
| r04 | Frozen Wastes       | (3,0) | Neutral. Low infection.               |
| r05 | Rustbelt Hubs       | (0,1) | Infection hotspot 60.                 |
| r06 | Silica Valley       | (1,1) | Key economic. Neutral.                |
| r07 | Cradle of Ruins     | (2,1) | High infection 70 (outbreak origin).  |
| r08 | The Veil            | (3,1) | Rival influence, low.                 |
| r09 | Southern Drylands   | (0,2) | Neutral.                              |
| r10 | Sunken Archipelago  | (1,2) | Isolated (fewer neighbors).           |
| r11 | Deep Equator        | (2,2) | High infection 50.                    |
| r12 | Scorched Peaks      | (3,2) | Rival. Very low influence.            |

Adyacencias = rectangular con diagonales (cada celda central tiene 8 vecinos, bordes menos).

---

## 5. Plan de implementación por fases

### Fase 1: Modelo de datos + simulación (sin UI todavía) — **DONE**
1. [x] Crear `data/regions.json` con 12 regiones, adyacencias, estado inicial.
2. [x] Crear `scripts/systems/region_grid.gd` con `initialize`, `apply_regional_effect`, `propagate_infection`, derivados.
3. [x] Modificar `WorldSimulation` para componer `RegionGrid`. Calcular `control_regions` y `crisis` como derivados.
4. [x] Ajustar `RunScene` para inicializar `RegionGrid` (el mapa orgánico sustituye al `StatsLabel` como fuente principal).
5. [x] **Test manual**: stats globales coherentes tras decisiones y propagación (validado vía MCP).

### Fase 2: Eventos regionales (mezcla con los globales existentes) — **DONE**
6. [x] Añadir eventos regionales con `template: ...` en `events.json` (`outbreak_focus`, `frontier_uprising`, `defector_cell`, `relief_mission`, y en Fase 4 `sabotage_strike`, `cure_trial`, `mass_migration`).
7. [x] Extender `EventDirector` para resolver templates y elegir regiones objetivo (`most_infected`, `least_influence`, `bordering_controlled`, `frontier_controlled`, `player_chooses`).
8. [x] Extender el resolver de efectos para soportar `effects_regional`, `effects_adjacent`.
9. [x] **Test**: "Outbreak in {region.name}" aparece con región real y las elecciones la afectan (validado vía MCP).

### Fase 3: UI del mini-mapa — **DONE**
10. [x] Crear `scenes/RegionMap.tscn` (no GridContainer — se usaron polígonos orgánicos por petición del director).
11. [x] Script `scripts/ui/region_map.gd` con señal `region_clicked(id)`, métodos `refresh(snapshot)` / `build_from_snapshot`, pintado por `influence`/`infection`.
12. [x] Integrar en `RunScene.tscn`. Refresco tras cada decisión y propagación.
13. [x] Modo "pick region" para eventos regionales (`set_selectable` / `clear_selectable`).

### Fase 4: Pulido y balance — **DONE**
14. [x] Ajustar `run_config.json`: `win_conditions.target_control_regions = 7`, `max_crisis_for_win = 50`, bloque `propagation` (`rate`, `resistance_factor`, `passive_drift`, `global_crisis_decay`).
15. [x] Animación suave (tween) cuando cambia influence/infection — via `_display_values` lerp en `region_map.gd`.
16. [x] Tooltip con detalles al pasar el ratón (región + stats + vecinos).
17. [x] Feedback visual cuando un evento regional apunta a una región (`set_active_target` → pulse dorado). *Pendiente*: flash rojo cuando una región pierde control por debajo del umbral — opcional.
18. [x] Actualizar `docs/DESIGN_regional_map.md` con el estado implementado (este documento).

### Fase 5 (post-release): distribución — **DONE inicialmente**
19. [x] `export_presets.cfg` configurado para Web, Windows Desktop, Android.
20. [x] Build Windows validada: `build/windows/CivPlagueRush.exe` arranca con el theme Ashen Fresco.
21. [x] Autoplay headless: `tools/autoplay_exe.ps1` corre una run completa contra el `.exe` exportado usando el MCP TCP embebido, con snapshots por turno en `build/windows/autoplay-runs/<stamp>/`.
22. [ ] Exportar y validar preset Web (siguiente sprint).
23. [ ] Exportar y validar preset Android (siguiente sprint).

---

## 6. Cambios de balance esperados

| Antes                              | Después                                         |
|------------------------------------|-------------------------------------------------|
| `control_regions +1` por evento    | `influence +10` en región elegida               |
| Crisis sube +2 pasivo cada turno   | Propagación por adyacencia (más emergente)      |
| Victoria: 8 regiones y crisis ≤60  | Victoria: 7 regiones (influence≥60) y media infection ≤50 |
| Elección táctica: qué stat subir   | Elección táctica + geográfica: **dónde** actuar |

---

## 7. Riesgos

- **Complejidad de UI táctil**: celdas demasiado pequeñas en móvil. Mitigación: GridContainer responsivo, `platform_profile` ajusta tamaño mínimo.
- **Propagación demasiado rápida/lenta**: tuning necesario. Mitigación: exponer coeficientes en `run_config.json`.
- **Eventos regionales + globales mezclados pueden confundir**: claridad visual en el evento (icono de región si es regional).

---

## 8. Primer commit objetivo

Fase 1 completa: modelo de regiones + propagación, sin UI nueva todavía, pero los stats derivados funcionan y las runs siguen siendo jugables como antes.
