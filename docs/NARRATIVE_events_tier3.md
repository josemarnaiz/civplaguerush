# Codex de Eventos — Nivel 3 "Las Cosas Que Piden Tiempo"
# Event Codex — Tier 3 "The Things That Ask for Time"

> *"Tier 1 firma, Tier 2 espera, Tier 3 escucha."*
> *"Tier 1 signs, Tier 2 waits, Tier 3 listens."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuentes canónicas / Canonical sources:** `docs/LORE_bible.md`, `docs/NARRATIVE_events.md`, `docs/NARRATIVE_events_tier2.md`, `docs/NARRATIVE_regions.md`, `docs/NARRATIVE_characters.md`, `docs/LORE_chapter02.md`, `docs/LORE_chapter03.md`.
**Ámbito / Scope:** seis eventos avanzados que cubren los últimos **ganchos regionales** del Atlas y un gancho introducido por el Cap.2 (*horas perdidas*).

- **ID de desbloqueo sugerido:** `unlock_event_tier_3`. Recomendable ligarlo al avance hasta Cap.3 (o al hito equivalente del meta-hub).
- **Peso en el pool:** **bajo**. Los eventos Tier 3 son tesoros narrativos. Aparecer 1 vez por run en promedio es suficiente.
- **Este documento no modifica** `data/events.json`.

---

## Principio del Tier 3 / Tier 3 principle

**ES:** Los eventos Tier 3 no son emergencias ni propuestas. Son **pliegues del mundo** — situaciones que solo pueden resolverse si el jugador dedica atención a la textura, no a los números. Muchas admiten un "no-gesto" como opción legítima, y recompensan al jugador que **escucha antes de firmar**. Introducen personajes canónicos (ver `NARRATIVE_characters.md`) y apuntan a los endings del Cap.3.

**EN:** Tier 3 events are neither emergencies nor proposals. They are **folds of the world** — situations resolvable only when the player attends to texture, not numbers. Many admit a "non-gesture" as a legitimate option and reward players who **listen before signing**. They introduce canonical characters and point toward Chapter 3 endings.

---

## 1. `arcology_blackout` — El apagón de la Arcología / The Arcology Blackout

- **ID mecánico sugerido:** `arcology_blackout`
- **Tipo:** regional (región fija: r01 Northern Arcology; plantilla `fixed_region: r01`).
- **Pilar:** melancólico con pragmático.
- **Personaje asociado:** Alma Veder.

### Título

- ES: **El apagón de la Arcología**
- EN: **The Arcology Blackout**

### Descripción

- ES: *Un sector entero de la Arcología del Norte se ha quedado sin luz. Nadie puede reparar el fallo porque el técnico que lo sabía desapareció hace un Año de Ceniza. Alma Veder sirve té en la oscuridad.*
- EN: *A whole sector of the Northern Arcology has gone dark. No one can repair it because the technician who knew how disappeared an Ash Year ago. Alma Veder pours tea in the dark.*

### Descripción larga

- ES: *El apagón no es peligroso — no hay máquinas vitales en ese sector — pero nadie se ha atrevido a usarlo desde que el técnico se fue. Los planos del Fresco están, las herramientas están, las válvulas están nombradas. Pero el técnico había aprendido algo que los planos no dicen y que, al irse, se llevó consigo. Alma recibe a los delegados sin encender velas; dice que cuando algo no se puede arreglar, conviene tenerlo a la altura de los ojos.*
- EN: *The blackout is not dangerous — no critical machines sit in that sector — but no one has dared use it since the technician left. The Fresco blueprints remain, the tools remain, the valves are labeled. Yet the technician had learned something the blueprints do not tell, and took it with them. Alma receives the delegates without lighting candles; she says what cannot be repaired should be kept at eye level.*

### Opciones

**A) Contratar a Silika para improvisar una reparación / Hire Silika to improvise a repair**
- ES: *Contratar a Silika para improvisar*
  - Subtexto: *Costosa, creativa. La luz vuelve; algo en la arcología queda distinto.*
  - Eco posterior: *"Silika enciende el sector con cables que no deberían funcionar. Uno de los pasillos, desde entonces, zumba bajo como un abejorro. Los administradores se acostumbran."*
