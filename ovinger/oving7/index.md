# greedy.jl
```julia
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

# Oppgave 1, done
function can_use_greedy(coins)
    for i = 1:length(coins) - 1
        next = coins[i + 1]
        if coins[i] > next && coins[i] % next != 0
            return false
        end
    end
    return true
end
#println(can_use_greedy([120, 60, 30, 15, 5, 1]), ": should be true")

# Oppgave 2
#=
For å løse problemet med en grådig algoritme skal du lage funksjonen min_coins_greedy(coins, value).

coins er en liste med mynt-verdier og value er en verdi som skal deles opp i et antall mynter. Funksjonen skal returnere det minste antall mynter verdien kan deles opp i.

Eksempel på hvordan funksjonen skal fungere:

min_coins_greedy([1000,500,100,20,5,1],1226)
6

min_coins_greedy([1000,500,100,20,5,1],2567)
9

min_coins_greedy([1000,500,100,20,5,1],8)
4
=#

function min_coins_greedy(coins, value)
    # Basically, use the coins array to displace the value
    used = 0
    current_coin = 1
    while value > 0
        if value >= coins[current_coin]
            value = value - coins[current_coin]
            used = used + 1
        else
            current_coin = current_coin + 1
        end
    end
    return used
end

function min_coins_dynamic(coins, value)
    inf=1000000000
    #For each time, check which of the coins are the better fit, aka which returns lowest x % y
    used = 0
    while value > 0
        current_low = value
        current_coin = 1
        for coin in coins
            if value % coin < current_low
                current_low = value % coin
                current_coin = coin
            end
        end
        value = value - current_coin
        used = used + 1
    end
    return used
end

println(min_coins_dynamic([1000, 500, 200, 100, 50, 20, 10, 5, 4, 3, 1],1027))
```
