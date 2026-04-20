# Micro-texto de UI / UI Microtext

> *"Un botón bien nombrado ya es media narrativa."*
> *"A well-named button is already half the narrative."*

**Mantenedor / Maintainer:** agente narrativo.
**Última revisión / Last revised:** 2026-04-20.
**Fuentes canónicas / Canonical sources:** `docs/NARRATIVE_style_guide.md`, `docs/NARRATIVE_run_states.md` (base ya promulgada), `docs/LORE_bible.md`, `docs/NARRATIVE_iconography.md`.
**Ámbito / Scope:** textos cortos que viven en la interfaz del juego — **loading screens**, **transiciones entre escenas**, **confirmaciones**, **tutorial**, **mensajes de error**, **notificaciones**, **créditos**. Todo bilingüe ES/EN. Cada línea incluye longitud máxima sugerida.

**Relación con `NARRATIVE_run_states.md`:** aquel documento cubrió UI del *run* en juego (HUD, eventos, turnos). Este documento cubre lo que está **alrededor** del run — arranque, pausas, transiciones, errores, meta-hub expandido.

**Regla dura / Hard rule:** ningún botón, mensaje de error o *loading screen* del juego final se escribe sin pasar por aquí. La urgencia tipográfica que introducen los devs apurados es el vector más común de rotura tonal.

---

## 1. Arranque de juego / Game startup

### 1.1. Primer arranque (primera vez en la vida que el jugador abre el juego)

Una sola frase en pantalla negra durante 3–5 segundos antes del menú. No hay logo del motor ni del estudio aquí (eso va después, con el splash estándar).

- ES: *"Este continente ya estaba cuando llegaste. Seguirá cuando te vayas."*
- EN: *"This continent was here before you arrived. It will remain when you leave."*

**Longitud máx. (ES):** 80 caracteres. **EN:** 80.

### 1.2. Arranques sucesivos

Al segundo arranque y posteriores, se rota al azar entre tres frases. Duración: 2 segundos máximo.

| # | ES | EN |
|---|---|---|
| 1 | *"Volviste. Hay té."* | *"You're back. There is tea."* |
| 2 | *"La Marea bajó un dedo en tu ausencia."* | *"The Tide fell a finger while you were away."* |
| 3 | *"El Coro te oyó entrar."* | *"The Chorus heard you come in."* |

**Longitud máx.:** 50 caracteres por idioma. Evitar signos de exclamación.

### 1.3. Splash de estudio y motor

El splash técnico (logo de Godot, logo del estudio) se muestra **sin texto adicional** — ningún *tagline*, ningún *"presents"*, ningún *"a game by"*. Solo los logotipos, 2 segundos cada uno, con transición en fundido. El jugador puede saltar con cualquier tecla.

---

## 2. Menú principal / Main menu

Botones canónicos (ya en `NARRATIVE_run_states.md §1`; aquí se amplía):

| Botón | ES | EN | Longitud máx. |
|---|---|---|---|
| Nueva corrida | *Nueva corrida* | *New run* | 14 |
| Continuar | *Retomar* | *Resume* | 10 |
| Meta-Hub | *Mesa del Velo* | *The Veil's Table* | 20 |
| Coleccionables | *Fresco hallado* | *Fresco found* | 18 |
| Ajustes | *Ajustes* | *Settings* | 10 |
| Créditos | *Los que firmaron* | *Those who signed* | 20 |
| Salir | *Cerrar la puerta* | *Close the door* | 18 |

**Notas:**
- El botón *"Meta-Hub"* narrativamente se presenta como *"Mesa del Velo"* / *"The Veil's Table"* (no como *meta-hub*). Es la misma pantalla.
- El botón *"Salir"* usa el motivo iconográfico #3 (puerta cerrada). Tooltipping opcional: *"Puedes volver a entrar cuando quieras."* / *"You may return when you wish."*.
- Ningún botón tiene exclamación ni llamado a la acción tipo *"¡Juega ya!"*.

---

## 3. Loading screens / Pantallas de carga

