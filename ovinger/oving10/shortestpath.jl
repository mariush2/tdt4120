using DataStructures

mutable struct Node
    ip::Int
    neighbours::Array{Tuple{Node,Int}}
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

function extract_min(all)
  min = all[1]
  minrisk = all[1].risk
  for node in all
    if node.risk < minrisk
      min = node
      minrisk = node.risk
    end
  end
  return min
end


function dijkstra!(graph, start)
  initialize_single_source!(graph, start)
  nodes = []
  for node in graph
    push!(nodes, node)
  end
  while !isempty(nodes)
    from = extract_min(nodes) # Korteste stien til start
    filter!(e->e≠from,nodes)
    for neighbour in from.neighbours
      #type(neighbour[1]) = Node, type(neighbour[2]) = cost
      relax!(from, neighbour[1], neighbour[2])
    end
  end
end


function bellman_ford!(graph, start)
  initialize_single_source!(graph, strat)
  for i = 1:length(graph)
    u = graph[i]
    for v in u.neighbours
      relax!(u, v[1], v[2])
    end
  end
  for i = 1:length(graph)
    u = graph[i]
    for v in u.neighbours
      if v[1].risk > u.risk + (v[2]/v[1].probability)
        return false
      end
    end
  end
  return true
end
