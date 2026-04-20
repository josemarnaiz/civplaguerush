# Codex de Eventos — Capítulo 1 "Ecos de Ceniza"
# Event Codex — Chapter 1 "Echoes of Ash"

> *"No elegimos lo que ocurre. Elegimos el gesto con el que se lo devolvemos al Fresco."*
> *"We do not choose what happens. We choose the gesture with which we return it to the Fresco."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuente canónica / Canonical source:** `docs/LORE_bible.md`, `docs/NARRATIVE_regions.md`.
**Ámbito / Scope:** este documento contiene las 12 entradas de evento del Capítulo 1, cada una con título, descripción corta, descripción larga (para tooltips y logs), y las 3 opciones con sus etiquetas y subtexto. Todo bilingüe.

---

## Cómo leer cada evento / How to read each event

Cada ficha contiene:
- **ID:** identificador mecánico (no cambiar).
- **Tipo:** global o regional (con plantilla de selección).
- **Pilar dominante:** mítico / pragmático / melancólico.
- **Título EN/ES:** forma corta. Los regionales usan `{region.name}` y `{region.short}` como sustitución dinámica.
- **Descripción EN/ES:** 2-3 frases. Voz del Coro.
- **Descripción larga EN/ES** *(opcional, para log o tooltip expandido):* 3-5 frases adicionales que amplían textura sin cambiar la decisión.
- **Opciones (x3) EN/ES:**
  - *Etiqueta* (imperativa, ≤ 40 caracteres).
  - *Subtexto* (una frase evocadora que se muestra al hover o en confirmación).
  - *Eco posterior* (una frase del Coro que se puede mostrar tras resolverse la elección).

Los campos de efectos mecánicos (`effects`, `effects_regional`, `effects_adjacent`) se mantienen tal cual los define `data/events.json` y **no** son responsabilidad narrativa.

---

## 1. `food_shortage` — Escasez de Grano / Grain Shortage

- **Tipo:** global.
- **Pilar:** pragmático, con capa melancólica.

### Título

- ES: **Escasez de Grano**
- EN: **Grain Shortage**

### Descripción

- ES: *Los silos amanecen con menos de lo que acostaron. El Coro de Ceniza lo llama "un año corto", pero los niños de la Arcología ya han aprendido a repetir la palabra "ración" antes de pedir pan.*
- EN: *The silos wake with less than they slept with. The Ash Chorus calls it "a short year," but the Arcology's children have already learned to repeat the word "ration" before asking for bread.*

### Descripción larga

- ES: *Las llanuras de la Deriva traen menos de lo acordado. Los mercados de Coastal Spires bajan el volumen. Nadie ha dicho "hambre" todavía, porque nombrar la cosa suele adelantarla. En las mesas largas del norte, un administrador apunta cifras en el margen de un plano: la letra le sale más pequeña que otros años.*
- EN: *The Drift's plains bring less than was agreed. Coastal Spires' markets lower their volume. No one has said "famine" yet, because naming the thing tends to summon it. On the long northern tables, an administrator writes numbers in a blueprint's margin: this year the handwriting comes out smaller than usual.*

### Opciones

**A) Abrir importaciones de emergencia / Open emergency imports**
- ES (etiqueta): *Abrir importaciones urgentes*
  - Subtexto: *Vaciar el cofre y que el pan llegue antes que la duda.*
  - Eco posterior: *"Las caravanas cargan y el Pulso se estabiliza; el oro se gasta con dignidad."*
- EN (label): *Open emergency imports*
  - Subtext: *Empty the coffers; let bread arrive before doubt does.*
  - Aftertone: *"The caravans load and the Pulse steadies; the gold is spent with dignity."*

**B) Racionar con severidad / Ration aggressively**
- ES: *Racionar con puño cerrado*
  - Subtexto: *La mano que distribuye el pan aprende a pesar. Y a olvidar.*
  - Eco posterior: *"Queda grano en los silos y un silencio nuevo en los barrios bajos. La Marea sube por el silencio."*
- EN: *Ration with a closed fist*
  - Subtext: *The hand that gives bread learns to weigh. And to forget.*
  - Aftertone: *"Grain remains in the silos, and a new silence in the lower quarters. The Tide rises through the silence."*

**C) Invertir en granjas hidropónicas / Invest in hydro farms**
- ES: *Levantar granjas de cristal*
  - Subtexto: *Plantar bajo Sílice lo que el Secano ya no da. El Fresco sabía hacerlo; quedan planos.*
  - Eco posterior: *"En el Valle de Sílice encienden invernaderos antiguos. Huelen a lluvia que nunca cayó."*
- EN: *Raise glass farms*
  - Subtext: *Plant beneath Silica what the Drylands no longer yield. The Fresco knew how; blueprints remain.*
  - Aftertone: *"In Silica Valley ancient greenhouses reignite. They smell of rain that never fell."*

---

## 2. `border_uprising` — Levantamiento Fronterizo / Border Uprising

