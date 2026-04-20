# Iconografía canónica / Canonical Iconography

> *"Un mundo se entiende por sus repeticiones."*
> *"A world is understood by its repetitions."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuentes canónicas / Canonical sources:** `docs/ART_bible.md`, `docs/LORE_bible.md`, `docs/LORE_chapter02.md`, `docs/LORE_chapter03.md`, `docs/NARRATIVE_characters.md`.
**Ámbito / Scope:** once **motivos canónicos** del universo, pensados como puente entre equipo narrativo y equipo de arte/animación/UI. Cada motivo especifica qué es, qué significa, dónde aparece, cómo se representa y qué no puede ser.

---

## 0. Reglas generales / General rules

### ES
1. **El motivo manda sobre el realismo.** Si una escena real contradice el motivo, el motivo gana.
2. **Los motivos no se inventan.** Si se necesita uno nuevo, pasa primero por el agente narrativo y este documento.
3. **Los motivos no se explican en pantalla.** Se muestran. La explicación está aquí.
4. **Los motivos canónicos son once.** No se añaden sin razón estructural. Se pueden retirar.
5. **Cada motivo tiene una forma limpia y una forma marchita.** La forma marchita gana peso según avanzan los capítulos.

### EN
1. **Motif trumps realism.** If a real scene contradicts a motif, the motif wins.
2. **No inventing motifs.** New motifs go through the narrative agent and this document first.
3. **Motifs are not explained on screen.** They are shown. The explanation lives here.
4. **Eleven canonical motifs.** No additions without structural reason. Retirements allowed.
5. **Each motif has a clean form and a withered form.** The withered form gains weight as chapters progress.

---

## 1. El oro empañado / The Tarnished Gold

- **Qué es / What it is:** el oro que, en el Año Nueve, dejó de brillar como antes. Sigue siendo oro. Ha perdido una cualidad mínima, imposible de nombrar, que toda la gente percibe y nadie explica.
- **Significado / Meaning:** el paso del tiempo sobre lo valioso. La riqueza heredada. El Fresco en versión metalúrgica.
- **Dónde aparece / Where:** monedas, candelabros, hebillas, marcos de cuadros, campanas sin badajo. La cúpula menor del Archipiélago está cubierta por dentro de oro empañado.
- **Cómo se representa / Visual treatment:** amarillo-miel apagado, con un matiz verde de oxidación sutil en las aristas. Evitar amarillo canario, evitar dorado puro. Usar `#C6A96B` como referencia de centro; bordes con un tono mínimo de oliva.
- **Forma marchita / Withered form:** cuando el oro pasa a un marrón casi rojizo (`#8A6B3A`), significa que lleva varias generaciones sin que nadie lo mire.
- **Uso en UI:** bordes de elementos legados (capítulo seleccionado, logro cumplido, doctrinas permanentes), pero siempre apagados. **Nunca** usar oro empañado para destacar urgencias.
- **Prohibiciones:** no usar oro empañado para la Marea, el enemigo o la urgencia. Ese es un mal acento.

---

## 2. La polilla / The Moth

- **Qué es / What it is:** una polilla beige-grisácea, del tamaño de una uña, con un punto blanco más pálido en cada ala. No oscura, no brillante. Común.
- **Significado / Meaning:** el testigo silencioso. Aparece donde se acaba de firmar algo — una decisión, un pacto, una muerte. Algunos personajes (Alma Veder, Fero Kauz) la tratan con naturalidad; otros la apartan.
- **Dónde aparece / Where:** junto a lámparas, sobre libros abiertos, en las costuras del Fresco. En el HUD, puede aparecer brevemente cuando el jugador confirma una decisión importante (<1 segundo, sin animación estridente).
- **Cómo se representa / Visual treatment:** silueta pequeña, siempre de perfil o con alas a tres cuartos. Antenas marcadas. Color `#C8B99C` con puntos `#E6DFD0`. Tamaño relativo: nunca más grande que un dedo meñique en pantalla.
- **Forma marchita / Withered form:** polilla con un ala rota; suele acompañar a decisiones que el Coro de Ceniza registra como dolorosas.
- **Uso en UI:** confirmación de firmas; cursor contextual en la mesa larga (Cap.3); firma del jugador en el ending (muy pequeña, en el margen).
- **Prohibiciones:** no usar enjambres de polillas. La polilla es **siempre una**. No usar mariposas. No usar polilla en escenas de batalla o propagación.

