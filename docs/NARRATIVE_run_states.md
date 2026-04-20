# Guion de Estados de Run — Microtexto in-game
# Run-State Script — In-game Microtext

> *"Hasta un botón puede bajar la voz, si está bien escrito."*
> *"Even a button can lower its voice, if it is well written."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuente canónica / Canonical source:** `docs/LORE_bible.md`.
**Ámbito / Scope:** textos cortos que aparecen en menús, cabeceras, botones, pantallas de transición y confirmaciones. Diseñados para ser intercambiables sin romper layout (límites de caracteres indicados).

---

## Convenciones / Conventions

- **Columnas paralelas EN/ES.** Un diseñador puede copiar la columna sin traducir.
- **Límites estrictos:** títulos ≤ 32 car., subtítulos ≤ 64 car., botones ≤ 24 car., flavor ≤ 120 car. Si una línea excede, se proporciona variante corta.
- **Voz:** todo el microtexto narrativo usa la voz del Coro (oracular, sujeto implícito). El microtexto puramente funcional (botones de "volver", "continuar") es más seco — **pragmático puro**, no mítico.
- **No cambiar términos canónicos.** *Marea, Sombra, Fresco, Pulso, Velo, Coalición* — tal como figuran en `LORE_bible.md §6`.

---

## 1. Menú principal / Main Menu

### Título del juego (ya fijado, referencia)
- Canónico: **CivPlagueRush**. *(Nombre de producto; no traducir.)*

### Tagline bajo el título
- ES (largo): *Después del Brote, la Coalición aprende a poner la mesa otra vez.*
- EN (long): *After the Outbreak, the Coalition learns to set the table again.*
- ES (corto, ≤ 64 car.): *La Coalición aprende a poner la mesa otra vez.*
- EN (short, ≤ 64 car.): *The Coalition sets the table again.*

### Botones principales

| Función | ES (canónico, ≤ 24 car.) | EN (canonical, ≤ 24 car.) |
|---|---|---|
| Empezar campaña | **Empezar una Run** | **Begin a Run** |
| Ir al meta-hub | **Sala de Doctrinas** | **Hall of Doctrines** |
| Ajustes | **Ajustes** | **Settings** |
| Créditos | **Manos sobre el mapa** | **Hands on the Map** |
| Salir | **Cerrar la mesa** | **Close the Table** |

### Flavor text de fondo (opcional, se rota)
Cinco fragmentos que pueden rotarse en la pantalla del menú principal para dar textura ambiental. Ninguno supera 120 caracteres.

1. ES: *"La polilla vuela por encima del mapa. Nadie la invita; siempre entra."*
   EN: *"The moth crosses the map. No one invites it; it always enters."*
2. ES: *"En la Arcología del Norte, las lámparas no se apagan. Se turnan."*
   EN: *"In the Northern Arcology, the lamps do not go out. They take turns."*
3. ES: *"Seis notas siguen sonando. Son las que aprendimos a no olvidar."*
   EN: *"Six notes still play. The ones we learned not to forget."*
4. ES: *"La Marea no tiene prisa. Por eso llega siempre."*
   EN: *"The Tide is not in a hurry. That is why it always arrives."*
5. ES: *"Del Fresco queda el olor. Con eso se levanta un país."*
   EN: *"Of the Fresco, the smell remains. A country is raised with that."*

---

## 2. Cabecera de run / Run Header

Elementos que se muestran siempre en pantalla durante la partida.

### Etiqueta de turno
- ES: **Turno {n} de {total}**
- EN: **Turn {n} of {total}**

### Etiqueta del capítulo activo
- ES: **Capítulo 1 — Ecos de Ceniza**
- EN: **Chapter 1 — Echoes of Ash**

### Etiquetas de estadísticas globales (UI técnica)

Aquí la UI técnica **puede** usar los nombres mecánicos directos por claridad. Los textos narrativos de eventos usarán los nombres canónicos del Coro (ver `LORE_bible.md §6`). Esta dualidad es intencional.
Here the technical UI **may** use direct mechanical names for clarity. Narrative event texts will use the Chorus canonical names (see `LORE_bible.md §6`). This duality is intentional.

