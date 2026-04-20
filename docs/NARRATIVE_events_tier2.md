# Codex de Eventos — Nivel 2 "Las Cosas Más Lentas"
# Event Codex — Tier 2 "The Slower Things"

> *"El primer año de una Coalición aprende a reaccionar. El segundo aprende a esperar."*
> *"A Coalition's first year learns to react. The second learns to wait."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuente canónica / Canonical source:** `docs/LORE_bible.md`, `docs/NARRATIVE_regions.md`, `docs/NARRATIVE_events.md`.
**Ámbito / Scope:** seis eventos adicionales derivados de los "ganchos de evento" del Atlas Regional. Están diseñados para **desbloquearse tras completar `chapter_clear`** (el unlock `unlock_event_tier_2` que ya define el sistema) y para aumentar la capa mítica del juego sin romper el balance del pool básico.

- **ID de desbloqueo requerido:** `unlock_event_tier_2`.
- **Integración sugerida:** añadir al pool de `EventDirector` con peso inferior al de los eventos Tier 1, para que aparezcan como "cosas raras que ocurren".
- **Este documento no modifica** `data/events.json`. Entrega textos listos para copiar.

---

## Principio de diseño narrativo del Tier 2 / Tier 2 narrative principle

Los eventos Tier 1 plantean **problemas que piden gesto rápido** (brote, levantamiento, fuga). Los Tier 2 plantean **cosas que no se van** — propuestas, ofertas, misterios. Tienen menor urgencia mecánica y mayor peso atmosférico. Casi todos introducen o profundizan un misterio canónico (la Cuna, el Archipiélago, el Velo, la Deriva).
Tier 1 events pose **problems that ask for a quick gesture** (outbreak, uprising, leak). Tier 2 events pose **things that do not leave** — proposals, offers, mysteries. Lower mechanical urgency, heavier atmosphere. Almost all deepen a canonical mystery.

---

## 1. `sealed_box_frost` — La caja sellada / The Sealed Box

- **ID mecánico sugerido:** `sealed_box_frost`
- **Tipo:** regional (región fija: r04 Frozen Wastes; plantilla `fixed_region: r04`).
- **Pilar:** mítico con pragmático.
- **Misterio que toca:** la plaga como arma diseñada.

### Título

- ES: **La caja sellada de los Páramos**
- EN: **The Sealed Box of the Wastes**

### Descripción

- ES: *Una caja con el sello del Fresco ha salido del hielo en los Páramos Helados. Los Nacidos del Óxido ofrecen abrirla. El Velo suplica que no se abra. La mesa larga calla.*
- EN: *A box bearing the Fresco's seal has risen from the ice in the Frozen Wastes. The Rustborn offer to open it. The Veil begs it not be opened. The long table is silent.*

### Descripción larga

- ES: *La caja está intacta. El sello tampoco se ha roto, aunque se deja leer: tres líneas en idioma del Fresco y una cuarta en algo que nadie reconoce. Los Rustborn han traído llaves, cizallas, soldadores. Un predicador del Velo ha viajado tres semanas para rogar, con cortesía, que la caja se devuelva al hielo. En los mercados de Coast ya se apuestan qué contiene: una cura, un arma, un niño, un dios.*
- EN: *The box is intact. The seal too remains unbroken, though legible: three lines in the Fresco's tongue and a fourth in something no one recognizes. The Rustborn have brought keys, shears, welders. A Veil preacher has traveled three weeks to politely beg for the box to be returned to the ice. In Coast's markets there are already bets on what it contains: a cure, a weapon, a child, a god.*

### Opciones

**A) Dejar que los Nacidos del Óxido la abran / Let the Rustborn open it**
- ES: *Dejar que los Rustborn la abran*
  - Subtexto: *Pagar por saber. Lo que salga de la caja entra en el mapa.*
  - Eco posterior: *"La caja se abre con un ruido blando. Una semana después, la Deriva trae un objeto pequeño que no sabe describir, y tres enclaves nuevos firman contratos con el Rustbelt."*
- EN: *Let the Rustborn open it*
  - Subtext: *Pay to know. Whatever emerges from the box enters the map.*
  - Aftertone: *"The box opens with a soft sound. A week later, the Drift returns an object it cannot describe, and three new enclaves sign contracts with the Rustbelt."*

