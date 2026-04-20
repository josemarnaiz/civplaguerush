# Manual de estilo narrativo / Narrative Style Guide

> *"Se escribe como el Fresco: con media mano."*
> *"One writes like the Fresco: with half a hand."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Destinatarios / Audience:** cualquier persona (humana o agente) que escriba texto canónico para `CivPlagueRush` — eventos, diálogos, UI, coleccionables, marketing, sermones, VO. Incluye programadores que añaden un *tooltip*.
**Ámbito / Scope:** reglas de tono, léxico, sintaxis, prohibiciones y plantillas de escritura. Todo el material del corpus se ha redactado siguiendo este documento; toda nueva pieza debe validarse contra él.

**Regla cero / Rule zero:** *si te pica escribir una metáfora, quítale un adjetivo.*
*If a metaphor itches, remove an adjective.*

---

## 1. Voz maestra / Master voice

El narrador maestro del juego es el **Coro de Ceniza** — una voz colectiva, femenina, mayor, ligeramente distante, no omnisciente pero bien informada. Desde esa voz maestra cuelgan todas las demás: eventos, personajes, UI, marketing.
The master narrator is the **Ash Chorus** — a collective voice, female, aged, slightly distant, not omniscient but well-informed. All other voices descend from it: events, characters, UI, marketing.

### Tres pilares tonales (ya cerrados en canon)

1. **Mítico / Mythic.** Frases que suenan como si llevaran siglos dichas.
2. **Pragmático / Pragmatic.** Hechos concretos, sin retórica.
3. **Melancólico / Melancholic.** Lo perdido, dicho sin drama.

Se mezclan. Un evento con solo uno de los tres es un evento fallido. Proporción útil: **50% pragmático, 30% melancólico, 20% mítico**. Variar por contexto.
They mix. An event with only one is a failed event. Useful ratio: **50 % pragmatic, 30 % melancholic, 20 % mythic**. Vary by context.

---

## 2. Léxico / Lexicon

### 2.1. Palabras canónicas / Canonical words

Lista cerrada (también en `LORE_bible.md`). No se traducen libremente.
Closed list (also in `LORE_bible.md`). Not freely translated.

| ES | EN | Referente |
|---|---|---|
| el Fresco | the Fresco | la civilización perdida, el mundo heredado |
| la Grieta / el Estallido | the Cracking / the Outbreak | el evento colapso original |
| los Años de Ceniza | the Ash Years | la era del presente |
| el Coro de Ceniza | the Ash Chorus | el narrador mítico, memoria distribuida |
| la Marea | the Tide | la crisis global (sustituye "crisis" en texto mítico) |
| el Pulso | the Pulse | la estabilidad (sustituye "stability" en texto mítico) |
| la Sombra | the Shadow | la infección regional (sustituye "infection") |
| la Influencia | Influence | influencia regional (término admitido en UI) |
| la Cuna | the Cradle | la Cuna de Ruinas (r07) |
| la Doctrina del Velo | the Veil Doctrine | facción del silencio formal |
| el Oído Hundido | the Sunken Ear | el coro sumergido (Cap.2) |
| los Custodios | the Custodians | los habitantes del Oído |
| la Tercera Voz | the Third Voice | el coro de Cap.3 |
| la mesa larga | the long table | el consejo administrativo |
| la firma | the signature | el gesto de decisión política |
| la Coalición | the Coalition | la alianza administrativa actual |

Cualquier sinónimo improvisado (*"la calamidad"*, *"la plaga", salvo en contexto técnico fuera de texto mítico*) rompe el canon.
Any improvised synonym (*"the calamity,"* *"the plague,"* except in technical non-mythic context) breaks canon.

### 2.2. Palabras prohibidas / Forbidden words