---

## 3. La puerta cerrada / The Closed Door

- **Qué es / What it is:** una puerta grande, con picaporte pero sin cerradura visible, que aparece en muros donde no había puerta la víspera. A veces es la misma puerta en distintos lugares; a veces son puertas distintas.
- **Significado / Meaning:** lo guardado, lo no decidido, la elección que se pospone. Relacionado con la Cuna de Ruinas (Cap.1-3).
- **Dónde aparece / Where:** en interior de arcología, al fondo de calles, al borde de la Cuna. En el menú de meta-hub como entrada visual al sótano de doctrinas.
- **Cómo se representa / Visual treatment:** madera oscura (`#3E2A1F`) con herrajes de oro empañado. Tres tablones verticales, uno con una veta más clara en diagonal. Picaporte descentrado, ligeramente bajo. Siempre cerrada; nunca se abre en pantalla.
- **Forma marchita / Withered form:** puerta con el picaporte caído al suelo a su pie. Señala que lo que hay detrás no puede salir ni ser visto ya — conservado a precio de inaccesibilidad.
- **Uso en UI:** transición entre capítulos; sala de meta-hub; ending 9.3 de Cap.3 (*"La puerta que se cerró tarde"*).
- **Prohibiciones:** **no enseñar nunca** qué hay al otro lado. Esto es una regla dura. La puerta solo se abre fuera de cámara, o lo que hay detrás se escucha pero no se ve.

---

## 4. El fresco que se desconcha / The Flaking Fresco

- **Qué es / What it is:** una pared de fresco pintado en colores cálidos, con zonas donde la pintura se ha caído revelando revoque blanco-grisáceo con restos de otro fresco debajo.
- **Significado / Meaning:** la memoria recuperable a medias. El Fresco como concepto (civilización perdida) y como objeto (pared pintada). Siempre ambos.
- **Dónde aparece / Where:** fondos de escena en arcologías, ruinas, menú principal. En el título del juego la F de "Fresco" tiene una zona desconchada.
- **Cómo se representa / Visual treatment:** paleta Ashen Fresco en la capa superior; revoque `#D9D1C1` en las zonas caídas; debajo, una capa más oscura (`#7A6550`) con fragmentos de otro color. Las zonas desconchadas no son simétricas ni regulares; siguen una textura orgánica.
- **Forma marchita / Withered form:** el fresco casi caído entero, con solo un pequeño resto de color — suele usarse en Cap.3 para indicar que la zona narrativa representada ha cedido memoria.
- **Uso en UI:** fondo del menú principal, paneles de evento, transiciones de turno en final de capítulo.
- **Prohibiciones:** no pintar frescos legibles (rostros reconocibles, escenas claras). El Fresco es siempre **a medias**. Si el jugador cree reconocer algo, es un error de composición.

---

## 5. La canción de cuna / The Lullaby

- **Qué es / What it is:** la melodía de ocho compases que canta el Coro de Ceniza. Melódicamente simple, rítmicamente imperfecta (un compás de 7/8 en medio). Se canta con voz de mujer mayor.
- **Significado / Meaning:** el Fresco en versión sonora. La canción de cuna es el recuerdo funcional del mundo antes de la Grieta.
- **Dónde aparece / Where:** menú principal (loop muy bajo), final de capítulo (completa o fragmentada según ending), evento `sealed_box_frost` (silbido), hook `lullaby_01` en coleccionables.
- **Cómo se representa / Audio treatment:** voz sola, a veces con un zumbido armónico grave de fondo (el Pulso). Sin instrumentos. Siempre reverb ligero. Lista de frases canónicas en `LORE_bible.md §3`.
- **Forma marchita / Withered form:** la canción cantada por una voz masculina (nunca debería ocurrir por canon; si ocurre, es señal narrativa explícita de quiebre) o por un coro desafinado.
- **Uso en UI:** no graficar nunca la partitura completa. Como máximo, dos notas y un silencio sobre fondo empañado.
- **Prohibiciones:** no instrumentar con orquesta. No modernizar con sintetizadores. No acelerar. La canción, siempre, se canta lento.

---

## 6. La campana sin badajo / The Clapperless Bell

