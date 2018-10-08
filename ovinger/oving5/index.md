# rooted_trees.jl
```julia
struct Node
    children::Dict{Char,Node}
    posi::Array{Int}
end

Node() = Node(Dict(),[])

function parse_string(sentence::String)::Array{Tuple{String,Int}}
    A = split(sentence)
    B::Array{Tuple{String,Int}} = []
    traversed = 1
    for word in A
        push!(B, (word, traversed))
        traversed = traversed + length(word) + 1
    end
    return B
end

#println(parse_string("en ei et"))
#Returns [("en", 1), ("ei", 4), ("et", 7)]

function build(list_of_words::Array{Tuple{String,Int}})::Node
    top = Node()
    for tuple in list_of_words
        word = tuple[1]
        current = top
        for (index, key) in enumerate(word)
            if !haskey(current.children, key)
                current.children[key] = Node()
            end
            current = current.children[key]
            if index == length(word)
                #Last key in current word
                push!(current.posi, tuple[2])
            end
        end
    end
    return top
end

function position(word::String,node::Node,index::Int=1)::Array{Int}
    if index == length(word)
        #Last value
        return node.posi
    end
    key = word[index]
    print(node.children)
    if haskey(node.children, key)
        print("has key")
        #Has the key
        position(word, node.children[key], index + 1)
    else
        return []
    end
end

top_node = build(parse_string("ha ha mons har en hund med moms hun er en hunn"))
println(position("ha",top_node))
```