- **apocalipsis / apocalypse** — lo que pasó fue concreto, no cósmico.
- **virus, bacteria, patógeno / virus, bacterium, pathogen** — la plaga no se nombra médicamente.
- **épico / epic, legendario / legendary, mítico** (este último solo como descriptor interno, no en texto del juego).
- **zombie, muerto viviente / undead, revenant** — no es ese tipo de juego.
- **horda / horde, ejército / army** — las amenazas no son masa.
- **misión / mission, quest** — las situaciones son *decisiones*, *firmas*, *eventos*.
- **héroe / hero, villano / villain** — no hay héroes nombrados.
- **salvación / salvation, salvar / save** — se *sostiene*, se *conserva*, se *reparte*, se *firma* — no se salva.
- **destino / destiny, fate** — determinismo que el juego rechaza.
- **destruir / destroy, aniquilar / annihilate** — en el Fresco las cosas *se caen*, *se apagan*, *se olvidan*.
- **luchar contra, derrotar / fight against, defeat** — no hay combate. Usar *gestionar*, *atender*, *responder*.

Si una palabra prohibida parece inevitable, probablemente la frase está mal enfocada. Reescribir el marco antes que buscar sinónimo.
If a forbidden word seems unavoidable, the framing is wrong. Reframe before seeking a synonym.

### 2.3. Palabras sobrias / Sober words

Preferimos estas a sus alternativas más dramáticas:
Prefer these to their more dramatic alternatives:

| Preferido | Evita |
|---|---|
| caer (cae, se cayó) | colapsar, desmoronarse, venirse abajo |
| apagar(se) | morir (para cosas no vivas), extinguir |
| soltar | abandonar, renunciar (en contextos emocionales) |
| firmar | decretar, ordenar, promulgar |
| sostener | mantener a toda costa, defender |
| atender | resolver, solucionar |
| callar | silenciar, amordazar |
| pasar (algo pasó) | acontecer, suceder (demasiado formal para el Coro) |
| doler | sufrir, padecer |

Reglas paralelas en inglés:
Parallel rules in English:

| Prefer | Avoid |
|---|---|
| fall | collapse, crumble, cave in |
| fade, go out | die (for things), extinguish |
| let go | abandon, renounce |
| sign | decree, order, enact |
| hold (up) | defend at all costs |
| attend (to) | solve, fix |
| fall silent | silence (trans.), gag |
| happen | befall, transpire |
| hurt (intransitive) | suffer, endure |

---

## 3. Sintaxis / Syntax

### 3.1. Frases cortas / Short sentences

- Meta: **promedio ≤ 16 palabras por frase** en texto narrativo.
- Tolerado: una frase larga por párrafo, nunca dos seguidas.
- Preferir punto a coma. Preferir coma a punto y coma. Evitar dos puntos salvo cuando presenten una lista o un eco.
- En inglés, preferir *periods* a *em-dashes*. Un *em-dash* por párrafo, máximo.

### 3.2. Ritmo de tres / Rhythm of three

Construcción característica del corpus: **tres cláusulas breves**, las dos primeras paralelas, la tercera rompiendo la cadencia.
Signature construction: **three short clauses**, the first two parallel, the third breaking cadence.

> *La Marea sube. El Pulso baja. El té sigue templado.*
> *The Tide rises. The Pulse fades. The tea is still warm.*

> *Firmaron. Cerraron. La polilla esperó.*
> *They signed. They closed. The moth waited.*

Usar con moderación (dos por documento largo máximo). Abusar del ritmo de tres lo vuelve cliché interno.
Use sparingly (max two per long document). Overuse makes it an internal cliché.

### 3.3. Pausas / Pauses

- Pausas narrativas se marcan con **punto y aparte**, no con "…" (reservado para la Tercera Voz y el Oído Hundido).
- En diálogo oral (VO), sí se permite *"..."* para indicar respiración; en texto escrito en pantalla, **evitar**.
- Un párrafo de una sola frase está permitido y es una herramienta válida. Dos seguidos, no.

### 3.4. Persona / Person

