# Códice de horas perdidas / Codex of Lost Hours

> *"Una hora perdida no vuelve. Lo que se pierde en ella, a veces, sí."*
> *"A lost hour does not return. What is lost within it, sometimes, does."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuentes canónicas / Canonical sources:** `docs/LORE_chapter02.md` (*"El Oído Hundido"*, mecánica diegética de "horas perdidas"), `docs/NARRATIVE_events_tier3.md` §`lost_hour`, `docs/NARRATIVE_collectibles.md`, `docs/NARRATIVE_collectibles_expansion.md`, `docs/NARRATIVE_style_guide.md`.
**Ámbito / Scope:** documento de soporte para el Capítulo 2. Establece **qué se pierde cuando se pierde una hora**, cómo se pierde, cómo se recupera parcialmente, y qué coleccionables, eventos y líneas se **bloquean** temporalmente al perderla. Fuente de verdad para el equipo de diseño y narrativa en Cap.2.

**Regla dura / Hard rule:** una *hora perdida* no es "tiempo dañado" — es una hora del día que se **descanoniza diegéticamente**. Para la Coalición, esa hora **existió**; para los Custodios y para el mundo, **no pasó**. La desincronización produce ruido narrativo.

---

## 0. Concepto canónico / Canonical concept

En el Capítulo 2, el Oído Hundido descubre que ciertas horas del día **no concuerdan** entre la medida de abajo (la de los Custodios) y la medida de arriba (la de la Coalición). Cuando la divergencia supera un umbral, **una hora concreta se pierde**: el reloj de los Custodios no la cuenta.

**Implicación diegética:**
- Las cosas ocurridas *solo* en esa hora **no tienen testigo del Oído**.
- Palabras dichas en esa hora quedan *"sin eco"* — el Coro no las puede repetir.
- Ciertos coleccionables, eventos o líneas que dependen de esa hora **se bloquean** hasta que la hora se recupere (si se recupera) o hasta que otro Coro la absorba.

**Implicación mecánica sugerida (no se decide aquí):**
- Se pierde una hora por cada desincronización grave en Cap.2 (ver eventos Cap.2).
- El jugador puede perder hasta **siete horas** a lo largo de Cap.2. Perder las siete activa un sub-ending específico ("Las siete horas bajan") — ver §7.

---

## 1. Las veinticuatro horas canónicas / The twenty-four canonical hours

Cada hora del día tiene una **palabra asociada** y un **gesto asociado**. Cuando la hora se pierde, la palabra y el gesto se vuelven *impronunciables* en su sentido pleno dentro de la Arcología (aún pueden decirse, pero *"suenan huecos"*).

| Hora | Palabra canónica ES | Canonical word EN | Gesto canónico |
|---|---|---|---|
| 00h | **silencio** | silence | palma hacia arriba, sin mover |
| 01h | **resguardo** | shelter | doblar el codo al pecho |
| 02h | **preparar** | prepare | abrir cajón lentamente |
| 03h | **esperar** | wait | respirar dos veces sin hablar |
| 04h | **anunciar** | announce | golpear madera una vez |
| 05h | **amanecer** | dawn | abrir persiana a medias |
| 06h | **pan** | bread | partir en dos con las manos |
| 07h | **saludar** | greet | inclinar cabeza |
| 08h | **levantar** | raise | abrir ventana entera |
| 09h | **comenzar** | begin | poner mano sobre herramienta |
| 10h | **hacer** | make | dos movimientos continuos |
| 11h | **reunir** | gather | abrir los brazos al tórax |
| 12h | **comer** | eat | sentarse sin invitación |
| 13h | **sentar** | sit | la misma silla dos veces |
| 14h | **hablar** | speak | girar hacia el que oye |
| 15h | **firmar** | sign | poner la palma sobre el papel |
| 16h | **enviar** | send | doblar el sobre por la línea |
| 17h | **escuchar** | listen | apoyar cabeza de lado |
| 18h | **regresar** | return | volver por el camino ya andado |
| 19h | **recoger** | gather-in | apilar con cuidado |
| 20h | **contar** | count | tocar cada cosa una vez |
| 21h | **apagar** | extinguish | soplar sin ruido |
| 22h | **descansar** | rest | soltar los hombros |
| 23h | **despedir** | bid-farewell | decir un nombre en voz baja |

Esta tabla es **canónica**. Otras palabras pueden asociarse a la hora por costumbre regional, pero las normativas son estas.

