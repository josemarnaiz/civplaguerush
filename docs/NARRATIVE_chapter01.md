# Capítulo 1 — Ecos de Ceniza
# Chapter 1 — Echoes of Ash

> *"Empieza aquí, porque aquí todavía hay quien recuerda el primer verso."*
> *"Begin here, because here someone still remembers the first verse."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuente canónica / Canonical source:** `docs/LORE_bible.md`.
**Ámbito / Scope:** material narrativo del primer capítulo — intro, hitos, epílogos según resultado, y teaser del Capítulo 2. Fuente para `data/campaign_ch1.json` y pantallas de resultado de run.

---

## 1. Identidad del capítulo / Chapter identity

- **ID mecánico:** `chapter_01_echoes_of_ash`
- **Título canónico ES:** *Capítulo 1 — Ecos de Ceniza*
- **Título canónico EN:** *Chapter 1 — Echoes of Ash*
- **Objetivo primario (legible):**
  - ES: *Terminar una run controlando al menos 6 regiones y con la Marea bajo 70.*
  - EN: *Finish one run with at least 6 controlled regions and the Tide below 70.*

El título es **canónico**. No se abrevia, no se traduce creativamente, no se le añaden subtítulos.
The title is **canonical**. Do not abbreviate, creatively re-translate, or append subtitles.

---

## 2. Apertura del capítulo / Chapter opening

Se muestra la **primera vez** que el jugador entra al meta-hub con el Capítulo 1 activo. Voz del Coro.
Shown the **first time** the player enters the meta-hub with Chapter 1 active. Ash Chorus voice.

### ES — versión larga (pantalla dedicada)

*Después del Brote, la arcología del norte encendió las lámparas con lo que quedaba de la noche.*

*La mesa larga era muy larga, y había muchas sillas vacías. En cada silla, alguien fue recordado por el que venía a sentarse detrás. Así se formó la Coalición: no por voto, no por trono, por turno de palabra.*

*El mapa que desplegaron sobre la mesa todavía conserva doce manchas. Una por región. Algunas manchas laten. Otras han dejado de hacerlo y alguien las dibuja de memoria.*

*Cada run que empieces es una manera de volver a servir la mesa. Cada run que pierdas es una manera de entender por qué la mesa era tan larga. Cada run que ganes — si la ganas — es una manera de repintar un color del Fresco antes de que caiga.*

*El Coro te acompaña. No te dirige. Baja la voz cuando sabe que tu mano tiembla y canta cuando la tuya firma. Escúchalo: dice más en los márgenes que en los titulares.*

*Bienvenida, Portavoz. El Fresco espera.*

### EN — long version (dedicated screen)

*After the Outbreak, the Northern Arcology lit its lamps with what was left of the night.*

*The long table was very long, and many chairs were empty. In each empty chair, someone was remembered by whoever came to sit behind them. That is how the Coalition was formed: not by vote, not by throne, but by turn of speech.*

*The map they spread on the table still keeps twelve stains. One per region. Some stains pulse. Others have stopped, and someone draws them from memory.*

*Every run you begin is a way of setting the table again. Every run you lose is a way of understanding why the table was so long. Every run you win — if you win — is a way of repainting one color of the Fresco before it falls.*

*The Chorus accompanies you. It does not direct you. It lowers its voice when it knows your hand trembles, and it sings when your hand signs. Listen to it: it says more in the margins than in the headlines.*

*Welcome, Speaker. The Fresco waits.*

### Versión corta / Short version (intro usable en pantalla de run start)

- ES: *Después del Brote, tu coalición se alza desde las ciudades quebradas. Cada región que estabilices alimenta tu influencia; cada decisión dura siembra miedo. El Fresco espera.*
- EN: *After the Outbreak, your coalition rises from the shattered cities. Every region you stabilize feeds your influence; every harsh choice plants fear. The Fresco waits.*

*(Esta versión corta es la que puede ir en `data/campaign_ch1.json` como `intro` sin romper layout.)*
*(This short version is the one safe to drop into `data/campaign_ch1.json` as `intro` without breaking layout.)*

---

## 3. Hitos del capítulo / Chapter milestones

Tres hitos reconocidos por el sistema. Cada uno recibe **nombre canónico bilingüe**, **descripción corta** (UI) y una **viñeta del Coro** (texto que se muestra al cumplirlo).
Three milestones recognized by the system. Each gets a **canonical bilingual name**, a **short description** (UI), and a **Chorus vignette** (text shown on completion).

### 3.1. `secure_four_regions` · Cuatro luces firmes / Four Steady Lights

- **Descripción corta UI:**
  - ES: *Controla 4 regiones en una misma run.*
  - EN: *Control 4 regions in a single run.*
- **Viñeta del Coro (ES):** *"Cuatro lámparas se mantienen encendidas al mismo tiempo. La arcología alta cree haber oído a la quinta responder. Puede ser verdad."*
- **Viñeta del Coro (EN):** *"Four lamps stay lit at once. The high arcology believes it heard a fifth answer. It may be true."*

