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