- **Tipo:** global.
- **Pilar:** pragmático.

### Título

- ES: **Levantamiento Fronterizo**
- EN: **Border Uprising**

### Descripción

- ES: *Dos enclaves fronterizos izan banderas que no tejimos nosotros. Al norte se oye una campana sin badajo — puede que la del Velo, puede que del óxido — y los administradores cierran las puertas un poco antes que otras noches.*
- EN: *Two border enclaves raise flags we did not weave. Northward, a bell without clapper is heard — possibly the Veil's, possibly the rust's — and administrators close the doors a little earlier than other nights.*

### Descripción larga

- ES: *Las provincias de la frontera no son ingratas: son demasiado honestas. Cuando el precio del grano sube y la Sombra no baja, firman su propia bandera en la misma tela con la que ayer marcaron pescado. No es rebelión. Es una carta abierta con la tinta que había.*
- EN: *Border provinces are not ungrateful: they are too honest. When grain prices rise and the Shadow does not fall, they sign their own flag on the same cloth that yesterday labeled fish. It is not rebellion. It is an open letter with whatever ink was at hand.*

### Opciones

**A) Enviar negociadores / Send negotiators**
- ES: *Enviar mesa larga a la frontera*
  - Subtexto: *Hablar, aunque cueste influencia. El pulso se sostiene con promesas cumplidas.*
  - Eco posterior: *"Dos banderas vuelven al arcón. Las costuras se deshacen bien cuando se las respeta."*
- EN: *Send a long table to the border*
  - Subtext: *Talk — even if it costs influence. The Pulse holds on kept promises.*
  - Aftertone: *"Two flags return to the chest. Seams undo gracefully when they are respected."*

**B) Desplegar ejecutores / Deploy enforcers**
- ES: *Desplegar ejecutores*
  - Subtexto: *El cordón se cierra. Se gana una región en el mapa; se pierde una en la memoria.*
  - Eco posterior: *"La frontera obedece. Alguien ha dejado una canción de cuna escrita en la puerta del cuartel."*
- EN: *Deploy enforcers*
  - Subtext: *The cordon closes. A region is won on the map; one is lost in memory.*
  - Aftertone: *"The border obeys. Someone has left a lullaby written on the barracks' door."*

**C) Conceder autonomía local / Grant local autonomy**
- ES: *Conceder autonomía*
  - Subtexto: *Soltar el puño para que el Pulso siga latiendo. Menos control, menos grietas.*
  - Eco posterior: *"Las provincias firman sus propios lemas. El Fresco admite un color nuevo sin protestar."*
- EN: *Grant autonomy*
  - Subtext: *Open the fist so the Pulse keeps beating. Less control, fewer cracks.*
  - Aftertone: *"The provinces sign their own mottos. The Fresco admits a new color without protest."*

---

## 3. `info_leak` — Fuga de Doctrina / Doctrine Leak

- **Tipo:** global.
- **Pilar:** pragmático con pizca mítica.

### Título

- ES: **Fuga de Doctrina**
- EN: **Doctrine Leak**

### Descripción

- ES: *Nuestros planos más tercos han aparecido copiados en papel que no es nuestro. Los predicadores del Velo los leen en voz baja. Los Nacidos del Óxido, en voz alta — y con risa.*
- EN: *Our most stubborn plans have shown up, copied, on paper that is not ours. Veil preachers read them in low voices. The Rustborn read them aloud — and laugh.*

### Descripción larga

- ES: *Un despacho reservado está en todas las mesas mal iluminadas del mapa. Alguien cobró por hacerlo, alguien pagó por leerlo, y la Coalición se mira a sí misma buscando el vaso roto en el borde de la larga mesa. Hay doctrinas que no se protegen con candados; se protegen con silencio. El silencio se ha vuelto caro este mes.*
- EN: *A classified dispatch is on every badly-lit table across the map. Someone was paid to do it, someone paid to read it, and the Coalition looks at itself searching for the chipped glass on the long table's edge. Some doctrines are not protected by locks; they are protected by silence. Silence has grown expensive this month.*

### Opciones

**A) Silenciar los canales / Silence the channels**
- ES: *Silenciar los canales*
  - Subtexto: *Apretar. Cerrar. Olvidar nombres. Los leales se quedan más tranquilos y más solos.*
  - Eco posterior: *"Tres oficinas se cierran esta semana. Quien las cruzaba ayer ya no las recuerda."*
- EN: *Silence the channels*
  - Subtext: *Tighten. Close. Forget names. The loyal are calmer — and lonelier.*
  - Aftertone: *"Three offices close this week. Those who crossed them yesterday no longer remember them."*

**B) Convertirlo en transparencia / Spin it as transparency**
- ES: *Convertirlo en transparencia*
  - Subtexto: *Publicar lo que ya todos leen, firmado. Oro manchado brillado aprisa.*
  - Eco posterior: *"Las ciudades copian el lema. El Velo baja el volumen un grado. No más."*