### 3.2. `hold_crisis_line` · Sostener la línea / Hold the Line

- **Descripción corta UI:**
  - ES: *Termina una run con la Marea por debajo de 55.*
  - EN: *End a run with the Tide below 55.*
- **Viñeta del Coro (ES):** *"La Marea vuelve a su ritmo — no se fue, se aprendió a moverla. En Coast, los relojes del muelle vuelven a marcar hora entera."*
- **Viñeta del Coro (EN):** *"The Tide returns to its rhythm — it did not leave, it was taught to move. On Coast, the dock clocks strike the hour again."*

### 3.3. `chapter_clear` · Ecos que aguantan / Echoes That Hold

- **Descripción corta UI:**
  - ES: *Cumple el objetivo principal del capítulo.*
  - EN: *Meet the chapter's primary objective.*
- **Viñeta del Coro (ES):** *"Seis regiones laten al mismo tiempo. El Coro reconoce el compás y lo canta hacia afuera. Alguien, muy al sur, levanta la vista."*
- **Viñeta del Coro (EN):** *"Six regions beat in time. The Chorus recognizes the meter and sings it outward. Someone, far to the south, looks up."*

---

## 4. Epílogos según resultado de run / Run-outcome epilogues

Cuatro cierres posibles. Cada uno es una mini-página narrativa que aparece tras resolver la run, justo antes de que el jugador vuelva al meta-hub. Voz del Coro, imagen final, y un gesto que sugiera lo que viene.
Four possible closings. Each is a small narrative page shown after the run resolves, right before the player returns to the meta-hub. Chorus voice, closing image, and a gesture that suggests what comes next.

### 4.1. Victoria con objetivo cumplido / Win with objective met *(chapter_clear)*

- **Título EN:** *The Fresco Takes a Breath*
- **Título ES:** *El Fresco respira*

- **Cuerpo ES:**
  *Seis regiones laten bajo tu mano. La Marea no ha ganado — no hoy. En la Arcología del Norte, alguien sirve té en tazas que llevaban dos Años de Ceniza sin usarse. Las tazas están frías; el té se bebe igual.*
  *Más allá del mapa, en los Picos Calcinados, una campana sin badajo se oye por primera vez desde hace estaciones. No te llama a ti: todavía no. Solo recuerda que estás.*

- **Cuerpo EN:**
  *Six regions beat beneath your hand. The Tide did not win — not today. In the Northern Arcology, someone pours tea in cups that had not been used for two Ash Years. The cups are cold; the tea is drunk all the same.*
  *Far across the map, on the Scorched Peaks, a clapperless bell is heard for the first time in seasons. It does not call you: not yet. It only remembers that you are.*

### 4.2. Victoria sin objetivo cumplido / Win without objective *(partial win — mechanical win condition met but `chapter_clear` not unlocked in this run)*

- **Título EN:** *A Map That Holds*
- **Título ES:** *Un mapa que aguanta*

- **Cuerpo ES:**
  *Has ganado la run. No has ganado al Fresco, pero sí al turno. Los administradores cierran la mesa larga con cuidado, como quien cierra un libro que todavía se va a releer. La Marea retrocede un paso; mañana intentará el paso siguiente. Que lo intente.*

- **Cuerpo EN:**
  *You have won the run. You have not won the Fresco, but you have won the turn. The administrators close the long table carefully, the way one closes a book they will re-read. The Tide takes one step back; tomorrow it will try the next step. Let it try.*

### 4.3. Derrota por estabilidad / Loss by stability collapse

- **Título EN:** *The Long Table Empties*
- **Título ES:** *La mesa larga se vacía*

- **Cuerpo ES:**
  *La arcología se queda sin voces para pasar la sal. Uno por uno, los administradores se levantan. No hay traición. Solo agotamiento. En el centro del mapa queda una taza apoyada sobre una línea de tiza y, al fondo, una canción de cuna que nadie termina.*
  *La run cierra. El Fresco no se derrumba — sigue en pie — pero aguanta dos notas menos. Lo sabremos cuando volvamos a contarlo.*

- **Cuerpo EN:**
  *The arcology runs out of voices to pass the salt. One by one, the administrators rise. No betrayal. Only exhaustion. At the center of the map, a cup rests on a chalk line; in the background, a lullaby no one finishes.*
  *The run closes. The Fresco does not collapse — it still stands — but it holds two notes fewer. We will know when we sit to count again.*

### 4.4. Derrota por Marea desbordada / Loss by Tide overflow

- **Título EN:** *The Shadow Learns the Lullaby*
- **Título ES:** *La Sombra aprende la canción de cuna*

- **Cuerpo ES:**
  *La Marea subió hasta tocar el marco del mapa. Una región, luego dos, luego todas en silencio al mismo tiempo. En la Arcología del Norte, los niños cantan la canción de cuna y se detienen en el segundo verso — no porque no lo recuerden, sino porque el segundo verso ha dejado de tener sentido.*
  *La run cierra. En los Picos Calcinados, la campana sin badajo suena distinta. Más cerca. Más paciente.*