**B) Devolver la caja al hielo / Return the box to the ice**
- ES: *Devolverla al hielo*
  - Subtexto: *Creer al Velo por esta noche. La ambigüedad se guarda; el Pulso se tranquiliza.*
  - Eco posterior: *"La caja se vuelve a enterrar con una liturgia que nadie ensayó. El predicador del Velo no da las gracias; baja la cabeza al pasar."*
- EN: *Return it to the ice*
  - Subtext: *Believe the Veil tonight. Ambiguity is stored; the Pulse calms.*
  - Aftertone: *"The box is reburied with a liturgy no one rehearsed. The Veil preacher does not thank anyone; they bow their head in passing."*

**C) Llevarla al Valle de Sílice para estudiarla / Bring it to Silica Valley to study**
- ES: *Llevarla a Sílice para estudiar*
  - Subtexto: *Ni abrir ni devolver. Mirar desde todos los ángulos posibles.*
  - Eco posterior: *"Los ingenieros construyen tres espejos nuevos para mirar la caja sin tocarla. Uno de los espejos deja de reflejar a los que pasan por delante."*
- EN: *Take it to Silica Valley to study*
  - Subtext: *Neither open nor bury. Look from every possible angle.*
  - Aftertone: *"The engineers build three new mirrors to look at the box without touching it. One of the mirrors stops reflecting those who walk past."*

### Efectos mecánicos sugeridos (no canónicos — el equipo de diseño decide)

- Opción A: `effects_regional` (r04): `{ influence: +8, infection: +6 }` · `effects`: `{ resources: -6, crisis: +3 }`
- Opción B: `effects_regional` (r04): `{ stability: +6 }` · `effects`: `{ crisis: -4, influence: +3 }`
- Opción C: `effects`: `{ resources: -10, influence: +5 }` · posible flag para desbloquear evento de seguimiento (*The Mirror That Does Not Reflect*, cap.2).

---

## 2. `silence_truce_veil` — La tregua del silencio / The Silence Truce

- **ID mecánico sugerido:** `silence_truce_veil`
- **Tipo:** regional (región fija: r08 The Veil; plantilla `fixed_region: r08`).
- **Pilar:** mítico.
- **Misterio que toca:** la Doctrina del Velo como antagonista ambigua.

### Título

- ES: **La tregua del silencio**
- EN: **The Silence Truce**

### Descripción

- ES: *Un predicador del Velo propone diez días sin ningún gesto — ni ataque, ni despacho, ni edicto. Quien acepte, promete silencio. Quien lo rompa, lo pagará en Pulso.*
- EN: *A Veil preacher offers ten days with no gesture — no attack, no dispatch, no edict. Whoever accepts, promises silence. Whoever breaks it, pays in Pulse.*

### Descripción larga

- ES: *La oferta llega grabada en un cuerno de campana sin badajo: el predicador la sostiene con ambas manos y solo la suelta cuando alguien la acepta o la rechaza. Si se acepta, dice, la Coalición y el Velo bajarán la voz a la vez durante diez días. Si se rompe la palabra por cualquier lado, "el silencio devuelve el gesto entero". No ha explicado qué significa. Ha mirado el mapa mucho rato.*
- EN: *The offer arrives engraved on the horn of a clapperless bell: the preacher holds it with both hands and only releases it when it is accepted or refused. If accepted, they say, the Coalition and the Veil will lower their voices together for ten days. If the word is broken from either side, "the silence returns the entire gesture." They have not explained what that means. They have looked at the map for a long time.*

### Opciones

**A) Aceptar la tregua y cumplirla / Accept and honor the truce**
- ES: *Aceptar la tregua*
  - Subtexto: *Diez días sin firmar nada. Algo se mueve en el Velo — no bueno, no malo, lento.*
  - Eco posterior: *"Durante diez días, la Coalición no dicta nada. El Pulso se asienta. Al undécimo día, dos de las arcologías del norte amanecen con una campana sin badajo en la puerta. Hay té servido."*
- EN: *Accept the truce*
  - Subtext: *Ten days signing nothing. Something moves in the Veil — not good, not bad, slow.*
  - Aftertone: *"For ten days, the Coalition issues no edict. The Pulse settles. On the eleventh day, two of the northern arcologies wake with a clapperless bell at their door. Tea is poured."*

