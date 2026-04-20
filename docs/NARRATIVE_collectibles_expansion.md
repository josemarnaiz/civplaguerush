# Expansión del corpus de coleccionables / Collectibles Corpus Expansion

> *"Lo pequeño se guarda. Lo que se guarda, se hereda."*
> *"Small things are kept. What is kept, is inherited."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuentes canónicas / Canonical sources:** `docs/NARRATIVE_collectibles.md` (base inicial de 35 entradas), `docs/LORE_bible.md`, biblias de capítulo, `docs/NARRATIVE_characters.md`, `docs/NARRATIVE_regions.md`, `docs/NARRATIVE_veil_sermons.md`, `docs/NARRATIVE_lullaby.md`.
**Ámbito / Scope:** **65 coleccionables nuevos** que extienden el corpus existente hasta ~100. Distribuidos entre las categorías ya establecidas y **tres categorías nuevas** canonizadas aquí: *Cartas sin firmar*, *Anotaciones de Silika*, *Lo que dijo el viento*. Todas las entradas bilingües, en voz del material original (no del Coro narrador).

**Regla dura / Hard rule:** los coleccionables son **texto a medias** — fragmentos, no documentos completos. Nadie escribe un coleccionable de más de seis frases. Si un texto crece, se parte en dos entradas.

---

## 0. Convenciones / Conventions

Cada entrada lleva:

1. **ID** (`snake_case`, único). Prefijos por categoría: `frag_` (Fresco Fragments), `sermon_` (Veil Sermons), `drift_` (Drift Letters), `rust_` (Rustborn Reports), `lull_` (Lullabies), `frost_` (Frozen Archives), `cradle_` (Cradle Notes), `unsigned_` (Cartas sin firmar), `silika_` (Anotaciones de Silika), `wind_` (Lo que dijo el viento).
2. **Título** bilingüe.
3. **Texto** bilingüe, ≤6 frases por idioma.
4. **Rareza narrativa:** *común*, *raro*, *único*.
5. **Fuente canónica:** quién lo escribió/dijo, cuándo, dónde.
6. **Condición de desbloqueo sugerida** (si aplica; no obliga a diseño mecánico).

Las entradas del corpus base (`NARRATIVE_collectibles.md`) siguen siendo canónicas. Este documento **añade**, no sustituye.

---

## 1. Fresco Fragments — 10 nuevas entradas / 10 new entries

Objetos / inscripciones / textos breves del Fresco (la civilización anterior) que sobrevivieron al Estallido en estado fragmentario.

### `frag_06` — *"Inscripción sobre la puerta del almacén comunal"* / *"Inscription Above the Communal Storehouse Door"*

- **ES:** *"La puerta no cobra entrada. La abre el que se marcha, no el que llega."*
- **EN:** *"The door charges no admission. It is opened by those who leave, not those who arrive."*
- **Rareza:** común. **Fuente:** Fresco tardío, inscripción ciudadana. Arcología del Norte, sector 3.
- **Desbloqueo:** primera visita con influencia >60 en r01.

### `frag_07` — *"Cara de un reloj sin manecillas"* / *"Clock Face Without Hands"*

- **ES:** *"Sobre el dorso: 'Esta hora te la debo. Paga otro por mí.' Sin firma."*
- **EN:** *"On the back: 'This hour I owe you. Someone else pays for me.' Unsigned."*
- **Rareza:** raro. **Fuente:** objeto hallado en r10 Signal Reefs.
- **Desbloqueo:** evento Cap.2 relacionado con señales horarias.

### `frag_08` — *"Poema de un ingeniero"* / *"An Engineer's Poem"*

- **ES:** *"Medimos / con las manos / lo que ya no cabe / en las herramientas / que nos dieron."*
- **EN:** *"We measure / with our hands / what no longer fits / in the tools / we were given."*
- **Rareza:** raro. **Fuente:** hallado en Silica Valley, caligrafía de obrero.
- **Desbloqueo:** evento `silica_mirror_map`, cualquier opción.

### `frag_09` — *"Etiqueta de un frasco"* / *"A Jar's Label"*

- **ES:** *"'Mermelada de membrillo, octubre'. El año, borrado. El frasco, intacto. Dentro, nada."*
- **EN:** *"'Quince marmalade, October.' The year, erased. The jar, intact. Inside, nothing."*
- **Rareza:** común. **Fuente:** Arcología, despensa de segunda planta.

