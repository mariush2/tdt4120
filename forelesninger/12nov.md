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
> Konkrete beslutningsproblemer tilsvarer formelle språk (mengder av strenger). Ja-instanser er med, nei-instanser er ikke.


__Accept, reject, decide__
> En algoritme $A$ _aksepterer_ $x$ dersom $A(x) = 1$.
> Den _avviser_ $x$ dersom $A(x) = 0$
> Den _avjør_ et språk $L$ dersom..
>  - $x \in L \rightarrow A(x) = 1$
>  - $x \not\in L \rightarrow A(x) = 0$


__Accept vs decide:__
> Selv om $L$ er språket som _aksepteres_ av $A$, så trenger ikke $A$ _avgjøre_ $L$, siden den kan la være å svare for nei-instanser (ved å aldri terminere)


__Kompleksitetsklasse:__
> En mengde språk


__P:__
> Språkene som kan avgjøres i polynomisk tid.
> Også de som kan aksepteres i polynomisk tid!(Theorem 34.2)


__Cobham's tese:__
> Det er disse problemene vi kan løse i praksis


__Sertifikat:__
> En streng $y$ som brukes som "bevis" for et ja-svar


__Verifikasjonsalgoritme:__
> Tar inn sertifikat $y$ i tillegg til instans $x$
> En algoritme $A$ __verifiserer__ $x$ hvis det eksiterer et sertifikat $y$ slik at $A(x,y) = 1$


__Intuitivt:__
> Algoritmen "sjekker svaret". Om en graf har en Hamilton-sykel, kan sertifikatet være noderekkefølgen i sykelen.


__Asymmetrisk:__
> Den finnes ikke "motbevis" eller "anti-sertifikat"


__NP:__
> Språkene som kan verifieres i polynomisk tid

N = Nondeterministic: Kan løses om vi klarer "gjette" sertifikater


__HAM-CYCLE:__
> Språket for Hamilton-sykel-problemet


$HAM-CYCLE ∈ NP$
> Lett å verifiere i polynomisk tid
> __Merk:__ Ikke nødvendigvis lett å _falsifiere_


__co-NP:__
> Språkene som kan _falsifieres_ i polynomisk tid

$$ L ∈ co-NP ⟺ \overline{L} ∈ NP $$

F.eks. TAUTOLOGY


__P vs NP:__
> Om vi kan _løse_ problemet, så kan vi _verifisere_ det med samme algoritme, og bare ignorere sertifikatet
> Dvs.: $P \subseteq NP$ og $P \subseteq co-NP$


__Vi vet ikke__ om $P = NP \cap co-NP$

Mest plausibelt at $P \subset NP \cap co-NP$


### Noen (vanskelige) problemer

#### CIRCUIT-SAT

 __Instans:__ En krets med logiske porter og én utverdi

 __Spørsmål:__ Kan utverdien bli 1?

#### SAT (Sett inn formelen fra forelesning)

$$
\begin{equation}
\begin{split}
\phi = & \; ((x_1 \rightarrow x_2) \vee \\
 & \neg ((\neg x_1 \longleftrightarrow x_3) \vee x_4) \wedge \neg x_2
\end{split}
\end{equation}
$$

 __Instans:__ En logisk formel

 __Spørsmål:__ Kan formelen være sann?

#### 3-CNF-SAT (Sett inn formel fra forelesning)

$$
\begin{equation}
\begin{split}
\phi = &(\hspace{0.6em} x_1 \vee \neg x_2 \vee \neg x_3)\: \wedge \\
&(\neg x_1 \vee \hspace{0.6em} x_2 \vee \hspace{0.6em} x_3)\: \wedge \\
 &(\hspace{0.7em} x_1 \vee \hspace{0.6em} x_2 \vee \hspace{0.6em} x_3)
\end{split}
\end{equation}
$$

 __Instans:__ En logisk formel på 3-CNF-form

 __Spørsmål:__ Kan formelen være sann?

#### SUBSET-SUM

 __Instans:__ Mengde positive heltall $S$ og positive heltall $t$

 __Spørsmål:__ Finnes en delmengde $S' \subseteq S$ så $\Sigma_{s ∈ S'}s = t$

#### CLIQUE

 __Instans:__ En urettet graf $G$ og et heltall $k$

 __Spørsmål:__ Har $G$ en komplett delgraf med $k$ noder?

#### VERTEX-COVER

 __Instans:__ En urettet graf $G$ og et heltall $k$

 __Spørsmål:__ Har $G$ et nodedekke med $k$ noder?
 Dvs., $k$ noder som tilsammen ligger inntil alle kanter

#### HAM-CYCLE

__Instans:__ En urettet graf $G$

__Spørsmål:__ Finnes det en sykel som inneholder alle nodene?

#### TSP

__Instans:__ En komplett graf med heltallsvekter og et heltall $k$

__Spørsmål:__ Finnes det en en rundtur med kostnad $⩽ k$?


## 2:3 Reduksjoner

## Skattekiste eksempel
La oss si du har funnet to skattekister. Du ønsker å si noe om hvor vanskelige de er å åpne.
Anta at B inneholder nøkkelen (løsningen) til A.

Kan det nå være vanskeligere å åpne A enn B?

Nei! Om vi kan åpne B, kan vi naturligvis åpne A som en følge.

Vi har _redusert_ problemet "åpne A" til problemet "åpne B"

$$ A ⩽ B $$

---

__Input:__ En bitstreng $x$

__Output:__ En bitstreng $f(x)$, der
$$ x \in L_1 ⟺ f(x) \in L_2 $$


Om vi kan avgjøre om $f(x) \in L_2$ kan vi avgjøre om $x /in L_1$

---

__Redusibilitet:__
> Hvis $A$ kan reduseres til $B$ i polynomisk tid, skriver vi $A \leqslant B$


__Ordning:__
> Relasjonen $<=p$ utgjør en _preordning_


__Hardhetsbevis:__
>For å vise at $B$ er vanskelig, redusér fra et vanskelig problem $A$
> dvs., etablér at $A \leqslant B$


## 3:3 Kompletthet


__Kompletthet:__
> Et problemt er _komplett_ or en gitt klasse og en gitt type reduksjoner dersom det er _maksimalt_ for redusibilitetsrelasjonen


__Maksimalitet:__
> Et element er maksimalt
> dersom alle andre er mindre
> eller lik.  For reduksjoner:  $Q$ er maksimalt dersom alle
> problemer i klassen kan reduseres til $Q$.


__NPC:__
> De komplette språkene i __NP__, under polynomiske
> reduksjoner


__De vanskelige problemene fra tidligere er altså eksempler på NP-komplette problemer__


__NP-hardhet:__
> Et problem $Q$ er __NP__-hardt dersom alle problemer i NP kan reduseres til det.
> Et problem er altså __NP__-komplett dersom det
> - er __NP__-hardt, og
> - er i __NP__


{% include mathjax.html %}
{% include gotop.html %}
