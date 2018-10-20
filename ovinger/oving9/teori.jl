using LightGraphs

g = SimpleGraph(8)
#=
1 = A
2 = B
3 = C
4 = D
5 = E
6 = F
7 = G
8 = H
=#

dict = Dict("A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6, "G" => 7, "H" => 8)
w = zeros(8, 8)

#For A
add_edge!(g, dict["A"], dict["B"])
w[dict["A"], dict["B"]] = 7
w[dict["B"], dict["A"]] = 7
add_edge!(g, dict["A"], dict["D"])
w[dict["A"], dict["D"]] = 1
w[dict["D"], dict["A"]] = 1
add_edge!(g, dict["A"], dict["F"])
w[dict["A"], dict["F"]] = 6
w[dict["F"], dict["A"]] = 6

#For B
add_edge!(g, dict["B"], dict["C"])
w[dict["B"], dict["C"]] = 2
w[dict["C"], dict["B"]] = 2
add_edge!(g, dict["B"], dict["E"])
w[dict["B"], dict["E"]] = 9
w[dict["E"], dict["B"]] = 9

#For C
add_edge!(g, dict["C"], dict["D"])
w[dict["C"], dict["D"]] = 4
w[dict["D"], dict["C"]] = 4
add_edge!(g, dict["C"], dict["H"])
w[dict["C"], dict["H"]] = 3
w[dict["H"], dict["C"]] = 3

#For D
add_edge!(g, dict["D"], dict["E"])
w[dict["D"], dict["E"]] = 8
w[dict["E"], dict["D"]] = 8
add_edge!(g, dict["D"], dict["G"])
w[dict["D"], dict["G"]] = 5
w[dict["G"], dict["D"]] = 5

#For E
add_edge!(g, dict["E"], dict["F"])
w[dict["E"], dict["F"]] = 9
w[dict["F"], dict["E"]] = 9
add_edge!(g, dict["E"], dict["H"])
w[dict["E"], dict["H"]] = 2
w[dict["H"], dict["E"]] = 2

#For F
add_edge!(g, dict["F"], dict["G"])
w[dict["F"], dict["G"]] = 1
w[dict["G"], dict["F"]] = 1

#For G
add_edge!(g, dict["G"], dict["H"])
w[dict["G"], dict["H"]] = 3
w[dict["H"], dict["G"]] = 3

#For H
#All edges are "taken"
#Sorted out making graph, now to making algorithms

function kruskal()
    a = kruskal_mst(g, w)
    print("Kruskal:")
    for edge in a
        print(" ", edge)
    end
    print(".\n")
end

function prim()
    a = prim_mst(g, w)
    print("Prims:")
    for edge in a
        print(" ", edge)
    end
    print(".\n")
end

kruskal()
prim()