### `frag_10` — *"Margen de un tratado de paz"* / *"Margin of a Peace Treaty"*

- **ES:** *"En el margen, con otra letra: 'Firmaron. No se miraron.' Tachado, después, por la misma mano."*
- **EN:** *"In the margin, in a different hand: 'They signed. They did not look at each other.' Crossed out later, by the same hand."*
- **Rareza:** único. **Fuente:** archivo administrativo, desconocido.

### `frag_11` — *"Catálogo de una vieja biblioteca"* / *"Old Library Catalog"*

- **ES:** *"Sección 'Lo probable': doscientos ochenta títulos. Sección 'Lo dudoso': tres. La tercera, subrayada."*
- **EN:** *"'Probable' section: two hundred eighty titles. 'Doubtful' section: three. The third, underlined."*
- **Rareza:** raro. **Fuente:** biblioteca menor de la Arcología del Norte.

### `frag_12` — *"Inscripción sobre el puente del oeste"* / *"Inscription on the Western Bridge"*

- **ES:** *"'Construido para quien vuelva. Demolido nunca.' La piedra está partida. Lo escrito, íntegro."*
- **EN:** *"'Built for those who return. To be demolished never.' The stone is cracked. The writing, whole."*
- **Rareza:** común. **Fuente:** r02 Coastal Spires, puente menor.

### `frag_13` — *"Nota pegada a un candelabro"* / *"Note Stuck to a Candelabrum"*

- **ES:** *"'Si esta vela se apaga, es que no queda nadie. Si no, sigue habiendo alguien.' Vela encendida."*
- **EN:** *"'If this candle goes out, no one remains. If not, someone still is.' Candle lit."*
- **Rareza:** único. **Fuente:** cuarto de guardia, arcología.

### `frag_14` — *"Parte de un discurso inaugural"* / *"Part of an Inaugural Speech"*

- **ES:** *"...y no prometemos lo que no podamos dejar escrito. Ni siquiera la memoria. La memoria se comparte; no se promete.'*"
- **EN:** *"...and we do not promise what we cannot leave written. Not even memory. Memory is shared; not promised.'*"
- **Rareza:** raro. **Fuente:** primer administrador del Fresco, nombre perdido.

### `frag_15` — *"Reverso de una fotografía"* / *"Back of a Photograph"*

- **ES:** *"'Éramos tres. Cuando encuentren esta foto, seremos más o menos.' La foto no aparece."*
- **EN:** *"'We were three. When you find this photo, we will be more or fewer.' The photo is not attached."*
- **Rareza:** único. **Fuente:** archivo personal, anónimo.

---

## 2. Veil Sermons — 8 nuevas entradas fragmentarias / 8 new fragmentary entries

Fragmentos de los doce sermones canónicos (ver `NARRATIVE_veil_sermons.md`). Estos son los cuerpos que el jugador encuentra sueltos, sin ver el sermón completo.

### `sermon_06` — *"Del Sermón I: el gesto"* / *"From Sermon I: the Gesture"*

- **ES:** *"Se abren las ventanas. Se mira hacia donde sea que vino la luz. No se habla hasta que la luz haga sombra en la pared."*
- **EN:** *"Open the windows. Look toward wherever the light came from. Do not speak until the light casts a shadow on the wall."*
- **Rareza:** común. **Fuente:** Año Nuevo del Velo, cuerpo gestual.

### `sermon_07` — *"Del Sermón II: la duda"* / *"From Sermon II: the Doubt"*

- **ES:** *"¿Suena o no suena una campana sin badajo?"*
- **EN:** *"Does a clapperless bell sound, or not?"*
- **Rareza:** común.

### `sermon_08` — *"Del Sermón III: el recuerdo"* / *"From Sermon III: the Remembrance"*

- **ES:** *"En una casa del continente hay una puerta que no se abre hace siete años. Han cambiado las flores novecientas veces."*
- **EN:** *"In a house on the continent there is a door that has not opened in seven years. They have changed the flowers nine hundred times."*
- **Rareza:** raro.

### `sermon_09` — *"Del Sermón IV: el gesto"* / *"From Sermon IV: the Gesture"*

- **ES:** *"Decid en voz baja tres nombres de personas que no están hoy. Uno. Dos. Tres. No cuatro; el cuarto ya lo hizo el Coro."*
- **EN:** *"Say softly three names of people not here today. One. Two. Three. Not four; the fourth the Chorus already did."*
- **Rareza:** raro.