- EN: *Hire Silika to improvise*
  - Subtext: *Costly, creative. The light returns; something in the arcology stays different.*
  - Aftertone: *"Silika lights the sector with cables that should not work. One hallway, since then, hums low like a bumblebee. The administrators grow used to it."*

**B) Buscar al técnico desaparecido / Search for the missing technician**
- ES: *Buscar al técnico desaparecido*
  - Subtexto: *Gastar turnos y oro en una búsqueda que quizá no rinde. Pero si la Deriva lo encuentra, todo cambia.*
  - Eco posterior: *"Vadra lo recuerda. Dice que el técnico vive — o sobrevive — en un enclave del Secano. No quiere volver. Vadra le preguntó si podía enseñar a alguien. Hay un cuaderno nuevo en la Arcología del Norte."*
- EN: *Seek the missing technician*
  - Subtext: *Spend turns and gold on a search that may not yield. If the Drift finds them, everything changes.*
  - Aftertone: *"Vadra remembers. She says the technician lives — or survives — in a Drylands enclave. They do not want to come back. Vadra asked if they could teach someone. There is a new notebook in the Northern Arcology."*

**C) Dejar el sector a oscuras / Leave the sector dark**
- ES: *Dejar el sector a oscuras*
  - Subtexto: *Aceptar la pérdida. Pulso pequeño; algo en el Coro, muy bajo, da las gracias.*
  - Eco posterior: *"El sector queda cerrado con una cortina de terciopelo. Alma Veder dice: 'esta arcología vive con más de un cuarto cerrado. No pasa nada.' Los niños aprenden a caminar por otros pasillos."*
- EN: *Leave the sector dark*
  - Subtext: *Accept the loss. Small Pulse; something in the Chorus, very low, gives thanks.*
  - Aftertone: *"The sector is closed off with a velvet curtain. Alma Veder says: 'this arcology lives with more than one closed room. It passes.' Children learn to walk through other corridors."*

### Efectos mecánicos sugeridos

- Opción A: `effects_regional` (r01): `{ influence: +6 }` · `effects`: `{ resources: -10, stability: +3 }`
- Opción B: `effects`: `{ resources: -6, influence: +3, stability: +4 }` — flag `technician_found = true` (hook: abre un evento futuro de aprendizaje).
- Opción C: `effects_regional` (r01): `{ stability: +4 }` · `effects`: `{ influence: -2 }` — flag `cradle_favor += 1` (la aceptación de la pérdida suma).

---

## 2. `vadra_list` — La lista de Vadra / Vadra's List

- **ID mecánico sugerido:** `vadra_list`
- **Tipo:** regional (región fija: r03 Ashen Plains).
- **Pilar:** mítico y melancólico.
- **Personaje asociado:** Vadra.

### Título

- ES: **La lista de Vadra**
- EN: **Vadra's List**

### Descripción

- ES: *Vadra ha decidido recitar su lista — las cosas del Fresco que cayeron al suelo y nadie recogió. Pide que la Coalición escuche con cuaderno nuevo. No cobra. Lo que no se apunte, se olvida.*
- EN: *Vadra has decided to recite her list — the Fresco-things that fell and no one picked up. She asks the Coalition to listen with a fresh notebook. No charge. Whatever is not written down is forgotten.*

### Descripción larga

- ES: *Vadra no escribe, ni deja escribir. Recita. Su lista empieza por un candelabro caído en la plaza de Coastal Spires en el Año Tres; sigue con un niño que dejó su juguete en la Cuna en el Año Siete; continúa con un tren que sigue en los Páramos con los abrigos sobre los asientos; desemboca en una campana que no llegó a colgarse en ningún monasterio del Velo porque el herrero murió antes. La lista tiene ciento cuarenta objetos. Vadra los recita en once horas.*
- EN: *Vadra does not write, nor does she let others write. She recites. Her list begins with a candelabrum fallen in the Coastal Spires square in Ash Year Three; continues with a child who left their toy in the Cradle in Year Seven; goes on with a train still in the Wastes with coats on its seats; and ends with a bell that never hung in any Veil monastery because the smith died first. The list has one hundred and forty objects. Vadra recites them in eleven hours.*