---

## 2. Qué se pierde al perder una hora / What is lost when an hour is lost

Perder la hora **H** implica tres efectos escalonados:

### 2.1. Efecto inmediato — la palabra se vacía / Immediate effect — the word empties

La palabra canónica de la hora H **no puede usarse con sentido pleno** en la Arcología hasta que la hora se recupere. Diegéticamente, el Coro la reconoce *"sin eco"*; el hablante percibe un instante de desorientación al usarla.

Ejemplo: si se pierde la hora 15h, la palabra *"firmar"* queda *"sin eco"*. La gente sigue firmando — pero nadie dice *"firmo"* durante el resto del Cap.2.

### 2.2. Efecto secundario — bloqueos de coleccionables / Secondary effect — collectible locks

Los coleccionables que contienen esa palabra en su texto canónico **no aparecen** en el pool de drops hasta que la hora se recupere. Ver §5 para la tabla de bloqueos.

### 2.3. Efecto terciario — bloqueos de eventos y líneas / Tertiary effect — event and line locks

Ciertos eventos Cap.2/Cap.3 que tienen la palabra o el gesto canónico en su estructura **se transforman**: se reemplazan por variantes silenciadas. Ver §6.

---

## 3. Cómo se pierde una hora / How an hour is lost

Canónicamente, una hora se pierde por **desincronización grave** entre el Oído Hundido y la Coalición. Los eventos Cap.2 que pueden provocar pérdida son:

| Evento | Horas en riesgo | Condición |
|---|---|---|
| `signal_desync` | 04h, 08h, 12h | fallar la comprobación de señal |
| `silica_mirror_map` | 15h, 16h | elegir opción C (forzar el espejo) |
| `silent_monastery` | 00h, 21h | elegir opción A (romper el silencio) |
| `lost_hour` | la hora especificada | cualquier opción A o B |
| `arcology_blackout` | 21h, 22h, 23h | fallar al restaurar luz |
| `weapon_tool_rust` | 09h, 10h | elegir opción A (huelga) |

**Regla:** nunca se pierden dos horas por un solo evento, salvo en *finales de Cap.2* donde puede perderse un bloque (ver §7).

---

## 4. Cómo se recupera / How it is recovered

Tres vías canónicas:

### 4.1. El Coro la absorbe / The Chorus absorbs

Alguien **repite** la palabra y el gesto siete veces en siete lugares distintos de la Arcología, en siete turnos consecutivos. El Coro termina absorbiéndola. La hora vuelve.

Narrativamente: este ritual informal aparece en Cap.2 como gesto espontáneo de los obreros de la Arcología. No es doctrina, es costumbre.

### 4.2. Un Custodio sube / A Custodian comes up

Un Custodio (canónicamente Morn, pero no solo) sube a la Arcología y **vuelve a contar la hora**. El reloj de abajo se resincroniza.

Narrativamente: este es el método formal. Es el que usa Alma cuando la pérdida es grave.

### 4.3. La hora se queda perdida / The hour stays lost

Si no se hace nada, la hora queda perdida **hasta el fin del Cap.2**. Al inicio del Cap.3 se reintegra automáticamente en **estado alterado** — la palabra vuelve, pero con un *"matiz"* (ver §8).

---

## 5. Bloqueos de coleccionables / Collectible locks

Tabla canónica. Columnas: hora perdida / coleccionables bloqueados / razón.