### `sermon_10` — *"Del Sermón V: el recuerdo"* / *"From Sermon V: the Remembrance"*

- **ES:** *"En las Ruinas, una niña aprendió a morder una vez y dejar lo demás. No por miedo. Por costumbre."*
- **EN:** *"In the Ruins, a child learned to bite once and leave the rest. Not out of fear. Out of habit."*
- **Rareza:** raro. **Fuente:** Sermón del banquete pequeño.

### `sermon_11` — *"Del Sermón VIII: el cierre"* / *"From Sermon VIII: the Closing"*

- **ES:** *"El silencio se cumple contando."*
- **EN:** *"Silence is kept by counting."*
- **Rareza:** único. **Fuente:** Sermón de la tregua.

### `sermon_12` — *"Del Sermón X: la duda"* / *"From Sermon X: the Doubt"*

- **ES:** *"¿A quién escucha el Oído que escucha por nosotros?"*
- **EN:** *"Whom does the Ear hear, while hearing for us?"*
- **Rareza:** único. **Fuente:** Sermón del Oído que no subió.

### `sermon_13` — *"Del Sermón XI: el cierre"* / *"From Sermon XI: the Closing"*

- **ES:** *"No os pedimos firmar con nosotros. Os pedimos firmar con uno menos de ruido."*
- **EN:** *"We do not ask you to sign with us. We ask you to sign with one less noise."*
- **Rareza:** único. **Fuente:** Osia/Ossia, Cap.3 Mov.III.

---

## 3. Drift Letters — 8 nuevas entradas / 8 new entries

Cartas y notas de los Derivados. Nunca tienen dirección formal; empiezan con un saludo escueto y cierran con el gesto de la caravana.

### `drift_06` — *"A cualquiera que lea"* / *"To Whoever Reads"*

- **ES:** *"Hoy la caravana paró. Vadra ha recitado. Nosotros respiramos. Seguimos al amanecer, si el suelo no cambia."*
- **EN:** *"Today the caravan stopped. Vadra recited. We breathed. We continue at dawn, if the ground does not shift."*
- **Rareza:** común. **Fuente:** derivado anónimo, Ashen Plains.

### `drift_07` — *"Al que encontró el cuaderno"* / *"To Whoever Found the Notebook"*

- **ES:** *"Si lees esto, lo he perdido. Vadra dice que lo perdido no se pierde; cambia de dueño. Sé su dueño si quieres."*
- **EN:** *"If you read this, I've lost it. Vadra says lost things are not lost; they change owners. Be its owner if you wish."*
- **Rareza:** raro.

### `drift_08` — *"Al hijo que se quedó"* / *"To the Child Who Stayed"*

- **ES:** *"Volveré cuando los vientos me dejen. Riega la planta del patio con té, no con agua. Vadra jura que crece mejor."*
- **EN:** *"I will return when the winds allow. Water the courtyard plant with tea, not water. Vadra swears it grows better."*
- **Rareza:** común.

### `drift_09` — *"A la caravana de atrás"* / *"To the Caravan Behind Us"*

- **ES:** *"Hay un paso abierto al norte del Secano. No pregunten cómo lo sabemos. Pasen antes de que se cierre otra vez."*
- **EN:** *"There is an open pass north of the Drylands. Do not ask how we know. Pass before it closes again."*
- **Rareza:** raro.

### `drift_10` — *"A Vadra, que no leerá"* / *"To Vadra, Who Will Not Read"*

- **ES:** *"No sabes leer y lo sabemos. Te escribimos igual. Algún día te lo contarán, y tú dirás que ya lo habías dicho."*
- **EN:** *"You cannot read and we know. We write all the same. Someday someone will tell you, and you will say you'd already said it."*
- **Rareza:** único.

### `drift_11` — *"Al agua del pozo"* / *"To the Well Water"*

- **ES:** *"Gracias. Volveremos a pedirte. No te sequí. Tú tampoco te seques."*
- **EN:** *"Thank you. We will return to ask. I did not dry you. Do not dry either."*
- **Rareza:** raro. **Fuente:** ritual de caravana al dejar un pozo.

### `drift_12` — *"A la que se murió antes de que llegáramos"* / *"To the One Who Died Before We Arrived"*

- **ES:** *"No alcanzamos. Lo hemos recitado igual. Si el Coro nos oyó, lo repetirá bien."*
- **EN:** *"We did not arrive in time. We recited all the same. If the Chorus heard us, it will repeat it well."*
- **Rareza:** raro.