| Sistema | UI técnica ES | UI técnica EN | Nombre del Coro (en eventos) |
|---|---|---|---|
| stability | **Estabilidad** | **Stability** | *el Pulso / the Pulse* |
| influence | **Influencia** | **Influence** | *(sin sinónimo del Coro — "influencia" es neutral)* |
| resources | **Recursos** | **Resources** | *(sin sinónimo — "oro manchado" solo como metáfora)* |
| crisis | **Marea** | **Tide** | *la Marea / the Tide* |
| control_regions | **Luces firmes** | **Steady Lights** | *(metáfora viva; conservarla)* |

> **Nota de estilo:** los nombres **Marea** y **Luces firmes** son canónicos incluso en la UI técnica. Son más evocadores que "crisis" y "regiones controladas" sin perder legibilidad. Si en algún lugar dice "crisis", rotar a "Marea".

### Tooltips de cabecera (≤ 100 car.)

- **Pulso / Pulse (stability):**
  - ES: *"El aliento común de la Coalición. Si baja a nada, las mesas largas se vacían."*
  - EN: *"The Coalition's common breath. If it falls to nothing, the long tables empty."*

- **Influencia / Influence:**
  - ES: *"La mano con que la Coalición firma sin firmar."*
  - EN: *"The hand with which the Coalition signs without signing."*

- **Recursos / Resources:**
  - ES: *"Oro manchado, trigo, repuestos. Todo lo que pesa y alimenta."*
  - EN: *"Tarnished gold, grain, spare parts. Everything that weighs and feeds."*

- **Marea / Tide (crisis):**
  - ES: *"La Sombra global. Sube despacio. Cuando llega al marco del mapa, la run se cierra."*
  - EN: *"The global Shadow. It rises slowly. When it reaches the map's frame, the run closes."*

- **Luces firmes / Steady Lights (controlled regions):**
  - ES: *"Regiones donde la Coalición no tiembla al encender la lámpara."*
  - EN: *"Regions where the Coalition does not tremble when lighting the lamp."*

---

## 3. Mini-mapa regional / Regional Mini-map

### Leyenda / Legend

Dos gradientes visibles (influencia y Sombra). Textos de leyenda:

- ES: **Influencia / Sombra**
- EN: **Influence / Shadow**

### Tooltips de región (formato plantilla)

Plantilla dinámica que se renderiza con los stats en vivo. El Coro da la frase introductoria; los números son UI técnica.

**Formato ES:**
```
{region.name} ({region.short})
{chorus_line_from_atlas}
— — —
Influencia: {influence} / 100
Sombra: {infection} / 100
Pulso: {stability} / 100
Vecinas: {neighbors_short_list}
```

**Format EN:**
```
{region.name} ({region.short})
{chorus_line_from_atlas}
— — —
Influence: {influence} / 100
Shadow: {infection} / 100
Pulse: {stability} / 100
Neighbors: {neighbors_short_list}
```

La `chorus_line_from_atlas` es el "Coro regional" de `docs/NARRATIVE_regions.md` para esa región. Una sola línea italicizada.

### Mensajes de selección regional (cuando un evento pide target)

- ES: **Elige una región.** *{target_prompt del evento}*
- EN: **Pick a region.** *{event target_prompt}*

Botones de confirmación/cancelación:
- ES: **Confirmar objetivo** | **Pensarlo otra vez**
- EN: **Confirm target** | **Reconsider**

---

## 4. Panel de evento / Event Panel

### Etiquetas genéricas

| Elemento | ES (≤ 24 car.) | EN (≤ 24 car.) |
|---|---|---|
| Cabecera "ha surgido algo" | **Un eco nuevo** | **A new echo** |
| Botón de confirmar elección | **Firmar** | **Sign** |
| Botón de ver detalles | **Escuchar al Coro** | **Listen to the Chorus** |
| Indicador de "evento regional" | **Eco regional** | **Regional echo** |
| Indicador de "evento global" | **Eco continental** | **Continental echo** |

### Cabecera contextual cuando aparece un evento

- ES: *"El Coro baja la voz. Algo pide gesto."*
- EN: *"The Chorus lowers its voice. Something asks for a gesture."*

