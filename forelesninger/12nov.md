---
title: Forelesning 12. november
---

# Forelesning 12. november - NP-kompletthet

## Pensum
- Kap. 34. NP-completeness
- Oppgave 34.1-4 med løsning (0-1 knapsack)

## Læringsmål
- Forstå _optimering_ vs _beslutning_
- Fortå _koding_ av instans
- Forstå at løsningen på 0-1-ryggsekkproblemet _ikke er polynomisk_
- Forstå _konkrete_ vs _abstrakte_ problemer
- Forstå repr. av beslutningsproblemer som _formelle språk_
- Forstå def. av __P__, __NP__ og __co-NP__
- Forstå _redusibilitets-relasjonen_
- Forstå def. av __NP-Hard__ og __NPC__
- Forstå den konvensjonelle hypotesen om __P__, __NP__ og __NPC__
- Forstå hvordan _NP-kompletthet_ kan bevises ved én reduksjon
- Kjenne noen __NPC-problemer__
- Forstå at _0-1-ryggsekk_ er __NPH__
- Forstå at _lengste enkle sti_ er __NPH__
- Kunne konstruere enkle __NPC-bevis__

0. [Matching](#03-matching)
1. [Problemer](#13-problemer)
2. [Reduksjoner](#23-problemer)
3. [Kompletthet](#33-problemer)

---

## 0:3 Matching

__Matching:__ Delmengde $M ⊆ E$ for en urettet graf $G = (V,E)$
  - Ingen av kantene i M deler noder
  - Bipartitt matching: M matcher partisjoner

---

__Input:__ En bipartitt urettet graf $G = (V,E)$

__Output:__ En matching $M ⊆ E$ med flest mulig kanter, dvs., der $\|M\|$ er maksimal.

---

### Heltallsteoremet (26.10):
__For heltallskapasiteter gir Ford-Fulkerson
heltallsflyt__



## 1:3 Problemer

Et problem er en relasjon mellom input og output. Jobben vår er å produsere gyldig output fra input.

Et problem kalles _konkret_ hvis input og output er bitstrenger.

En _verifikasjonsalgoritme_ sjekker om løsningen stemmer.

Kaller gjerne en løsning et _sertifikat_ eller et _vitne_

Generelt: Egentlig et hvilket som helst ja/nei-spørsmål

- Optimering: Ikke nødvendigvis noe vitne
- Lag beslutningsprolemb med terksling
- Avgjøres vha. optimering, som da er minst like vanskelig
- Hvis $P = NP$ kan vi finne optimum vha. binærsøk med terskelen


__Problem med språk:__
- Konkrete beslutningsproblemer tilsvarer formelle språk (mengder av strenger). Ja-instanser er med, nei-instanser er ikke.

__Accept, reject, decide__
- En algoritme $A$ _aksepterer_ $x$ dersom $A(x) = 1$.
- Den _avviser_ $x$ dersom $A(x) = 0$
- Den _avjør_ et språk $L$ dersom..
  - $x \in L \rightarrow A(x) = 1$
  - $x \in L \rightarrow A(x) = 0$

__Accept vs decide:__
- Selv om $L$ er språket som _aksepteres_ av $A$, så trenger ikke $A$ _avgjøre_ $L$, siden den kan la være å svare for nei-instanser (ved å aldri terminere)

__Kompleksitetsklasse:__
- En mengde språk

__P__
- Språkene som kan avgjøres i polynomisk tid.
- Også de som kan aksepteres i polynomisk tid!(Theoremt 34.2)

__Cobham's tese:__
- Det er disse problemene vi kan løse i praksis

__Sertifikat:__
- En streng $y$ som brukes som "bevis" for et ja-svar

__Verifikasjonsalgoritme:__
- Tar inn sertifikat $y$ i tillegg til instans $x$
- En algoritme $A$ __verifiserer__ $x$ hvis det eksiterer et sertifikat $y$ slik at $A(x,y) = 1$

__Intuitivt:__
- Algoritmen "sjekker svaret". Om en graf har en Hamilton-sykel, kan sertifikatet være noderekkefølgen i sykelen.

__Asymmetrisk:__
- Den finnes ikke "motbevis" eller "anti-sertifikat"

__NP:__
- Språkene som kan verifieres i polynomisk tid





## 2:3 Reduksjoner


## 3:3 Kompletthet

{% include mathjax.html %}
{% include gotop.html %}