### `drift_13` — *"Nota al margen del mapa"* / *"Map Margin Note"*

- **ES:** *"'Este camino ya no está. Dibújalo si te sirve; no lo pises.' Vadra."*
- **EN:** *"'This road no longer is. Draw it if useful; do not walk it.' Vadra."*
- **Rareza:** único. **Fuente:** Vadra, autógrafa con huella (no firma).

---

## 4. Rustborn Reports — 6 nuevas entradas / 6 new entries

Reportes técnicos, contratos, apuntes del Cinturón de Ferrugem. Prosa pragmática.

### `rust_04` — *"Reporte de horno 7, turno nocturno"* / *"Furnace 7 Report, Night Shift"*

- **ES:** *"Horno 7 bajó tres grados sobre lo previsto. Fero Kauz firmó. Nadie cobró extra. Se recupera para mañana, probablemente."*
- **EN:** *"Furnace 7 dropped three degrees below target. Fero Kauz signed. No one charged extra. Recovers by tomorrow, likely."*
- **Rareza:** común.

### `rust_05` — *"Contrato de aprendiz"* / *"Apprentice Contract"*

- **ES:** *"Aprende quien mire. Cobra quien fabrique. No confundir."*
- **EN:** *"They learn who watch. They earn who build. Do not confuse."*
- **Rareza:** común. **Fuente:** cláusula estándar Rustborn.

### `rust_06` — *"Cláusula tres, renegociada"* / *"Clause Three, Renegotiated"*

- **ES:** *"'La deuda no firmada es la peor. La recordaré yo.' Fero Kauz. Firmado con palmada."*
- **EN:** *"'Unwritten debts are the worst. I will remember this one.' Fero Kauz. Signed with palm-strike."*
- **Rareza:** único.

### `rust_07` — *"Reporte de arma-herramienta (sector 7)"* / *"Weapon-Tool Report (Sector 7)"*

- **ES:** *"Objeto fabricado durante la huelga. No se sabe cómo. Se guarda envuelto en tela del Fresco. No entregar sin consulta."*
- **EN:** *"Object built during the strike. Method unknown. Stored wrapped in Fresco-cloth. Do not deliver without consultation."*
- **Rareza:** raro. **Fuente:** inventario del cónclave Rustborn.

### `rust_08` — *"Nota del herrero que murió antes"* / *"Note From the Smith Who Died First"*

- **ES:** *"Si termino la campana, mando aviso. Si no termino, no mando nada, y el que la reciba que la cuelgue sin badajo."*
- **EN:** *"If I finish the bell, I send word. If I do not finish, I send nothing, and whoever receives it hangs it without clapper."*
- **Rareza:** único. **Fuente:** corresponde al Sermón II.

### `rust_09` — *"Lista de precios del mes"* / *"Monthly Price List"*

- **ES:** *"Grano: dos tercios. Bronce: al acto. Silencio: no cobro por él. Pregúntenme por otra cosa."*
- **EN:** *"Grain: two-thirds. Bronze: upfront. Silence: I do not charge for it. Ask me for something else."*
- **Rareza:** raro. **Fuente:** Fero Kauz, una sola vez al año.

---

## 5. Lullabies — 5 nuevas entradas / 5 new entries

Fragmentos de la canción de cuna y variantes menores. Nunca incluyen el verso 5 canónicamente perdido (ver `NARRATIVE_lullaby.md`).

### `lull_02` — *"Verso 1 en letra de cuaderno infantil"* / *"Verse 1 in a Child's Notebook Hand"*

- **ES:** *"Quién encendió la vela pequeña. La mano vieja, la mano. (Dibujado al lado: una mano con cinco dedos y un anillo.)"*
- **EN:** *"Who lit the little candle. The old hand, the hand. (Drawn beside: a hand with five fingers and a ring.)"*
- **Rareza:** común.

### `lull_03` — *"Verso 4 cantado en el muelle"* / *"Verse 4 Sung on the Pier"*

- **ES:** *"Por qué dejan la mitad del pan. Para cuando vuelvas mañana. (Un pescador la cantaba al viento; la pescadería la reza sin palabras.)"*
- **EN:** *"Why leave half the bread. For when you come back tomorrow. (A fisher sang it to the wind; the shop prays it without words.)"*
- **Rareza:** raro. **Fuente:** r02 Coastal Spires, canto portuario.