### Después de firmar una elección (antes de resolver)

- ES: *"La mano se cierra sobre el mapa."*
- EN: *"The hand closes over the map."*

### Mientras se aplican los efectos (pantalla de pausa breve, ≤ 64 car.)

- ES: *"El Fresco asimila el gesto."*
- EN: *"The Fresco takes in the gesture."*

---

## 5. Transiciones entre turnos / Turn Transitions

Texto que se muestra al final de cada turno, breve, rotable. Diez variantes; la UI puede elegir una al azar para dar textura.
Shown at the end of each turn — brief, rotatable. Ten variants; the UI may pick one at random for texture.

| # | ES | EN |
|---|---|---|
| 1 | *"La Marea hace su movimiento."* | *"The Tide makes its move."* |
| 2 | *"En las Llanuras, una caravana se detiene un minuto más de lo usual."* | *"On the Plains, a caravan stops a minute longer than usual."* |
| 3 | *"En la Arcología del Norte, alguien sirve té."* | *"In the Northern Arcology, someone pours tea."* |
| 4 | *"Una campana sin badajo se oye, lejos."* | *"A bell without clapper is heard, far away."* |
| 5 | *"El Coro cuenta. Deja de contar. Vuelve a contar."* | *"The Chorus counts. Stops counting. Counts again."* |
| 6 | *"La polilla cruza el mapa."* | *"The moth crosses the map."* |
| 7 | *"La canción de cuna llega al tercer verso y duda."* | *"The lullaby reaches the third verse and hesitates."* |
| 8 | *"Un fresco pierde otro color. Nadie lo anota."* | *"A fresco loses another color. No one notes it down."* |
| 9 | *"Los Derivados miran el mapa y siguen andando."* | *"The Drift looks at the map and keeps walking."* |
| 10 | *"La Sombra respira y retrocede medio paso."* | *"The Shadow breathes and draws back half a step."* |

### Transición de turno como tarjeta (formato)
- Título: **Turno {n+1}** / **Turn {n+1}**
- Subtítulo rotatorio: una de las 10 líneas de arriba.
- Botón: **Continuar** / **Continue**.

---

## 6. Pantalla de fin de run / Run Result Screen

### Cabecera

| Estado | ES (título, ≤ 24 car.) | EN (title, ≤ 24 car.) |
|---|---|---|
| Victoria con objetivo | **El Fresco respira** | **The Fresco Breathes** |
| Victoria sin objetivo | **Un mapa que aguanta** | **A Map That Holds** |
| Derrota por estabilidad | **La mesa se vacía** | **The Table Empties** |
| Derrota por Marea | **La Sombra aprende** | **The Shadow Learns** |

*(Los epílogos largos correspondientes están en `docs/NARRATIVE_chapter01.md §4`.)*

### Resumen de run (etiquetas)

| Campo | ES | EN |
|---|---|---|
| Duración | **Duración de la run** | **Run duration** |
| Turnos completados | **Turnos escuchados** | **Turns listened** |
| Regiones controladas al cierre | **Luces firmes al final** | **Lights steady at the end** |
| Marea al cierre | **Marea al cierre** | **Tide at close** |
| Hitos cumplidos | **Ecos que aguantaron** | **Echoes that held** |
| Créditos ganados | **Oro devuelto a la mesa** | **Gold returned to the table** |

### Botones

| Función | ES (≤ 24 car.) | EN (≤ 24 car.) |
|---|---|---|
| Ver epílogo (si hay) | **Leer al Coro** | **Read the Chorus** |
| Ir al meta-hub | **Ir a la Sala de Doctrinas** | **Go to the Hall of Doctrines** |
| Nueva run | **Otra run** | **Another run** |

---

## 7. Meta-Hub / Hall of Doctrines

### Título y subtítulo

- ES título: **Sala de Doctrinas**
- EN title: **Hall of Doctrines**

- ES subtítulo: *Lo que la Coalición ya no olvida.*
- EN subtitle: *What the Coalition no longer forgets.*

### Etiqueta de créditos (moneda del meta-hub)

- ES: **Oro devuelto** · *{count}*
- EN: **Gold returned** · *{count}*