- **Qué es / What it is:** una campana grande, de bronce, sin badajo. Pertenece a la liturgia de la Doctrina del Velo. Se "hace sonar" golpeándola por fuera con una mano envuelta en tela.
- **Significado / Meaning:** la intención sin el acto. La Doctrina del Velo predica que no es lo que se dice, sino lo que se quiso decir en silencio, lo que queda. La campana es la liturgia del silencio formal.
- **Dónde aparece / Where:** monasterios del Velo, eventos `silence_truce_veil` y `silent_monastery`, mesa larga del Cap.3 (si ending 9.5).
- **Cómo se representa / Visual treatment:** bronce con oro empañado en el borde, colgada de una viga de madera. Badajo **ausente**; centro hueco visible. En el exterior, un paño negro que cuelga.
- **Forma marchita / Withered form:** campana volcada en el suelo, paño rasgado. Aparece en ending 9.7 (*"Tres coros rotos"*).
- **Uso en UI:** icono de la Doctrina del Velo en pool de eventos; pactos con el Velo en el Cap.3; transición a Cap.3 si el jugador aceptó al Velo en Cap.2.
- **Prohibiciones:** no hacer sonar la campana como una campana estándar. El sonido canónico es **sordo, breve y grave**. No representar al Velo con cruces, estrellas o símbolos religiosos reales.

---

## 7. La mano sobre el mapa / The Hand Over the Map

- **Qué es / What it is:** una mano humana (derecha o izquierda indistintamente) apoyada sobre un mapa del continente con los dedos abiertos. A veces el mapa es pequeño (de mesa); a veces enorme (pared de arcología).
- **Significado / Meaning:** la Coalición firmando. La decisión política concreta. El Fresco en versión administrativa. También: el jugador mismo.
- **Dónde aparece / Where:** pantalla de firma de decisiones; HUD del Meta-Hub; mesa larga en todas sus apariciones; sello final al completar capítulo.
- **Cómo se representa / Visual treatment:** mano en silueta, sin rostro asociado visible. Los dedos tocan tres regiones específicas del mapa (no importa cuáles — basta con que cubran tres). Tinta del Fresco (`#3E2A1F`) con luz cenital muy suave. La mano no tiembla.
- **Forma marchita / Withered form:** mano vieja, con manchas y temblor (Alma Veder en el último tramo de Cap.3). Se usa solo una vez por capítulo como máximo.
- **Uso en UI:** confirmación final de decisiones mayores (cierre de capítulo, firma de pacto con el Velo, orquestación de Cap.3). Muy sobria.
- **Prohibiciones:** no mostrar nunca la cara asociada. No mostrar dos manos a la vez en el mismo encuadre — **la decisión es siempre de una**. No usar en decisiones menores; se reserva para lo importante.

---

## 8. El reloj de arena / The Hourglass (nuevo, Cap.2+)

- **Qué es / What it is:** un reloj de arena de proporciones antiguas — cuerpo de vidrio abultado por el centro, bases planas, madera oscura. La arena es **fina y dorada-empañada**, lo que le da una textura cercana al oro del motivo 1.
- **Significado / Meaning:** el tiempo medido. La manera en que los Custodios del Oído Hundido viven. Introduce la idea de *tiempo como recurso contable*.
- **Dónde aparece / Where:** observatorio del Oído en la cúpula menor, eventos de Cap.2, HUD de turno (pequeño, en la esquina, cuando el jugador está en una escena de Cap.2).
- **Cómo se representa / Visual treatment:** silueta clásica; arena `#C6A96B`; cristal con un reflejo alto en `#E6DFD0`. Nunca animarlo rápido; el grano cae con lentitud.
- **Forma marchita / Withered form:** reloj caído y derramado, con la arena en el suelo formando una frase en un idioma no pronunciado. (No mostrar la frase legible.)
- **Uso en UI:** transición a Cap.2, eventos de Cap.2 como `sealed_box_frost` y `lost_hour`.
- **Prohibiciones:** no usarlo en Cap.1 sin contexto (sería prematuro). No usarlo como contador urgente / amenaza. Aquí el tiempo no es enemigo: es oficio.

---

## 9. La máscara pálida con grieta dorada / The Pale Mask with Golden Crack (nuevo, Cap.2+)