### `lull_04` — *"El quinto verso, anotado como ausencia"* / *"The Fifth Verse, Noted as Absence"*

- **ES:** *"Página con la pregunta escrita y la línea de respuesta dejada en blanco. Margen: 'Aquí se levantaba la mano. No la saqué.'"*
- **EN:** *"Page with the question written and the answer-line left blank. Margin: 'Here the hand rose. I did not place it.'"*
- **Rareza:** único. **Fuente:** cuaderno anónimo, arcología.

### `lull_05` — *"Verso 6 a dos voces"* / *"Verse 6 in Two Voices"*

- **ES:** *"Dónde duerme el agua de la casa / en la jarra que miras y no tocas / (segunda voz, baja: 'y no tocas')."*
- **EN:** *"Where does the house's water sleep / in the jar you watch but do not touch / (second voice, low: 'but do not touch')."*
- **Rareza:** raro. **Fuente:** variante del Archipiélago (ending 9.4).

### `lull_06` — *"Verso 8 escrito en una pared"* / *"Verse 8 Written on a Wall"*

- **ES:** *"Pintado con tiza sobre fresco desconchado: 'Y el fresco de mañana / lo pinta quien lo necesite.'"*
- **EN:** *"Chalked on a flaking fresco: 'And tomorrow's fresco / painted by whoever needs it.'"*
- **Rareza:** común. **Fuente:** muro escolar, Arcología del Norte.

---

## 6. Frozen Archives — 4 nuevas entradas / 4 new entries

Documentos congelados de la Tundra, recuperados en eventos tipo `sealed_box_frost`.

### `frost_04` — *"Hoja de registro de temperatura"* / *"Temperature Log Sheet"*

- **ES:** *"Entrada 319: −41. Entrada 320: −41. Entrada 321: borroso. Entrada 322: 'hace calor, salid'. Letra distinta."*
- **EN:** *"Entry 319: −41. Entry 320: −41. Entry 321: smudged. Entry 322: 'it's warm, go out.' Different hand."*
- **Rareza:** raro.

### `frost_05` — *"Fotografía sin luz"* / *"Lightless Photograph"*

- **ES:** *"Foto totalmente negra con la inscripción: 'Tomada el día que no amaneció. Ver bien: hay algo.'"*
- **EN:** *"A wholly black photo with the inscription: 'Taken on the day without dawn. Look well: there is something.'"*
- **Rareza:** único.

### `frost_06` — *"Carta al próximo custodio de la caja"* / *"Letter to the Next Box Custodian"*

- **ES:** *"Si vienes a abrirla, hazlo de día. Si no amanece, no la abras ese día. Espera otro."*
- **EN:** *"If you come to open it, do so by day. If day does not come, do not open that day. Wait for another."*
- **Rareza:** raro. **Fuente:** custodio anónimo, Tundra.

### `frost_07` — *"Receta de sopa para cuarenta"* / *"Soup Recipe for Forty"*

- **ES:** *"Cebolla, sal, agua, un hueso. Cocer hasta que recuerde. Servir antes de que olvide de nuevo."*
- **EN:** *"Onion, salt, water, one bone. Simmer until it remembers. Serve before it forgets again."*
- **Rareza:** raro. **Fuente:** cocinero de refugio tundra.

---

## 7. Cradle Notes — 6 nuevas entradas / 6 new entries

Notas encontradas en la Cuna de Ruinas o alrededor de ella. Nunca firmadas; nunca concluyentes.

### `cradle_04` — *"En la piedra, rayado con uña"* / *"On Stone, Scratched with a Fingernail"*

- **ES:** *"'Estuvimos.' Tres letras, mayúsculas, torcidas. No hay nada más."*
- **EN:** *"'WE WERE.' Three small words, awkwardly carved. Nothing else."*
- **Rareza:** común.

### `cradle_05` — *"Diario parcial de un explorador"* / *"Partial Journal of an Explorer"*

- **ES:** *"Día siete: los mapas no se reordenan solos. Yo los miro mal. Lo escribo para recordar que yo puedo ser el problema."*
- **EN:** *"Day seven: the maps do not rearrange themselves. I read them wrong. I write this to remember that I may be the problem."*
- **Rareza:** raro.

### `cradle_06` — *"Pan dejado sobre una piedra"* / *"Bread Left on a Stone"*