### Opciones

**A) Escuchar la lista completa / Listen to the full list**
- ES: *Escuchar la lista completa*
  - Subtexto: *Dedicar once horas reales de narrativa. Los once nombres más importantes quedan como coleccionables.*
  - Eco posterior: *"Al terminar, Vadra dice: 'hasta la siguiente mesa.' No vuelve en meses. Los once nombres cambian algo pequeño pero persistente en toda arcología que los oyó."*
- EN: *Listen to the full list*
  - Subtext: *Dedicate eleven narrative hours. The eleven most important names remain as collectibles.*
  - Aftertone: *"When she finishes, Vadra says: 'until the next table.' She does not return for months. The eleven names change something small and persistent in every arcology that heard them."*

**B) Pedirle que condense la lista / Ask her to condense it**
- ES: *Pedirle que condense la lista*
  - Subtexto: *Respetar menos, obtener parte. Vadra obedece; pero los condensados no son lo mismo.*
  - Eco posterior: *"Vadra dice tres nombres. Al salir, mira al cuaderno: 'esos son los tuyos. Los otros ciento treinta y siete se van con la caravana.' Los ciento treinta y siete se olvidan de verdad."*
- EN: *Ask her to condense*
  - Subtext: *Respect less, receive part. Vadra obeys; but the condensed is not the same.*
  - Aftertone: *"Vadra says three names. On her way out, she glances at the notebook: 'those are yours. The other hundred and thirty-seven go with the caravan.' The hundred and thirty-seven are truly forgotten."*

**C) Declinar la escucha / Decline the recitation**
- ES: *Declinar con cortesía*
  - Subtexto: *La Coalición no tiene tiempo para once horas. Vadra asiente. Todo se olvida. Solo Vadra lo recuerda.*
  - Eco posterior: *"Vadra se va sin despedirse. Al cruzar las Llanuras, recita la lista al viento. El viento también es un Coro, dicen algunos. Nadie puede verificarlo."*
- EN: *Politely decline*
  - Subtext: *The Coalition has no time for eleven hours. Vadra nods. It is all forgotten. Only Vadra remembers.*
  - Aftertone: *"Vadra leaves without farewell. Crossing the Plains, she recites the list to the wind. The wind is also a Chorus, some say. None can verify."*

### Efectos mecánicos sugeridos

- Opción A: `effects`: `{ influence: +8, stability: +4, crisis: -4 }` — flag `vadra_list_heard = true`. Mayor recompensa en coleccionables (desbloquea ~11 entradas del catálogo §1 de `NARRATIVE_collectibles.md`).
- Opción B: `effects`: `{ influence: +3, resources: -2 }` — flag `vadra_list_condensed = true`. Menor recompensa.
- Opción C: `effects`: `{ influence: -4, stability: -2 }` — flag `vadra_list_refused = true`. Si Vadra muere en un evento posterior y este flag está activo, su muerte no da eco (no se queda rastro narrativo).

---

## 3. `weapon_tool_rust` — El arma-herramienta / The Weapon-Tool

- **ID mecánico sugerido:** `weapon_tool_rust`
- **Tipo:** regional (región fija: r05 Rustbelt Hubs).
- **Pilar:** pragmático con una nota mítica al final.
- **Personaje asociado:** Fero Kauz.

### Título

- ES: **El arma-herramienta**
- EN: **The Weapon-Tool**

### Descripción

- ES: *Un cónclave Rustborn pide a la Coalición una exención sanitaria. A cambio ofrece un objeto — un arma, una herramienta, ambas cosas — cuyo uso no explica. Fero Kauz firma.*
- EN: *A Rustborn conclave asks the Coalition for a sanitary exemption. In exchange, they offer an object — a weapon, a tool, both — whose use they will not explain. Fero Kauz signs.*

### Descripción larga

