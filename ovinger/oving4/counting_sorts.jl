#=
function counting-sort(A, B, k)
    let C[0...k] be a new array
    for i = 0 to k
       C[i] = 0
    for j = 1 to A.length
       C[A[j]] += 1
    for i = 1 to k
       C[i] = C[i] + C[i - 1]
    for j = A.length downto 1
       B[C[A[j]]] = A[j]
       C[A[j]] -= 1
=#
#Question 1
#Done
function counting_sort_letters(A::Array{String,1}, position::Int)
   k = 96
   B::Array{String} = []
   C = zeros(26)
   for i = 1:length(A)
      push!(B, "")
   end
   for j = 1:length(A)
      C[Int(A[j][position]) - k] = C[Int(A[j][position]) - k] + 1
   end
   for i = 2:26
      C[i] = C[i] + C[i - 1]
   end
   for j = length(A):-1:1
      #println(Int(C[Int(A[j][position]) - k]))
      B[Int(C[Int(A[j][position]) - k])] = A[j]
      C[Int(A[j][position]) - k] = C[Int(A[j][position]) - k] - 1
   end
   return B
end

#println(counting_sort_letters(["ccc", "cba", "ca", "ab", "abc"], 2))

#Question 2
#=
function counting-sort(A, B, k)
    let C[0...k] be a new array
    for i = 0 to k
       C[i] = 0
    for j = 1 to A.length
       C[A[j]] += 1
    for i = 1 to k
       C[i] = C[i] + C[i - 1]
    for j = A.length downto 1
       B[C[A[j]]] = A[j]
       C[A[j]] -= 1
=#

# Return ERROR in INGINIOUS
function counting_sort_length(A)
   B = []
   C = []
   needed = 0
   for i = 1:length(A)
      push!(B, "")
      if length(A[i]) > needed
         needed = length(A[i])
      end
   end
   for i = 1:needed
      push!(C, 0)
   end
   for j = 1:length(A)
      C[length(A[j])] = C[length(A[j])] + 1
   end
   for i = 2:length(C)
      C[i] = C[i] + C[i - 1]
   end
   for j = length(A):-1:1
      B[C[length(A[j])]] = A[j]
      C[length(A[j])] = C[length(A[j])] - 1
   end
   return B
end

println(counting_sort_length(["bbbbb", "aa", "aaaa", "ccc"]))

#Question 3
#Done
function flexradix(A, max_length)
   for i = max_length:-1:1
      rest::Array{String} = []
      actual::Array{String} = []
      for j = 1:length(A)
         if i > length(A[j])
            push!(rest, A[j])
         else
            push!(actual, A[j])
         end
      end
      actual = counting_sort_letters(actual, i)
      for j = 1:length(actual)
         push!(rest, actual[j])
      end
      A = rest
   end
   return A
end

println(flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6))
#Skal returnere ["agg", "aggie", "hyblen", "kobra", "kort"]