- El Coro de Ceniza habla en **tercera persona**, a veces primera del plural (*"nosotros"* / *"we"*) para el continente como sujeto colectivo.
- Los personajes hablan en primera persona, siempre en el estilo de su *voice pack*.
- El jugador es **"tú"** / *"you"* — nunca *"usted"* / *"one"*.
- Los textos de UI (*tooltips*, botones) hablan al jugador directamente, en segunda persona, con la misma sobriedad que el Coro.
- **Nunca** primera persona del narrador omnisciente (*"nuestro juego"* es una blasfemia de tono).

### 3.5. Tiempo verbal / Tense

- Texto narrativo en **pasado**, como si ya hubiese ocurrido — aunque ocurra ahora. Es la voz del Coro. *"Llegó, firmó, se fue."*
- Descripciones de estado en **presente**. *"La Arcología del Norte está en pie."*
- Imperativos: **evitar**. Preferir condicional, infinitivo sustantivado, o subjuntivo:
  - ~~*"Abre la puerta"*~~ → *"Abrir la puerta"*, *"Podéis abrir la puerta"*.
- Futuro simple admitido con moderación. *"Volverá si ha de volver."*

---

## 4. Bilingüismo / Bilingualism

Toda pieza canónica se redacta en **paralelo ES/EN**. No se considera escrita hasta que las dos versiones existen y cuadran.

### 4.1. Equivalencia, no traducción / Equivalence, not translation

La versión inglesa no es traducción literal. Es **la misma pieza en otra lengua**. Permite:

- Reordenar frases si la cadencia lo pide.
- Cambiar una metáfora por su equivalente cultural (rara vez necesario).
- Acortar o alargar una frase para mantener el ritmo.

No permite:

- Cambiar el significado canónico.
- Añadir ideas que no están en la otra columna.
- Diluir un motivo (p. ej. "vela" → *"light"* sería una pérdida; se traduce *"candle"*).

### 4.2. Préstamos / Loanwords

Conservados en original en ambas versiones:

- *Fresco* — siempre en ambas.
- *Coro de Ceniza* / *Ash Chorus* — traducido, pero conservan mayúsculas.
- Nombres propios de personajes — **no se adaptan**. *Alma Veder* en EN es *Alma Veder*. *Osia/Ossia* admite la variante *Ossia* en EN (como en `NARRATIVE_characters.md`).
- Nombres de regiones — bilingües canónicos en `NARRATIVE_regions.md` y `data/regions.json`.

### 4.3. Voseo, tuteo, *you* / Address forms

- ES: **tuteo** general (*"tú"*). Excepción: Morn y Vadra **vosean** por edad y contexto; en español neutro, marcar con *"hijo/hija mía"* o *"hermano, hermana"*. No usar *"vos"* rioplatense — está fuera de canon.
- EN: *"you"* siempre, singular. *"Siblings"* para el Velo en plural.

### 4.4. Puntuación / Punctuation

- **ES usa signos de apertura**: `¿`, `¡`. No omitir nunca.
- **EN usa espaciado estándar** entre palabras, no doble espacio tras punto.
- Comillas: `"..."` en EN, `«...»` o `"..."` en ES (preferir `"..."` por consistencia tipográfica en Godot). Si usas `«»`, deben usarse en **todo** el documento.
- Emdash: `—` en ambas, con espacios a ambos lados.

---

## 5. Estructura de piezas frecuentes / Structure of common pieces

### 5.1. Evento / Event

Plantilla canónica (ver `NARRATIVE_events.md` y tiers 2/3):

1. **ID mecánico sugerido** (`snake_case`).
2. **Tipo** (global / regional + plantilla).
3. **Pilar dominante** (mítico / pragmático / melancólico) y, si aplica, personaje asociado.
4. **Título** bilingüe (≤6 palabras).
5. **Descripción corta** (1–2 frases) bilingüe.
6. **Descripción larga** (2–4 frases) bilingüe.
7. **Opciones** (2–3) con subtexto y eco posterior (*aftertone*) bilingüe.
8. **Efectos mecánicos sugeridos** en `effects` / `effects_regional` (JSON-like, inline).

### 5.2. Personaje / Character