| Hora | Coleccionables bloqueados | Razón |
|---|---|---|
| 00h | `wind_03`, `sermon_11`, `lull_06` | todos contienen *silencio* en su texto |
| 01h | `cradle_07` | *"no la cierres del todo"* = gesto de resguardo |
| 02h | `silika_02`, `silika_05` | ambos dan instrucciones de preparación |
| 03h | `drift_11`, `frost_06` | ambos implican *esperar* al agua/día |
| 04h | `sermon_08`, `silika_04` | ambos mencionan anuncio/vibración |
| 05h | `frag_10`, `lull_02` | *"la luz"*, *"la vela"* = amanecer |
| 06h | `cradle_06`, `sermon_10` | ambos: pan a medio comer / niña que muerde una vez |
| 07h | `drift_06`, `wind_04` | *"saludo"* al paso / *"atended"* |
| 08h | `frag_06`, `sermon_06` | *"abren ventanas"*, *"abre la puerta"* |
| 09h | `rust_09` | *"lista de precios del mes"* se firma al empezar |
| 10h | `rust_05`, `silika_01` | *"aprende / cobra"*, cable que tiembla |
| 11h | `sermon_09` | *"tres nombres reunidos"* |
| 12h | `frost_07` | receta de sopa comunitaria |
| 13h | `unsigned_02`, `frag_13` | ambos implican sentarse a la misma mesa dos veces |
| 14h | `drift_09`, `wind_02` | voz pronunciada en alto |
| 15h | `frag_08`, `rust_06`, `rust_07` | firmar explícito |
| 16h | `drift_07`, `drift_08`, `unsigned_01` | envíos de carta |
| 17h | `sermon_12`, `lull_05` | *"a quién escucha"*, voz a media escucha |
| 18h | `drift_12`, `cradle_05` | *"no alcanzamos"*, *"regresamos"* |
| 19h | `frost_05`, `frag_15` | objetos apilados/envueltos |
| 20h | `frag_11`, `frost_04` | *"contar títulos / entradas"* |
| 21h | `lull_04`, `frag_13` | soplar la vela, apagar la luz |
| 22h | `sermon_07` | bell that doesn't sound = descansar sin repique |
| 23h | `letter_alma_9_3`, `unsigned_04` | despedidas nombrando |

**Regla:** los `letter_*_*` (cartas de despedida) se bloquean solo si la pérdida ocurre **en Cap.2**; en Cap.3 no se bloquean (el ending es el ending).

---

## 6. Bloqueos / transformaciones de eventos / Event locks and transformations

Algunos eventos **se transforman** al perderse la hora, en lugar de bloquearse:

| Hora perdida | Evento afectado | Transformación |
|---|---|---|
| 04h | `signal_desync` | pierde la opción A; queda solo B y C |
| 06h | `arcology_bread` | la niña de la Cuna no aparece si pasa en esa hora |
| 12h | `council_lunch` | la Coalición come sin hablar; sin dialogue |
| 14h | `diplomatic_meeting` | texto en pantalla con todas las comillas a bilingüismo pero **sin doblaje** (el VO queda en off) |
| 15h | `sign_treaty` | la firma se aplaza una hora |
| 17h | `listen_signal` | la señal se oye pero no se puede transcribir esa run |
| 21h | `candle_night` | no se muestra la cinemática de cierre de luz; salto directo |

**Regla:** las transformaciones son **silenciosas**. El jugador no ve un cartel que diga *"Se ha perdido una hora"*. Lo nota por ausencia. (La UI marca la pérdida, pero no explica el enlace a cada evento.)

---

## 7. Finales de Cap.2 por número de horas perdidas / Cap.2 endings by lost-hour count

Canónicamente, el Cap.2 tiene cuatro estados de salida según cuántas horas se perdieron:

### Estado A — ninguna hora perdida (0)

*"El Oído sube por invitación"* / *"The Ear comes up by invitation"*.
El Capítulo 3 comienza con Morn ya arriba, mesa larga ampliada. Epílogo breve, sereno.

### Estado B — entre una y tres horas (1–3)

*"El continente cojea"* / *"The continent limps"*.
Cap.3 comienza con varias palabras *"sin eco"* en los diálogos iniciales. Se recuperan gradualmente. Epílogo: pragmático.

### Estado C — entre cuatro y seis horas (4–6)

*"Las voces tardan"* / *"The voices are slow"*.
Cap.3 comienza con silencios más largos en cutscenes. Un evento nuevo aparece (`the_echoes_wait`, ver `NARRATIVE_events_tier3.md` futuro) — las palabras perdidas piden turno.

### Estado D — siete o más horas (7+)

*"Las siete horas bajan"* / *"The seven hours go down"*.
Las horas perdidas **bajan al Oído** — el Oído las guarda. Al inicio de Cap.3, Morn ya no puede subir. El Oído habla solo **a través de Kael**. Esto activa ciertos endings específicos (ver `LORE_chapter03.md`).

**Regla:** no se puede perder más de nueve horas. Al llegar a nueve, el juego **fuerza** un evento (`cascade_of_hours`) que cierra el Cap.2 anticipadamente con el Estado D.

---

## 8. Matices al reintegrarse / Nuances on reintegration

Cuando una hora perdida **vuelve** al inicio del Cap.3 sin haber sido recuperada activamente, vuelve con un matiz. La palabra canónica se oye, pero con *"media distancia"*. Diegéticamente:

