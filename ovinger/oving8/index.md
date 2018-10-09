# traversegraph.jl
```julia
using Pkg
Pkg.add("DataStructures")

mutable struct Node
    id::Int
    neighbours::Array{Node}
    color::Union{String, Nothing}
    distance::Union{Int, Nothing}
    predecessor::Union{Node, Nothing}
end
Node(id) = Node(id, [], nothing, nothing, nothing)

function makenodelist(adjacencylist)
    nodes::Array{Node} = []
    for i in 1:length(adjacencylist)
        push!(nodes, Node(i))
    end
    for (i, adjacent) in enumerate(adjacencylist)
        for neigbour in adjacent
            push!(nodes[i].neighbours, nodes[neigbour])
        end
    end
    return nodes
end

function bfs!(nodes, start)
    for node in nodes
        node.color = "white"
        node.distance = 99999999
    end
    start.color = "grey"
    start.distance = 0
    Q = Queue{Node}()
    enqueue!(Q, start)
    while length(Q) > 0
        u = dequeue!(Q) #FIFO
        if isgoalnode(u)
            return u
        end
        for vertex in u.neighbours
            if vertex.color == "white"
            # Add vertex to queue
            vertex.color = "grey"
            vertex.distance = u.distance + 1
            vertex.predecessor = u
            enqueue!(Q, vertex)
            end
        end
    u.color = "black"
    end
    return nothing
end

function makepathto(goalnode)
    path::Array{Int64} = [goalnode.id]
    node = goalnode
    while node.predecessor != nothing
        push!(path, node.predecessor.id)
        node = node.predecessor
    end
    return reverse(path)
end
```
