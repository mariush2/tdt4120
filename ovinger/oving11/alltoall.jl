#f = min
#g = +

function f(x, y)
    return min(x, y)
end

function g(x, y)
    return x + y
end

function floyd_warshall(adjacency_matrix, nodes) ## Remember to "add" f and g afterwards

end

function test_floyd()
    a = [0 7 2; Inf 0 Inf; Inf 4 0]
    n = 3
    return [0 6 2; Inf 0 Inf; Inf 4 0] == floyd_warshall(a, n)
end
