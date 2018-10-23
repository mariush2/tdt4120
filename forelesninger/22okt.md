---
title: Forelesning 22. Oktober
---

# Forelesning 22. oktober Kortest vei fra én til alle

## Pensum
-  Kap. 24. Single-source shortest paths: Innledning og 24.1-24.3

## Læringsmål
- Forstå varianter av _kortest-vei_-problemet
- Forstå strukturen til problemet
- Forstå negative sykler gir mening for kortest _enkle vei_
- Forstå at _kortest_ og _lengsteenkle vei_ kan løses vha. hverandre
- Forstå _kortest-vei-trær_
- Forstå _kant-slakking_ og __RELAX__
- Forstå ulike egenskaperved korteste veier og slakking
- Forstå __BELLMAN-FORD__
- Forstå __DAG-SHORTEST-PATH__
- Forstå kobling mellom __DAG-SHORTEST-PATH__ og __DP__
- Forstå __DJIKSTRA__

1. Dekomponering
2. DAG-Shortest-Path
3. Kantslakking
4. Bellman-Ford
5. Djikstras algoritme

---

# 1:5 Dekomponering
Vi begynner med å anta en asyklisk graf. Vi ser at vi kan la grafen være sin egen delinstansgraf.

Vil finne avstand lille-delta(s, t) fra startnoden s.
Vi antar så induktivt at vi har funnet lille-delta(s, -) for inn-naboer.
Inn-nabo x gir mulig stilengde lille-delta(s, x) + w(x, t); velg minium!


Vi får altså at lille-delta(s, t) = min{lille-delta(s, u) + w(u, t), lille-delta(s, v) + w(v, t)}


Video startet;

Dekomponeringen fungerer bare for asykliske grafer!


# 2:5 DAG-Shortest-Path
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
    v.pi = nothing
  end
  s.d = 0
end

function relax(u, v, w)
  if v.d > u.d + w(u, v)
    v.d = u.d + w(u, v)
    v.pi = u
  end
end
```

Vil heller bruker ut kanter enn inn kanter.

Hvis vi skiller ut init, kanv i kjøre minium

Så lenge u.d er rett, kan vi trygt utføre linje 8 og 9 (de siste to linjene)

Med andre ord, nå kan vi bruke ut-kanter også!

Dette kalles reaching, istedenfor pulling. Som i vanlig DP, husk valg som tas. Dette gjøres vha. en forgjenger (pi)!

Flytter init og min til en egen funksjon, refaktor!

```julia
function dag_shortest_path(G, w, s)
  topologically sort the vertices of G
  initialize-single-source(G, s)
  for each vertex u, in topsort order
    for each vertex v in G.adj[u]
      relax(u, v, w)
    end
  end
end
```
NB! Sykler fungerer ikke med denne modellen

- God mental modell for DP; erkeeksempel
- Delproblemer er avstander fra s til innnaboer; velg den som gir deg best resultat
- Bottom-up: Kantslakking av inn-kanter i topologisk sortert rekkefølge (såkalt pulling)
- Gir samme svar: Kantslakking av ut-kanter i topologisk sortert rekkefølge (såkalt reaching)


| Operasjon            | Antall    | Kjøretid     |
| -------------------- |:---------:| ------------:|
| Topologisk-sortering | 1         | $\theta(V + E)$ |
| Initialisering       | 1         | $\theta(V)$     |
| RELAX                | E         | $\theta(1)$     |

Kantslakking er altså en oppspalting av miniums-operasjoner fra dekomponeringen. Vi har foreløpig ikke vært så kreative med hvordan vi har brukt det - la oss studere teknikken i litt mer detalj.

---


# 3:5 Kantslakking

lille-delta(s, v) <= v.d

Kantslakking; problematisk når vi har flere strukne kanter i en sti.

### Sti-slakkings-egenskapen
Om p er en kortest vei fra s til v og vi slakker kantene til p i rekkefølge, så vil v få riktig avstandsestimat. Det gjelder uavhengig av om andre slakkinger forekommer, selv om de kommer innimellom.
Se side 650 for flere slektninger av denne egenskapen.

- En __enkel__ sti er en sti uten sykler
- En __kortest__ sti er alltid __enkel__
- Negativ sykel? Ingen sti er __kortest__!
- Det finnes fortsatt en __kortest enkel__ sti!
- Å finne den effektivt: Uløst (NP-hardt)

---
La <v<sub>1</sub>, v<sub>2</sub>, ..., v<sub>k</sub>> være korteste vei til z.
Vi vil slakke kantene langs stien, men kjenner ikke rekkefølgen.

__Løsning:__
Slakk absolutt alle kanter k - 1 ganger!
---

Hvis vi lar k = \|V\| så får alle noder rett estimat

---

# 4:5 Bellman-ford
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
| Initialisering | 1      | $\theta(V)$ |
| RELAX          | V - 1  | $\theta(E)$ |
| RELAX          | O(V)   | $\theta(E)$ |

__Totalt: O(VE)__

---
Om et estimat endres, så var tidligere slakking fra noden bortkastet.

__Konklusjon:__ Slakk kanter fra v når v.d ikke kan forbedres.

---
### Strategi 1 av 2:
Slakk kanter ut fra noder i topologisk sortert rekkefølge

- Krever en retter asyklisk graf

#### Hvorfor blir det rett?

Når alle inn-kanter er slakket kan ikke noden forbedres og trygt velges som neste.

---


## Hva om vi vil ha sykler?


---
### Strategi 2 av 2:
Velg den gjenværende med lavest estimat.

- Stemmer ikke hvis vi har negative kanter!

#### Hvorfor blir dette rett?
Gjenværende noder kan kun forbedres ved slakking fra andre gjenværende. Det laveste estimatet kan dermed ikke forbedres.

---

## 5:5 Dijkstras algoritme

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

| Operasjon      | Antall | Kjøretid |
| -------------- |:------:| --------:|
| Initialisering | 1      | $\theta(V)$ |
| BUILD-HEAP     | 1      | $\theta(V)$ |
| EXTRACT-MIN    | V      | O(lg V)  |
| DECREASE-KEY   | E      | O(lg V)  |

__Total: O(V lg V + E lg V)__

Med binærheap: bedre enn lineært søk for E = o(V<sup>2</sup>/lg V)

Med Fibonacci-heap: DECREASE-KEY er O(1): vi får O(V lg V + E)

{% include mathjax.html %}