**B) Aceptar y romperla a mitad / Accept, then break it**
- ES: *Aceptar y romperla después*
  - Subtexto: *Mentir con solemnidad. Ganar turno; perder algo que no cabe en el HUD.*
  - Eco posterior: *"El predicador se entera antes que nadie. No grita, no se va; se sienta en la Arcología del Norte y espera. A partir de ese día, el mapa entero cree saber algo que nunca se dijo."*
- EN: *Accept it, then break it*
  - Subtext: *Lie solemnly. Win a turn; lose something that does not fit on the HUD.*
  - Aftertone: *"The preacher knows before anyone else. They do not shout, they do not leave; they sit in the Northern Arcology and wait. From that day, the whole map believes it knows something that was never said."*

**C) Rechazar la oferta / Refuse the offer**
- ES: *Rechazar con firmeza*
  - Subtexto: *Negar la liturgia ajena. El Pulso se tensa; la Influencia sube.*
  - Eco posterior: *"El predicador guarda el cuerno. Al despedirse, dice: 'La próxima vez la caja será tuya.' Nadie entiende a qué caja se refiere. Nadie se atreve a preguntar."*
- EN: *Firmly refuse*
  - Subtext: *Deny another's liturgy. Pulse tightens; Influence rises.*
  - Aftertone: *"The preacher packs up the horn. On leaving, they say: 'Next time the box will be yours.' No one understands which box. No one dares to ask."*

### Efectos mecánicos sugeridos

- Opción A: `effects`: `{ stability: +8, crisis: -5, influence: -3 }` — el jugador pierde una ventana de acción que habría usado.
- Opción B: `effects`: `{ influence: +6, crisis: +6, stability: -5 }` — flag interno: `truce_broken = true` (hook para eventos futuros).
- Opción C: `effects`: `{ influence: +4, crisis: +3 }` — interacción frontal normal.

---

## 3. `shared_dream_drylands` — El sueño compartido / The Shared Dream

- **ID mecánico sugerido:** `shared_dream_drylands`
- **Tipo:** regional (región fija: r09 Southern Drylands; plantilla `fixed_region: r09`).
- **Pilar:** mítico con melancólico.
- **Misterio que toca:** la plaga como idea / memoria.

### Título

- ES: **El sueño compartido**
- EN: **The Shared Dream**

### Descripción

- ES: *Un enclave del Secano ha descubierto un acuífero del Fresco. El agua sale tibia y dulce. Los niños que la beben sueñan todos el mismo sueño. Los padres no han dicho si es bonito.*
- EN: *A Drylands enclave has uncovered a Fresco aquifer. The water runs warm and sweet. Every child who drinks it dreams the same dream. Parents have not said whether it is beautiful.*

### Descripción larga

- ES: *El enclave ha empezado a racionar el agua sin que nadie dé la orden. Los niños, al cabo de tres noches bebiéndola, cuentan el mismo sueño con detalle creciente — un patio con mosaicos del Fresco, una silla vacía, una canción de cuna con un verso más. Los médicos del Ecuador Profundo han pedido muestras. La Deriva ya ha pasado por el enclave dos veces: la primera miró el agua, la segunda miró a los niños.*
- EN: *The enclave has started rationing the water without anyone giving the order. After three nights drinking it, the children tell the same dream with growing detail — a courtyard with Fresco mosaics, an empty chair, a lullaby with one more verse. Deep Equator's physicians have requested samples. The Drift has passed the enclave twice: first they looked at the water, then they looked at the children.*

### Opciones

**A) Distribuir el agua en toda la Coalición / Distribute the water across the Coalition**
- ES: *Repartir el agua*
  - Subtexto: *Que todos sueñen el sueño, si es el mismo, al menos sabremos qué soñamos.*
  - Eco posterior: *"En tres arcologías, los niños cantan el verso nuevo de la canción de cuna. Un administrador viejo lo reconoce. No dice dónde lo aprendió."*
- EN: *Distribute the water*
  - Subtext: *Let everyone dream the dream — if it is the same, at least we will know what we dream.*
  - Aftertone: *"In three arcologies, the children sing the new lullaby verse. An old administrator recognizes it. They do not say where they learned it."*

**B) Sellar el acuífero / Seal the aquifer**
- ES: *Sellar el acuífero*
  - Subtexto: *Cerrar el grifo del Fresco. El oro se gasta; la Sombra se esconde; el sueño se va.*
  - Eco posterior: *"Se construye una tapa de hormigón del Fresco reciclado. Durante un mes, los niños del enclave no sueñan nada. Después vuelven a soñar — otro sueño. Más pobre."*