### 3.1. Duración esperada

El juego no es pesado. *Loading screens* largas (>4 segundos) son errores de ingeniería. Para estados breves de carga (≤3 s), **no mostrar texto** — solo el motivo visual (polilla #2) en movimiento mínimo.

Para cargas más largas (entrada a capítulo, hot-reload, primer arranque post-actualización), mostrar una frase del Coro con el motivo del fresco desconchado de fondo.

### 3.2. Frases canónicas para cargas largas

Veinte frases, rotadas al azar. Duración por frase: 3 segundos mínimo si se muestran. Todas bilingües, ≤90 caracteres por idioma.

| # | ES | EN |
|---|---|---|
| 1 | *Se está desdoblando el mapa. Tarda un poco.* | *The map is being unfolded. It takes a moment.* |
| 2 | *El Coro estaba a medio verso; le dejamos terminar.* | *The Chorus was mid-verse; we let it finish.* |
| 3 | *Alma Veder está poniendo té. Esperad.* | *Alma Veder is pouring tea. Wait.* |
| 4 | *Contad hasta tres sin pronunciar la hora.* | *Count to three without naming the hour.* |
| 5 | *La polilla salió volando; volverá.* | *The moth flew off; it will return.* |
| 6 | *Vadra está recordando algo que vale la pena esperar.* | *Vadra is remembering something worth the wait.* |
| 7 | *El Fresco se está asentando.* | *The Fresco is settling.* |
| 8 | *Una firma aún está secándose.* | *A signature is still drying.* |
| 9 | *Se afinan los bronces del Velo.* | *The Veil's bronzes are being tuned.* |
| 10 | *Silika busca un cable que no debería funcionar.* | *Silika hunts a cable that shouldn't work.* |
| 11 | *El Pulso se está estabilizando.* | *The Pulse is steadying.* |
| 12 | *Fero Kauz cuenta en voz baja.* | *Fero Kauz counts under his breath.* |
| 13 | *La Marea retrocedió un poco; aprovechamos.* | *The Tide pulled back a little; we take advantage.* |
| 14 | *Kael afila una sílaba.* | *Kael sharpens a syllable.* |
| 15 | *Se abre el cuaderno por la página correcta.* | *The notebook opens at the right page.* |
| 16 | *El monasterio está conteniendo una campanada.* | *The monastery holds back a bell-stroke.* |
| 17 | *Se buscan los papeles del turno anterior.* | *Last turn's papers are being found.* |
| 18 | *La Coalición se estira las manos.* | *The Coalition stretches its hands.* |
| 19 | *Hay silencio; luego habrá mundo.* | *There is silence; then there will be world.* |
| 20 | *Un momento. La Arcología está respirando.* | *One moment. The Arcology is breathing.* |

**Reglas:**
- **No** usar frases técnicas (*"Generando regiones... 42%"*, *"Cargando assets"*).
- **No** mostrar barra de porcentaje con números grandes; si hay progreso visual, usar una **polilla recorriendo un filo horizontal** de izquierda a derecha.
- **No** combinar dos frases en una pantalla.

### 3.3. Carga por capítulo

Entrada a **Capítulo 1:** *"Se despliega el Fresco. Lo que falta, se firma."* / *"The Fresco unfolds. What is missing, is signed."*
Entrada a **Capítulo 2:** *"Bajamos. El reloj aún tarda un grano."* / *"We descend. The hourglass needs one grain more."*
Entrada a **Capítulo 3:** *"Las tres voces se están acomodando en la mesa."* / *"The three voices settle at the table."*

Estas frases están fijas por capítulo; no rotan.

---

## 4. Transiciones entre escenas / Scene transitions

### 4.1. Paso de turno / Turn-to-turn transition

Fondo: fresco desconchado en penumbra. Duración: 1.5 segundos. Texto en la esquina inferior derecha, tipografía `#C6A96B`.

- Formato: *"Turno {n}"* / *"Turn {n}"*.
- Variante sutil cada 4 turnos: *"Turno {n} — {micro-descriptor}"*.

Micro-descriptores rotados (≤14 caracteres):

| ES | EN |
|---|---|
| *, al amanecer* | *, at dawn* |
| *, con lluvia* | *, in rain* |
| *, con viento* | *, with wind* |
| *, templado* | *, mild* |
| *, silencioso* | *, silent* |

### 4.2. Paso de región a región en el mapa / Region-to-region map transition

Sin texto. Un fundido corto y el nombre de la región de destino aparece en la esquina superior izquierda, canónico bilingüe (ver `NARRATIVE_regions.md`). Tipografía `#EDE5D8`.

### 4.3. Entrada a evento / Entering an event

Aparición de un panel desde abajo. Sobre el panel, el título del evento con su bilingüe en dos líneas.

- Línea 1: título ES.
- Línea 2: título EN en tipografía más pequeña.

Excepción: si el jugador tiene el idioma fijado a EN, se invierte. El idioma secundario se muestra siempre, pero más chico. Es parte del tono bilingüe del juego.

---

## 5. Botones y acciones / Buttons and actions

Longitud máxima sugerida por elemento: 18 caracteres ES, 18 EN. Si más largos, revisar.

### 5.1. Acciones generales

| Acción | ES | EN |
|---|---|---|
| Confirmar (firma menor) | *Firmar* | *Sign* |
| Confirmar (firma mayor, ver §6) | *Poner la palma* | *Place the palm* |
| Cancelar | *Dejar sin firmar* | *Leave unsigned* |
| Volver | *Volver* | *Go back* |
| Cerrar | *Cerrar* | *Close* |
| Siguiente | *Seguir* | *Continue* |
| Rechazar oferta | *Declinar* | *Decline* |
| Posponer | *Dejarlo para mañana* | *Leave for tomorrow* |
| Terminar turno | *Cerrar el turno* | *Close the turn* |
| Terminar corrida | *Cerrar la corrida* | *Close the run* |

Evitar: *Aceptar*, *OK*, *Listo*, *Continuar* (preferir *Seguir*).
Evitar EN: *Accept*, *OK*, *Done*, *Proceed*.

### 5.2. Acciones de menú

| Acción | ES | EN |
|---|---|---|
| Guardar | *Dejar escrito* | *Leave written* |
| Cargar | *Retomar lo escrito* | *Take up what was written* |
| Borrar partida | *Cerrar la puerta de esta corrida* | *Close this run's door* |
| Nueva partida | *Abrir una nueva mañana* | *Open a new morning* |
| Volver al menú | *Salir a la mesa* | *Leave to the table* |

**Nota canónica:** los textos en §5.2 están intencionalmente un poco más largos. Son opciones del meta-menú, no del flujo principal, y el tono mítico compensa la baja frecuencia de uso.

### 5.3. Ajustes / Settings

Encabezados y controles:

| Sección | ES | EN |
|---|---|---|
| Audio | *Cómo se oye* | *How it sounds* |
| Visual | *Cómo se ve* | *How it looks* |
| Controles | *Cómo se firma* | *How you sign* |
| Idioma | *Idioma* | *Language* |
| Accesibilidad | *Acomodos* | *Accommodations* |
| Restablecer | *Volver al principio* | *Return to the beginning* |

Dentro de audio:
- *Música del Coro* / *Chorus music*
- *Voz* / *Voice*
- *Efectos* / *Effects*
- *Silencios* / *Silences* (control de reverb y pausas — **no** silenciar los silencios; bajar la duración)

Dentro de idioma: *"Español"* / *"English"* como botones. Cuando aparezca portugués-BR (ver `NARRATIVE_l10n_ptbr.md`), *"Português do Brasil"*.

---

## 6. Firma mayor / Major signature

Cuando el jugador toma una decisión de capítulo (por ejemplo, el eje de *La cautela o el cambio* al final del Cap.1, la decisión climática del Cap.2, o la orquestación del Cap.3), el botón de confirmación **no** es *"Firmar"* — es *"Poner la palma"* / *"Place the palm"*. Se acompaña visualmente del motivo iconográfico #7 (la mano sobre el mapa).

Confirmación final tras *"Poner la palma"*:

- ES: *"¿Quedas así?"*
- EN: *"Do you stand on this?"*

Respuestas:

- ES: *"Sí, firmo."* / *"Aún no."*
- EN: *"Yes, I sign."* / *"Not yet."*

Tras confirmar, aparece una línea del *voice pack* del personaje asociado al evento (ver `NARRATIVE_voice_packs.md §10.1`), y se oye una polilla (sonido breve).

---

## 7. Tutorial / Tutorial

El tutorial de `CivPlagueRush` es **ligero por diseño**. No hay secuencias largas de instrucciones; el juego se aprende en la primera corrida. Los textos tutoriales aparecen como *notas al margen* — breves, en voz del Coro, adosadas a la acción.

### 7.1. Frases tutoriales canónicas (primera corrida, Cap.1)

Aparecen como *barks* o pequeñas burbujas a la derecha del HUD, sin bloquear al jugador. Máximo **siete** en toda la primera corrida. Tiempo en pantalla: 6 segundos por frase, luego se desvanecen.

| # | Disparador | ES | EN |
|---|---|---|---|
| 1 | Entrada al primer turno | *Este es el mapa. Hay doce regiones.* | *This is the map. Twelve regions.* |
| 2 | Aparece el Pulso (barra) | *Ese es el Pulso. No lo dejéis caer del todo.* | *That is the Pulse. Do not let it fall completely.* |
| 3 | Aparece la Marea (barra) | *La Marea sube sin ruido. La iréis oyendo.* | *The Tide rises without noise. You'll come to hear it.* |
| 4 | Primer evento | *Llega un evento. Miradlo. No hay prisa.* | *An event arrives. Look at it. No rush.* |
| 5 | Primera firma | *Las decisiones se firman. Aparecerá la mano.* | *Decisions are signed. The hand will appear.* |
| 6 | Primera región mostrada al detalle | *La región tiene su propio Pulso. Y su propia Sombra.* | *Each region has its own Pulse. And its own Shadow.* |
| 7 | Cierre del turno 3 | *Ya sabes lo básico. Lo otro lo vais aprendiendo solos.* | *You know the basics. The rest you'll learn on your own.* |

### 7.2. Reglas de tutorial

- **No hay tutorial forzado.** El jugador puede saltar cualquier *bark* con una tecla.
- **No hay subtítulos de "Presiona {tecla} para continuar".** Los *barks* se desvanecen solos.
- **No hay pantallas bloqueantes** de tutorial. El juego nunca se pausa para explicar.
- **Toda explicación mecánica** debe caber en ≤12 palabras, o no se muestra.
- **Si el jugador falla en tres eventos seguidos** (*fail* entendido como Pulso regional a 0), aparece una *bark* extra: *"La arcología cae. Se puede seguir. La corrida no se termina por una arcología."* / *"The arcology falls. You may go on. The run doesn't end for one arcology."*.

### 7.3. Tutoriales de capítulos 2 y 3

**Cap.2** introduce el reloj de arena y el Oído Hundido. Una sola *bark* al entrar:

- ES: *"Este capítulo se mide distinto. La arena cuenta por ti."*
- EN: *"This chapter measures differently. The sand counts for you."*

**Cap.3** introduce la Tercera Voz y la orquestación. Una sola *bark*:

- ES: *"Hay tres voces ahora. Si se pisan, se cansan todos."*
- EN: *"There are three voices now. If they tread on each other, all grow tired."*

Ninguno de los dos capítulos añade tutorial sistemático. Se aprenden jugando.

---

## 8. Confirmaciones y alertas / Confirmations and alerts

### 8.1. Confirmaciones menores

Diálogo simple, sin motivos. Botones canónicos.

**Abandonar corrida a medias:**
- ES: *"¿Quieres cerrar esta corrida sin terminarla?"*
- EN: *"Do you want to close this run without finishing?"*
- Botones: *Sí, cerrar* / *Seguir firmando* — *Yes, close* / *Keep signing*.

**Sobrescribir guardado:**
- ES: *"Hay otra corrida en esta ranura. ¿La dejamos escrita encima?"*
- EN: *"There is another run in this slot. Shall we write over it?"*
- Botones: *Sí* / *No* (excepción única al canon de no usar *Sí*/*No* sueltos: aquí es más claro).

**Salir del juego:**
- ES: *"¿Cerramos la puerta?"*
- EN: *"Shall we close the door?"*
- Botones: *Cerrar* / *Aún no* — *Close* / *Not yet*.

### 8.2. Alertas importantes

**Pulso global crítico (≤20%):**
- ES: *"El Pulso está bajo. La Arcología siente."*
- EN: *"The Pulse is low. The Arcology feels it."*

**Marea al máximo:**
- ES: *"La Marea ha subido casi del todo. Decide con calma."*
- EN: *"The Tide has risen nearly full. Decide with calm."*

**Final de corrida inminente (último turno):**
- ES: *"Último turno. Después, el Fresco se firma solo."*
- EN: *"Last turn. Afterward, the Fresco signs itself."*

**Nota:** ninguna alerta usa signos de exclamación, ningún adjetivo dramático, ninguna palabra prohibida.

---

## 9. Mensajes de error / Error messages

Los errores de software también son canónicos. Tienen tres categorías de tono:

### 9.1. Error leve (recoverable, el juego sigue)

- ES: *"Algo se ha soltado sin consecuencias. Seguimos."*
- EN: *"Something came loose, harmlessly. We go on."*

### 9.2. Error medio (algo no se guarda / el *autosave* falla)

- ES: *"El cuaderno no ha podido escribirse. Tu corrida sigue, pero no hemos tomado nota."*
- EN: *"The notebook could not be written. Your run continues, but we have not taken note."*

### 9.3. Error fatal (el juego no puede continuar)

- ES: *"La mesa se ha quedado vacía. Volveremos a servirla pronto."*
- EN: *"The table has been left empty. We will set it again shortly."*
- Acompaña: botón *Volver al menú* / *Return to menu*. Sin *crash report* visible; los logs técnicos viven en archivo.

**Reglas:**
- Nunca mostrar *stack traces* al jugador.
- Nunca usar *"Error 504"* o códigos. Si hace falta un código, va en el log, no en pantalla.
- Los mensajes de error **nunca culpan al jugador**. *"Has hecho algo mal"* es contrario al tono.

---

## 10. Notificaciones y *toasts* / Notifications and toasts

Mensajes breves, no bloqueantes, que aparecen en la esquina inferior derecha durante 3 segundos. Formato canónico:

`{icono-motivo} {mensaje corto}`

Canon de motivos:
- Polilla → confirmación de firma.
- Oro empañado → desbloqueo de coleccionable.
- Puerta cerrada → evento diferido.
- Campana sin badajo → pacto con el Velo avanza.
- Reloj de arena → tiempo en Cap.2+.

### 10.1. Coleccionable desbloqueado

- ES: *"Se ha añadido al Fresco hallado: {nombre}."*
- EN: *"Added to the Fresco found: {name}."*

### 10.2. Doctrina desbloqueada (meta-hub)

- ES: *"Una doctrina nueva espera en la Mesa del Velo."*
- EN: *"A new doctrine waits at the Veil's Table."*

### 10.3. Personaje aparece por primera vez

- ES: *"{Nombre} se ha sentado a la mesa."*
- EN: *"{Name} has joined the table."*

### 10.4. Evento Tier 3 desbloqueado

- ES: *"La Tierra Honda ha abierto un pliegue nuevo."*
- EN: *"The Deep Land has opened a new fold."*

### 10.5. Nuevo capítulo disponible

- ES: *"Puedes bajar al Cap.2 cuando quieras. No hay prisa."*
- EN: *"You may descend to Chapter 2 when you wish. No rush."*

---

## 11. Meta-hub — Mesa del Velo / Meta-hub

Pantalla del meta-hub con texto mínimo, voz del Coro. Ver `NARRATIVE_run_states.md §8` para base.

### 11.1. Encabezado

- ES: *"Aquí se guarda lo aprendido entre corridas."*
- EN: *"Here we keep what is learned between runs."*

### 11.2. Secciones

| Sección | ES | EN |
|---|---|---|
| Doctrinas | *Doctrinas* | *Doctrines* |
| Coleccionables | *Fresco hallado* | *Fresco found* |
| Personajes | *Los conocidos* | *The known* |
| Capítulos | *Capítulos abiertos* | *Chapters open* |
| Registro | *Cuaderno* | *Notebook* |

### 11.3. Frases atmosféricas (rotadas)

Se muestran bajo el título, una cada vez, cambian al entrar a cada sección.

| # | ES | EN |
|---|---|---|
| 1 | *La mesa está ordenada, casi.* | *The table is tidy, almost.* |
| 2 | *Alma Veder pasó por aquí esta mañana.* | *Alma Veder was here this morning.* |
| 3 | *Hay más entradas en el cuaderno que ayer.* | *The notebook has more entries than yesterday.* |
| 4 | *Uno de los coleccionables parpadea un poco.* | *One collectible flickers faintly.* |

---

## 12. Créditos / Credits

El nombre canónico de la pantalla es *"Los que firmaron"* / *"Those who signed"*.

### 12.1. Estructura

1. **Apertura del Coro** (una frase, centrada, 3 s).
2. **Nombres** agrupados por rol (un grupo por pantalla, scroll lento).
3. **Agradecimientos** (una frase corta por cada uno).
4. **Cierre del Coro** (última frase).
5. **Motivo final** — una polilla sobre fondo negro, ~5 s, y luego retorno al menú.

### 12.2. Apertura del Coro

- ES: *"La mesa larga estuvo llena esta vez. Hemos anotado los nombres."*
- EN: *"The long table was full this time. We have noted the names."*

### 12.3. Cabeceras de rol (bilingües)

| ES | EN |
|---|---|
| *Diseño* | *Design* |
| *Programación* | *Code* |
| *Arte* | *Art* |
| *Sonido* | *Sound* |
| *Voz* | *Voice* |
| *Narrativa* | *Narrative* |
| *Producción* | *Production* |
| *Traducción* | *Translation* |
| *Agradecimientos* | *Thanks* |

Preferir **sin cursiva** en las cabeceras finales. Tipografía `#C6A96B`.

### 12.4. Formato de nombres

- Nombre real, a la izquierda.
- (Opcional) rol específico o proyecto donde contribuyó, a la derecha, en tipografía más pequeña.
- **No** usar títulos ("Lead", "Senior", "Principal") — el juego no honra jerarquías en pantalla.

### 12.5. Cierre del Coro

- ES: *"Y a ti, que has llegado hasta aquí. La puerta queda entornada."*
- EN: *"And to you, who reached this point. The door is left ajar."*

Esta frase es la última que el jugador ve antes del retorno al menú. No cambia nunca.

---

## 13. Pausa / Pause

### 13.1. Al entrar en pausa

- ES: *"Hemos parado. Respira."*
- EN: *"We've paused. Breathe."*

### 13.2. Al reanudar

- ES: *"Volvemos donde estábamos."*
- EN: *"We return to where we were."*

### 13.3. Dentro de la pausa

Opciones:
- *Seguir* / *Resume*
- *Ajustes* / *Settings*
- *Salir al menú* / *Leave to the menu*

Ningún contador visible de "tiempo en pausa".

---

## 14. Accesibilidad / Accessibility

Texto de la sección *Acomodos* / *Accommodations* del menú de ajustes.

### 14.1. Encabezado

- ES: *"Los acomodos están para que el Fresco pueda verse y oírse por todos."*
- EN: *"Accommodations exist so the Fresco can be seen and heard by all."*

### 14.2. Opciones canónicas

| Opción | ES | EN |
|---|---|---|
| Tamaño de texto | *Texto más grande* | *Larger text* |
| Alto contraste | *Colores más nítidos* | *Sharper colors* |
| Subtítulos | *Subtítulos siempre* | *Always-on captions* |
| Ritmo lento | *Que el juego respire más* | *Let the game breathe more* |
| Sin parpadeo | *Sin parpadeos bruscos* | *No harsh flicker* |
| Sonidos ambiente | *Bajar los silencios largos* | *Shorten long silences* |
| Auto-confirmar | *Firma automática en eventos menores* | *Auto-sign on minor events* |

Nota: el *"ritmo lento"* alarga todas las transiciones narrativas en 40%. No hay *"ritmo rápido"* canónico — el juego no se acelera.

---

## 15. Primera hora de juego — guion / First hour — playthrough script

Guion consolidado del onboarding para QA y testers. Duración esperada: 45–60 min.

1. **0:00** — Splash técnico, splash narrativo §1.1.
2. **0:10** — Menú principal. Elige *Nueva corrida*.
3. **0:15** — Carga entrada a Cap.1 (frase §3.3 de Cap.1).
4. **0:20** — Tutorial bark §7.1 #1.
5. **0:30** — Primer turno. Barks 2 y 3 cuando aparezcan barras.
6. **1:00** — Primer evento (canónicamente: `founding_famine`). Bark #4, luego #5 al firmar.
7. **2:00** — Segundo turno, bark #6 al detallar región.
8. **3:00** — Tercer turno, bark #7 al cerrar.
9. **8:00** — Run llega a turno 10 o similar. Evento mayor.
10. **12:00** — Fin de corrida. Epílogo (ver `NARRATIVE_chapter01.md`).
11. **12:30** — Meta-hub abre automáticamente. Primera entrada en *Cuaderno*.
12. **13:00** — Jugador puede comenzar segunda corrida o explorar meta-hub.

**Regla:** si algún *bark* no se ha disparado antes del turno 5, se dispara al final del turno 5 forzosamente (para no dejar al jugador sin orientación).

---

## 16. Prohibiciones generales de UI / General UI prohibitions

1. **Ningún texto de UI con exclamación.**
2. **Ningún texto con mayúsculas sostenidas** (ALL CAPS) fuera de logotipos.
3. **Ningún tooltip de más de 80 caracteres ES** / **80 EN**.
4. **Ningún icono parpadeante** salvo el coleccionable recién desbloqueado (una sola vez, 1.5 s).
5. **Ningún sonido de botón "click" plástico.** El botón usa respiraciones del Speaker (ver `NARRATIVE_voice_packs.md §10.2`).
6. **Ningún emoji**. Los iconos son siempre del set canónico (`NARRATIVE_iconography.md`).
7. **Ningún texto técnico visible al jugador** ("DEBUG", "DEV BUILD", "TEST"). Si el build es de desarrollo, el splash narrativo §1.1 se reemplaza por *"Versión en pruebas. Se agradece el cuidado."* / *"Testing build. Your care is appreciated."*.
8. **Ninguna urgencia numérica en pantalla.** Nada de *"¡3 segundos!"* o *"Last chance"*. Los tiempos corren en silencio.
9. **Ningún texto que nombre la plaga directamente** en UI. Excepciones posibles: accesibilidad, donde *"enfermedad"* es tolerable en el texto descriptivo de *Acomodos* (porque ahí importa claridad médica).

---

## 17. Cierre / Closing

La interfaz no es un conjunto de pantallas. Es la **piel del Coro**. Todo lo que el jugador toca debe sonar como si el Coro estuviera un poco más cerca. Si un elemento de UI rompe ese tono, el elemento está mal, no el Coro.

> *"Un botón debe ser firmable sin irritación. Un mensaje de error, leíble sin culpa."*
> *"A button should be signable without irritation. An error message, readable without blame."*

---

*Fin del micro-texto de UI. Cualquier nuevo elemento de interfaz pasa por aquí primero.*
*End of UI microtext. Any new interface element comes through here first.*