- EN: *Spin it as transparency*
  - Subtext: *Publish what everyone already reads — signed. Tarnished gold polished in haste.*
  - Aftertone: *"Cities copy the motto. The Veil lowers its volume a single notch. No more."*

**C) Empujar contrainteligencia / Counter-intelligence push**
- ES: *Empujar a las sombras internas*
  - Subtexto: *Hacer el trabajo sucio con luz tenue. Gastar oro, recuperar oídos.*
  - Eco posterior: *"El mapa se vuelve a escuchar nítido. Un archivo aparece vacío y nadie pregunta."*
- EN: *Push the inner shadows*
  - Subtext: *Do the dirty work in dim light. Spend gold, recover ears.*
  - Aftertone: *"The map sounds clear again. One archive turns up empty and no one asks."*

---

## 4. `pandemic_wave` — Ola de Marea / Tide Surge

- **Tipo:** global.
- **Pilar:** melancólico con capa mítica. Este es el evento más atmosférico.

### Título

- ES: **Ola de Marea**
- EN: **Tide Surge**

### Descripción

- ES: *La Marea sube a un ritmo que no es el suyo. Logística titubea, los hospitales abren dos puertas más, y en cada arcología, alguien deja de cantar la canción de cuna completa.*
- EN: *The Tide rises at a rhythm that is not its own. Logistics stumbles, hospitals open two more doors, and in every arcology, someone stops singing the lullaby in full.*

### Descripción larga

- ES: *La Sombra se mueve por las cañerías del Rustbelt y por los muelles de Coast al mismo tiempo — como si compartieran un reloj. Los médicos del Ecuador Profundo cuelgan en sus puertas dibujos de flores que nadie reconoce. En la Arcología del Norte, el administrador más viejo insiste en que esto ya pasó, en el año quince después de la Grieta. Nadie encuentra el registro.*
- EN: *The Shadow moves through Rustbelt's pipes and Coast's docks at the same time — as if they shared a clock. Deep Equator's physicians hang drawings of unrecognizable flowers on their doors. In the Northern Arcology, the oldest administrator insists this happened before, in the fifteenth Ash Year. No one finds the record.*

### Opciones

**A) Cerrar los nodos comerciales / Lock down trade hubs**
- ES: *Sellar los nodos comerciales*
  - Subtexto: *Cortar la sangre para salvar el cuerpo. El Pulso se queja; la Marea baja.*
  - Eco posterior: *"Los almacenes callan. En las Agujas Costeras, alguien borra la hora del reloj del muelle."*
- EN: *Seal the trade hubs*
  - Subtext: *Cut the blood to save the body. The Pulse complains; the Tide recedes.*
  - Aftertone: *"The warehouses fall quiet. On the Coastal Spires, someone erases the hour from the dock clock."*

**B) Tratamiento rápido masivo / Mass rapid treatment**
- ES: *Desplegar tratamiento masivo*
  - Subtexto: *Vaciar el botiquín del continente. El Pulso se firma más alto; el oro baja.*
  - Eco posterior: *"Cien mil brazos ofrecen venas. Cien mil frescos conservan un color más un año."*
- EN: *Deploy mass treatment*
  - Subtext: *Empty the continent's pharmacy. The Pulse signs higher; the gold sinks.*
  - Aftertone: *"A hundred thousand arms offer veins. A hundred thousand frescoes keep one color for one more year."*

**C) Dejar que las regiones se gestionen solas / Let regions self-manage**
- ES: *Dejar que cada región cure la suya*
  - Subtexto: *Reconocer que el norte no puede ver todo el mapa. El oro se queda; el Pulso se parte.*
  - Eco posterior: *"Cada región cuenta sus muertos en voz baja. La Marea aprende un ritmo nuevo."*
- EN: *Let each region heal its own*
  - Subtext: *Admit that the north cannot see the whole map. The gold stays; the Pulse splits.*
  - Aftertone: *"Each region counts its dead in low voices. The Tide learns a new rhythm."*

---

## 5. `golden_opportunity` — Oferta Dorada / Golden Offer

- **Tipo:** global.
- **Pilar:** pragmático, con capa mítica en el título.

### Título

- ES: **Oferta Dorada**
- EN: **Golden Offer**

### Descripción

- ES: *Una región neutral ofrece lealtad. El precio está escrito en una esquina del papel; el olor del papel es nuevo.*
- EN: *A neutral region offers allegiance. The price is written in the corner of the paper; the paper smells fresh.*

### Descripción larga

- ES: *Un delegado llega con un contrato escrito en dos manos — la primera en verbo claro, la segunda en verbo pequeño. Pide apoyo, pide reconocimiento, pide un poco de oro por las molestias. Se sienta en la mesa larga y se queda quieto como si la oferta se la hiciera él a sí mismo.*
- EN: *A delegate arrives with a contract written in two hands — the first in clear verb, the second in small verb. They ask for support, for recognition, for a little gold for the trouble. They sit at the long table and stay still, as if the offer they made was theirs to receive.*