- EN: *Seal the aquifer*
  - Subtext: *Close the Fresco's tap. Gold spent; Shadow hidden; the dream departs.*
  - Aftertone: *"A lid is built from recycled Fresco concrete. For a month, the enclave's children dream nothing. Then they dream again — another dream. A poorer one."*

**C) Aislar a los niños del enclave y estudiarlos en Sílice / Isolate the children and study them in Silica**
- ES: *Aislar a los niños para estudiarlos*
  - Subtexto: *La crueldad limpia. Se aprende; se pierde algo al enclave.*
  - Eco posterior: *"Los niños vuelven al enclave tres meses después. Hablan igual. Saben más. No vuelven a beber el agua. Nadie les preguntó si querían."*
- EN: *Isolate the children to study them*
  - Subtext: *Clean cruelty. Knowledge is gained; something is lost to the enclave.*
  - Aftertone: *"The children return three months later. They speak the same. They know more. They never drink the water again. No one asked if they wanted to."*

### Efectos mecánicos sugeridos

- Opción A: `effects_regional` (r09): `{ influence: +6, infection: +4 }` · `effects_adjacent`: `{ infection: +2 }` · `effects`: `{ stability: +4 }`
- Opción B: `effects_regional` (r09): `{ infection: -6, influence: -3 }` · `effects`: `{ resources: -8 }`
- Opción C: `effects_regional` (r09): `{ stability: -6, influence: -2 }` · `effects`: `{ influence: +5, resources: -4 }`

---

## 4. `cradle_returns` — Vuelve una voz / A Voice Returns

- **ID mecánico sugerido:** `cradle_returns`
- **Tipo:** regional (región fija: r07 Cradle of Ruins; plantilla `fixed_region: r07`).
- **Pilar:** mítico puro.
- **Misterio que toca:** el Silencio de la Cuna.

### Título

- ES: **Vuelve una voz de la Cuna**
- EN: **A Voice Returns from the Cradle**

### Descripción

- ES: *Un niño sale caminando de la Cuna de Ruinas hablando un idioma que ningún cronista reconoce. Habla despacio. Espera respuesta.*
- EN: *A child walks out of the Cradle of Ruins speaking a language no chronicler recognizes. They speak slowly. They wait for an answer.*

### Descripción larga

- ES: *El niño no está asustado. Tampoco enfermo. Tiene las manos limpias y las uñas recortadas. Habla con pausa, como si leyera. Los enviados de la Coalición le han ofrecido pan: lo ha aceptado, lo ha partido en dos, y ha devuelto una mitad. Los predicadores del Velo, al enterarse, han detenido el paso sin consulta. La Deriva ha ofrecido llevar al niño al Archipiélago; los médicos del Ecuador quieren estudiarlo; los Rustborn no han dicho nada, por primera vez en años.*
- EN: *The child is not afraid. Nor sick. Their hands are clean, their nails trimmed. They speak with pauses, as if reading. Coalition envoys have offered bread: the child accepted, broke it in two, and handed back one half. The Veil's preachers, hearing this, have halted their march without consultation. The Drift has offered to take the child to the Archipelago; the Equator's physicians want to study them; the Rustborn have said nothing, for the first time in years.*

### Opciones

**A) Acoger al niño en la Arcología del Norte / Welcome the child in the Northern Arcology**
- ES: *Acoger al niño en la Arcología*
  - Subtexto: *Llevarlo a la mesa larga. El Coro escucha con atención. La Cuna, también.*
  - Eco posterior: *"El niño come con los administradores y se queda tres semanas. Enseña tres palabras nuevas al mayor de la mesa. Al despedirse, deja una de las palabras dicha en voz alta."*
- EN: *Welcome the child in the Arcology*
  - Subtext: *Bring them to the long table. The Chorus listens closely. So does the Cradle.*
  - Aftertone: *"The child eats with the administrators and stays three weeks. They teach three new words to the eldest of the table. On leaving, they speak one of the words aloud as farewell."*

