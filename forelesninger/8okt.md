---
title: Forelesning 8. Oktober
---

# Forelesning 8. oktober

## Pensum
- Kap. 22. Elementary graph algorithms: Innledning og 22.1-22.4
- Appendiks E i pensumheftet

## Læringsmål
- Forstå hvordan grafer kan implementeres
- Forstå DFS, også for å finne _kortest vei uten vekter_
- Forstå DFS og _parantesteoremet_
- Forstå hvordan DFS _klassifiserer kanter_
- Forstå __TOPOLOGICAL-SORT__
- Forstå hvordan DFS kan _implementeres med en stakk_
- Forstå _travaseringstrær_ (som _bredde-først_ og _dybde-først_-trær).
- Forstå _travasering med vilkårlig prioritetskø_


# 1:4 Grafrepresentasjoner
- Vi ser på to representasjoner: Nabomatriser og nabolister
- Man sier ofte at det er raskere med nabomatriser men at de tar mer plass
- Det er en overforenkling!
- Det kommer an på problemet!

## Nabomatriser
En bitmatrise, viser om to "koordinater" har en kant mellom hverandre.

Effektivt om man vil slå opp raskt for å se om det eksisterer en kant. Ikke så bra for travasering (hvis det er få kanter i forhold til punkter).

## Nabolister
Liste (eller tabell) med ut-naboer for hver node.

Kompakt; egnet til travasering; ikke så egnet til raske oppslag

# 2:4 Traversering BFS
Traversering generelt:
Vi besøker noder, oppdager noder langs kanter og vedlikeholder en huskeliste.

Besøker nodene og noterer naboene til nodene, helt til lista er tom; da har vi besøkt alle vi kan.

Passer på om vi får overlappende naboer mellom forskjellige noder.

Så lenge vi bruker en FIFO-kø (dvs., BFS) så finner vi __korteste vei__; ellers risikerer vi å finne noder via omveier!

```julia
function bfs(G, s)
  for vertex in G.V - {s}
    vertex.color = WHITE
    vertex.d = Inf
    vertex.pi = nothing
  s.color = GREY
  s.d = 0
  s.pi = nothing
  Q = empty
  enqueue(Q, s)
  while Q != empty
    u = dequeue(Q) #FIFO
    for vertex in G.adj[u]
      if vertex.color == WHITE
        #Add vertex to queue
        vertex.color = GREY
        vertex.d = u.d + 1
        enqueue(Q, vertex)
    u.color = BLACK
```

# 3:4 Traversering DFS
<!-- Visualize DFS as tree(p5.js)? -->
DFS, _flood-fill_: Fyll rekursivt nord, øst, sør, vest
- Som BFS, men med LIFO kø
- Enklere å implementere rekursivt

```julia
function dfs(G)
  for vertex in G.v
    u.color = WHITE
    u.pi = nothing
  time = 0 #global variabel, en counter
  for vertex in G.v
    if vertex.color == WHITE
      dfs_visit(G, vertex)

function dfs_visit(G, vertex)
  time = time + 1
  vertex.d = time #Discover time
  vertex.color = GREY
  for v in G.adj[vertex]
    if v.color == WHITE
      v.pi = vertex
      dfs_visit(G, v)
  vertex.color = BLACK
  time = time + 1
  vertex.f = time #Finish time
```

## Kantklassifisering
- __Tre-kanter__
  - Kanter i dybde-først-skogen
- __Bakoverkanter__
  - Kanter til en forgjenger i DF-skogen (Har sykler)
- __Foroverkanter__
  - Kanter utenfor DF-skogen som går framover


- __Møter hvit node__
  - Tre-kant
- __Møter grå node__
  - Bakoverkant
- __Møter svart node__
  - Forover- eller krysskant

## Parantesteoremet
Noder oppdages før og avsluttes etter sine etterkommere

## Kjøretid
- DFS - Worst Case: Theta(V + E), Best case: Theta(V + E)
- BFS - Worst Case: Theta(V + E), Best case: Theta(1)

# 4:4 Topologisk sortering
- Gi nodene en rekkefølge
- Foreldre før barn
- Evt.: Alle kommer etter avhengigheter
- Det er egentlig det vi gjør med delproblemgrafen i DP
- Krever at grafen er en DAG! (Directed Asyclic Graph)


- Stigende discover-tid: Ikke trygt
- Synkende finish-tid: Trygt

{% include mathjax.html %}
