# alltoall.jl
```julia
#f = min
#g = +
f(x, y) = min(x, y)
g(x, y) = (x + y)

function floyd_warshall(adjacency_matrix, nodes, f, g)
    D = []
    push!(D, adjacency_matrix) # D^0 = W
    for k = 2:nodes
        push!(D, fill(Inf, (nodes, nodes)))
        for i = 1:nodes
            for j = 1:nodes
                D[k][i, j] = f(D[k - 1][i, j], g(D[k - 1][i, k], D[k - 1][k, j]))
            end
        end
    end
    return D[nodes]
end

function test_floyd()
    a = [0 7 2; Inf 0 Inf; Inf 4 0]
    n = 3
    result = floyd_warshall(a, n, f::Function, g::Function)
    return [0 6 2; Inf 0 Inf; Inf 4 0] == result
end

println(test_floyd())
```