### Opciones

**A) Pagar el paquete de apoyo / Pay the support package**
- ES: *Pagar el paquete entero*
  - Subtexto: *Oro por dos regiones, sin regatear. El Fresco se ensancha un hilo.*
  - Eco posterior: *"El delegado firma con tres manos. La tercera la dibujó el propio Coro."*
- EN: *Pay the full package*
  - Subtext: *Gold for two regions, without haggling. The Fresco widens by a thread.*
  - Aftertone: *"The delegate signs with three hands. The third was drawn by the Chorus itself."*

**B) Ofrecer un pacto de defensa / Offer a defense pact**
- ES: *Ofrecer un pacto de defensa*
  - Subtexto: *Menos oro, más palabra. La Coalición cede influencia; gana una sombra amiga.*
  - Eco posterior: *"Se firma bajo candelabros del Fresco; dos pisos abajo, alguien ya está contando las velas."*
- EN: *Offer a defense pact*
  - Subtext: *Less gold, more word. The Coalition yields influence; it gains a friendly shadow.*
  - Aftertone: *"They sign beneath Fresco candelabra; two floors below, someone is already counting the candles."*

**C) Declinar por ahora / Decline for now**
- ES: *Declinar con cortesía*
  - Subtexto: *Guardar el oro. La oferta volverá — distinta, más cara, o de otro bando.*
  - Eco posterior: *"El delegado sonríe. Al día siguiente ha cruzado el mapa y está cenando en el Velo."*
- EN: *Decline, politely*
  - Subtext: *Keep the gold. The offer will return — altered, pricier, or from another camp.*
  - Aftertone: *"The delegate smiles. By the next day they have crossed the map and are dining at the Veil."*

---

## 6. `outbreak_focus` — Brote en {region.name} / Outbreak in {region.name}

- **Tipo:** regional (plantilla: `most_infected`).
- **Pilar:** melancólico con capa pragmática.

### Título

- ES: **Brote en {region.name}**
- EN: **Outbreak in {region.name}**

### Descripción

- ES: *{region.name} entra en una nueva ola. La Sombra se vuelve más oscura, más lenta, más dulce. Los vecinos miran desde sus balcones sin saber si cerrar o cantar.*
- EN: *{region.name} enters a new wave. The Shadow grows darker, slower, sweeter. Neighboring regions watch from their balconies unsure whether to close their doors or to sing.*

### Descripción larga

- ES: *Los médicos de {region.name} dejan de pedir refuerzos en un tono y empiezan a pedirlos en otro. Los mapas del evento muestran un círculo que crece al ritmo de una campana sin badajo. En {region.short}, la palabra "cuarentena" lleva días en boca de todos: unos la dicen como amenaza, otros como rezo.*
- EN: *{region.name}'s physicians stop requesting reinforcements in one tone and begin requesting them in another. The event's maps show a circle expanding at the rhythm of a clapperless bell. In {region.short}, the word "quarantine" has been on every mouth for days: some say it as threat, others as prayer.*

### Opciones

**A) Cuarentena dura de {region.short} / Hard quarantine of {region.short}**
- ES: *Cuarentena dura de {region.short}*
  - Subtexto: *Sellar puertas, sellar trenes, sellar cartas. El Fresco se corta limpio por una línea.*
  - Eco posterior: *"{region.short} queda detrás de una línea de tiza. Al otro lado, alguien aprende el gesto del que se queda."*
- EN: *Hard quarantine of {region.short}*
  - Subtext: *Seal doors, seal trains, seal letters. The Fresco cuts clean along a line.*
  - Aftertone: *"{region.short} is left behind a chalk line. On the other side, someone learns the gesture of the one who stays."*

**B) Paquete médico urgente / Rush a medical aid package**
- ES: *Empujar ayuda médica urgente*
  - Subtexto: *Gastar oro por vidas que podemos contar. El Pulso local se agradece.*
  - Eco posterior: *"Las ambulancias abren ventanas. En {region.name}, los niños vuelven a preguntar por postre."*
- EN: *Rush medical aid*
  - Subtext: *Spend gold on lives we can name. The local Pulse gives thanks.*
  - Aftertone: *"Ambulances open their windows. In {region.name}, children ask for dessert again."*

**C) Fortificar cordón alrededor de {region.short} / Fortify cordon around {region.short}**
- ES: *Fortificar cordón alrededor de {region.short}*
  - Subtexto: *Sacrificar la región para salvar las vecinas. El Coro guarda este gesto para el epílogo.*
  - Eco posterior: *"{region.short} se queda sola con la Sombra. Alrededor, los vecinos aprenden un silencio nuevo."*
- EN: *Fortify cordon around {region.short}*
  - Subtext: *Sacrifice the region to save its neighbors. The Chorus saves this gesture for the epilogue.*
  - Aftertone: *"{region.short} is left alone with the Shadow. Around it, neighbors learn a new silence."*