- ES: *El objeto llega envuelto en tela del Fresco, amarrado con cuerda. No pesa casi. Tiene un mango, una hoja, un gatillo, y una aguja que nadie sabe dónde conecta. Fero explica que el cónclave lo fabricó durante una huelga en la que los hornos bajaron de rugido. "No se acuerda cómo lo hicimos; por eso lo vendemos." A cambio piden que la Coalición les permita saltarse la inspección sanitaria del sector 7 del Rustbelt durante seis turnos. Saben que es mucho.*
- EN: *The object arrives wrapped in Fresco-cloth, tied with cord. It weighs almost nothing. It has a grip, a blade, a trigger, and a needle no one knows where connects. Fero explains that the conclave built it during a strike when the furnaces lowered their roar. "We do not remember how we did it; that is why we sell it." In exchange, they ask the Coalition to waive Sector 7 sanitary inspections for six turns. They know the asking is large.*

### Opciones

**A) Firmar la exención y aceptar el objeto / Sign the waiver and accept the object**
- ES: *Firmar la exención*
  - Subtexto: *Sí, con cláusula. Fero aprecia la lectura atenta. La Sombra de Rustbelt sube; un arma extraña entra al inventario narrativo.*
  - Eco posterior: *"El objeto se guarda en el sótano de la Arcología. Durante tres meses no hace nada. Al cuarto, un clavo cae de su propio peso al lado. Silika lo pide prestado."*
- EN: *Sign the waiver*
  - Subtext: *Yes, with a clause. Fero appreciates careful reading. Rustbelt's Shadow climbs; a strange object enters the narrative inventory.*
  - Aftertone: *"The object rests in the Arcology's cellar. For three months it does nothing. On the fourth, a nail drops of its own weight beside it. Silika asks to borrow it."*

**B) Rechazar el objeto y pagar la diferencia / Refuse and pay the difference**
- ES: *Rechazar y pagar en oro*
  - Subtexto: *Comprarle la paz al Rustbelt sin su arma. El oro se va; la Sombra no sube.*
  - Eco posterior: *"Fero anota dos golpes en su cuaderno con la palma y guarda el arma-herramienta. 'La guardaremos hasta que algún día la pidáis.' No ha explicado por qué está tan seguro."*
- EN: *Refuse and pay*
  - Subtext: *Buy Rustbelt peace without its weapon. Gold leaves; Shadow does not rise.*
  - Aftertone: *"Fero marks two palm-strikes on his notebook and stores the weapon-tool away. 'We'll keep it until you come asking someday.' He has not explained why he is so sure."*

**C) Aceptar el objeto pero negar la exención / Accept the object, deny the waiver**
- ES: *Aceptar el objeto; denegar la exención*
  - Subtexto: *Coger lo raro y no pagar el precio. Fero lo lee como una deuda no escrita.*
  - Eco posterior: *"Fero dice: 'la deuda no firmada es la peor. La recordaré yo.' El Rustbelt cumple sus plazos más lentos durante el resto del capítulo. Nunca por causa visible."*
- EN: *Accept the object, refuse the waiver*
  - Subtext: *Take the strange and not pay the cost. Fero reads it as an unwritten debt.*
  - Aftertone: *"Fero says: 'unwritten debts are the worst. I will remember this one.' The Rustbelt runs slower deadlines for the rest of the chapter. Never visibly caused."*

### Efectos mecánicos sugeridos

- Opción A: `effects_regional` (r05): `{ infection: +6, influence: +4 }` · `effects`: `{ influence: +3 }` — flag `strange_weapon_stored = true` (hook: si existe, un evento futuro en Cap.3 le da uso).
- Opción B: `effects`: `{ resources: -12, influence: +2 }` — flag `rustborn_goodwill += 1`.
- Opción C: `effects_regional` (r05): `{ stability: -5 }` · `effects`: `{ influence: -3 }` — flag `fero_debt = true` (pulla menor al resto de interacciones con Fero).

---

## 4. `silica_mirror_map` — El espejo que muestra mapas / The Mirror That Shows Maps

