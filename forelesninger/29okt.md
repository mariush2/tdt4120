---
title: Forelesning 29. oktober
---

# Forelesning 29. september - Korteste vei fra alle til alle
Korteste vei fra alle til alle

## Læringsmål
- Forstå _forgjengerstrukturen_ for _alle-til-alle_-varianten av kortestevei-problemet. Operasjoner: __PRINT-ALL-PAIRS-SHORTEST-PATH__
- Forstå __FLOYD-WARSHALL__
- Forstå __TRANSITIVE-CLOSURE__
- Forstå __JOHNSON__

## Pensum
- Kap. 25. All-pairs shortest paths: Innledning, 25.2 og 25.3

1. [Jonsons algoritme](#13-jonhsons-algoritme)
2. [Transitiv lukning](#23-transitiv-lukning)
3. [Floyd-Warshall](#33-floyd-warshall)

---

## 1:3 Jonhsons algoritme

__Input__: En vektet, rettet graf $G = <V,E>$ uten negative sykler, der $V = \\{1, \ldots, n\\}$, og vektene er gitt av matrisen $W = (W_{ij})$

__Output__: En $n × n$-matrise $D = (d_{ij})$ med avstander, dvs., $d_{ij} = \delta(i,j)$


For spinkle grafer: Dijkstra fra hver node!

Men hva om vi har negative kanter?

Fast økning: STier med mange kanter taper på det, dvs at den korteste stien _kan_ bli 'ødelagt'

Vi kan tillate oss en teleskopsum...


Vekten $w(u, v)$ økes med __differansen__ $h(u) - h(v)$

For hver node i midten av en sti, vil kansellere hverandre


Vi må ha $w(u, v) + h(u) - h(v) \geqslant 0$, dvs $w(u, v) + h(u) \geqslant h(v)$

Fra én-til-alle: $\delta(s, v) \leqslant \delta(s, u) + w(u, v)$. Kan la $h(v) = \delta(s, v)$!


$$ w(u, v) + h(u) \geqslant h(v)\\
w(u, v) + \delta(s, u) \geqslant \delta(s,v )$$

Men hva er $s$? Vi må sikre at vi når alle... (uendelighet)

Må sørge for at kantene våres er endelige. Vi kan legge til en ny node (midlertidlig)!

(Merk: VI verken innfører eller fjerner negative sykler!)


```julia
function johnson(G, w)
  construct G' with start node s
  bellman-ford(G', w, s)
  for each vertex v ∈ G.V
    h(v) = v.d
  for each edge (u, v) ∈ G.E
    w_hat(u,v) = w(u,v) + h(u) - h(v)
  let D = (d_uv) be a new n × n matrix
  for each vertex v ∈ G.V
   dijkstra(G, w_hat, u)
   for each vertex v ∈ G.V
     d_uv = v.d + h(v) - h(u)
  return D
```

## 2:3 Transitiv lukning

__Input__: En rettet graf $G =(V, E)$

__Output__: En rettet graf $G⋆ = (V, E⋆)$ der $(i, j) ∈ E⋆$ hvis og bare hvis det finnes en sti fra $i$ til $j$ i $G$.


Traversér fra hver node?
  -  Kjøretid $V × \Theta(E + V) = \Theta(VE + V^2)$
  - Bra når vi har få kanter, f.eks. $E = o(V^2)$
  - Mye overhead; høye konstantledd
  Målsetting:
    - Vi fokuserer på tilfellet $E = \Theta(V^2)$
    - Vi vil ha et lavere konstantledd
  Observasjon:
    - Korteste stier har felles segmenter
    - Overlappende delproblemer...

$$ t_{ij}^{(k)} $$

Det finnes en vei fra $i$ til $j$ via node fra $\\{1 \ldots k\\}$


Delproblemet blir da å finne en vei fra $i$ til $j$ via nodene vi har fått tildelt.

De mulige stiene $p$, $p_1$ og $p_2$ går kun via noder fra $\\{1 \ldots k - 1\\}$

$$t_{ij}^{(k)} = t_{ij}^{(k - 1)} \vee (t_{ki}^{(k - 1)} \wedge t_{kj}^{(k - 1)})$$

$$
t_{ij}{(0)}=
\begin{cases}
  0\:if\:i \neq j\:and\:(i,j) ∉ E,\\
  1\:if\:i = j\:or\:(i,j) ∈ E.\\
\end{cases}
$$

```julia
function transitive_closure(G)
  n = |G.V|
  let T^0 = (t_ij^0) be a new n \times n matrix
  for i = 1:n
    for j = 1:n
      if i == j or (i, j) ∈ G.E
        t_ij^0 = 1
      else
        t_ij^0 = 0
  for k = 1:n
    let T^k = t_ij^k be a new n × n matrix
    for i = 1:n
      for j = 1:n
        t_{ij}^{(k)} = t_{ij}^{(k - 1)} ⋁ (t_{ki}^{(k - 1)} ⋀ t_{kj}^{(k - 1)})
  return T^n

function transitive_closure'(G)
  n = |G.V|
  initialize T
  for k = 1:n
    for i = 1:n
      for j = 1:n
        t_{ij} = t_{ij} ⋁ (t_{ki} ⋀ t_{kj})
  return T
```

### Kjøretid:

Totalt: $\Theta(n^3)$


## 3:3 Floyd-Warshall

Fra hver node til alle andre?
- Dijkstra med tabell: $O(V^3 + VE)$
- ... med binærhaug: $O(VElogV)$
- ... med fib. haug: $O(V^2logV + VE)$
- Bellman-Ford: $\Theta(V^2E)$
Målsetting:
- Vi vil tillate negative kanter
- Vi vil ha lavere asymptotisk kjøretid...
- ...__og__ vil ha lavere konstantledd


$$d_{ij}^{(k)}$$

Kortest vei fra $i$ til $j$ via noder fra $\\{1 \ldots ... k\\}$

$$\pi_{ij}^{(k)}$$

Forgjengeren til $j$ om vi starter i $i$ og går via noder fra $\\{1 \ldots ... k\\}$

Det samme som i Transitiv lukning (k-noder).

$$d_{ij}^{(k)} = min(d_{ij}^{(k - 1)}, d_{ik}^{(k - 1)}, d_{kj}^{(k - 1)})$$

Stien kan enten være $d_{ij}^{(k - 1)}$ eller $d_{ik}^{(k - 1)} + d_{kj}^{(k - 1)}$

$$
d_{ij}^{(k)}=
\begin{cases}
  w_{ij} \: if\:k = 0,\\
  min(d_{ij}^{(k - 1)}, d_{ik}^{(k - 1)}, d_{kj}^{(k - 1)}) \: if\:k ⩾ 1
\end{cases}
$$

$$
\pi_{ij}^{(0)}=
\begin{cases}
  NIL \: if\:i = j\:or\:w_{ij} = ∞,\\
  i \: if\:i \neq j\:and\:w_{ij} < ∞
\end{cases}
$$

$$
\pi_{ij}^{(k)}=
\begin{cases}
  \pi_{ij}{(k - 1)}\: if \: d_{ij}^{(k - 1)} ⩽ d_{ik}^{(k - 1)} + d_{kj}^{(k - 1)},\\
  \pi_{kj}{(k - 1)}\: if \: d_{ij}^{(k - 1)} > d_{ik}^{(k - 1)} + d_{kj}^{(k - 1)}.
\end{cases}
$$

$$
d_{ij}=
\begin{cases}
  w_{ij} \: if k = 0,\\
  min(d_{ij}, d_{ik}, d_{kj}) \: if k ⩾ 1\\
\end{cases}
$$

Bruker bare de beste

$$
\pi_{ij}^{(k)}=
\begin{cases}
  \pi_{ij}^{(k - 1)}\: if\:d_{ij}^{(k - 1)} ⩽ d_{ik}^{(k - 1)} + d_{kj}^{(k - 1)},\\
  \pi_{kj}^{(k - 1)}\: if\:d_{ij}^{(k - 1)} > d_{ik}^{(k - 1)} + d_{kj}^{(k - 1)}.
\end{cases}
$$


```julia
function floyd_warshall(W)
  n = W.rows
  D(0) = W
  for k = 1:n
    let D(k) = d_{ij}^{(k)} be a new n × n matrix
    for i = 1:n
      for j = 1:n
        d_{ij}^{(k)} = min(d_{ij}^{(k - 1)}, d_{ik}^{(k - 1)}, d_{kj}^{(k - 1)})
  return D(n)


function floyd_warshall'(W)
  n = W.rows
  initialize D and Π
  for k = 1:n
    for i = 1:n
      for j = 1:n
        if d_ij > d_ik + d_kj
          d_ij = d_ik + d_kj
          π.ij = π.kj
  return D, Π
```

```julia
function print_all_shortest_path(Π, i, j)
  if i == j
    print i
  elseif π_ij == NIL
    print "no path from" i "to" j "exists"
  else
    print_all_shortest_path(Π, i, π_ij)
    print j
```

### Kjøretid

Totalt $\Theta(n^3)$

{% include mathjax.html %}
{% include gotop.html %}