- La gente dice la palabra y hace una pausa pequeña al decirla.
- El Coro la repite sin convicción.
- Algunos coleccionables que habían desaparecido vuelven al pool, pero *tachados* visualmente (rareza *"común tachado"*, un estado narrativo único del Cap.3 al 9-14 % de los coleccionables).

**No** se listan aquí todos los matices línea-a-línea — eso es decisión de escritura por escena cuando se haga. Aquí basta la regla: **las horas que vuelven solas no vuelven limpias.**

---

## 9. Anti-canon / What is not lost

Lo que **nunca** se pierde:

- **La lullaby.** La canción de cuna del Coro se canta aunque todas las horas estén perdidas. (Su función es precisamente sostener las horas.)
- **El nombre de los personajes canónicos.** Alma sigue siendo Alma aunque se pierda la hora 07h (saludo). Los nombres no son palabras canónicas.
- **El pan a medio comer.** El gesto se repite en cualquier hora; no está atado a una sola.
- **La niña de la Cuna.** Puede aparecer sin hora. Su tiempo es propio.

Estas cuatro invariantes son **invulnerables**. Ningún evento, por grave que sea, las bloquea.

---

## 10. UI sugerida / Suggested UI

No es decisión de narrativa, pero se proponen principios:

- **No** mostrar un contador grande de *"horas perdidas"*. Romper la inmersión.
- **Sí** marcar discretamente cuáles están perdidas — quizá un anillo en el HUD con 24 segmentos, algunos apagados, visible solo al pasar el cursor por encima.
- **Sí** permitir al jugador repasar en meta-hub qué horas se perdieron en su run — pero solo tras completarla.

Cualquier texto en pantalla que describa una hora perdida usa una única fórmula canónica:

> *"Esa hora no contó."* / *"That hour did not count."*

No se explica más. No se disculpa.

---

## 11. Tabla rápida para escritores / Quick reference for writers

Si un escritor va a redactar una escena o evento que toca una hora concreta, debe:

1. Consultar la tabla §1 para saber qué palabra/gesto usar.
2. Si la escena puede darse en estado de *hora perdida*, escribir **dos versiones** — una normal y una silenciada.
3. La versión silenciada sigue estas reglas:
   - Sustituir la palabra canónica por una perífrasis (*"poner la palma sobre el papel"* en vez de *"firmar"*).
   - Reducir el número de líneas habladas a la mitad.
   - Añadir al menos una pausa marcada con punto y aparte.
4. **Nunca** hacer que un personaje diga *"esta hora está perdida"* en cámara. Esa frase rompe el tono.

---

## 12. Relación con el resto del canon / Relation to the rest of canon

- **LORE_chapter02.md:** fuente del concepto. Cualquier divergencia, la biblia del capítulo manda.
- **NARRATIVE_events_tier3.md §`lost_hour`:** evento que canoniza la pérdida como decisión consciente del jugador. Las seis horas mencionadas en ese evento usan este códice como diccionario.
- **NARRATIVE_collectibles_expansion.md:** la tabla de bloqueos §5 depende directamente de los IDs de este documento.
- **NARRATIVE_voice_packs.md:** si una línea grabada contiene una palabra canónica que cae en hora perdida, el sistema debe *sustituir* por la versión silenciada si existe; si no, mutear esa línea.
- **NARRATIVE_style_guide.md §léxico:** las palabras de §1 son canónicas en este sentido; no se consideran "perdidas" desde la perspectiva del guía de estilo — ese documento sigue autorizándolas. Simplemente durante una hora perdida, no suenan.

---

## 13. Prohibiciones / Prohibitions

- **No se usa el concepto "hora perdida" fuera del Cap.2.** En Cap.1 no existe; en Cap.3 existe solo como memoria.
- **No se pierde la hora de nacimiento de ningún personaje canónico.** (Ninguna está canonizada; regla preventiva.)
- **No se invierten horas** — no se pierde la "mitad" de una hora, ni "dos minutos". La unidad es la hora entera.
- **No se monetiza.** No se recupera una hora con pago alguno, ni con recurso de juego. Solo por Coro, Custodio, o tiempo.
- **No hay "hora bonus".** No se gana una hora nunca. Solo se pierde o se mantiene.

---

*Fin del códice. Veinticuatro horas, once posibles pérdidas, cuatro finales de capítulo. Lo que no contó, contará de otra forma.*
*End of the codex. Twenty-four hours, eleven possible losses, four chapter-endings. What did not count will count otherwise.*
