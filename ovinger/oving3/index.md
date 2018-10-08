# divide_and_conquer.jl
```julia
#Question 1
function bisect_left(A, pos, rear, val)
    i = pos
    if pos < rear
       q = floor(Int, (pos+rear)/2)  # floor() er en innebygd funksjon som runder ned. ceil() runder opp.
       if val <= A[q]
           i = bisect_left(A, pos, q, val)
       else
           i = bisect_left(A, q+1, rear, val)
       end
   end
   return i
end

function bisect_right(A, p, r, v)
    i = p
    if p < r
       mid = ceil(Int, (p+r)/2)  # floor() er en innebygd funksjon som runder ned. ceil() runder opp.
       if v >= A[mid]
           i = bisect_right(A, mid, r, v)
       else
           i = bisect_right(A, p, mid-1, v)
       end
   end
   return i
end

function test_bisects()
    a = [1,2,2,3]
    find = 2
    println("Looking for ",find," in ",a)

    print("Bisect left gave index: ")
    print(bisect_left(a, 1, length(a), find))

    print("\n")

    print("Bisect right gave index: ")
    print(bisect_right(a, 1, length(a), find))
    #It works?
end

#Question 2
function qsort(A,p,r)
    if p < r
        q = partition(A,p,r)
        qsort(A,p,q-1)
        qsort(A,q+1,r)
    end
    return A
end

function partition(A,p,r)
    x = A[r]
    i = p - 1
    for j = p:r-1
        if A[j] <= x
            i = i + 1
            temp = A[i]
            A[i] = A[j]
            A[j] = temp
        end
    end
    temp2 = A[i + 1]
    A[i + 1] = A[r]
    A[r] = temp2
    return i + 1
end

function algdat_sort!(A)
    #Quicksort, works
    qsort(A, 1, length(A))
end

function find_median(A, lower, upper)
    #Works!
    left = bisect_left(A, 1, length(A), lower)
    right = bisect_right(A, 1, length(A), upper)
    lengthSub = right - left + 1
    mid = floor(Int,left + (right-left)/2)

    if lengthSub % 2 == 0
        #Partalls subarray liste
        return (A[mid] + A[mid+1])/2
    else
        return A[mid]
    end
end

#println("\nTest\n")
println(find_median([3, 5, 7], 5, 7))
#6.0  deltabell=[5, 7]

#println(find_median([10, 20, 30], -100, 100))
#20.0 deltabell=[10, 20, 30]

#println(find_median([1, 5, 5, 7, 10, 10, 10], 5, 10))
#8.5  deltabell=[5, 5, 7, 10, 10, 10]

#println(find_median([1,2,3], 1 ,2))
#1.5 deltabell=[1,2]

#test_bisects()
```
