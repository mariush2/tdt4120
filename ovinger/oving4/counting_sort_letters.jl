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
function counting_sort_letters(A, position)
   k = 96
   B = []
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
function counting_sort_length(A)
   B = []
   C = []
   for i = 1:length(A)
      push!(B, "")
      if length(C) < length(A[i])
         for i = 1:length(A[i])-length(C)
            push!(C, 0)
         end
      end
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

#println(counting_sort_length(["bbbb", "aa", "aaaa", "ccc"]))

#Question 3
function flexradix(A, max_length)
   B = A
   for i = 1:max_length
      counting_sort_length(A)
