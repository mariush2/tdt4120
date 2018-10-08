# dynamic_programming.jl
```julia
# All functions return 100% correct! :D
function cumulative(weights)
    #Select using wieght[x, y]
    weights_x, weights_y = size(weights)
    path_weights = zeros(Int64, weights_x, weights_y)

    for i = 1:weights_y
        path_weights[1, i] = weights[1, i]
    end

    for x = 1:weights_x - 1
        for y = 1:weights_y
            current = weights[x + 1, y]
            chosen = 0
            if y != 1 && y != weights_y
                #check both sides
                if weights[x, y - 1] <= weights[x, y] && weights[x, y - 1] <= weights[x, y + 1]
                    # 100% the smallest to the left
                    chosen = weights[x, y - 1]
                elseif weights[x, y] <= weights[x, y - 1] && weights[x, y] <= weights[x, y + 1]
                    chosen = weights[x, y]
                else
                    chosen = weights[x, y + 1]
                end
            elseif y == 1
                #Check only right
                if weights[x, y] <= weights[x, y + 1]
                    chosen = weights[x, y]
                else
                    chosen = weights[x, y + 1]
                end
            else
                #Check only left
                if weights[x, y - 1] <= weights[x, y]
                    chosen = weights[x, y - 1]
                else
                    chosen = weights[x, y]
                end
            end
            path_weights[x + 1, y] = chosen + current
            weights[x + 1, y] = path_weights[x + 1, y]
        end
    end
    return path_weights
end

function back_track(path_weights)
    path = []
    x, y = size(path_weights)
    #Init last value
    last_y = 0
    last_val = Inf
    for k = 1:y
        if path_weights[x, k] < last_val
            last_y = k
            last_val = path_weights[x, k]
        end
    end
    last = (x, last_y)
    push!(path, last)
    for i = x - 1:-1:1
        current = Inf
        current_y = 0
        if last_y != 1 && last_y != y
            #Check all sides
            if path_weights[i, last_y - 1] < current
               current = path_weights[i, last_y - 1]
               current_y = last_y - 1
            end

            if path_weights[i, last_y] < current
                current = path_weights[i, last[2]]
                current_y = last_y
            end

            if path_weights[i, last_y + 1] < current
                current = path_weights[i, last_y]
                current_y = last_y + 1
            end
        elseif last_y == 1
            #Check only right
            if path_weights[i, last_y] < current
                current = path_weights[i, last_y]
                current_y = last_y
            end

            if path_weights[i, last_y + 1] < current
                current = path_weights[i, last_y + 1]
                current_y = last_y + 1
            end
        else
            if path_weights[i, last_y - 1] < current
               current = path_weights[i, last_y - 1]
               current_y = last_y - 1
            end

            if path_weights[i, last_y] < current
                current = path_weights[i, last_y]
                current_y = last_y
            end
        end
        chosen = (i, current_y)
        last = chosen
        last_y = current_y
        push!(path, chosen)
    end
    return path
end
```