---

## 7. `frontier_uprising` — Fricción en la frontera de {region.short} / Unrest on the {region.short} frontier

- **Tipo:** regional (plantilla: `bordering_controlled`).
- **Pilar:** pragmático.

### Título

- ES: **Fricción en la frontera de {region.short}**
- EN: **Unrest on the {region.short} frontier**

### Descripción

- ES: *Las tensiones arden en {region.name}, una frontera donde el Fresco y el Velo comparten sombra. Al este, la Coalición respira hondo y espera la carta.*
- EN: *Tensions flare in {region.name}, a border where Fresco and Veil share one shadow. Eastward, the Coalition breathes deep and waits for the letter.*

### Descripción larga

- ES: *El mercado de {region.short} lleva tres semanas cerrando dos horas antes. Los predicadores del Velo caminan despacio por las calles centrales. Los administradores de la Coalición responden con mesas aún más largas. La gente de {region.name} mira ambos gestos y decide uno — no hoy, pero pronto.*
- EN: *{region.short}'s market has been closing two hours early for three weeks. Veil preachers walk slowly through the central streets. The Coalition's administrators respond with still-longer tables. {region.name}'s people watch both gestures and choose one — not today, but soon.*

### Opciones

**A) Desplegar cuadro leal / Deploy loyalist cadre**
- ES: *Desplegar cuadro leal*
  - Subtexto: *La Coalición firma con su rostro más serio. Influencia sube, Pulso se resiente.*
  - Eco posterior: *"Los cuadros cenan en la plaza. La mitad de la plaza come con ellos; la otra mitad cena en casa."*
- EN: *Deploy loyalist cadre*
  - Subtext: *The Coalition signs with its sternest face. Influence rises, Pulse strains.*
  - Aftertone: *"The cadre dines in the plaza. Half the plaza dines with them; the other half dines at home."*

**B) Incentivos comerciales / Offer trade incentives**
- ES: *Ofrecer incentivos comerciales*
  - Subtexto: *Oro que convence sin gritar. Pulso sube; el cofre baja.*
  - Eco posterior: *"Los almacenes de {region.short} abren dos horas más. La campana del Velo se oye menos."*
- EN: *Offer trade incentives*
  - Subtext: *Gold that persuades without shouting. Pulse rises; coffer sinks.*
  - Aftertone: *"{region.short}'s warehouses open two more hours. The Veil's bell is heard less."*

**C) Ignorar la fricción / Ignore the unrest**
- ES: *Ignorar la fricción*
  - Subtexto: *Dejar que la frontera se queme sola. El oro se queda; la Sombra sube por la chimenea.*
  - Eco posterior: *"Nada se decide hoy. Mañana alguien ha tachado una arcología del mapa con lápiz."*
- EN: *Ignore the unrest*
  - Subtext: *Let the border burn on its own. The gold stays; the Shadow climbs the flue.*
  - Aftertone: *"Nothing is decided today. Tomorrow someone has crossed an arcology off the map with pencil."*

---

## 8. `defector_cell` — Célula desertora en {region.name} / Defector cell in {region.name}

- **Tipo:** regional (plantilla: `least_influence`).
- **Pilar:** pragmático con capa mítica.

### Título

- ES: **Célula desertora en {region.name}**
- EN: **Defector cell in {region.name}**

### Descripción

- ES: *Rivales organizan sus cartas desde {region.name} — una región donde nuestra mano pesa poco. Miran nuestras posesiones cercanas con la paciencia de quien ya ha leído dos veces el mapa.*
- EN: *Rivals arrange their cards from {region.name} — a region where our hand weighs little. They look at our nearby holdings with the patience of those who have read the map twice.*

### Descripción larga

- ES: *La célula no se esconde bien, pero tampoco le hace falta. Recluta en los cafés, paga en oro manchado, deja cartas abiertas sobre las mesas. El Coro canta bajo en {region.name}: la canción de cuna vuelve a cantarse, pero con dos versos cambiados. Los cambios son pequeños. Son exactos.*
- EN: *The cell does not hide well, but it does not need to. It recruits in cafés, pays in tarnished gold, leaves letters open on tables. The Chorus sings low in {region.name}: the lullaby is sung again, but with two verses altered. The alterations are small. They are precise.*

### Opciones

**A) Infiltrar y cooptar / Infiltrate and co-opt**
- ES: *Infiltrar y cooptar*
  - Subtexto: *Jugar su juego con nuestros guantes. Influencia sube; el oro y la Marea lo pagan.*
  - Eco posterior: *"Un par de desertores cenan en la Arcología. Cuentan versos nuevos con acento propio."*
- EN: *Infiltrate and co-opt*
  - Subtext: *Play their game wearing our gloves. Influence rises; gold and Tide pay for it.*
  - Aftertone: *"A pair of defectors dine in the Arcology. They recite new verses with their own accent."*

