include("./counting_sorts.jl")
import Test
import counting_sorts

#Oppgave 1
@test counting_sort_letters(["ccc", "cba", "ca", "ab", "abc"], 2) == ["ca", "cba", "ab", "abc", "ccc"]

#Oppgave 2
@test counting_sort_length(["bbbb", "aa", "aaaa", "ccc"]) == ["aa", "ccc", "bbbb", "aaaa"]

#Oppgave 3
@test flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6) == ["agg", "aggie", "hyblen", "kobra", "kort"]
