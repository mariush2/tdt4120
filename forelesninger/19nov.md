---
title: Forelesning 19. November
---

# Forelesning 19. November - Algoritmisk problemløsning

## Pensum
- Utdelt [materiale](https://algdat.idi.ntnu.no/guide.pdf){:target="_blank"} om problemløsning.

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

$$A ⋯ Z \leqslant C$$

Kompletthet: Universalnøkkel! $X \leqslant C$ for __alle__ $X$

$$L \in NPC$$

### Hvordan viser vi at $L$ er __NP__-komplett?

- Vis at $L \in NP$

> At sertifikatet for ja-svar kan verifiseres i polynomisk tid

- Velg et kjent __NP__-komplett språk $L´$
- Beskriv en algortime som beregner en funksjon

$$ f\: :\{0,1\}^⋆ \longrightarrow \{0,1\}^⋆ $$

som mapper instaner av $L´$ til instanser av $L$
> Dette er altså reduksjonen fra $L´$ til $L$, som viser $L´\leqslant_p L$

- Vis at

$$ x \in L´⟺ f(x) \in L,$$

for alle $x \in \\{0,1\\}^{⋆}$

> Vi må sørge for at vi får samme svar for $f(x)$

- Vis at algoritmen som beregner $f$ har polynomisk kjøretid


## 1:5 Problemløsning

### En slags prosess for problemløsningen

![prosess][../prosess]

#### Input T.1
  Hva slags objekt er en instans?  En mengde?  En sekvens?  En graf?
  Består den av flere deler, som for eksempel en graf og en vektfunksjon?
  Stilles det spesielle krav for at en instans skal være gyldig?

#### Output T.2
  Hva slags objekt er resultatet?  Har vi et søkeproblem, beslutningsproblem eller optimeringsproblem?  Dersom vi har et søkeproblem:  Hva er søkerommet?

#### Relasjon T.3
  For søkeproblemer: Hvilke krav stilles det til objektene vi leter etter?
  For optimering: Hva er løsningsrommet og mulighetsområdet, og hva er målfunksjonen?
  For beslutningsproblemer: Hva er spørsmålet?

#### Krav T.4
  Må den ha en bestemt verste, gjennomsnittlig eller amortisert kjøretid? Kan den kun bruke bestemte operasjoner? Er minnet begrenset? Kan den være randomisert?

#### Øvre, nedre T.5
  Skal det være en øvre eller nedre grense for kjøretid? Eller, vise at et problem er NP-komplett?

---

#### Kjente øvre A.1
  Kan du redusere til et eksiterende problem som har de egenskapene du trenger, f.eks. som kan løses like effektivt? Husk å bevare nødvendig egenskaper i reduksjonen.

#### Komponenter A.2
  Plassér probleminstansen i en familie med flere instanser som beskrives av et sett med parametre eller egenskaper, som for eskempel størrelse. Om mulig, del problemet opp mer.

#### Rammeverk A.3
  Kanskje det passer i et rammeverk for algoritme design?

#### Kjente nedre A.4
  Kan du redusere fra et eksisterende problem som er f.eks. like vanskelig å løse effektivt?

---

#### Induksjon S.1
  Du kan la løsningen for et delproblem være avhengig av at andre delproblemer er løst allerede, men du kan ikke ha uendelige avhengighetskjeder! Alle andre relasjoner fungerer.

#### Reduksjon S.2
  Hvis du skal løse et problem i polynomisk tid, sørg for at reduksjonen har polynomisk tid!

---

### Reduksjon fra A til B
- Kartlegg A og B grunding (som i fase 1)
- For hver del av A, finn ut hvilke deler av B som kan brukes til å simulere delen fra A
- Beskriv hvordan en instans fra A kan transformeres til en instans for B
- Sjekk at transformasjonen bevarer rett svar og tar polynomisk tid


## 2:5 Eksempel: Ferievakter
Du vil dekke ferievakter ved en klinikk, og må ha minst én lege på vakt hver dag.
Du vet hvem som kan når, men hver lege skal maks stille 1 dag per ferieperiode og maks $c$ dager totalt

### Tolkning
- Input: Mapping mellom leger og dager de kan jobbe. Gruppering av dager i ferieperioder. En maksgrense $c$
- Output: Mapping mellom leger og dager de faktisk skal jobbe
- Relasjon: Resultatmapping å respektere originalmapping, og overholde grensene!
- Krav: Polynomisk kjøretid - så lav som mulig
- Øvre, nedre: Øvre - skal løse problemet

### Analyse, øvre grense
- Kjente øvre: Bipartitt matching? Kortest vei? Flyt? Vi prøver flyt!
- Komponenter: -
- Rammeverk: Maks-flyt

### Syntese, reduksjon
- Reduksjon fra ferievakter til maks-flyt
- Deler av B som tilsvarer deler av A:
  - Arbeidskapasitet som flyt?
  - Leger, dager og ferieperioder som noder?
- Transformasjon: La oss se nærmere på det...

> Ønsker å ha minst én lege $(d)$ på vakt hver feriedag $(f)$
> Kan gjøres omtrent som matching (hvem er tilgjengelig når?)
> ...men hver lege kan jobbe et visst antall $(c)$ feriedager
> Hva om man maksimalt skal jobbe (f.eks.) én dag per ferie?
> Vi kan innføre én node per lege/ferie-kombinasjon
> Disse nodene "distribuerer" antall dager en lege kan jobbe
> Hver slik grupperings-node har en inn-kant med kap. (f.eks.) 1
>
Da har vi løst problemet! (Vi ser at i dette eksempelet så finnes det ingen løsning! 😛)

## 3:5 Eksempel: Veisperring
Etter et bankran kan politiet sette opp et gitt antall veisperringer og vil stanse forbryterne om mulig.
Du har kart over veinettet og får oppgitt makshastigheten til forbryterne, hvor og når forbrytelsen skjedde og når veisperringene kan være på plass. Hvor bør de settes opp?

### Tolkning
- Input:
  - Veinett: Vektet graf (rettet?)
  - Åsted: Node
  - Tid for forbrytelse, makshastighet, tidspunkt for sperring: Hvor langt kan de ha kommet?
- Output: Veier/kanter som skal sperres
- Relasjon: Veiene må utgjør et nitt rundt åstedet, lenger unna enn forbryterne kan ha kommet, maks så mange kanter du klarer å sperre - evt. færrest mulig

### Analyse, øvre grense
- Kjente øvre:
  - Korteste vei
  - Minimalt snitt

### Syntese, reduksjon
- Reduksjon fra veisperring til korteste vei, flyt
- Deler av B som tilsvarer deler av A:
  - Hvor kan de ha kommet? Korteste veier fra start
  - Mest mulig effektiv veisperring: Minimalt snitt

> Vi sikter mot minimalt snitt, der kantene har kapasitet 1
> Vi slår sammen mangedoble kanter og legger sammen kapasiteter
> Koble ytterste noder til $t$, og vi har løst problemet!

Simsallabim!

## 4:5 Eksempel: Handelsreise
En handelsreisende skal besøke et sett med byer. Hver by skal besøkes nøyaktig én gang,
og handelsreisen skal være så kort som mulig

__Dette er TCP problemet__

### Tolkning
- Input: Komplett, vektet graf
- Output: Sykel innom alle noder
- Relasjon: Kortest mulig, gitt vekting
- Øvre, nedre: Nedre

### Analyse, nedre grense
- Kjente nedre: Hamilton sykel

### Syntese, reduksjon
- Reduksjon fra Hamilton-sykel til Handelsreise
- Deler av B som tilsvarer deler av A:
  - Noder blir noder
  - Kanter blir billige kanter
  - Fraværende kanter blir dyre kanter
- Transformasjon: ...

__TSP__
- Instans: En komplett graf med heltallsvekter og heltakk k
- Spørsmål: Finnes det en rundtur med konstand $\leqslant k$

## 5:5 Veien videre
I TDT4125 Algoritmekonstruksjon lærer
du mer avanserte designmetoder, som
bl.a. går ut over det å finne eksakte
løsninger i polynomisk tid. Vi jobber med
NP-harde problemer, onlineproblemer
approksimasjonsalgoritmer,
parametriserte algoritmer, og mye mer!

### MIP
Det finnes programvare som løser lineære
optimeringsproblemer, helt generelt! Om
vi krever heltallsløsninger er det NP-
hardt, men de fungerer overraskende bra
i praksis likevel.

```julia
using JuMP, Cbc
using JuMP: dot

function knapsack(n, w, v, W)
  m = model(solver=CbcSolver())

  @variable   m x[1:n] Bin
  @objective  m Max dot(x, v)
  @constraint m W >= dot(x, W)

  solve(m)
  getvalue(x)

end
```
> x er spesielle JuMP -variable; getvalue(x) gir oss vanlige verdier

{% include mathjax.html %}
{% include gotop.html %}