**B) Asedio económico sobre {region.short} / Economic siege on {region.short}**
- ES: *Asediar en lo económico a {region.short}*
  - Subtexto: *Apretar el cinturón ajeno. Influencia sube; Pulso local se hunde.*
  - Eco posterior: *"El mercado de {region.short} aprende a vender menos cosas con más palabras."*
- EN: *Lay economic siege on {region.short}*
  - Subtext: *Tighten someone else's belt. Influence rises; local Pulse sinks.*
  - Aftertone: *"{region.short}'s market learns to sell fewer things with more words."*

**C) Dejar que se desangren solos / Let them bleed themselves**
- ES: *Dejar que se desangren solos*
  - Subtexto: *No intervenir. La Marea global sube; los vecinos resienten la Sombra que no contuvimos.*
  - Eco posterior: *"La célula crece y se parte en dos. Las dos miran al mismo lugar en el mapa."*
- EN: *Let them bleed themselves*
  - Subtext: *Do not intervene. The global Tide rises; neighbors resent the Shadow we did not contain.*
  - Aftertone: *"The cell grows and splits in two. Both halves look at the same point on the map."*

---

## 9. `relief_mission` — Misión de Auxilio / Relief Mission

- **Tipo:** regional (plantilla: `player_chooses`, filtro `uncontrolled`).
- **Pilar:** melancólico con pragmático.

### Título

- ES: **Misión de Auxilio — elige destino**
- EN: **Relief Mission — choose a destination**

### Prompt de selección

- ES: *Elige una región no controlada para recibir auxilio.*
- EN: *Pick an uncontrolled region to receive relief.*

### Descripción

- ES: *Una coalición de caridades — medio Deriva, medio Fresco — ofrece llenar de oro y médicos el enclave que señalemos. Nadie ha dicho a cambio de qué. Nunca lo dicen en voz alta.*
- EN: *A coalition of charities — half Drift, half Fresco — offers to fill with gold and physicians whichever enclave we name. No one has said in exchange for what. They never say it aloud.*

### Descripción larga

- ES: *Las caravanas ya están cargadas. Huelen a linimento y a harina. Los Derivados que las guían saben que la decisión depende del gesto de una mano — no ellos, no los enfermos, no la Marea. Una mano sobre un mapa.*
- EN: *The caravans are already loaded. They smell of liniment and flour. The Drift drivers know the decision hangs on a hand's gesture — not theirs, not the sick's, not the Tide's. A hand over a map.*

### Opciones

**A) Empuje de infraestructura en {region.short} / Infrastructure push in {region.short}**
- ES: *Empujar infraestructura en {region.short}*
  - Subtexto: *Levantar lo que falta, antes de curar lo que duele. Influencia y Pulso suben.*
  - Eco posterior: *"Los tejados de {region.short} dejan de gotear. Los niños descubren un eco nuevo en el patio."*
- EN: *Push infrastructure in {region.short}*
  - Subtext: *Raise what is missing before healing what hurts. Influence and Pulse rise.*
  - Aftertone: *"The roofs of {region.short} stop leaking. The children discover a new echo in the yard."*

**B) Erradicación en {region.short} / Disease eradication in {region.short}**
- ES: *Erradicar la Sombra en {region.short}*
  - Subtexto: *Los médicos entran primero. La Sombra cae limpia; el oro se vacía.*
  - Eco posterior: *"Las ventanas de {region.short} se abren a mediodía. En el Coro se reconoce un compás ganado."*
- EN: *Eradicate the Shadow in {region.short}*
  - Subtext: *The physicians enter first. The Shadow falls clean; the coffers empty.*
  - Aftertone: *"The windows of {region.short} open at noon. The Chorus recognizes a beat regained."*

**C) Redirigir recursos a casa / Redirect resources home instead**
- ES: *Redirigir los recursos a casa*
  - Subtexto: *Negar la ayuda. El oro vuelve, la influencia cae, la canción de cuna se canta un verso menos.*
  - Eco posterior: *"Las caravanas dan media vuelta. En {region.short} alguien apaga la lámpara que nos esperaba."*
- EN: *Redirect resources home instead*
  - Subtext: *Decline the aid. The gold returns, influence sinks, the lullaby is sung with one fewer verse.*
  - Aftertone: *"The caravans turn back. In {region.short} someone extinguishes the lamp that was waiting for us."*

---

## 10. `sabotage_strike` — Golpe de sabotaje en {region.name} / Sabotage strike on {region.name}

- **Tipo:** regional (plantilla: `frontier_controlled`).
- **Pilar:** pragmático con mítico.

### Título

- ES: **Golpe de sabotaje en {region.name}**
- EN: **Sabotage strike on {region.name}**

### Descripción

- ES: *Agentes rivales apuntan a {region.name}, nuestra fortaleza fronteriza. Cada vecino mira para ver qué gesto devolvemos.*
- EN: *Rival agents target {region.name}, our frontier stronghold. Every neighbor watches to see what gesture we return.*

### Descripción larga

