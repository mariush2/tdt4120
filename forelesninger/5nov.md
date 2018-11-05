---
title: Forelesning 5. November
---

# Forelesning 5. November - Maksimal flyt

## Pensum
- Kap. 26. Maximum flow: Innledning og 26.1-26.3

## Læringsmål
- Kunne definere _flynett_, _flyt_ og _maks-flyt-problemet_
- Kunne håndtere _antiparallellekanter_ og flere _kilder_ og _sluk_
- Kunne definere _residualnettverket_ til et nettverk med en gitt flyt
- Forstå _oppheving_ av flyt
- Forstå _forøkende_ stier
- Forstå _snitt_, _snitt-kapasitet_ og _minimalt snitt_
- Forstå _maks-flyt/min-snitt_
- Forstå __FORD-FULKERSON__
- Vite at __FORD-FULKERSON__ med __BFS__ er __EDMONDS-KARP__
- Kunne finne en _maksimum bipartitt matching_ vha. flyt
- Forstå _heltallsteoremet_

1. [Problemet](#15-problemet)
2. [Ideer](#25-ideer)
3. [Ford-fulkerson](#35-ford-fulkerson)
4. [Minimalt snitt](#45-minimalt-snitt)
5. [Matching](#55-matching)

---

## 1:5 Problemet
__Flytnett:__ Rettet graf $G = (V, E)$
- Kapasitet $c(u, v) \geqq 0$
- Kilde og sluk $s, t ∈ V$
- $v ∈ V ⇒ s \leadsto v \leadsto t$
- Ingen løkker (_self-loops_)
- $(u, v) ∈ E \Longrightarrow (v, u) ∉ E$
- $(u, v) ∉ E \Longrightarrow c(u, v) = 0$

__Flyt:__ En funksjon $𝑓 : V × V \longrightarrow ℝ$
- $0 \leqq 𝑓(u, v) \leqq c(u, v)$
- $u \ne s, t \Longrightarrow Σ_v \itf (v, u) = Σ_v \itf (u, v)$

__Flytverdi:__ $\|𝑓\| = Σ_v \itf (s, v) - Σ_v \itf (v, s)$


__Input:__ Et flyttnetverk G

__Output:__ En flyt $\itf$ for $G$ med maks. $\|\itf\|$


- Cormen 1 & 2 har __andre definisjoner__
- __Antiparallelle kanter:__
  - Splitt den ene med en node (Fikser problemet)
- __Flere kilder og sluk:__
  - Legg til super-kilder og super-sluk


## 2:5 Ideer

### Restnett
_Residualnettverk_

- Engelsk: Residual network
- Fremoverkant ved ledig kapasitet
- Bakoverkant ved flyt

### Forøkende sti
_Flytforøkende sti_

- Engelsk: Augmenting path (flow augmenting path)
- En sti fra kilde til sluk i restnettet. $s \leadsto t$
- Langs fremoverkanter: Flyten kan økes
- Langs bakoverkanter: Flyten kan omdirigeres

$$
c_𝑓(u,v)=
\begin{cases}
  c(u,v) - 𝑓(u,v)\:if\:(u,v) ∈ E,\\
  𝑓(v,u)\:if\:if (v,u) ∈ E,\\
  0\:otherwise\\
\end{cases}
$$


## 3:5 Ford-fulkerson
- Finn forøkende stier så lenge det går
- Deretter er flyten maksimal
- Generell metode, ikke en algoritme (litt underspesifisert)

- Normal implementasjon:
  - Finn forøkende sti først
  - Finns å flaskehalsen i stien
  - Oppdater flyt langs stien med denne verdien


```julia
function ford_fulkerson_method(G, s, t)
  initialize flow 𝑓 to 0
  while there is an augm. path p to G_𝑓
    augment flow 𝑓 along p
  end
  return 𝑓
end

function ford_fulkerson(G, s, t)
  for each edge e ∈ G.E
    e.f = 0
  end
  while there is a path p from s to t in G_𝑓
    c_𝑓(p) = min(c_𝑓(u, v) : (u, v) is in p)
    for each edge (u, v) in p
      if (u, v) ∈ E
        (u,v).f = (u, v).f + c_𝑓(p)
      else
        (v, u).f = (v, u).f - c_𝑓(p)
      end
    end
  end
end
```

- Alternativ "Flett inn" BFS
  - Finn flaskehalser underveis!
  - Hold styr på hvor mye flyt vi får frem til hver node
  - Traverser bare noder vi ikke har nådd frem til ennå
- Denne "implementasjonen" står ikke i boka


Alle nodene får et felt _a_ (augmentation).

```julia
function edmonds_karp(G, s, t)
  for each edge (u,v) ∈ G.E
    (u,v).f = 0
  end
  repeat #-> until t.a == 0
    for each vertex u ∈ G.V
      u.a = 0 # flow reaching u in G.f
      u.π = NIL
    s.a = ∞
    Q = ∅
    enqueue(Q, s)
    while t.a == 0 && Q != ∅
      u = dequeue(Q)
      for all edges (u,v),(v,u) ∈ G.E
        if (u,v) ∈ G.E
          c_f(u,v) = c(u, v) - (u,v).f
        else
          c_f(u,v) = (v,u).f
        end
        if c_f(u,v) > 0 and v.a == 0
          v.a = min(u.a, c_f(u,v))
          v.π = u
          enqueue(Q, v)
        end
      end
    end
    u, v = t.π, t # at this point, t.a = c_f(p)
    while u != NIL
      if (u, v) ∈ G.E
        (u,v).f = (u,v).f + t.a
      else
        (v,u).f = (v,u).f - t.a
      end
      u, v = u.π, u
    end
  until t.a == 0
```



## 4:5 Minimalt snitt

## 5:5 Matching

{% include mathjax.html %}