**B) Entregarlo a los médicos del Ecuador Profundo / Hand them to the Deep Equator physicians**
- ES: *Entregarlo a los médicos*
  - Subtexto: *Medir lo que no se puede medir. La Sombra baja; algo se pierde.*
  - Eco posterior: *"El niño se deja estudiar sin resistencia. Los médicos publican un informe tres páginas más corto de lo previsto. Nadie encuentra la parte que falta."*
- EN: *Hand them to the physicians*
  - Subtext: *Measure what cannot be measured. Shadow sinks; something is lost.*
  - Aftertone: *"The child allows themselves to be studied without resistance. The physicians publish a report three pages shorter than expected. No one finds the missing part."*

**C) Devolverlo a la Cuna / Return them to the Cradle**
- ES: *Devolverlo a la Cuna*
  - Subtexto: *No hacer nada. La Cuna recupera lo que había prestado.*
  - Eco posterior: *"El niño camina hacia la Cuna sin mirar atrás. En el umbral, se detiene, saluda con la misma mano que recibió pan, y entra. La Cuna guarda silencio una temporada más larga que la habitual."*
- EN: *Return them to the Cradle*
  - Subtext: *Do nothing. The Cradle reclaims what it lent.*
  - Aftertone: *"The child walks toward the Cradle without looking back. At the threshold, they pause, wave with the same hand that received bread, and enter. The Cradle keeps silent for a longer season than usual."*

### Efectos mecánicos sugeridos

- Opción A: `effects`: `{ influence: +6, stability: +3, crisis: +3 }` — hook de lore: el niño enseñó una palabra.
- Opción B: `effects_regional` (r07): `{ infection: -6 }` · `effects`: `{ influence: +3, stability: -3 }`
- Opción C: `effects_regional` (r07): `{ infection: -10, stability: +4 }` · `effects`: `{ influence: -4 }` — flag interno `cradle_favor += 1` para Cap.2.

---

## 5. `veil_fleet_coast` — La flota pálida / The Pale Fleet

- **ID mecánico sugerido:** `veil_fleet_coast`
- **Tipo:** regional (región fija: r02 Coastal Spires; plantilla `fixed_region: r02`).
- **Pilar:** pragmático con capa mítica.
- **Misterio que toca:** la presencia paciente del Velo.

### Título

- ES: **La flota pálida ante las Agujas**
- EN: **The Pale Fleet Before the Spires**

### Descripción

- ES: *Una flota del Velo ha echado anclas fuera del radio de cañón de las Agujas Costeras. No negocia. Espera. Los muelles bajan el volumen sin que nadie lo ordene.*
- EN: *A Veil fleet has anchored beyond the Coastal Spires' cannon range. It does not negotiate. It waits. The docks lower their volume without anyone giving the order.*

### Descripción larga

- ES: *Son trece barcos blancos, con velas de tela sin teñir y campanas sin badajo en cada proa. No han respondido a las radios, pero tampoco las han apagado. Los pescadores dicen que por las noches se oye cantar, muy bajo, desde cubierta — una liturgia que no coincide con la del continente. Los mercaderes del Óxido han pedido permiso para subir a bordo con mercancía; no se les ha respondido.*
- EN: *Thirteen white ships, with undyed sails and clapperless bells at each prow. They have not answered radios, nor silenced them. Fishermen say that on some nights singing is heard, very low, from the deck — a liturgy that does not match the continent's. Rustborn merchants have asked permission to come aboard with cargo; no answer.*

### Opciones

**A) Enviar una delegación a cubierta / Send a delegation aboard**
- ES: *Enviar delegación a cubierta*
  - Subtexto: *Poner la mesa larga sobre el mar. El Pulso respira; algo nuevo se negocia.*
  - Eco posterior: *"Cinco delegados suben. Cuatro bajan. El que se quedó envió dos meses después una carta escrita en tinta diluida, muy educada, proponiendo tregua."*
- EN: *Send a delegation aboard*
  - Subtext: *Place the long table on the sea. The Pulse breathes; something new is negotiated.*
  - Aftertone: *"Five delegates go up. Four come down. The one who stayed sends, two months later, a letter written in diluted ink, very polite, proposing a truce."*

**B) Bloquear la flota con barcos costeros / Blockade with Coastal ships**
- ES: *Bloquear con barcos costeros*
  - Subtexto: *Mostrar dientes. Influencia y Pulso mejoran; el oro baja; la Sombra local sube.*
  - Eco posterior: *"La flota no se mueve. Cuatro semanas después, las velas se levantan solas de madrugada y la flota se retira sin saludar. Las campanas no sonaron."*