- ES: *La noche del sabotaje, nadie oyó nada — y esa es la señal. En el patio de la arcología local alguien ha dejado una campana sin badajo colgada del picaporte. No la tocó el viento. La vieron los guardias a las tres de la madrugada y fingieron que no.*
- EN: *On the night of the sabotage, no one heard anything — and that is the signal. In the local arcology's courtyard, someone has hung a clapperless bell from the door handle. The wind did not touch it. The guards saw it at three in the morning and pretended they didn't.*

### Opciones

**A) Respuesta rápida en {region.short} / Deploy rapid response in {region.short}**
- ES: *Desplegar respuesta rápida en {region.short}*
  - Subtexto: *Firma visible, gesto orgulloso. Pulso e influencia suben; el oro pesa menos.*
  - Eco posterior: *"Los vecinos aplauden cuando pasan los carros. Al Velo le tiembla un pie sin moverse."*
- EN: *Deploy rapid response in {region.short}*
  - Subtext: *Visible signature, proud gesture. Pulse and influence rise; the gold grows lighter.*
  - Aftertone: *"Neighbors applaud as the carts pass. The Veil's foot trembles without moving."*

**B) Investigar en silencio / Investigate quietly**
- ES: *Investigar en silencio*
  - Subtexto: *No responder con cara. Se aprende más; la Sombra gana un palmo.*
  - Eco posterior: *"Un informe llega en papel sin sellar. Lee tres nombres. Dos ya se han ido."*
- EN: *Investigate quietly*
  - Subtext: *Answer without a face. More is learned; the Shadow gains a handspan.*
  - Aftertone: *"A report arrives on unsealed paper. It names three. Two have already left."*

**C) Convocar represalia / Rally a retaliation**
- ES: *Convocar represalia*
  - Subtexto: *Devolver el golpe. El mapa se enciende; los aliados cercanos dudan.*
  - Eco posterior: *"Los tambores se oyen desde la Arcología del Norte. La Marea responde con otra ola."*
- EN: *Rally a retaliation*
  - Subtext: *Return the strike. The map lights up; nearby allies hesitate.*
  - Aftertone: *"The drums are heard from the Northern Arcology. The Tide answers with another wave."*

---

## 11. `cure_trial` — Ensayo de cura / Cure Trial

- **Tipo:** regional (plantilla: `player_chooses`, filtro `infected`).
- **Pilar:** mítico con capa melancólica. Este evento toca directamente la ambigüedad de la plaga.

### Título

- ES: **Ensayo de cura — elige una región**
- EN: **Cure trial — choose a host region**

### Prompt de selección

- ES: *Elige una región infectada para alojar el ensayo.*
- EN: *Pick an infected region to host the cure trial.*

### Descripción

- ES: *Los investigadores del Valle de Sílice han preparado una cura que dicen funcionar. Dicen "dicen". Antes de creerles, preguntan dónde probar.*
- EN: *Silica Valley's researchers have prepared a cure they say works. They say "say." Before we believe them, they ask where to try it.*

### Descripción larga

- ES: *La fórmula llega en tres frascos pequeños, cada uno con una inscripción: uno en el idioma del Fresco, uno en el de la Deriva, uno en un idioma que los investigadores juran no haber escrito. "Funcionará", dicen. Nadie les pregunta qué entienden por funcionar.*
- EN: *The formula arrives in three small vials, each with an inscription: one in the Fresco's tongue, one in the Drift's, one in a language the researchers swear they did not write. "It will work," they say. No one asks what they mean by work.*

### Opciones

**A) Despliegue completo en {region.short} / Full rollout in {region.short}**
- ES: *Despliegue completo en {region.short}*
  - Subtexto: *Todo o nada. La Sombra cae mucho; el oro, más.*
  - Eco posterior: *"{region.short} respira. Los vecinos también — un suspiro pequeño, casi agradecido."*
- EN: *Full rollout in {region.short}*
  - Subtext: *All or nothing. The Shadow falls deeply; the gold, deeper.*
  - Aftertone: *"{region.short} breathes. So do the neighbors — a small sigh, almost grateful."*

**B) Ensayo cauto en {region.short} / Cautious limited trial in {region.short}**
- ES: *Ensayo cauto en {region.short}*
  - Subtexto: *Medir antes de creer. Sombra baja; influencia sube un paso.*
  - Eco posterior: *"Los frascos vuelven medio llenos. Un investigador no duerme; escribe toda la noche."*
- EN: *Cautious limited trial in {region.short}*
  - Subtext: *Measure before believing. Shadow sinks; influence gains a step.*
  - Aftertone: *"The vials return half full. One researcher does not sleep; she writes all night."*

**C) Desviar la financiación a propaganda / Divert funding to propaganda**
- ES: *Desviar el oro a propaganda*
  - Subtexto: *Vender esperanza en lugar de probarla. Influencia sube; la Marea global también.*
  - Eco posterior: *"Los carteles brillan en la Arcología. Los investigadores queman el tercer frasco sin decir por qué."*