### Ficha de doctrina (plantilla)

Cabecera, cuerpo y botón de desbloqueo. Los textos canónicos están en `docs/NARRATIVE_techs.md`.

```
{Doctrine canonical name}
{Chorus internal name (italic)}

{short tooltip, ≤ 120 char.}

— — —
{pragmatic voice: mechanical effect}
```

### Botones de la ficha

| Estado | ES (≤ 24 car.) | EN (≤ 24 car.) |
|---|---|---|
| Puede desbloquearse | **Recordar para siempre** | **Remember forever** |
| Ya desbloqueada | **Hábito adquirido** | **Habit kept** |
| No alcanza coste | **No alcanza el oro** | **Not enough gold** |

### Mensaje al desbloquear

- ES: *"La Coalición aprende un gesto nuevo. La próxima vez, ya lo sabrá."*
- EN: *"The Coalition learns a new gesture. Next time, it will already know it."*

### Botón volver

- ES: **Volver al mapa** | EN: **Return to the map**

---

## 8. Pantallas de pausa y confirmación / Pause & Confirm Screens

### Pausa

- Título: **Pausa** / **Pause**
- Subtítulo rotatorio (opcional, 3 variantes):

| # | ES | EN |
|---|---|---|
| 1 | *"La mesa larga espera."* | *"The long table waits."* |
| 2 | *"El Coro baja la voz; no se va."* | *"The Chorus lowers its voice; it does not leave."* |
| 3 | *"La Marea no tiene prisa. Tú tampoco."* | *"The Tide is not in a hurry. Neither are you."* |

Botones:

| Función | ES (≤ 24 car.) | EN (≤ 24 car.) |
|---|---|---|
| Continuar | **Continuar la run** | **Continue the run** |
| Ajustes | **Ajustes** | **Settings** |
| Abandonar run | **Abandonar la mesa** | **Leave the table** |

### Confirmación de abandono

- Título ES: *¿Plegar la mesa?*
- Title EN: *Fold the table?*
- Cuerpo ES: *"Si pliegas la mesa, perderás el progreso de esta run. El Coro recordará, aunque tú no quieras."*
- Body EN: *"If you fold the table, this run's progress is lost. The Chorus will remember, even if you would rather not."*
- Botones: **Sí, plegar** / **Yes, fold** — **Volver a la mesa** / **Back to the table**

---

## 9. Créditos / Credits

### Título de la pantalla
- ES: **Manos sobre el mapa**
- EN: **Hands on the Map**

### Introducción
- ES: *"Lo que el Fresco no recuerda, lo recuerdan las manos que lo sostienen."*
- EN: *"What the Fresco does not remember, the hands that hold it remember."*

### Botón de volver
- ES: **Volver al menú** | EN: **Return to menu**

---

## 10. Mensajes de sistema genéricos / Generic System Messages

Catálogo de pequeñas frases reutilizables. Respetan el tono pragmático cuando son mecánicos, oracular cuando son de sabor.

| Situación | ES | EN |
|---|---|---|
| Guardando | **Guardando en la mesa larga…** | **Saving to the long table…** |
| Cargando | **Desplegando el mapa…** | **Unfolding the map…** |
| Conectando | **Buscando al Coro…** | **Searching for the Chorus…** |
| Error genérico | **Se rompió una línea. Vuelve a intentar.** | **A line broke. Try again.** |
| Nueva actualización disponible | **El Fresco tiene nuevos colores.** | **The Fresco has new colors.** |
| Sin conexión | **El mapa se ha quedado en silencio.** | **The map has fallen silent.** |

### Toasts de efecto regional (≤ 80 car.)

Mensajes que pueden aparecer sobre el mini-mapa cuando una región pasa umbrales.

| Situación | ES | EN |
|---|---|---|
| Región alcanza "luz firme" (>= 60 influence) | *"{region.short}: luz firme."* | *"{region.short}: steady light."* |
| Región cae de "luz firme" | *"{region.short}: la luz parpadea."* | *"{region.short}: the light flickers."* |
| Región alcanza Sombra crítica (>= 80 infection) | *"{region.short}: la Sombra se queda."* | *"{region.short}: the Shadow stays."* |
| Región se limpia por completo (infection = 0) | *"{region.short}: un color vuelve al fresco."* | *"{region.short}: one color returns to the fresco."* |

