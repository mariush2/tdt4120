---
title: Forelesning 15. Oktober
---

# Forelesning 10. oktober - Minimale spenntrær
Noder med vekter (weighted-nodes).


1.  Disjunkte mengder
2.  Generisk MST
3.  Kruskals algoritme
4.  Prims algoritme

---

# 1:4 Disjunkte mengder
Mengder representeres som trær vha. foreldrepekere _v.p_
Roten er en representant for mengden, lat som det er et slags mengdeobjekt. Self-loop i rot (fjerner spesialtilfeller i FIND-SET).

For _union by rank_-heuristikk: Rang er øvre grense for nodehøyde

```julia
function make_set(x)
  x.p = x
  x.rank = 0
end

function union(x, y) #Merk at union allerede er definert i julia
  link(find_set(x), find_set(y))
end

function link(x, y)
  if x.rank > y.rank
    y.p = x
  else
    x.p = y
    if x.rank == y.rank
      y.rank = y.rank + 1
    end
  end
end

function find_set(x)
  if x!= x.p
    x.p = find_set(x.p)
  end
end
```

m operasjoner: O(m • alpha(n)). (med komprimering og union by rank)

alpha(n) :=

0.  hvis 0 <= n <= 2,
1.  hvis n = 3
2.  hvis 4 <= n <= 7
3.  hvis 8 <= n <= 2047
4.  hvis 2048 <= n <= 16<sup>512</sup>
---

# 2:4 Generisk MST
Hva er et spenn tre?

-   Kobler sammen alle nodene slik at det er nøyaktig en sti mellom et par av ndoer


__Vi innfører nå vekter på kantene. Disse omtales også som lengder eller kostnader.__


__Input:__ En urettet graf G = (V,E) og en vekt-funksjon _w_: E -> R

__Output:__ En asyklisk delmengde T C= E som kobler sammen nodene i V og minimerer vektsummen.

- Vi utvider en kantmengde (partiellløsning) gradvis
- Invariant: Kantmengden utgjør en del av minimalt spenntre
- En "trygg kant" er en kant som bevarer invarianten

```julia
function generic_mst(G, w)
  A = []
  while A does not form a spanning tree,
   find an edge (u, v) that is safe for A
    push!(A, (u, v))
  end
  return A
end
```

Lette kanter: den som har minimal kant kost fra en node til en annen

- "Exchange argument", som før
- Ta en optimal (eller vilkårlig) løsning som ikke har valgt grådig
- Vis at vi kan endre til den grådige løsningen uten å få en dårligere løsning

__Hva om det går i sikk-sakk, og har flere? Holder argumentet fortsatt?__

- En lett kant over et snitt som respekterer løsning vår er trygg
- Vi kan løse problemet grådig!
- Men ... hvilke snitt skal vi velge?

__Kruskal__: En kant med minimal vekt balnt de gjenværende er trygg så lenge den ikke danner sykler.

__Prim__: Bygger et tre gradvis; en lett kant over snittet rundt treet er alltid trygg.

__Boûvka:__ En slags blanding. Kobler hvert tre til det nærmeste av det andre.

---

# 3:4 Kruskals algoritme
Construction A. Perform the following step as many times as possible: Among the edges of G not yet chosen, choose the shortest edge which does not form any loops with those edges already chosen. Clearly the set of edges eventually chosen must form a spanning tree of G, and infact it forms the shortest spanning tree.

## To skoger på én gang

Til å begynne med er hver node en komponent i en partiell løsning

Komponenter: Disjunkte nodemengder. Starter med v.p = v

Hvis vi vil legge til en kant mellom to komponenter, må vi passe på at kanten ikke danner en syklus og deretter oppdatere v.p for den ene komponenten.


Tilsammen _kan v.p_-pekerene våre utgjøre MST-et vårt...

Ofte mer effektivt om de ikke gjør det!

- èn skog er framenter av et MST
- Den andre skogen: Disjont-set forest
  - Samme noder og komponenter
  - Rettede kanter/pekere som spiller en helt annen rolle
- Vi behandler denne siste skogen som en "black box" i algoritmen.

```julia
function mst_kruskal(G, w)
  A = []
  for each vertex v in G.V
    make_set(v)
  end
  sort G.E by w # Sorter etter vekting
  for each edge (u,v) in G.E
    if find_set(u) != find_set(v)
      # en trygg kant
      push!(A, (u, v))
      union(u, v) #Egen definert union funksjon, se lenger oppe
    end
  end
  return A
```

| Operasjon     | Antall    | Kjøretid    |
| ------------- |:---------:| -----------:|
| MAKE-SET      | V         | O(1)        |
| Sortering     | 1         | O(E log(E)) |
| FIND-SET      | O(E)      | O(log(V))   |
| UNION         | O(E)      | O(log(V))   |

__Totalt O(E log(V))__

---

# 4:4 Prims algoritme
The two fundamental construction principles(P1 and P2) for shortest connection networks can be stated as follows:
Principle 1: Any isolated terminal can be connected to a nearest neighbor
Principle 2: Any isolated fragment can be connected to nearest neighbor by a shortest available link

- Kan implementeres vha. traversering
- Der BFS bruker FIFO og DFS bruker LIFO, så bruker Prim en min-prioritets-kø
- Prioriteten er vekten på den letteste kanten mellom noden til treet.
- For enkelhets skyld: Legg alle noder inn fra starten, med uendelig dårlig prioritet.

```julia
function mst_prim(G, w, r)
  for each u in G.V
    u.key = Inf
    u.pi = nothing
  end
  r.key = 0
  Q = G.V
  while Q != empty
    u = extract_min(Q)
    for each v in G.adj(u)
      if v in Q and w(u,v) < v.key
        v.pi = u
        v.key = w(u, v)
      end
    end
  end
```

- I det følgende: Farging som for BFS
- Kanter mellom svarte noder er endelige
- Beste kanter for grå noder også uthevet
- Boka uthever bare kentene i spenntreet

| Operasjon      | Antall    | Kjøretid    |
| -------------- |:---------:| -----------:|
| BUILD-MIN-HEAP | 1         | O(V)        |
| EXTRACT-MIN    | V         | O(log(V))   |
| DECREASE-KEY   | E         | O(log(V))   |

__Totalt: O(E log(V))__

Dette gjelder om vi bruker en binærhaug

Kan forbedres med en Fib.haug (Fib heap). Blir da O(E + V log(V)).

{% include mathjax.html %}
