---
title: Forelesning 19. November
---

# Forelesning 19. November - Algoritmisk problemløsning

## Pensum
- Utdelt [materiale](https://algdat.idi.ntnu.no/guide.pdf){:target="_blank"} om problemløsning_.

## Læringsmål
- Kjenne et bredt spekter av etablerte algoritmer og datastrukturer
- Kjenne klassiske problemer med kjente effektive løsninger
- Kjenne kompleske problemer uten kjente effektive løsninger
- Kunne analysere algoritmers korrekthet og effektivitet
- Kunne formulere problemer så de kan løses av algoritmer
- Kunne konstruere nye effektive algoritmer
- Kunne bruke eksisterende algoritmer på nye problemer
- Kunne utvikle nye løsninger på praktiske problemer

0. [Kompletthet](#05-kompletthet)
1. [Problemløsning](#15-problemløsning)
2. [Eksempel: Ferievakter](#25-eksempel-ferievakter)
3. [Eksempel: Veisperring](#35-eksempel-veisperring)
4. [Eksempel: Handelsreise](#45-eksempel-handelsreise)
5. [Veien videre](#55-veien-videre)

---

## 0:5 Kompletthet
La oss se på skattekistene våre igjen. Hvis A sin nøkkel er i B kan vi redusere "åpne A" til "åpne B"

$$A \leqslant B$$

Kompletthet: Universalnøkkel! $X \leqslant C$ for __alle__ $X$

$$L \in NPC$$

### Hvordan viser vi at $L$ er __NP__-komplett?

- Vis at $L \in NP$
> At sertifikatet for ja-svar kan verifiseres i polynomisk tid

- Velg et kjent __NP__-komplett språk $L´$
- Beskriv en algortime som beregner en funksjon

$$ f\: :\{0,1\}^⋆ \longrightarrow \{0,1\}^⋆ $$

som mapper instaner av $L´$ til instanser av $L$
> Dette er altså reduksjonen fra $L´$ til $L$, som viser $L´\leqslant p L$

- Vis at

$$ x \in L´⟺ f(x) \in L,$$

for alle $x \in \{0,1\}^{⋆}$

> Vi må sørge for at vi får samme svar for $f(x)$

- Vis at algoritmen som beregner $f$ har polynomisk kjøretid


## 1:5 Problemløsning

## 2:5 Eksempel: Ferievakter

## 3:5 Eksempel: Veisperring

## 4:5 Eksempel: Handelsreise

## 5:5 Veien videre

{% include mathjax.html %}
{% include gotop.html %}