- **Qué es / What it is:** una máscara de porcelana pálida (`#EDE5D8`), lisa, sin rasgos marcados, con una grieta que la cruza en diagonal. La grieta está rellena de oro empañado — **kintsugi en negativo** (en kintsugi real, se repara lo roto con oro; aquí el oro marca lo no reparado).
- **Significado / Meaning:** el rostro del Custodio. Toda persona que ha bajado al Oído Hundido lleva máscara. La máscara es igual para todos — es el oficio, no el individuo, lo que se presenta.
- **Dónde aparece / Where:** Morn (Cap.2); Custodios en general; final del Cap.2 en ending 9.4 (*"Los de abajo suben"*) — las máscaras apiladas en el muelle.
- **Cómo se representa / Visual treatment:** porcelana con textura plana. Grieta diagonal (arriba-derecha a abajo-izquierda). Ojos: dos ovalos oscuros sin luz. Boca: una línea horizontal sin expresión.
- **Forma marchita / Withered form:** máscara rota por la grieta, en dos mitades. Se usa **una única vez** en el juego: en el ending 9.4 del Cap.3, si la Coalición provoca la apertura de los Custodios.
- **Uso en UI:** retrato de Morn en eventos de Cap.2; icono del Oído Hundido; si se usa en UI, siempre pequeño.
- **Prohibiciones:** no usar máscaras con expresión (ira, risa). No romper la máscara fuera del ending específico. No usar máscara sin grieta — la grieta es canónica.

---

## 10. El pan a medio comer / The Half-Eaten Bread (nuevo, Cap.2+)

- **Qué es / What it is:** una hogaza pequeña de pan con un mordisco claro en el borde, apoyada sobre un paño.
- **Significado / Meaning:** gesto canónico de la niña de la Cuna (ver `NARRATIVE_characters.md §6`). Al comer la mitad y dejar la otra, indica aceptación con límite; no pide; no da las gracias. Ningún adulto imita este gesto sin que se lea como irrespeto.
- **Dónde aparece / Where:** eventos de Cap.1 y Cap.2 donde la niña aparece; primer plano corto en el ending 9.1 de Cap.3 (*"Tres voces, un oído"*) — la niña, ya mayor, come la mitad del pan en la mesa larga.
- **Cómo se representa / Visual treatment:** hogaza con corteza clara (`#C9B38A`) y miga más pálida (`#E6DFD0`); el mordisco es limpio, no desgarrado. Paño gris-marfil debajo. Fondo siempre neutro.
- **Forma marchita / Withered form:** hogaza entera, sin mordisco. Significa que la niña no aceptó lo ofrecido — es rarísima; se usa solo como derivación consciente del motivo.
- **Uso en UI:** icono en eventos que involucran a la niña; no usar como icono genérico de comida.
- **Prohibiciones:** no mostrar a la niña comiendo; solo se muestra **el pan después**. No mostrar el pan terminado (sin miga). No usar pan partido con cuchillo — este gesto es de otra cultura (la Coalición; la niña no).

---

## 11. La tercera mesa / The Third Table (nuevo, Cap.3)

- **Qué es / What it is:** una mesa larga vacía con **tres sillas** en cabecera, en lugar de una. Las tres sillas son idénticas; ninguna tiene más peso que otra. La mesa está en el salón alto de la Arcología del Norte.
- **Significado / Meaning:** el principio de la orquestación de Cap.3. Las tres sillas no representan a tres personas, sino a los tres coros. Nadie se sienta en ellas; están ahí para recordar quién escucha.
- **Dónde aparece / Where:** transición a Cap.3; Movimientos I y IV de Cap.3; ending 9.1 (*"Tres voces, un oído"*) como encuadre final.
- **Cómo se representa / Visual treatment:** mesa larga de madera oscura, con tres sillas iguales en cabecera, separadas entre sí por un metro. La sala alrededor en penumbra. En el ending 9.1, una polilla sobre la cabecera central.
- **Forma marchita / Withered form:** mesa larga con dos sillas en cabecera y un espacio vacío entre ellas donde la tercera debería estar. Se usa en endings 9.3 y 9.7.
- **Uso en UI:** inicio del Cap.3, fin del Cap.3, meta-hub (si el jugador ha alcanzado Cap.3).
- **Prohibiciones:** no sentar a nadie en las sillas. No bajar el número de sillas a dos (salvo forma marchita). No usar tres sillas alrededor de la mesa — son de cabecera.

---

## Matriz de motivos por capítulo / Motifs by chapter

