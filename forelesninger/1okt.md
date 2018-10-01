# Forelesning 1. oktober


## Pensum
- Kap. 16. Greedy algorithms: innledning og 16.1-16.3

## Læringsmål
- Forstå designmetoden _grådighet_
- Forstå _grådighetsegenskapen_ (_the greedy-choice property_).
- Forstå eksemplene _aktivitet-utvelgelse_ og _det fraksjonelle ryggsekkproblemet_
- Forstå __HUFFMAN__ og _Huffman-koder_

---

## 1:4 Grådighet > Hva er det?
- Velger med én gang
- "Gjetter" hva som er rett
- Løser kun den delinstansen som ser mest "lovende" ut.

Annet perspektiv: Ser på "veien videre" heller enn "veien hit".

- Dynamisk programmering:
 - Løs delproblember rekursivt
 - Bygg løsning på beste delløsning
- Grådighet:
 - Løs det mest lovende delproblemet rekursivt
 - Bygg løsning på denne delløsningen

### Ting å identifisere
1. Globalt optimalitetskriterium
2. Lokalt optimalitetskriterium
3. Konsktruksjonstrinn

### Ting å vise
1. Grådighetsegenskapen
 - Kan velge det som ser best ut her og nå uten å skyte oss i foten
2. Optimal delstruktur
 - Kan fortsette på samme måte: Optimal løsning bygger på optimale delløsninger

### Det vil si:
Grådig valg + optimal delløsning gir optimal løsning

### Om vi ikke har...
1. Grådighetsegenskapen vil et grådig valg kunne gjøre at vi ikke lenger har håp om optimalitet
2. Optimal delstruktur vil vi kunne måtte løse ting på en helt annen måte etter første valg



1. Formuler som opt-problem der vi tar et valg så ett delproblem gjenstår
2. Vis at det alltid finnes en optimal løsning som tar det grådige valget
3. Vis at optimal løsning på grådig valg

## 2:4 Eksempel: Ryggsekk
__Input__: Verdier v1...vn, vekter w1... wn og en kapasitet W.

__Output__: Indekser _i<sub>1</sub>...i<sub>k</sub>_ og en fraksjon 0 <= e <= 1 slik at _w<sub>i1</sub> + ... + w<sub>ik-1</sub> + e • w<sub>ik</sub> <= W_ og totalverdien _v<sub>i1</sub> + ... + e • v<sub>ik</sub> er_ maksimal

- Fra {0,1} til brøk
 - Velg alltid det med høyest kilopris
 - Begge har optimal substruktur


- Grådighetsegenskapen
 - Det finnes en optimal løsning der vi tar med mest mulig av det dyreste
- Optimal delstruktur
 - Om vi tar med noe, må resten av sekken fortsatt fylles optimalt

## 2:5 Eksempel: Aktivitetsutvalg

__Input__: Intervall [s<sub>1</sub>,f<sub>1</sub>,...[s<sub>n</sub>,f<sub>n</sub>)

__Output__: Flest mulig ikke-overlappende intervaller


- Skal velge størst mulig delmengde av ikke-overlappende intervaller
- Delproblem: Intervaller innenfor et gitt område
- Valg: Et intervall som skal bli med
 - Løs begge delproblemer rekursivt og legg til 1
- Men: Vi trenger ikke se på alle disse delproblemene!
 - Det vil alltid lønne seg å ta med intervallet som slutter først!


- Grådighetsegenskapen:
 - Det finnes en optimal løsning som inkluderer første intervall
- Optimal delstruktur:
 - Om vi velger første intervall, må resten fortsatt løses optimalt


```julia
function rec_act_sel(s, f, k, n)
 # S[i] start, a_i
 # f[i] slutt, a_i
 # a_k forrige
 # a_m neste
 # n antall
 m = k + 1
 while m <= n && s[m] < f[k]
  m = m + 1
 end
 if m <= n
  S = rec_act_sel(s, f, m , n)
  return union(a_m, S)
 end
 return nothing
```

__Grådig versjon__
```julia
function greedy_activity_selector(s, f)
 n = length(s)
 A = [a_1]
 k = 1
 for m = 2:n
  if s[m] >= f[k]
   push!(A, a_m) # A = union(A, a_m)
   k = m
  end
 end
 return A
```

### Bevis ved forsprang
- Vis at grådighet er minst like bra som alle andre algoritmer for hvert trinn; det følger at den gir en optimal løsning

## 4:4 Eksempel: Huffman
__Input__: Alfabet C = {c,...} med frekvenser _c.freq_

__Output__: Binær koding som minimerer forventet kodelengde.

- VIl lage binære koder for tegn
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

### Korrekthet
- Vil vise at det lønner seg å slå sammen de to sjeldneste nederst
 - Anta en vilkårlig annen løsning, med de sjeldneste lenger opp; Ser at bidragene viser at det er trygt å bytte plass slik at de sjeldneste er nederst.
