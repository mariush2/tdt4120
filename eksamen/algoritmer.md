---
title: Algoritmer til eksamen
---
# En samling av viktige algoritmer til eksamen

- [Tellesortering](#tellesortering)

- [Radikssortering](#radikssortering)

- [Bøttesortering](#bøttesortering)

- [Huffman](#huffman)

- [Breadth-first-search](#breadth-first-search)

- [Depth-first-search](#depth-first-search)

- [Generisk MST](#generisk)

- [Kruskal algoritme](#kruskal)

- [Prims algoritme](#prims)

- [DAG-Shortest-Path](#dag-shortest-path)

- [Bellman-ford](#bellman-ford)

- [Dijkstras algoritme](#dijkstras)

## Tellesortering

```julia
function counting-sort(A, B, k)
    let C[0...k] be a new array
    for i = 0 to k
       C[i] = 0
    for j = 1 to A.length
       C[A[j]] += 1
    for i = 1 to k
       C[i] = C[i] + C[i - 1]
    for j = A.length downto 1
       B[C[A[j]]] = A[j]
       C[A[j]] -= 1
```

$$T(n) = \Theta(n + k)$$

## Radikssortering

```julia
function radix-sort(A, d)
    for i = 1 to d
       sort* A by digit d
```

$$T(n) = \Theta(d * (n + k))\\$$

## Bøttesortering

```julia
function bucket-sort(A)
    n = A.length
    create B[0...n-1]
    for i = 0 to n
       make B[i] an empty list
    for i = 1 to n
       add A[i] to B[floor(nA[i])]
    for i = 0 to n - 1
       sort list B[i] #Bruker insertion sort
    concatenate B[0]...B[n - 1]
```

$$T_w(n) = \Theta(n^2)\\$$
$$T_a(n) = \Theta(n)\\$$
$$T_b(n) = \Theta(n)\\$$

## Huffman

__Input__: Alfabet $C = \\{c,...\\}$ med frekvenser $c.freq$

__Output__: Binær koding som minimerer forventet kodelengde $\sum_{c\;∈\;C}c.freq × length(code(c))$.

- Vil lage binære koder for tegn
- Tegnene har frekvens
- Kodene kan ha varierende lengde
- Vil minimerere forventet kodelengde

__Prøver en grådig algoritme__
- Vi kan slå sammen to partielle løsninger ved å la én bit velge mellom dem
- Grådighet: Slå alltid sammen de sjeldneste, siden den ekstra bit-en da koster minst


```julia
 function huffman(C)
  #C Frekvenser
  # Q pri-kø
  n = length(C) # |C|
  Q = C
  for i = 1:n - 1
   # allocate a new node z
   x = extract_min(Q)
   y = extract_min(Q)
   z.left, z.right = x, y
   z.freq = x.freq + y.freq
   insert(Q, z)
 end
 return extract_min(Q)
```

## Breadth-first-search

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
    vertex.π = nothing
  s.color = GREY
  s.d = 0
  s.π = nothing
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

$$
Worst\:case: \Theta(V + E)\\
Best\:case: \Theta(V)\\
$$

## Depth-first-search

DFS, _flood-fill_: Fyll rekursivt nord, øst, sør, vest
- Som BFS, men med LIFO kø
- Enklere å implementere rekursivt

```julia
time;
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

$$
Worst\:case: \Theta(V + E)\\
Best\:case: \Theta(V + E)\\
$$

## Generisk

__Input:__ En urettet graf $G = (V, E)$ og en vekt-funksjon $w: E \rightarrow R$

__Output:__ En asyklisk delmengde $T ⊆ E$ som kobler sammen nodene i $V$ og minimerer vektsummen $w(T) = \sum_{(u,v) ∈ T} w(u,v)$.

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

## Kruskal

__To skoger på en gang__

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

| Operasjon     | Antall    | Kjøretid      |
| ------------- |:---------:| -------------:|
| MAKE-SET      | $V$       | $O(1)$        |
| Sortering     | $1$       | $O(E log(E))$ |
| FIND-SET      | $O(E)$    | $O(log(V))$   |
| UNION         | $O(E)$    | $O(log(V))$   |

$$Totalt:\:O(E log(V))$$

## Prims

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

| Operasjon      | Antall  | Kjøretid    |
| -------------- |:-------:| -----------:|
| BUILD-MIN-HEAP | $1$     | $O(V)$      |
| EXTRACT-MIN    | $V$     | $O(log(V))$ |
| DECREASE-KEY   | $E$     | $O(log(V))$ |

$$Totalt: O(E log(V))$$

Kan forbedres med en Fib.haug (Fib heap). Blir da $O(E + V log(V))$.

## DAG-Shortest-Path

```julia
topologically sort G
initialize_single_source(G, s)
for each vertex v in V
  for each edge (u, v) in E
    relax(u, v, w)
  end
end

function initialize_single_source(G, s)
  for each vertex v in V
    v.d = Inf
    v.\pi = nothing
  end
  s.d = 0
end

function relax(u, v, w)
  if v.d > u.d + w(u, v)
    v.d = u.d + w(u, v)
    v.\pi = u
  end
end
```

| Operasjon            | Antall    | Kjøretid        |
| -------------------- |:---------:| ---------------:|
| Topologisk-sortering | 1         | $\Theta(V + E)$ |
| Initialisering       | 1         | $\Theta(V)$     |
| RELAX                | E         | $\Theta(1)$     |

## Bellman-ford

```julia
function bellman_ford(G, w, s)
  initialize_single_source(G, s)
  for i = 1 to |G.V| - 1
    for each edge (u, v) in G.E
      relax(u, v w)
    end
  end
  for each edge (u, v) in G.E
    if v.d > u.d + w(u, v)
      return false
    end
  end
  return true
```

| Operasjon      | Antall | Kjøretid |
| -------------- |:------:| --------:|
| Initialisering | 1      | $\Theta(V)$ |
| RELAX          | $V - 1$  | $\Theta(E)$ |
| RELAX          | $O(V)$   | $\Theta(E)$ |

$Totalt: O(VE)$

## Dijkstras

```julia
function dijkstra(G, w, s)
  initialize_single_source(G, s)
  S = []
  Q. = G.V #Queue
  while Q != empty
    u = extract_min(Q) # Korteste stien til start
    push!(S, u)
    for each vertex v in G.adj[u]
      relax(u, v, w)
    end
  end
end
```

| Operasjon      | Antall | Kjøretid    |
| -------------- |:------:| -----------:|
| Initialisering | 1      | $\Theta(V)$ |
| BUILD-HEAP     | 1      | $\Theta(V)$ |
| EXTRACT-MIN    | $V$    | $O(lg V)$   |
| DECREASE-KEY   | $E$    | $O(lg V)$   |

__Total: O(V lg V + E lg V)__

Med binærheap: bedre enn lineært søk for $E = o(V^2/lg V)$

Med Fibonacci-heap: DECREASE-KEY er $O(1)$: vi får $O(V lg V + E)$

---

{% include mathjax.html %}
{% include gotop.html %}