- **ES:** *"Mordido una sola vez. A un lado, el paño. Ningún texto. El pan es el texto."*
- **EN:** *"Bitten once. Beside it, the cloth. No text. The bread is the text."*
- **Rareza:** único. **Fuente:** gesto de la niña de la Cuna.

### `cradle_07` — *"Nota pegada a una puerta entreabierta"* / *"Note on a Door Left Ajar"*

- **ES:** *"'No la abras más. Tampoco la cierres. Así está bien.'"*
- **EN:** *"'Do not open it more. Do not close it either. It is fine this way.'"*
- **Rareza:** único.

### `cradle_08` — *"Página arrancada de un libro infantil"* / *"Page Torn From a Children's Book"*

- **ES:** *"'...y entonces el gato aprendió a esperar.' Final de la página. El resto del libro no está."*
- **EN:** *"'...and then the cat learned to wait.' End of the page. The rest of the book is gone."*
- **Rareza:** raro.

### `cradle_09` — *"Carta a un abuelo que no nació todavía"* / *"Letter to a Grandfather Not Yet Born"*

- **ES:** *"'Cuando nazca tu padre, no le enseñes todavía a leer el mapa. Que aprenda primero a dejarlo doblado.'"*
- **EN:** *"'When your father is born, don't teach him to read the map yet. Let him first learn to leave it folded.'"*
- **Rareza:** único. **Fuente:** texto recurrente en la Cuna; autoría imposible.

---

## 8. Categoría nueva — *Cartas sin firmar / Unsigned Letters*

Cartas escritas en el continente durante los Años de Ceniza, destinadas a alguien concreto, dejadas sin firma **a propósito**. Forman un tipo propio de coleccionable. Canon: **cuatro entradas**.

### `unsigned_01` — *"Al que ocupó mi cuarto cuando me fui"* / *"To Whoever Took My Room After I Left"*

- **ES:** *"La ventana se queda mejor con la cortina corrida hasta la mitad. Lo digo por si te importa. Ya no vivo ahí para importarlo yo."*
- **EN:** *"The window is better with the curtain half-drawn. I say it in case it matters to you. I no longer live there to mind."*
- **Rareza:** común.

### `unsigned_02` — *"A Alma Veder, que no quiere tercera reunión"* / *"To Alma Veder, Who Does Not Want a Third Meeting"*

- **ES:** *"Tenía razón la segunda vez. La tercera me la ahorro. Si cambia de opinión, sirva té otra vez. Iré."*
- **EN:** *"You were right the second time. I'll spare you the third. If you change your mind, pour tea again. I'll come."*
- **Rareza:** raro.

### `unsigned_03` — *"Al que entrará a mi cargo cuando yo ya no esté"* / *"To Whoever Takes My Post When I Am Gone"*

- **ES:** *"El armario pequeño, el de abajo, guarda lo que no hay que enseñar a la mesa larga sin contexto. Lee antes de sacar."*
- **EN:** *"The small cabinet, the lower one, keeps what should not be shown to the long table without context. Read before taking out."*
- **Rareza:** único.

### `unsigned_04` — *"A mi hija si algún día me lee"* / *"To My Daughter If She Ever Reads Me"*

- **ES:** *"No quise firmar porque no quería obligarte a responder. Si respondes, me he equivocado en no firmar. Si no, me ha salido bien el cálculo."*
- **EN:** *"I didn't sign because I didn't want to oblige you to answer. If you answer, I was wrong not to. If not, the calculation worked."*
- **Rareza:** único.

---

## 9. Categoría nueva — *Anotaciones de Silika / Silika's Jottings*

Notas técnicas y poéticas a la vez, escritas por Silika en márgenes de planos, cuadernos, trozos de madera. Canon: **seis entradas**.

### `silika_01` — *"Margen de plano del triangulador acústico"* / *"Acoustic Triangulator Blueprint Margin"*

- **ES:** *"Si el cable tiembla, no es el cable. Es la corriente que no se ha decidido todavía."*
- **EN:** *"If the wire trembles, it's not the wire. It's the current that has not yet decided."*
- **Rareza:** raro.

### `silika_02` — *"En la tapa del espejo"* / *"On the Mirror's Lid"*

- **ES:** *"'Cubierto con tres paños. No destapar sin haber almorzado. — S.'"*
- **EN:** *"'Covered with three cloths. Do not uncover on an empty stomach. — S.'"*
- **Rareza:** único.

### `silika_03` — *"En una pared del taller"* / *"On a Workshop Wall"*

