# minspan.jl
```julia
mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end


function findset(x::DisjointSetNode)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end

function union!(x::DisjointSetNode, y::DisjointSetNode) #Merk at union allerede er definert i julia
  link(findset(x), findset(y))
end

function link(x, y)
  if x.rank > y.rank
    y.p = x
  else
    x.p = y
    if x.rank == y.rank
      y.rank = y.rank + 1
    end
  end
end

function hammingdistance(s1::String, s2::String)
  k = 0
  for i = 1:length(s1)
    if s1[i] != s2[i]
      k = k + 1
    end
  end
  return k
end

function make_set(x)
  x.p = x
  x.rank = 0
end

#findclusters(E::Vector{Tuple{Int, Int, Int}}, n::Int, k::Int), tuple => (w, u, v), n = |V|, k = mengde klynger
#Fungerer ikke ->
function findclusters(E::Vector{Tuple{Int, Int, Int}}, n::Int, k::Int)
  if length(E) == 0
    A = [1]
  else
    A = []
  end
  nodes::Vector{DisjointSetNode} = []
  for i = 1:n
    push!(nodes, DisjointSetNode())
  end
  #sort G.E by w # Sorter etter vekting
  sort!(E)
  current = 1
  while length(A) < k
    tuple = E[current]
    u = nodes[tuple[2]]
    v = nodes[tuple[3]]
    if find_set(u) != find_set(v)
      # en trygg kant
      push!(A, [tuple[2], tuple[3]])
      union!(u, v) #Egen definert union funksjon, se lenger oppe
    end
    current = current + 1
  end
  return A
end

#test med
# N=1, k=1, E=Tuple{Int64,Int64,Int64}[]
E = Tuple{Int64,Int64,Int64}[]
println(findclusters(E, 1, 1))
```

# teori.jl
```julia
using LightGraphs

g = SimpleGraph(8)
#=
1 = A
2 = B
3 = C
4 = D
5 = E
6 = F
7 = G
8 = H
=#

dict = Dict("A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6, "G" => 7, "H" => 8)
w = zeros(8, 8)

#For A
add_edge!(g, dict["A"], dict["B"])
w[dict["A"], dict["B"]] = 7
w[dict["B"], dict["A"]] = 7
add_edge!(g, dict["A"], dict["D"])
w[dict["A"], dict["D"]] = 1
w[dict["D"], dict["A"]] = 1
add_edge!(g, dict["A"], dict["F"])
w[dict["A"], dict["F"]] = 6
w[dict["F"], dict["A"]] = 6

#For B
add_edge!(g, dict["B"], dict["C"])
w[dict["B"], dict["C"]] = 2
w[dict["C"], dict["B"]] = 2
add_edge!(g, dict["B"], dict["E"])
w[dict["B"], dict["E"]] = 9
w[dict["E"], dict["B"]] = 9

#For C
add_edge!(g, dict["C"], dict["D"])
w[dict["C"], dict["D"]] = 4
w[dict["D"], dict["C"]] = 4
add_edge!(g, dict["C"], dict["H"])
w[dict["C"], dict["H"]] = 3
w[dict["H"], dict["C"]] = 3

#For D
add_edge!(g, dict["D"], dict["E"])
w[dict["D"], dict["E"]] = 8
w[dict["E"], dict["D"]] = 8
add_edge!(g, dict["D"], dict["G"])
w[dict["D"], dict["G"]] = 5
w[dict["G"], dict["D"]] = 5

#For E
add_edge!(g, dict["E"], dict["F"])
w[dict["E"], dict["F"]] = 9
w[dict["F"], dict["E"]] = 9
add_edge!(g, dict["E"], dict["H"])
w[dict["E"], dict["H"]] = 2
w[dict["H"], dict["E"]] = 2

#For F
add_edge!(g, dict["F"], dict["G"])
w[dict["F"], dict["G"]] = 1
w[dict["G"], dict["F"]] = 1

#For G
add_edge!(g, dict["G"], dict["H"])
w[dict["G"], dict["H"]] = 3
w[dict["H"], dict["G"]] = 3

#For H
#All edges are "taken"
#Sorted out making graph, now to making algorithms

function kruskal()
    a = kruskal_mst(g, w)
    print("Kruskal:")
    for edge in a
        print(" ", edge)
    end
    print(".\n")
end

function prim()
    a = prim_mst(g, w)
    print("Prims:")
    for edge in a
        print(" ", edge)
    end
    print(".\n")
end

kruskal()
prim()
```