- **ID mecánico sugerido:** `silica_mirror_map`
- **Tipo:** regional (región fija: r06 Silica Valley).
- **Pilar:** mítico.
- **Personaje asociado:** Silika.

### Título

- ES: **El espejo que muestra mapas que no existen**
- EN: **The Mirror That Shows Maps That Do Not Exist**

### Descripción

- ES: *Silika ha construido un espejo nuevo. Muestra mapas de sitios que ninguna delegación conoce. Algunos no regresan a contar lo que vieron. Silika ofrece entrada por turnos; pide que la Coalición elija quién mira.*
- EN: *Silika has built a new mirror. It shows maps of places no delegation knows. Some who look do not return to tell what they saw. Silika offers turns to look; she asks the Coalition to choose who.*

### Descripción larga

- ES: *El espejo no es grande. Tiene un metro por un metro. Silika lo cubre con tela negra, destapa de golpe. En la superficie, durante dos minutos, aparece un mapa: a veces reconocible, a veces no. A veces es el continente como si la Grieta no hubiera ocurrido. A veces es un continente donde el Fresco es otro. Silika ha mirado tres veces. No quiere mirar más — dice que se le gastan los ojos, no los del cuerpo, los otros.*
- EN: *The mirror is not large. One meter by one. Silika covers it with black cloth, unveils it abruptly. For two minutes, a map appears on the surface: sometimes recognizable, sometimes not. Sometimes the continent as if the Cracking had never happened. Sometimes a continent where the Fresco is different. Silika has looked three times. She will not look again — she says her eyes wear out, not the body-eyes, the other ones.*

### Opciones

**A) Enviar a Kael a mirar / Send Kael to look**
- ES: *Enviar a Kael a mirar*
  - Subtexto: *Kael es entrenada para traducir voces. Puede que sepa traducir mapas.*
  - Eco posterior: *"Kael mira durante el doble de tiempo permitido. Regresa con un cuaderno nuevo, lleno de coordenadas de sitios que no existen. Tres semanas después, una delegación encuentra un pozo nuevo en las Llanuras justo donde Kael había apuntado."*
- EN: *Send Kael to look*
  - Subtext: *Kael is trained to translate voices. Perhaps she can translate maps.*
  - Aftertone: *"Kael looks for twice the allowed time. She returns with a new notebook, full of coordinates of places that do not exist. Three weeks later, a delegation finds a new well in the Plains exactly where Kael had marked."*

**B) Enviar a Alma Veder a mirar / Send Alma Veder to look**
- ES: *Enviar a Alma Veder*
  - Subtexto: *Alma tiene memoria entera. Puede que compare sin perderse.*
  - Eco posterior: *"Alma mira una sola vez. Regresa, sirve té, y dice: 'vi la Arcología del Norte con dos torres más. Las dos caídas. No sé si eso ya pasó o todavía no.' No vuelve a mirar."*
- EN: *Send Alma Veder*
  - Subtext: *Alma has whole memory. She may compare without getting lost.*
  - Aftertone: *"Alma looks once. She returns, pours tea, and says: 'I saw the Northern Arcology with two more towers. Both fallen. I don't know if that's already happened or hasn't yet.' She does not look again."*

**C) Cubrir el espejo sin mirar / Cover the mirror without looking**
- ES: *Cubrir el espejo sin mirar*
  - Subtexto: *Silika no insiste. Guarda el espejo. Tampoco lo destruye.*
  - Eco posterior: *"Silika envuelve el espejo en tres paños negros y lo guarda en un sótano. Diez turnos después, a medianoche, el sótano zumba como el pasillo de la Arcología del Norte. Ningún daño. Un zumbido."*
- EN: *Cover the mirror, do not look*
  - Subtext: *Silika does not insist. She stores the mirror. She does not destroy it either.*
  - Aftertone: *"Silika wraps the mirror in three black cloths and stores it in a cellar. Ten turns later, at midnight, the cellar hums like the Northern Arcology corridor. No damage. Just a hum."*

### Efectos mecánicos sugeridos