| Motivo | Cap.1 | Cap.2 | Cap.3 |
|---|---|---|---|
| 1. Oro empañado | Protagonista visual | Constante | Constante |
| 2. Polilla | Firma | Firma | Firma |
| 3. Puerta cerrada | Presente | Presente | Clave |
| 4. Fresco desconchado | Fondo | Fondo | Fondo |
| 5. Canción de cuna | Menú, final | Fragmentada | Completa (9.1) |
| 6. Campana sin badajo | Ocasional | Central (Velo) | Clave (9.5) |
| 7. Mano sobre el mapa | Firma mayor | Firma mayor | Firma mayor |
| 8. Reloj de arena | Ausente | Central | Ocasional |
| 9. Máscara grieta dorada | Ausente | Central | Ocasional |
| 10. Pan a medio comer | Ocasional | Regular | Clave (9.1) |
| 11. Tercera mesa | Ausente | Ausente | Central |

Los motivos 8-11 solo entran en Cap.2+; no deben aparecer en Cap.1 para preservar la lógica de descubrimiento.
Motifs 8–11 enter only in Cap.2+; they must not appear in Cap.1 to preserve discovery logic.

---

## Paleta oficial de los motivos / Official motif palette

Referencias de color para todo el equipo de arte. Alineadas con `ART_bible.md`:
Color references for the art team, aligned with `ART_bible.md`:

- **Oro empañado:** `#C6A96B` — y `#8A6B3A` (forma marchita).
- **Beige de polilla:** `#C8B99C`, con puntos `#E6DFD0`.
- **Madera oscura de puerta / mesa:** `#3E2A1F`.
- **Revoque de fresco caído:** `#D9D1C1`.
- **Color subyacente del fresco antiguo:** `#7A6550`.
- **Porcelana pálida de la máscara:** `#EDE5D8`.
- **Corteza de pan:** `#C9B38A`.
- **Tinta de firma:** `#3E2A1F` (misma que madera).

**Nota:** estos colores son referenciales. Los ajustes finales en pixel art / concept los decide el equipo de arte; aquí se garantiza consistencia conceptual.

---

## Glosario de gestos asociados / Associated gesture glossary

Para el equipo de animación e ilustración: cada motivo tiene un gesto humano asociado. Un gesto es canónico cuando siempre aparece acompañado del motivo correspondiente.
For animation/illustration: each motif has an associated human gesture. A gesture is canonical when it always appears alongside its motif.

1. **Oro empañado — pulir con el pulgar.** Alma Veder hace esto sin pensar cuando se concentra.
2. **Polilla — inhalar ligeramente.** Toda la Coalición. Nadie lo enseña; todos lo hacen.
3. **Puerta cerrada — poner la palma encima.** Kael, para medir.
4. **Fresco desconchado — no tocar.** Regla cultural de la Coalición. Tocar el fresco desconchado es un pequeño tabú.
5. **Canción de cuna — cerrar los ojos un instante.** Lo hace el Coro y también los oyentes.
6. **Campana sin badajo — envolver la mano con tela.** Doctrina del Velo.
7. **Mano sobre el mapa — extender los cinco dedos abiertos.** Firma.
8. **Reloj de arena — girarlo con las dos manos.** Custodios.
9. **Máscara pálida — no tocarla en público.** Morn y sus pares.
10. **Pan a medio comer — morder una vez, dejar el resto sobre el paño.** La niña de la Cuna.
11. **Tercera mesa — mirar en tres direcciones antes de hablar.** Protocolo de Cap.3.

---

## Lo que NO es iconografía canónica / What is NOT canonical iconography

Anti-canon. Estos elementos, si aparecen, son errores narrativos o visuales:
Anti-canon. These elements, if present, are narrative or visual errors:

- Cráneos, huesos desnudos, ataúdes (el Fresco no muestra la muerte, la aloja).
- Virus o bacterias figurativos, mascarillas médicas, guantes de látex, jeringuillas.
- Sangre abundante; sí salpicaduras muy pequeñas, si son imprescindibles.
- Banderas con escudos.
- Armaduras de fantasía, espadas rituales, arcos largos.
- Runas angulares, círculos de invocación, cristales flotantes.
- Reloj digital, tubos de neón, pantallas OLED.
- Engranajes visibles (steampunk).
- Niños llorando en primer plano — el llanto de niños en `CivPlagueRush` es siempre **fuera de cuadro**.
- Animales muertos en pantalla.
- Texto en alfabetos inventados visibles en pantalla (sí se admite en fondo, siempre ilegible).

---

*Fin de la iconografía canónica. Cualquier nueva imagen que aspire a repetirse en el juego debe, primero, pasar por aquí.*
*End of canonical iconography. Any new image that aims to recur in the game must first pass through this document.*
