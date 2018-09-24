# Forelesning 10. september

## Læringsmål
- Forstå _delproblemgrafer_
- Forstå _dynamisk programmering_
- Forstå løsning ved _memoisering (top-down)_
- Forstå løsning ved _iterasjon (bottom-up)_
- Forstå hvordan man _rekonstruerer_ en løsning fra lagrede beslutninger
- Forstå hva _optimal delstruktur_ er
- Forstå hva _overlappende delproblemer_ er
- FOrstå _stavkutting_ og _LCS_
- Forstå løsningen på _0-1-ryggsekkproblemet_ (se appendisk D i pensumheftet)

## 1:5 Dekomponering
Dele problemet opp i mange delproblemer, løser vi delproblemene, kan vi løse hovedproblemet våres

```julia
function(A)
 S = divide(A)
 n = S.length
 let R[1...n] be a new array
  for i = 1 to n
   R[i] = function(S[i])
 return combine(R)
```

### Optimal delstruktur
Det finnes en optimal løsning bestående av optimale delløsninger

### Velfunderthet
Enhver avhengighetskjede ender med et grunntilfelle
Unngå uendelig rekursjon
Kan godt gå 'oppover' i det uendelige, men vi må ha et slags startpunkt for at det skal fungere
Det samme holder for syklisk avhengighet.

- Dette beskriver __velfunderte relasjoner__
- Disse kan brukes til __induksjon__
- Eksemplene vi har brukt så langt:
 - Naturlig induksjon: "__er én mindre enn__"
 - Sterk induksjon: "__er strengt mindre enn__"
 - Strukutrell induksjon, trær: "__er barn av__"

## 2:5 Dynamisk programmering -> Hva er det?

### Oppskrift, Cormen et al.
1. _Characterize the structure_ of an optimal solution
2. _Recursively define the value_ of an optimal solution
3. _Compute the value_ of an optimal solution
4. _Construct_ an optimal solution from computed information

### Oppskrift, Sniedovich
1. _Embed_ your problem in a family of related problems
2. _Derive_ a relationship between the solutions to these problems
3. _Solve_ this relationship
4. _Recover_ a solution to your problems from this relationship

__Men er det ikke det vi har gjort til nå?__

### "Time-memory" tradeoff
Regner bare ut løsningen for et delproblem __en__ gang.

__Nyttig__ når vi har overlappende delproblemer
__Korrekt__ når vi har optimal substruktur

### Memoisering
Gi funksjonen hukommelse: "Har jeg regnt ut dette problemet før?"
Hvis ja: Returnér svaret du lagret sist!

```julia
function(A)
 if F[A] == nothing
   S = divide(A)
   n = S.length
   let R[1...n] be a new array
    for i = 1 to n
     R[i] = function(S[i])
   F[A] = combine(R)
 return F[A]
```
## 3:5 Eksempel: Stavkutting
_Rod-cutting problem_

__Input:__ En lengde _n_ og priser _p_ for lengder _i_ = 1...n
__Output:__ Lengder l_1 ... l_k der summen av lengder l_1 + ... + l_k er n og r_n = p_l_1 + ... + p_l_k totalprisen er maksimal