- Opción A: `effects`: `{ influence: +6, stability: +3 }` — flag `kael_mapped_unknowns = true` (hook para Cap.2/3: una señal horaria gana precisión).
- Opción B: `effects`: `{ stability: -4, influence: +4, crisis: -3 }` — flag `alma_saw_fallen_towers = true` (si Alma muere, su última línea referencia esto).
- Opción C: `effects`: `{ resources: -3 }` — flag `mirror_uncovered = false`. Neutro; el espejo queda como ancla narrativa para un Tier 4.

---

## 5. `silent_monastery` — El monasterio silencioso / The Silent Monastery

- **ID mecánico sugerido:** `silent_monastery`
- **Tipo:** regional (región fija: r12 Scorched Peaks).
- **Pilar:** mítico.
- **Personaje asociado:** Osia/Ossia (indirectamente).

### Título

- ES: **El monasterio que dejó de sonar**
- EN: **The Monastery That Stopped Sounding**

### Descripción

- ES: *Un monasterio del Velo ha dejado de hacer sonar la campana sin badajo. Los peregrinos esperan — no se sabe a qué. La Coalición duda entre intervenir o dejar que el silencio se resuelva solo.*
- EN: *A Veil monastery has stopped ringing its clapperless bell. Pilgrims wait — no one knows for what. The Coalition hesitates between intervening or letting the silence resolve itself.*

### Descripción larga

- ES: *El monasterio cuelga de la pared oeste de los Picos Calcinados, sostenido por una liturgia antes que por cables. Su campana sin badajo lleva doce noches sin manifestarse. Los peregrinos — trescientos — no han bajado al valle. Se sientan, miran, esperan. No piden comida. El predicador del monasterio no ha salido. Osia/Ossia, preguntada, dice: "yo también espero. Cuando llegue, sabré por qué."*
- EN: *The monastery hangs from the west wall of the Scorched Peaks, held up by liturgy before cables. Its clapperless bell has been mute for twelve nights. The pilgrims — three hundred — have not descended to the valley. They sit, look, wait. They ask for no food. The monastery's preacher has not come out. Ossia, when asked, says: "I, too, wait. When it arrives, I will know why."*

### Opciones

**A) Enviar ayuda material / Send material aid**
- ES: *Enviar ayuda material*
  - Subtexto: *Comida, mantas, médicos. Los peregrinos agradecen con el gesto del Velo. El pacto futuro gana peso.*
  - Eco posterior: *"Los peregrinos comen sin hablar. Al noveno día de ayuda, la campana del monasterio vuelve a oírse — no desde el monasterio, desde la plaza donde comían. La acústica del Fresco trabaja caminos nuevos."*
- EN: *Send material aid*
  - Subtext: *Food, blankets, physicians. The pilgrims thank with the Veil gesture. Future pact gains weight.*
  - Aftertone: *"The pilgrims eat without speaking. On the ninth day of aid, the monastery's bell rings again — not from the monastery, from the plaza where they ate. Fresco acoustics work new paths."*

**B) Enviar una delegación política / Send a political delegation**
- ES: *Enviar una delegación política*
  - Subtexto: *Hablar con el silencio como si fuera un rival. Puede que el silencio lo interprete como desconsideración.*
  - Eco posterior: *"La delegación llega. El predicador no sale; los peregrinos se reacomodan educadamente. La delegación vuelve sin respuesta; Osia/Ossia se entera en Coast y cierra los ojos un momento. No cancela su próxima reunión."*
- EN: *Send a political delegation*
  - Subtext: *Speak with silence as if it were a rival. Silence may read it as discourtesy.*
  - Aftertone: *"The delegation arrives. The preacher does not come out; the pilgrims politely rearrange themselves. The delegation returns without answer; Ossia hears in Coast and closes her eyes for a moment. She does not cancel her next meeting."*

**C) No hacer nada / Do nothing**
- ES: *No hacer nada*
  - Subtexto: *Dejar que el silencio del monasterio termine solo. Paciencia como diplomacia.*
  - Eco posterior: *"Pasan veinte turnos. En el día veintiuno, la campana suena tres veces — no cuatro, como siempre. El predicador sale y saluda al valle. Los peregrinos bajan y traen una respuesta que la Coalición nunca pidió."*
