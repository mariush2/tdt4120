# Forelesning 10. september

## Pensum
- Kap. 8. Sorting in linear time
- Kap. 9. Medians and order statistics


## Læringsmål
- Forstå hvorfor _sammenligningsbasert sortering_ har en _worst-case_ på Omega(n lgn)
- Vite hva en _stabilsorteringsalgoritme_ er
- Forstå **COUNTING-SORT**, og hvorfor den er stabil
- Forstå **RADIX-SORT**, og hvorfor den trenger en stabil subrutine
- Forstå **BUCKET-SORT**
- Forstå **RANDOMIZED-SELECT**
- Kjenne til **SELECT**; grunding forståelse kreves ikke


### Summen opp til 2^i (1+2+4+8+...) = 2^(i+1) - 1

## Rangering i lineær tid

**-1, Sorteringsgrense**
**-2, Tellesortering**
**-3, Radikssortering**
**-4, Bøttesortering**
**-5, Randomized Select**
**-6, Select**

## T(sqrt(n)) = lg n#
### T(n^(1/2)) = lg n
- m = lg n
- T(2^(m/2)) = m
- sqrt(n) = n^(1/2) = (2^m)^(1/2) = 2^(m/2)
- S(m) := T(n) = T(2^m)
- T(2^(m/2)) = S(m/2)
- S(m/2) = m
- S(m) = 2m
- T(n) = 2 lg n

## T(n) = 2T(sqrt(n)) + lg n
- m = lg n
- T(2^m) = 2T(2^(m/2) + m
- S(m) := T(n) = T(2^m)
- T(2^m/2) = S(m/2)
- S(m) = 2S(m/2) + m (Master teoremet)
- S(m) = m lg m + m
- T(n) = lg n lg lg n + lg n


## 1:6 Sorteringsgrensen
"Tenk på en permutasjon"
...av n! mulige
_Trenger maks lg n! ja-nei-spørsmål_


### 2^(T(n)) >= lg n!
- Nedre grense for verste tilfelle
- Fra Stirlings approksimasjon: n! >= (n / e)^n
- => lg n! >= n lg n - n lg e

#### Worstcase
- T_w(n) = O(infinity)
- T_w(n) = Theta(?)
- T_w(n) = Omega(n lg n)

#### Bestcase
- T_b(n) = O(infinity)
- T_b(n) = Theta(?)
- T_b(n) = Omega(n)

## 2:6 Tellesortering
function counting-sort(A, B, k)
    let C[0...k] be a new array
    for i = 0 to k
       C[i] = 0
    for j = 1 to A.length
       C[A[j]] += 1
    for i = 1 to k
       C[i] = C[i] + C[i - 1]
    for j = A.length downto 1
       B[C[A[j]]] = A[j]
       C[A[j]] -= 1
