#f = min
#g = +
function f(x, y)
    return min(x, y)
end

function g(x, y)
    return x + y
end

function floyd_warshall(adjacency_matrix, nodes, f::Function, g::Function)
    D = []
    push!(D, adjacency_matrix) # D^0 = W
    for k = 1:nodes
        push!(D, fill(Inf, (nodes, nodes)))
    end
    println("Before run")
    print_floyd(D)
    println("\n")
    for k = 2:nodes
        for i = 1:nodes
            for j = 1:nodes
                D[k][j, i] = f(D[k - 1][j, i], g(D[k - 1][k, i], D[k - 1][j, k]))
            end
        end
    end
    println("After run")
    print_floyd(D)
    return D[nodes + 1]
end

function test_floyd()
    a = [0 7 2; Inf 0 Inf; Inf 4 0]
    n = 3
    return [0 6 2; Inf 0 Inf; Inf 4 0] == floyd_warshall(a, n, f::Function, g::Function)
end

function print_floyd(D)
    for matrix in D
        display(matrix)
        print("\n\n")
    end
end

println(test_floyd())