- EN: *Do nothing*
  - Subtext: *Let the monastery's silence end on its own. Patience as diplomacy.*
  - Aftertone: *"Twenty turns pass. On the twenty-first day, the bell strikes three times — not four, as always. The preacher steps out and greets the valley. The pilgrims descend carrying an answer the Coalition never asked for."*

### Efectos mecánicos sugeridos

- Opción A: `effects_regional` (r12): `{ influence: +8, stability: +4 }` · `effects`: `{ resources: -8, crisis: -3 }` — flag `veil_goodwill += 2`.
- Opción B: `effects_regional` (r12): `{ influence: -3, stability: -3 }` · `effects`: `{ influence: +2, crisis: +2 }` — flag `veil_goodwill -= 1`.
- Opción C: `effects_regional` (r12): `{ stability: +6 }` · `effects`: `{ crisis: -5, influence: +3 }` — flag `veil_goodwill += 1`, + hook para evento posterior *"La respuesta no pedida"*.

---

## 6. `lost_hour` — Una hora perdida / One Lost Hour

- **ID mecánico sugerido:** `lost_hour`
- **Tipo:** global con vocación regional (la pérdida afecta al continente pero se manifiesta primero en una región).
- **Plantilla sugerida:** `most_infected` (la Sombra pesa más cuando el tiempo se hace porosa).
- **Pilar:** mítico puro. Gancho principal: Cap.2.
- **Personaje asociado:** Kael.

### Título

- ES: **Una hora perdida**
- EN: **One Lost Hour**

### Descripción

- ES: *El reloj del Oído Hundido ha saltado una hora. Nadie la esperaba; nadie llegó a oírla. Kael la ha anotado como "hora que no se dirá". La Marea se comporta de un modo extraño durante el siguiente turno.*
- EN: *The Sunken Ear's clock has skipped an hour. Nobody expected it; nobody heard it. Kael has filed it as "the hour that shall not be spoken." The Tide behaves strangely for the next turn.*

### Descripción larga

- ES: *La ausencia de una hora es pequeña y enorme al mismo tiempo. En la Arcología del Norte, los relojes de pared dejan de coincidir entre sí por unos minutos. En Coast, la marea entra a destiempo. En {region.name} — la región más ensombrecida — la gente se siente más cansada de lo habitual sin saber por qué. Kael, sentada al micrófono, dice: "no es un error del reloj. Es que nosotros no lo escuchamos. La próxima vez, escuchemos mejor."*
- EN: *One missing hour is small and vast at once. In the Northern Arcology, wall clocks briefly disagree with each other. In Coast, the tide arrives off-time. In {region.name} — the most shadowed region — people feel more tired than usual without knowing why. Kael, seated at the microphone, says: "it is not the clock's error. It is that we did not listen. Next time, let us listen better."*

### Opciones

**A) Entrenar radioescuchas adicionales / Train more listeners**
- ES: *Entrenar radioescuchas adicionales*
  - Subtexto: *Invertir en oír mejor la próxima hora. Oro gastado; Resonancia asegurada para el resto del capítulo.*
  - Eco posterior: *"Tres discípulos de Kael entran en formación. Son lentos — ella advierte que lentos es bueno. Nadie vuelve a perder una hora ese capítulo."*
- EN: *Train additional listeners*
  - Subtext: *Invest in hearing the next hour better. Gold spent; Resonance ensured for the rest of the chapter.*
  - Aftertone: *"Three Kael-apprentices enter training. They are slow — she warns that slow is good. No hour is lost again that chapter."*

**B) Pedir al Velo que medie una "liturgia del no oír" / Ask the Veil for a "liturgy of not-hearing"**
- ES: *Pedir al Velo una liturgia*
  - Subtexto: *Aceptar, por una vez, que el Velo lleva razón estructural. Pacto con el Velo crece; Coalición cede un color.*
  - Eco posterior: *"Osia/Ossia envía seis novicios. Entran al observatorio de Silica en fila, no se presentan, no hablan. Una semana después, todos los radioescuchas oyen mejor. Incluso Kael."*