Ver `NARRATIVE_characters.md`. Plantilla:

1. Nombre canónico, papel, aparición inicial (capítulo/evento).
2. Semblanza (3–5 frases).
3. Voz (registro, cadencia).
4. Muestras de voz (3–4 líneas bilingües).
5. Arco (por capítulo).
6. Gesto canónico.
7. Prohibiciones específicas del personaje.

### 5.3. Micro-texto de UI / UI microtext

Ver `NARRATIVE_run_states.md` y `NARRATIVE_ui_microtext.md`. Plantilla mínima:

- **ID del contexto** (pantalla, estado, transición).
- **Texto** bilingüe en una sola frase.
- **Longitud máxima** (caracteres ES y EN por separado).
- **Prohibiciones** (si aplica).

### 5.4. Coleccionable / Collectible

Ver `NARRATIVE_collectibles.md`. Plantilla:

- Categoría (Fresco Fragment, Veil Sermon, etc.).
- Título bilingüe.
- Texto (≤6 frases) bilingüe.
- Rareza narrativa (común / raro / único).
- Fuente canónica (personaje, época, lugar).

---

## 6. Escribir un evento: ejemplo comentado / Writing an event: commented example

Para ilustrar las reglas, un evento **incorrecto** y su versión corregida.

### ❌ Versión incorrecta / Incorrect version

> **Título:** *¡La plaga ataca la capital!*
>
> *La terrible plaga del Fresco ha llegado a la capital, destruyendo todo a su paso. La Coalición debe actuar rápido para salvar a los ciudadanos antes de que sea tarde. Los héroes de la Coalición luchan contra la horda de enfermos...*
>
> **Opción A:** *Enviar al ejército a combatir a los infectados.*

**Problemas:**
- *"¡La plaga ataca!"* — palabra prohibida (*plaga* nombrada sin eufemismo), y *"atacar"* personifica la crisis.
- *"terrible"*, *"rápido"*, *"destruyendo"* — adjetivos / verbos de tono épico.
- *"salvar"* — prohibido.
- *"los héroes", "luchan", "horda"* — tres prohibiciones en la misma frase.
- *"Enviar al ejército"* — no existe ejército en canon.

### ✅ Versión corregida / Corrected version

> **Título ES:** *La Sombra llega a la Arcología* · **EN:** *The Shadow Reaches the Arcology*
>
> **Descripción ES:** *La Sombra se ha hecho oír en el sector oeste de la Arcología del Norte. Alma Veder convoca mesa larga antes del té.*
> **Descripción EN:** *The Shadow has made itself heard in the western sector of the Northern Arcology. Alma Veder calls the long table before tea.*
>
> **Opción A ES:** *Enviar delegaciones médicas y aceptar la ayuda de Silika.*
> **Opción A EN:** *Send medical delegations and accept Silika's help.*

**Qué se hizo bien:**
- Usa la Sombra (palabra canónica) en vez de la plaga.
- Verbo *"llegar"* / *"reach"* en lugar de *"atacar"* / *"attack"*.
- Contextualiza con un personaje canónico (Alma) y un detalle cotidiano (té).
- La opción es concreta, administrativa, sin retórica.

---

## 7. Escribir una línea de UI: ejemplo / Writing a UI line: example

### ❌ Incorrecto

> *"¡Has perdido! Inténtalo de nuevo."*

**Problemas:** exclamación, imperativo directo, palabra *"perdido"* (sugiere derrota), tono de arcade.

### ✅ Correcto

> ES: *"La corrida se ha apagado. Puedes volver a empezar cuando quieras."*
> EN: *"The run has gone out. You may begin again when you wish."*

**Por qué:** "apagar" (del léxico sobrio), segunda persona sin imperativo, sin exclamación, deja agencia al jugador.

---

## 8. Cómo se revisa un texto / How text is reviewed

Antes de promulgar cualquier nueva pieza, verificar en este orden:

