---
title: Forelesning 5. November
---

# Forelesning 5. November

## Pensum
- Kap. 26. Maximum flow: Innledning og 26.1-26.3

## Læringsmål
- Kunne definere _flynettverk_, _flyt_ og _maks-flyt-problemet_
- Kunne håndtere _antiparallellekanter_ og flere _kilder_ og _sluk_
- Kunne definere _residualnettverket_ til et nettverk med en gitt flyt
- Forstå _oppheving_ av flyt
- Forstå _forøkende_ stier
- Forstå _snitt_, _snitt-kapasitet_ og _minimalt snitt_
- Forstå _maks-flyt/min-snitt_
- Forstå __FORD-FULKERSON__
- Vite at __FORD-FULKERSON__ med __BFS__ er __EDMONDS-KARP__
- Kunne finne en _maksimum bipartitt matching__ vha. flyt
- Forstå _heltallsteoremet_

1. [Problemet](#15-problemet)
2. [Ideer](#25-ideer)
3. [Ford-fulkerson](#35-ford-fulkerson)
4. [Minimalt snitt](#45-minimalt-snitt)
5. [Matching](#55-matching)

---

## 1:5 Problemet
__Flytnettverk:__ Rettet graf $G = (V, E)$
- Kapasitet $c(u, v) \geqq 0$
- Kilde og sluk $s, t ∈ V$
- $v ∈ V ⇒ s \leadsto v \leadsto t$
- Ingen løkker (_self-loops_)
- $(u, v) ∈ E \Rightarrow (v, u) ∉ E$
- $(u, v) ∉ E \Rightarrow c(u, v) = 0$

__Flyt:__ En funksjon $𝑓 : V × V \rightarrow 𝚁$
- $0 \leqq \bif (u, v) \leqq c(u, v)$
- $u \ne s, t \Rightarrow Σ_v \bif (v, u) = Σ_v \bif (u, v)$

__Flytverdi:__ $|\bif| = Σ_v \bif (s, v) - Σ_v \bif (v, s)$



## 2:5 Ideer

## 3:5 Ford-fulkerson

## 4:5 Minimalt snitt

## 5:5 Matching

{% include mathjax.html %}
