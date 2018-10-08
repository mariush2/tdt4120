# insertion_sort.jl
```julia
#Insertion sort
function insertion_sort(A)
    for j = 2:length(A)
        key = A[j]
        # Insert A[j] into sorted sequence A[1..j-1]
        i = j - 1
        while i > 0 && A[i] > key
            A[i + 1] = A[i]
            i = i - 1
        end
        A[i + 1] = key
    end
    return A
end
```