1. ¿Respeta el léxico canónico de §2?
2. ¿Evita las palabras prohibidas de §2.2?
3. ¿La frase media cae bajo 16 palabras (§3.1)?
4. ¿Las versiones ES y EN existen y cuadran (§4)?
5. ¿El tono mezcla al menos dos de los tres pilares (mítico / pragmático / melancólico)?
6. ¿No introduce nuevos personajes, motivos o lugares sin referencia a las biblias?
7. ¿El texto admite ser leído **sin hype**, en voz baja, sin que suene a trailer?

Si falla cualquiera de los seis puntos, **reescribir antes de publicar**.

---

## 9. Errores recurrentes / Recurring errors

Antipatrones detectados en primeras escrituras (para aprendizaje de colaboradores):

### 9.1. El adjetivo de más

Cada adjetivo de un texto del Fresco paga peaje. *"Una vela pequeña y brillante"* es demasiado; *"una vela pequeña"* es Fresco.
Every adjective in Fresco text pays toll. *"A small and shining candle"* is too much; *"a small candle"* is Fresco.

### 9.2. El punto exclamativo

Prohibido en narrativa. Permitido exactamente en **un** lugar del corpus: el diálogo de Fero Kauz cuando da una palmada, y solo de forma implícita. En texto escrito: nunca.
Forbidden in narrative. Permitted exactly in **one** corpus spot: Fero Kauz's dialogue when he palm-strikes, implicit only. In on-screen text: never.

### 9.3. La explicación mecánica en la voz

Si el texto de un evento dice *"esto subirá tu estabilidad en 3 puntos"*, está roto. La mecánica viaja en los números, no en la voz. La voz sugiere.
If event text says *"this raises your stability by 3,"* it is broken. Mechanics travel in numbers, not in voice. Voice hints.

### 9.4. El adverbio terminado en *-mente* / *-ly*

Sospechoso por defecto. *"Rápidamente"*, *"terriblemente"*, *"increíblemente"* — casi siempre se puede prescindir. *"Rapidly"*, *"terribly"*, *"incredibly"* — usually droppable.

### 9.5. La personificación de la Marea

La Marea **no quiere** nada. La Marea **no ataca**, **no castiga**, **no perdona**. Sube y baja. Si aparece con agencia personal, se reescribe.
The Tide **wants** nothing. It does not attack, punish, forgive. It rises and falls. If it has personal agency, rewrite.

### 9.6. El personaje nuevo "solo por este evento"

Si un evento introduce un personaje con nombre solo para ese evento, hay error estructural. Los personajes nombrados están en `NARRATIVE_characters.md`. El resto es *"una delegación"*, *"un enviado"*, *"la niña"*.
If an event introduces a named character just for that event, structural error. Named characters live in `NARRATIVE_characters.md`. The rest is *"a delegation,"* *"an envoy,"* *"the child."*

### 9.7. La redundancia bilingüe

Si la versión EN dice **más** que la ES, o viceversa, hay un problema. Ambas deben contener la misma información esencial con economías propias.

---

## 10. Plantillas mínimas / Minimal templates

### 10.1. Tooltip de región / Region tooltip

```
{region_name_es}
{region_motto_es} — una sola frase, ≤10 palabras.

{region_name_en}
{region_motto_en} — one sentence, ≤10 words.
```

### 10.2. Bark al firmar / Signing bark

```
ES: "Firmado." / "Que quede escrito." / "Lo asumo." / "Cerrado."
EN: "Signed." / "Let it be written." / "I take it on." / "Sealed."
```

### 10.3. Eco posterior a una elección / Aftertone

Tres frases máximo, en voz del Coro.
Three sentences max, Chorus voice.

```
ES: "Se hizo como se firmó. {frase 2}. {frase 3}."
EN: "It was done as signed. {sentence 2}. {sentence 3}."
```

### 10.4. Título de capítulo / Chapter title

Patrón canónico: *Capítulo N — {nombre corto}*. El nombre corto evoca un verbo o una imagen, nunca una persona.
Canonical pattern: *Chapter N — {short name}*. The short name evokes a verb or image, never a person.

