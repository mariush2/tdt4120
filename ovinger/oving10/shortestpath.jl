using DataStructures

mutable struct Node
    ip::Int
    neighbours::Array{::Tuple{Node,Int}}
    risk::Union{Float64, Nothing}
    predecessor::Union{Node, Nothing}
    probability::Float64
end

function initialize_single_source!(graph, start)
  for node in graph
    node.risk = typemax(Float64)
    node.predecessor = nothing
  end
  start.risk = 0
end

function relax!(from_node, to_node, cost)
  #v = to_node, u = from_node, w(u, v) = cost/to_node.probability
  if to_node.risk > from_node.risk + (cost/to_node.probability)
    to_node.risk = from_node.risk + (cost/to_node.probability)
    to_node.predecessor = from_node
  end
end

function extract_min(q)
  min = q[1]
  for node in q
    if node.risk < min.risk
      min = node
    end
  end
  return min
end


function dijkstra!(graph, start)
  initialize_single_source(graph, start)
  Q = Queue{Node}()
  for node in graph
    enqueue!(Q, node)
  end
  while !isempty(Q)
    from = dequeue!(Q) # Korteste stien til start
    for to in from.neighbours
      relax(from, to, w)
    end
  end
end


function bellman_ford!(graph, start)
  initialize_single_source(graph, strat)
  for i = 1 to |G.V| - 1
    for each edge (u, v) in G.E
      relax(u, v, w)
    end
  end
  for each edge (u, v) in G.E
    if v.d > u.d + w(u, v)
      return false
    end
  end
  return true
end
