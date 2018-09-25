function cumulative(weights)
    #Select using wieght[x, y]
    path_weights = zeros(Int64, 5, 5)
    len = 5
    for i = 1:len
        path_weights[1, i] = weights[1, i]
    end
    for x = 1:len - 1
        for y = 1:len
            current = weights[x + 1, y]
            if y != 1 && y != len
                #check both sides
                if weights[x, y - 1] + current < weights[x, y] + current
                    #left
                    path_weights[x + 1, y] = weights[x, y - 1] + current
                elseif weights[x, y] + current < weights[x, y + 1] + current
                    #down
                    path_weights[x + 1, y] = weights[x, y] + current
                else
                    #right
                    path_weights[x + 1, y] = weights[x, y + 1] + current
                end
            elseif y == 1
                #check only right
                if weights[x, y + 1] + current < weights[x, y] + current
                    path_weights[x + 1, y] = weights[x, y + 1] + current
                else
                    path_weights[x + 1, y] = weights[x, y] + current
                end
            else
                #check only left
                if weights[x, y - 1] + current < weights[x, y] + current
                    path_weights[x + 1, y] = weights[x, y - 1] + current
                else
                    path_weights[x + 1, y] = weights[x, y] + current
                end
            end
            weights[x + 1, y] = path_weights[x + 1, y]
        end
    end
    return path_weights
end

function test_cumulative()
    weights = [3  6  8 6 3;
           7  6  5 7 3;
           4  10 4 1 6;
           10 4  3 1 2;
           6  1  7 3 9]

    path_weights = [3  6  8  6  3;
                10 9  11 10 6;
                13 19 13 7  12;
                23 17 10 8  9;
                23 11 15 11 17]
    println("Path_weights:", typeof(path_weights))
    for x = 1:5
        println(path_weights[x, 1:5])
    end
    println("\n")
    test = cumulative(weights)
    println("Test weights:", typeof(test))
    for x = 1:5
        println(test[x, 1:5])
    end
    return test == path_weights
end

println(test_cumulative())