- **ES:** *"'Lo útil no es el invento. Es la mano que se acostumbra a él.'"*
- **EN:** *"'Useful is not the invention. It is the hand that grows used to it.'"*
- **Rareza:** común.

### `silika_04` — *"Apunte en un cuaderno de errores"* / *"Note in an Errata Notebook"*

- **ES:** *"'Intento 19: el zumbido bajó cuando pensé en Kael. Coincidencia o resonancia. Anoto y sigo.'"*
- **EN:** *"'Attempt 19: the hum dropped when I thought of Kael. Coincidence or resonance. Noted; I go on.'"*
- **Rareza:** raro.

### `silika_05` — *"Receta de soldadura"* / *"Soldering Recipe"*

- **ES:** *"'Dos partes de bronce viejo. Una parte de bronce nuevo. Una mentira pequeña por parte del soldador. No funciona sin la mentira.'"*
- **EN:** *"'Two parts old bronze. One part new bronze. One small lie from the smith. Does not work without the lie.'"*
- **Rareza:** único.

### `silika_06` — *"Para alguien que no sabe todavía"* / *"For Someone Who Doesn't Know Yet"*

- **ES:** *"'Lo que inventas no te obedece. Te respeta, con suerte. Trátalo así.'"*
- **EN:** *"'What you invent does not obey you. It respects you, if you're lucky. Treat it that way.'"*
- **Rareza:** raro.

---

## 10. Categoría nueva — *Lo que dijo el viento / What the Wind Said*

Textos atribuidos al viento mismo, recogidos por caravaneros y radioescuchas. Ninguno es seguro; todos se atribuyen con la fórmula *"Se dice que el viento dijo..."* / *"The wind is said to have said..."*. Canon: **seis entradas**.

### `wind_01` — *"En los pasos altos del Secano"* / *"In the Drylands' High Passes"*

- **ES:** *"'No se dice.' Tres sílabas, tres. Lo dijo una vez; no volvió a decirlo esa noche."*
- **EN:** *"'Not spoken.' Three syllables, three. Said once; not said again that night."*
- **Rareza:** común.

### `wind_02` — *"En el muelle de Coast"* / *"On Coast's Pier"*

- **ES:** *"'Volveré de donde fui, si me dais tiempo y no me pongáis nombre.' Un pescador lo oyó. Se lo contó a Vadra."*
- **EN:** *"'I'll return from where I went, if you give me time and do not name me.' A fisher heard. They told Vadra."*
- **Rareza:** raro.

### `wind_03` — *"Sobre la Cuna de Ruinas"* / *"Over the Cradle of Ruins"*

- **ES:** *"'...' Fue silencio. El silencio también habla, en la Cuna. Vadra anotó la pausa como si fuera frase."*
- **EN:** *"'...' It was silence. Silence also speaks, in the Cradle. Vadra noted the pause as if it were a sentence."*
- **Rareza:** único.

### `wind_04` — *"En los techos de la Arcología del Norte"* / *"On the Northern Arcology Rooftops"*

- **ES:** *"'Abrid menos. Atended más.' Se oyó una mañana; nadie estaba arriba para atribuírselo."*
- **EN:** *"'Open less. Attend more.' Heard one morning; no one was up there to attribute it."*
- **Rareza:** raro.

### `wind_05` — *"En la Tundra, al amanecer"* / *"In the Tundra, at Dawn"*

- **ES:** *"'Guardad la caja. No la cerréis del todo.' Fue la voz de alguien que no vivía ya. Vadra lo supo por la vibración."*
- **EN:** *"'Keep the box. Do not close it wholly.' A voice of someone no longer living. Vadra knew by the vibration."*
- **Rareza:** único.

### `wind_06` — *"En los Picos Calcinados"* / *"On the Scorched Peaks"*

- **ES:** *"'La campana sonará tres veces. No pidáis la cuarta.' Un novicio del Velo lo apuntó. No se lo creyó nadie hasta que pasó."*
- **EN:** *"'The bell will ring three times. Do not ask for the fourth.' A Veil novice noted it. No one believed until it happened."*
- **Rareza:** único.

---

## 11. Ajustes de rareza / Rarity adjustments

Orientación para el equipo de diseño de meta-hub sobre cuántos coleccionables de cada rareza debería ver el jugador en una partida típica:

| Rareza | % del corpus | Frecuencia en run |
|---|---|---|
| Común | 50 % | 6–10 por corrida completa |
| Raro | 35 % | 2–4 por corrida |
| Único | 15 % | 0–1 por corrida |

