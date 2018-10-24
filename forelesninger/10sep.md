---
title: Forelesning 10. September
---

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


### Summen opp til $2^i (1+2+4+8+...) = 2^{i+1} - 1$

## Rangering i lineær tid

-1 Sorteringsgrense
-2 Tellesortering
-3 Radikssortering
-4 Bøttesortering
-5 Randomized Select
-6 Select

## $T(\sqrt{n}) = lg n$
### $T(n^{1/2}) = lg n$

$$m &= lg n\\T(2^{m/2}) &= m\\\sqrt{n} &= n^{1/2} = (2^m)^{1/2} = 2^{m/2}\\S(m) &≔ T(n) = T(2^m)\\T(2^{m/2}) &= S(m/2)\\S(m/2) &= m\\S(m) &= 2m\\T(n) &= 2 lg n$$

## T(n) = 2T(sqrt(n)) + lg n

$$m = lg n\\T(2^m) = 2T(2^(m/2) + m\\S(m) := T(n) = T(2^m)\\T(2^m/2) = S(m/2)\\S(m) = 2S(m/2) + m (Master teoremet)\\S(m) = m lg m + m\\T(n) = lg n lg lg n + lg n$$


## 1:6 Sorteringsgrensen
"Tenk på en permutasjon"
...av $n!$ mulige
_Trenger maks lg n! ja-nei-spørsmål_


### $2^{T(n)} >= lg n!$
- Nedre grense for verste tilfelle
- Fra Stirlings approksimasjon: $n! \geq (n / e)^n$
- $\Rightarrow lg n! \geq n lg n - n lg e$

#### Worstcase
$$T_w(n) = O(\infty)\\
$$T_w(n) = \theta(?)\\
$$T_w(n) = \Omega(n lg n)\\

#### Bestcase
$$T_b(n) = O(\infty)\\
$$T_b(n) = \Theta(?)\\
$$T_b(n) = \Omega(n)\\

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

### T(n) = $\theta$(n + k)
Utvid veriområdet

## 3:6 Radikssortering
function radix-sort(A, d)
    for i = 1 to d
       sort* A by digit d

$$T(n) = \Theta(d * (n + k))\\

Bryt grensen
... denne gang for AC

## 4:6 Bøttesortering
function bucket-sort(A)
    n = A.length
    create B[0...n-1]
    for i = 0 to n
       make B[i] an empty list
    for i = 1 to n
       add A[i] to B[floor(nA[i])]
    for i = 0 to n - 1
       sort list B[i] #Bruker insertion sort
    concatenate B[0]...B[n - 1]

$$T_w(n) = \Theta(n^2)\\
$$T_a(n) = \Theta(n)\\
$$T_b(n) = \Theta(n)\\

Bryt grensen for AC
... ved å begrense problemet

## 5:6 Randomized Select

Hvem er på 10. plass? (f.eks.)
- Antar distinkte verdier!

Induksjon/reduksjon
- Anta mindre instanser kan løses

"Quicksort som binærsøk"

function randomized-select(A,p,r,i)
    if p == r
       return A[p]
    q = randomized-partition(A,p,r)
    k = q - p + 1
    if i == k
       return A[q]
    else if i < k
       return randomized-partition(A,p,q - 1, i)
    else
       return randomized-partition(A, q + 1, r, i - k)

$$T(n) = T(n / 2) + n\\
$$T(n) = 2n - 1\\

$$T_w(n) = \Theta(n^2)\\
$$T_a(n) = \Theta(n)\\
$$T_b(n) = \Theta(n)\\

Gjenta suksessen!
... denne gangen for WC

## 6:6 Select

Trenger god pivot
- Bruk ... Select?

"Median av medianer"

function partition-around(A,p,r,x)
    i = 1
    while A[i] != x
       i += 1
    exchange A[r] and A[i]
    return partition(A,p,r)

function select(A, p, r, i)
    if P == r
       return A[p]
    ....


function good-partiton(A, p , r)
    n = r - p + 1
    m = ceil(n / 5)
    create B[1...m]
    for i = 0 to m - 1
       q = p + 5i
       sort A[q...q + 4]
       B[i] = A[q + 3]
    x = select(B, 1, m, floor(m/2))
    return partiton-around(A,p,r,x)

$$T(n) = \Theta(n)\\

{% include mathjax.html %}