---

## 11. Errores narrativos prohibidos / Forbidden narrative errors

Revisar microtexto nuevo contra esta lista:
Run new microtext against this list:

1. No decir *"crisis"* en textos narrativos; decir *"Marea"*.
2. No decir *"infección"* en textos narrativos; decir *"Sombra"*.
3. No usar emojis, exclamaciones entusiastas (*¡Victoria!*), ni emoticonos ASCII.
4. No llamar al jugador *"tú"* excepto en saludos del menú principal. En texto de evento, el Coro nunca dice *"tú"* directo.
5. No decir *"virus"* salvo en voz pragmática explícita (p. ej. informe técnico dentro de un evento).
6. No usar *"gracias a ti"*, *"has logrado"*, *"felicidades"*. El Coro no felicita. Reconoce.
7. No mezclar idiomas en un mismo campo. Siempre ES o EN, nunca ES con una palabra EN.
8. No revelar qué ES la plaga. Cualquier texto que afirme su naturaleza debe reescribirse.

---

## 12. Catálogo de frases del Coro para uso flexible / Chorus phrase bank

Frases cortas (≤ 80 car.) que pueden insertarse en lugares no previstos — pantallas de carga, eventos sin descripción, banners de transición. Todas canónicas.

| # | ES | EN |
|---|---|---|
| 1 | *"El Coro baja la voz. No se va."* | *"The Chorus lowers its voice. It does not leave."* |
| 2 | *"Una mano se cierra sobre el mapa."* | *"A hand closes over the map."* |
| 3 | *"La Marea escucha."* | *"The Tide listens."* |
| 4 | *"El Fresco guarda un color más por hoy."* | *"The Fresco keeps one more color for today."* |
| 5 | *"Seis notas, y una callada."* | *"Six notes, and one silent."* |
| 6 | *"El Velo es más delgado esta noche."* | *"The Veil is thinner tonight."* |
| 7 | *"La canción de cuna llega hasta el segundo verso."* | *"The lullaby reaches the second verse."* |
| 8 | *"En la Cuna no canta el Coro. Escucha."* | *"In the Cradle the Chorus does not sing. It listens."* |
| 9 | *"Alguien firma. Alguien recuerda."* | *"Someone signs. Someone remembers."* |
| 10 | *"La polilla entra por una ventana que no debería estar abierta."* | *"The moth enters through a window that should not be open."* |
| 11 | *"Los Derivados pasan. No juzgan."* | *"The Drift passes. It does not judge."* |
| 12 | *"Oro manchado, pan dividido, noche entera."* | *"Tarnished gold, divided bread, one whole night."* |

---

## 13. Mapa de correspondencia texto→lugar en UI / Text-to-UI mapping

Para que un diseñador sepa dónde va cada bloque sin adivinar:
So a designer knows where each block belongs without guessing:

| Sección narrativa | Destino UI |
|---|---|
| §1 Menú principal | `scenes/MainMenu.tscn` |
| §2 Cabecera de run | `scenes/RunScene.tscn` — header |
| §3 Mini-mapa | `scenes/RegionMap.tscn` — leyenda y tooltips |
| §4 Panel de evento | `scenes/RunScene.tscn` — EventPanel |
| §5 Transiciones | `scenes/RunScene.tscn` — transición entre turnos |
| §6 Fin de run | `scenes/RunScene.tscn` — resultado / cargar `NARRATIVE_chapter01.md §4` |
| §7 Meta-hub | `scenes/MetaHub.tscn` |
| §8 Pausa | overlay en `scenes/RunScene.tscn` |
| §9 Créditos | pantalla aún no implementada, reservar nombre |
| §10 Mensajes de sistema | cualquier overlay genérico |
| §11/12 Reglas y catálogo | referencia interna, no va a UI directa |

---

*Fin del guion. Cada botón es una pequeña liturgia. Cada transición, un respiro del Fresco.*
*End of the script. Each button is a small liturgy. Each transition, a breath of the Fresco.*