- EN: *Blockade with Coastal ships*
  - Subtext: *Show teeth. Influence and Pulse rise; gold sinks; local Shadow climbs.*
  - Aftertone: *"The fleet does not move. Four weeks later, the sails rise on their own at dawn and the fleet retreats without greeting. The bells did not ring."*

**C) Ignorar la flota / Ignore the fleet**
- ES: *Ignorar la flota*
  - Subtexto: *Como si no estuvieran. El oro se queda; la gente de Coast baja la voz más de lo que conviene.*
  - Eco posterior: *"Los barcos siguen anclados durante todo el capítulo. Los niños de Coast aprenden a dormir con el ruido del mar que casi se oye cantar."*
- EN: *Ignore the fleet*
  - Subtext: *As if they were not there. Gold stays; Coast's people lower their voices more than is healthy.*
  - Aftertone: *"The ships remain anchored for the rest of the chapter. Coast's children learn to sleep with a sea that almost sings."*

### Efectos mecánicos sugeridos

- Opción A: `effects_regional` (r02): `{ stability: +4 }` · `effects`: `{ resources: -6, crisis: -3 }` — flag `veil_envoy_contact = true`.
- Opción B: `effects_regional` (r02): `{ influence: +6, infection: +4 }` · `effects`: `{ resources: -8, stability: +4 }`
- Opción C: `effects_regional` (r02): `{ stability: -5 }` · `effects`: `{ crisis: +4 }`

---

## 6. `bone_flutes_equator` — Las flautas de hueso / The Bone Flutes

- **ID mecánico sugerido:** `bone_flutes_equator`
- **Tipo:** regional (región fija: r11 Deep Equator; plantilla `fixed_region: r11`).
- **Pilar:** mítico con melancólico.
- **Misterio que toca:** la plaga como posible entidad con voluntad.

### Título

- ES: **Las flautas de hueso**
- EN: **The Bone Flutes**

### Descripción

- ES: *Una clínica del Ecuador afirma que la Sombra retrocede cuando se tocan ciertas flautas talladas en hueso del Fresco. La Coalición necesita creerlo o desmentirlo.*
- EN: *A clinic in the Deep Equator claims the Shadow recedes when certain flutes, carved from Fresco-bone, are played. The Coalition needs to believe it or debunk it.*

### Descripción larga

- ES: *Las flautas son tres, cada una de un hueso distinto. Los médicos del Ecuador las han probado delante de seis pacientes. En cuatro casos, la Sombra bajó medible. En dos, el paciente murió con una sonrisa. Los investigadores de Sílice quieren los huesos; los predicadores del Velo aseguran que las flautas son suyas; la Deriva las trajo al Ecuador y no dice de dónde.*
- EN: *There are three flutes, each from a different bone. The Equator's physicians have played them before six patients. In four cases, the Shadow measurably receded. In two, the patient died smiling. Silica's researchers want the bones; Veil preachers insist the flutes are theirs; the Drift brought them to the Equator and will not say from where.*

### Opciones

**A) Producir copias en el Valle de Sílice / Produce copies in Silica Valley**
- ES: *Copiar las flautas en Sílice*
  - Subtexto: *Escalar el milagro si es falso, el crimen si es verdadero. Sombra baja; Influencia y Pulso suben; oro se gasta.*
  - Eco posterior: *"Sílice fabrica doce copias. Seis funcionan. De las otras seis, tres son silbatos para perros y los tres restantes no suenan. Nadie sabe por qué."*
- EN: *Copy the flutes in Silica Valley*
  - Subtext: *Scale the miracle if false, the crime if true. Shadow sinks; Influence and Pulse rise; gold is spent.*
  - Aftertone: *"Silica manufactures twelve copies. Six work. Of the other six, three are dog-whistles and three make no sound at all. No one knows why."*

**B) Entregar las flautas al Velo / Hand the flutes to the Veil**
- ES: *Entregar las flautas al Velo*
  - Subtexto: *Ceder. El Pulso respira; la Influencia baja; pactos nuevos aparecen.*
  - Eco posterior: *"Los predicadores agradecen sin palabras. En la siguiente luna, una caravana del Velo entrega un objeto pequeño en la Arcología. No se explica. Se guarda."*
