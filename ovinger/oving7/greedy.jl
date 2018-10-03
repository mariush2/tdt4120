# Øving 7
#=
I denne øvingen skal du lage funksjonalitet for et pengevekslingsystem. Du kommer til å måtte skrive både en grådig algoritme og en algoritme som tar i bruk dynamisk programmering.

Grådige algoritmer er ofte veldig raske, og har som regel en simpel implementasjon sammenlignet med en løsning som tar i bruk dynamisk programming. Av den grunn ønsker vi å implementere en funksjon som undersøker om en gitt instans av problemet kan løses grådig.

Et konkret eksempel på når en grådig løsning vil feile er som følger:

coins=[4,3,1], value= 6

En grådig løsning vil returnere 3 som minimum antall mynter. Den vil dele 6 opp i myntene [4,1,1], men den optimale løsningen er [3,3]

Gjennom øvingen skal du implementere følgende funksjoner, for å lage et komplett pengevekslingssystem:

    can_use_greedy: En funksjon som undersøker om man kan bruke en grådig algoritme for å løse problemet
    min_coins_greedy: En grådig algoritme som finner det minste antall mynter, fra en liste med mynter, en tall-verdi kan deles opp i.
    min_coins_dynamic: En DP algoritme som finner det minste antall mynter, fra en liste med mynter, en tall-verdi kan deles opp i.

MERK:

    Alle myntsettene som det blir testet med vil inneholde mynten 1, slik at det vil være mulig å dele ut alle beløp.
    Alle myntsettene vil være på formen [a1,a2,...,an−1,an]

hvor ai>ai+1 for i∈[1,n−1]. Altså i synkende rekkefølge
=#

# Oppgave 1
#=
Vi ønsker først å undersøke om problemet kan løses grådig. For å få til dette skal du implementere can_use_greedy(coins).

coins er en liste med integer-verdier. Disse verdiene representerer ulike mynter. Funksjonen skal returnere true eller false, avhengig om man kan bruke en grådig løsning på listen med mynter.

MERK! Funksjonen du skal implementere vil teste for en tilstrekkelig betingelse, og ikke en nødvendig betingelse. Det betyr at den vil aldri gi noen false positives, men vil kunne gi false negatives. Med andre ord vil can_use_greedy i noen tilfeller si at du ikke kan bruke en grådig algoritme, selv om det egentlig er mulig. Dette er tatt høyde for under testingen av implementasjonen din, og er ikke noe du trenger å ta hensyn til.

Den tilstrekkelige betingelsen du skal teste for er som følger:
∀ci∈C(ci / ci+1∈ℕ),hvorC=⟨c1,…,cn⟩,ci>ci+1 og 1≤i≤n−1

Her er C et set med vilkårlig antall mynter
=#
function can_use_greedy(coins)
    previous = coins[1]
    for i = 2:length(coins)
        t = round(previous / coins[i])
        if previous < coins[i] && (t < 1 || t > length(coins))
            return false
        else
            previous = coins[i]
        end
    end
    return true
end

println(can_use_greedy([100, 75, 50, 25, 5, 1]), ": should be false")