- EN: *Ask the Veil for a liturgy*
  - Subtext: *Accept, for once, that the Veil is structurally right. Veil pact grows; Coalition yields a color.*
  - Aftertone: *"Ossia sends six novices. They enter Silica's observatory in file, unintroduced, wordless. A week later, every listener hears better. Even Kael."*

**C) Anotarlo y seguir / Note it and move on**
- ES: *Anotarlo y seguir*
  - Subtexto: *No gastar oro, no llamar al Velo. Confiar en que una hora perdida es aceptable. Puede que sí; puede que no.*
  - Eco posterior: *"Kael anota la hora perdida en su cuaderno. Marca el margen con una equis. Nunca vuelve a pasar. O nunca vuelve a darse cuenta — no se sabrá distinguir."*
- EN: *Note and move on*
  - Subtext: *No gold spent, no Veil called. Trust that one lost hour is acceptable. Maybe. Maybe not.*
  - Aftertone: *"Kael files the lost hour in her notebook. She marks the margin with an X. It never happens again. Or she never notices again — it will not be known which."*

### Efectos mecánicos sugeridos

- Opción A: `effects`: `{ resources: -8, influence: +3 }` — flag `listener_school = true` (hook para Cap.3: más oídos al orquestar).
- Opción B: `effects`: `{ influence: -4, crisis: -4, stability: +4 }` — flag `veil_liturgy_adopted = true`.
- Opción C: `effects`: `{ crisis: +3, stability: -2 }` — flag `hour_lost += 1`. Con tres horas perdidas en el historial, se desbloquea un ending alternativo oculto (ver `LORE_chapter02.md §12.1`).

---

## Tabla resumen / Summary table

| ID sugerido | Región | Plantilla | Pilar | Personaje | Gancho de Biblia |
|---|---|---|---|---|---|
| `arcology_blackout` | r01 Northern Arcology | `fixed_region` | Melancólico/pragmático | Alma Veder | Prepara Cap.3 (memoria) |
| `vadra_list` | r03 Ashen Plains | `fixed_region` | Mítico/melancólico | Vadra | Desbloquea coleccionables |
| `weapon_tool_rust` | r05 Rustbelt Hubs | `fixed_region` | Pragmático | Fero Kauz | Inventario narrativo |
| `silica_mirror_map` | r06 Silica Valley | `fixed_region` | Mítico | Silika | Ancla Cap.3 |
| `silent_monastery` | r12 Scorched Peaks | `fixed_region` | Mítico | Osia/Ossia (indirecta) | Prepara mediación del Velo |
| `lost_hour` | variable | `most_infected` | Mítico | Kael | Horas perdidas de Cap.2 |

---

## Ganchos que quedan libres tras el Tier 3 / Hooks still free after Tier 3

Material consumido:
Hooks used:

- r01 (apagón) ✓
- r02 (flota del Velo) ✓ en Tier 2
- r03 (lista de Vadra) ✓
- r04 (caja sellada) ✓ en Tier 2
- r05 (arma-herramienta) ✓
- r06 (espejo de Sílice) ✓
- r07 (niña de la Cuna) ✓ en Tier 2
- r08 (tregua del silencio) ✓ en Tier 2
- r09 (sueño compartido) ✓ en Tier 2
- r10 (señal horaria) reservado para Cap.2 como eje
- r11 (flautas de hueso) ✓ en Tier 2
- r12 (monasterio silencioso) ✓

Queda espacio para:
Room remains for:

- **Una segunda onda de eventos globales** (no regionales) — sobre hambre crónica, prensa, memoria colectiva. Reservado.
- **Eventos específicos del Cap.2 y Cap.3** — esos son responsabilidad de las biblias de capítulo, no del pool general.
- **Un evento final del Cap.3** que orquesta los tres coros — descrito en `LORE_chapter03.md §8`.

---

*Fin del Tier 3. Seis pliegues del mundo que solo se abren si alguien les da tiempo.*
*End of Tier 3. Six folds of the world that open only for those who give them time.*