- EN: *Hand the flutes to the Veil*
  - Subtext: *Yield. Pulse breathes; Influence sinks; new pacts appear.*
  - Aftertone: *"The preachers give thanks without speaking. At the next moon, a Veil caravan delivers a small object to the Arcology. No explanation. It is kept."*

**C) Destruir las flautas / Destroy the flutes**
- ES: *Destruir las flautas*
  - Subtexto: *Negar la ambigüedad. Pulso global se resiente; Influencia sube, pero algo en el Ecuador enferma un color más.*
  - Eco posterior: *"Las flautas se queman al amanecer. Un músico del Ecuador las graba de memoria. Canta la melodía una vez al año. Nadie vuelve a enfermarse aquella semana."*
- EN: *Destroy the flutes*
  - Subtext: *Deny ambiguity. Global Pulse strains; Influence rises, but something in the Equator sickens by one more color.*
  - Aftertone: *"The flutes are burned at dawn. An Equator musician records the tune from memory. They play it once a year. No one falls ill that week."*

### Efectos mecánicos sugeridos

- Opción A: `effects`: `{ influence: +5, stability: +4, crisis: -6, resources: -8 }`
- Opción B: `effects_regional` (r08): `{ influence: -4 }` · `effects`: `{ stability: +6, crisis: -4, influence: -3 }` — flag `veil_goodwill += 1`.
- Opción C: `effects_regional` (r11): `{ stability: -5, infection: +3 }` · `effects`: `{ influence: +4, crisis: -2 }`

---

## Tabla resumen / Summary table

| ID sugerido | Región | Plantilla | Pilar | Misterio tocado |
|---|---|---|---|---|
| `sealed_box_frost` | r04 Frozen Wastes | `fixed_region` | Mítico/pragmático | Plaga como arma diseñada |
| `silence_truce_veil` | r08 The Veil | `fixed_region` | Mítico | La Doctrina del Velo |
| `shared_dream_drylands` | r09 Southern Drylands | `fixed_region` | Mítico/melancólico | Plaga como idea |
| `cradle_returns` | r07 Cradle of Ruins | `fixed_region` | Mítico | Silencio de la Cuna |
| `veil_fleet_coast` | r02 Coastal Spires | `fixed_region` | Pragmático/mítico | Presencia del Velo |
| `bone_flutes_equator` | r11 Deep Equator | `fixed_region` | Mítico/melancólico | Plaga como entidad |

---

## Nota para el sistema de templates / Note on the template system

Estos eventos introducen un nuevo tipo de plantilla narrativa — `fixed_region` — que resuelve siempre a la misma región en lugar de elegirla dinámicamente. Si el `EventDirector` actual no lo soporta, el diseño tiene dos caminos sin tocar la lógica:
These events introduce a new narrative template type — `fixed_region` — which always resolves to the same region instead of picking dynamically. If the current `EventDirector` does not support it, design has two paths without touching logic:

1. **Precalcular el texto**: sustituir `{region.name}` y `{region.short}` a mano en el JSON usando los nombres ya fijos. Los placeholders dejarían de ser placeholders. Funcionaría con el sistema actual sin cambios.
2. **Extender el sistema de plantillas**: añadir `template: "fixed_region"` con campo `region_id: "r04"`. Es una línea adicional y no rompe nada. *Esta decisión es del agente de código, no mía.*

---

## Ganchos de follow-up no incluidos aquí / Follow-up hooks not included here

Los siguientes ganchos del Atlas Regional siguen sin evento dedicado. Reservados para Tier 3 o para Cap.2:
The following Atlas hooks still have no dedicated event. Reserved for Tier 3 or Chapter 2:

- r01 — Apagón sectorial en la Arcología del Norte.
- r03 — El Anciano Vadra con su lista de cosas caídas del Fresco.
- r05 — Rustborn piden exención sanitaria por un "arma-herramienta".
- r06 — El espejo de Sílice que muestra mapas que no existen.
- r10 — La señal horaria del Archipiélago Hundido. **(Clave: corazón del Cap.2, desarrollar allí.)**
- r12 — El monasterio del Velo que dejó de sonar.

---

*Fin del Tier 2. Seis lentitudes nuevas que el Fresco no supo evitar.*
*End of Tier 2. Six new slownesses the Fresco could not avoid.*