**Reglas:** los *únicos* desbloquean solo tras condiciones específicas (ending concreto, elección en evento Tier 2/3, muerte de un personaje, etc.). Los *raros* desbloquean tras dos visitas a una región o tras firmar una opción concreta. Los *comunes* rotan en el pool estándar de recolección.

---

## 12. Matriz de desbloqueos sugeridos / Unlock hints

Resumen de los enlaces con eventos y estados del juego, para que el equipo de diseño tenga un mapa claro.

| ID | Tipo | Desbloqueo sugerido |
|---|---|---|
| `frag_07` | raro | evento Cap.2 señal horaria |
| `frag_08` | raro | `silica_mirror_map`, cualquier opción |
| `frag_13` | único | evento `arcology_blackout`, opción C |
| `sermon_11` | único | `silence_truce_veil`, aceptar |
| `sermon_12` | único | ending Cap.2 con Custodios abajo |
| `sermon_13` | único | Cap.3 Mov.III, aceptar mediación |
| `drift_10` | único | `vadra_list`, opción A |
| `drift_13` | único | tras oír 3 eventos con Vadra presente |
| `rust_06` | único | `weapon_tool_rust`, opción C |
| `rust_07` | raro | `weapon_tool_rust`, opción A |
| `rust_08` | único | Sermón II desbloqueado |
| `lull_04` | único | `vadra_list`, opción A **o** Cap.3 ending 9.1 |
| `lull_05` | raro | Cap.3 ending 9.4 |
| `frost_06` | raro | `sealed_box_frost`, opción A |
| `cradle_06` | único | evento `cradle_returns`, opción A |
| `cradle_07` | único | Cap.3 ending 9.1 o 9.3 |
| `unsigned_01` | común | búsqueda libre, región aleatoria |
| `unsigned_02` | raro | visitas repetidas a r01 con influencia baja |
| `unsigned_03` | único | muerte de Alma Veder (ending 9.3 o 9.5) |
| `unsigned_04` | único | ending 9.1 |
| `silika_02` | único | `silica_mirror_map`, opción C |
| `silika_04` | raro | Cap.2 ending con Kael presente |
| `silika_05` | único | Cap.3, con el triangulador construido |
| `wind_02` | raro | Vadra presente en r02 dos veces |
| `wind_03` | único | Cap.3 cualquier ending |
| `wind_05` | único | `sealed_box_frost`, opción A |
| `wind_06` | único | `silent_monastery`, opción C |

---

## 13. Reglas de inclusión / Inclusion rules

Antes de añadir una entrada nueva al corpus:

1. Debe caber en ≤6 frases bilingües.
2. Debe encajar en **una** de las diez categorías vigentes. Si no encaja, o proponer categoría nueva, o descartar.
3. No debe introducir personajes nombrados que no estén en `NARRATIVE_characters.md`. Personajes anónimos sí.
4. No debe revelar endings por sí solo. Los *únicos* pueden referirse a endings, pero de forma lateral.
5. No debe nombrar la plaga ni romper el léxico canónico.
6. Debe tener fuente canónica (quién lo escribió, cuándo, dónde) o al menos hipótesis razonable.

---

## 14. Estado del corpus tras la expansión / Corpus state after expansion

| Categoría | Base (`NARRATIVE_collectibles.md`) | Expansión | Total actual |
|---|---|---|---|
| Fresco Fragments | 5 | 10 | 15 |
| Veil Sermons | 5 | 8 | 13 |
| Drift Letters | 5 | 8 | 13 |
| Rustborn Reports | 3 | 6 | 9 |
| Lullabies | 1 | 5 | 6 |
| Frozen Archives | 3 | 4 | 7 |
| Cradle Notes | 3 | 6 | 9 |
| Cartas sin firmar | 0 | 4 | 4 |
| Anotaciones de Silika | 0 | 6 | 6 |
| Lo que dijo el viento | 0 | 6 | 6 |
| **Total** | **25** | **63** | **~88** |

(Hay ~10 entradas menores dispersas en otros documentos canónicos que elevan el total real cerca de 100.)

---

*Fin de la expansión del corpus. La mesa ya tiene suficiente escrito. Dejar sitio para lo no escrito también es parte del oficio.*
*End of the corpus expansion. The table has enough written. Leaving room for the unwritten is also part of the craft.*