- **Cuerpo EN:**
  *The Tide rose until it touched the map's frame. One region, then two, then all of them silent at the same time. In the Northern Arcology, the children sing the lullaby and stop at the second verse — not because they have forgotten it, but because the second verse has ceased to make sense.*
  *The run closes. On the Scorched Peaks, the clapperless bell rings differently. Closer. More patient.*

---

## 5. Epílogo del capítulo (tras completar `chapter_clear`) / Chapter epilogue

Texto final que se muestra **una sola vez**, cuando el jugador cumple el objetivo primario del Capítulo 1 y desbloquea `unlock_event_tier_2`. Esta es la bisagra hacia el Capítulo 2.
Final text shown **once**, when the player meets Chapter 1's primary objective and unlocks `unlock_event_tier_2`. This is the hinge to Chapter 2.

### ES

*La mesa larga se pliega por primera vez en muchos Años de Ceniza. Los administradores no la guardan: solo la doblan, porque saben que volverá a abrirse.*

*Sobre el mapa, las seis luces firmes laten con la cadencia de una liturgia vieja. El Coro reconoce el ritmo y, por una noche, canta en voz alta — tan alta que en la Cuna de Ruinas, por una vez, se escucha.*

*Pero al alba, llegan tres despachos del sur. Los tres dicen lo mismo, en tres letras distintas. Una señal horaria, exacta, emite desde el Archipiélago Hundido — en un canal del Fresco que lleva apagado desde la Grieta.*

*Alguien, abajo, mantiene el reloj.*

*El Fresco respira. La Coalición también. Y en algún sitio del mapa, más allá de las arcologías del norte, una nueva voz empieza a aprender a cantar.*

*— Fin del Capítulo 1 —*

### EN

*The long table is folded for the first time in many Ash Years. The administrators do not store it: they only fold it, because they know it will open again.*

*Across the map, the six steady lights pulse with the cadence of an old liturgy. The Chorus recognizes the rhythm, and for one night, it sings aloud — loud enough that in the Cradle of Ruins, for once, it is heard.*

*But at dawn, three dispatches arrive from the south. All three say the same thing, in three different hands. An hour-signal, exact, is broadcasting from the Sunken Archipelago — on a Fresco channel that has been silent since the Cracking.*

*Someone, down there, keeps the clock.*

*The Fresco breathes. So does the Coalition. And somewhere on the map, beyond the northern arcologies, a new voice begins learning to sing.*

*— End of Chapter 1 —*

---

## 6. Teaser del Capítulo 2 / Chapter 2 teaser

Se muestra **inmediatamente después** del epílogo anterior como gancho. Una única frase en pantalla, en ambos idiomas (o en el idioma activo), sin más elementos.
Shown **immediately after** the epilogue above as a hook. A single line on screen, in either or both languages (depending on active locale), with no other UI elements.

- ES: *"El Archipiélago no se hundió. Decidió bajar la voz. Pronto aprenderás a escucharlo."*
- EN: *"The Archipelago did not sink. It chose to lower its voice. Soon, you will learn to listen to it."*

Título provisional del Capítulo 2 (reservado, no canonizar todavía fuera de este doc):
- ES: *Capítulo 2 — El Oído Hundido*
- EN: *Chapter 2 — The Sunken Ear*

---

## 7. Ganchos narrativos no utilizados pero canónicos / Canon narrative hooks not yet used

Material canónico disponible si se añaden más hitos, eventos, o pantallas al Capítulo 1 sin alterar su diseño mecánico actual. Cualquiera de estos es seguro de usar.
Canonical material ready if more milestones, events, or screens are added to Chapter 1 without changing the mechanical design. Any of these is safe to use.

1. **La primera decisión grabada.** En la Arcología del Norte, el primer acta de la Coalición se conserva en un cristal que alguien pulió con el puño del abrigo. Lo que dice el acta nadie lo recuerda bien; todos aseguran haberla firmado.
2. **La recaída de Rustbelt.** Una vez cada varios Años de Ceniza, los hornos del Rustbelt bajan su rugido un grado. Durante esa semana, las enfermedades del metal remiten y los niños del Óxido sueñan con un mar azul que no existe.
3. **El cartógrafo del Velo.** Un renegado del Velo se presentó en Silica con un mapa donde las arcologías estaban en sitios levemente distintos. Se rió cuando le dijeron que era falso. Al día siguiente, dos enclaves aparecieron donde el mapa los dibujaba.
4. **La invitación a la Cuna.** Cada cierto tiempo, la Cuna de Ruinas envía a una caravana un objeto pequeño del Fresco, limpio, sin explicación. La caravana que lo recibe no puede rechazarlo y no puede entregarlo. Lo guarda y sigue.
5. **El canto perdido.** Existe un verso de la canción de cuna que solo cantan los niños de Coastal Spires. Si dejaran de cantarlo, la marea del golfo cambiaría de ritmo. Nadie ha probado.

---

*Fin del Capítulo 1. No hay cierre — solo una mesa plegada y una campana escuchando a distancia.*
*End of Chapter 1. There is no closure — only a folded table and a bell listening from afar.*