---

## 11. Anti-prompt para LLMs / Anti-prompt for LLMs

Si un LLM se usa para generar texto del juego, el prompt inicial debe contener **al menos**:

> *"Estás escribiendo para `CivPlagueRush`, en el estilo del Coro de Ceniza. Ver `docs/LORE_bible.md` y `docs/NARRATIVE_style_guide.md`. No puedes: usar palabras prohibidas (apocalipsis, héroe, horda, plaga directamente, virus, salvar, épico), escribir exclamaciones, producir texto sin equivalente EN/ES paralelo, introducir personajes con nombre que no estén en `NARRATIVE_characters.md`, usar imperativos fuera de *voice packs*. Debes: promediar ≤16 palabras por frase, mezclar al menos dos pilares (mítico/pragmático/melancólico), conservar léxico canónico (Fresco, Marea, Pulso, Sombra, Coro de Ceniza, Cuna, Velo, Oído Hundido)."*

Con ese marco, los primeros párrafos generados ya pasan 4 de los 6 criterios de revisión. Los otros dos requieren siempre pasada humana.
With that frame, the first generated paragraphs already pass 4 of 6 review criteria. The other two always need a human pass.

---

## 12. Gobernanza / Governance

### 12.1. Quién decide qué es canon

1. **Este manual** manda sobre improvisación.
2. **Las biblias** (LORE_*.md) mandan sobre este manual en conflictos temáticos concretos.
3. **`LORE_bible.md`** manda sobre las biblias de capítulo en conflictos cosmológicos.
4. **El agente narrativo mantenedor** resuelve empates.

### 12.2. Cómo añadir material nuevo

Flujo canónico:

1. Comprobar si el vacío lo cubre un documento existente.
2. Redactar borrador siguiendo §5.
3. Pasar por los seis criterios de §8.
4. Abrir PR narrativo con el archivo correspondiente en `docs/`.
5. **No tocar `data/*.json`** sin validación del agente narrativo. Las *ids* mecánicas son propuesta, no promulgación.

### 12.3. Cómo retirar material canónico

Solo cuando una incoherencia rompe el corpus.

1. Documentar la incoherencia en este archivo en sección histórica.
2. Marcar el fragmento retirado con nota `// RETIRADO: razón, fecha`.
3. Sustituir, si hace falta, por material nuevo canónico.

Nunca borrar silenciosamente. La historia del canon también es canon.
Never delete silently. The canon's history is canon too.

---

## 13. Glosario breve de términos del manual / Short glossary of manual terms

- **Canon** — lo que está fijado en este documento, biblias y subdocumentos. Cualquier texto en `docs/` con `LORE_` o `NARRATIVE_` en el nombre es canónico.
- **Promulgación** — momento en que una pieza pasa de borrador a canon. Se produce al fusionar el PR narrativo.
- **Pilar** — uno de los tres tonos (mítico / pragmático / melancólico).
- **Motivo** — imagen canónica recurrente (ver `NARRATIVE_iconography.md`).
- **Voz maestra** — el Coro de Ceniza; fuente tonal de todo el corpus.
- **Revisión** — paso obligatorio de §8 antes de publicar.
- **Eco** (*aftertone*) — tercera parte de un evento canónico: lo que el Coro dice tras la elección.

---

## 14. Cierre / Closing

Este manual **se queda corto**. Quiere quedarse corto. Cuando aparezca una situación que no cubre, preguntar dos veces:

1. *¿Qué diría el Coro de Ceniza ante esto?*
2. *Si se lo quito al Coro, ¿la escena aún se sostiene?*

Si las dos se contestan con un sí tranquilo, el canon aguanta.
If both are answered with a calm yes, canon holds.

> *"Escribe como si ya estuviera escrito. Luego quita."*
> *"Write as if already written. Then subtract."*

---

*Fin del manual. Cualquier regla nueva entra por este documento o no entra.*
*End of the manual. Any new rule enters through this document or it does not enter.*