- EN: *Divert funding to propaganda*
  - Subtext: *Sell hope instead of testing it. Influence rises; the global Tide, too.*
  - Aftertone: *"Posters glow across the Arcology. The researchers burn the third vial without saying why."*

---

## 12. `mass_migration` — Migración masiva hacia {region.name} / Mass migration into {region.name}

- **Tipo:** regional (plantilla: `bordering_controlled`).
- **Pilar:** melancólico.

### Título

- ES: **Migración masiva hacia {region.name}**
- EN: **Mass migration into {region.name}**

### Descripción

- ES: *Refugiados inundan {region.name}, desestabilizando la frontera pegada a nuestra mano. Las puertas se negocian a diario; los nombres, cada hora.*
- EN: *Refugees flood {region.name}, destabilizing the border pressed against our hand. Doors are negotiated daily; names, hourly.*

### Descripción larga

- ES: *Vienen de dos semanas andando y de algún lugar del mapa donde la Sombra alcanzó la canción de cuna. No gritan. Traen niños y carpetas. En la plaza central de {region.name} alguien ha escrito con tiza: "cabemos todos si cabemos despacio". La tiza ha aguantado la lluvia del viernes. No es tiza nuestra.*
- EN: *They have been walking for two weeks from somewhere on the map where the Shadow reached the lullaby. They do not shout. They carry children and folders. In {region.name}'s central plaza someone has written in chalk: "we all fit if we fit slowly." The chalk survived Friday's rain. It is not our chalk.*

### Opciones

**A) Abrir corredores hacia {region.short} / Open corridors into {region.short}**
- ES: *Abrir corredores hacia {region.short}*
  - Subtexto: *Aceptar a todos; la influencia sube, la Sombra también.*
  - Eco posterior: *"La plaza se llena. Alguien canta la canción de cuna con tres versos nuevos — bonitos."*
- EN: *Open corridors into {region.short}*
  - Subtext: *Accept all; influence rises, the Shadow rises too.*
  - Aftertone: *"The plaza fills. Someone sings the lullaby with three new verses — beautiful ones."*

**B) Sellar la frontera / Seal the border**
- ES: *Sellar la frontera*
  - Subtexto: *Cerrar las puertas. La Sombra local baja; las vecinas la heredan.*
  - Eco posterior: *"Las puertas se cierran. Al otro lado, los refugiados escriben nombres en la puerta; tantos que la puerta se dobla."*
- EN: *Seal the border*
  - Subtext: *Close the doors. Local Shadow falls; neighbors inherit it.*
  - Aftertone: *"The doors close. On the other side, refugees write names on them; enough names to bend the door."*

**C) Reasentar en provincias adyacentes / Resettle into adjacent holdings**
- ES: *Reasentar en provincias vecinas*
  - Subtexto: *Repartir el peso. Gastar oro; ganar influencia repartida; debilitar un poco el Pulso vecino.*
  - Eco posterior: *"Las caravanas se desvían. Tres arcologías aprenden a poner la mesa más larga."*
- EN: *Resettle into neighboring holdings*
  - Subtext: *Spread the weight. Spend gold; gain distributed influence; weaken neighbors' Pulse slightly.*
  - Aftertone: *"The caravans divert. Three arcologies learn to set their long tables longer."*

---

## Registro de integración / Integration log

Este documento **no modifica** `data/events.json`. Describe la narrativa que los IDs mecánicos deben exhibir cuando la UI los renderice. Si un programador o diseñador quiere alinear los textos en JSON con estos, puede usar la tabla inferior como correspondencia directa.
This document **does not modify** `data/events.json`. It describes the narrative that the mechanical IDs must exhibit when rendered by the UI. If a programmer or designer wants to align the JSON texts with these, use the table below as direct correspondence.

| ID mecánico | Sección narrativa | Campo sugerido a remplazar en JSON |
|---|---|---|
| `food_shortage` | §1 | `title`, `description`, `choices[].label` |
| `border_uprising` | §2 | ídem |
| `info_leak` | §3 | ídem |
| `pandemic_wave` | §4 | ídem |
| `golden_opportunity` | §5 | ídem |
| `outbreak_focus` | §6 | ídem + respetar placeholders `{region.name}` y `{region.short}` |
| `frontier_uprising` | §7 | ídem |
| `defector_cell` | §8 | ídem |
| `relief_mission` | §9 | ídem + `target_prompt` |
| `sabotage_strike` | §10 | ídem |
| `cure_trial` | §11 | ídem + `target_prompt` |
| `mass_migration` | §12 | ídem |

Los campos *subtexto* y *eco posterior* son **material opcional** para una segunda iteración de UI (tooltips expandidos, log narrativo). No son necesarios para la primera integración.

---

*Fin del Codex. Doce gestos sobre un mapa, doce ecos en el Fresco.*
*End of the Codex. Twelve gestures over one map, twelve echoes in the Fresco.*
