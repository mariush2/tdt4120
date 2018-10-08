# traversemax.jl
```julia
mutable struct Record
    next::Union{Record,Nothing}  # next kan peke på et Record-objekt eller ha verdien nothing.
    value::Int
end

function createlinkedlist(length, valuerange)
    # Lager listen bakfra.
    next = nothing
    record = nothing
    for i in 1:length
        record = Record(next, rand(valuerange))  # valuerange kan f.eks. være 1:1000.
        next = record
    end
    return record
end

function traversemax(record)
    current = record
    max = record.value
    while current.next != nothing
        current = record.next
        if current.value > max
            max = current.value
        end
    end
    return max
end

print((createlinkedlist(10, 1000))
```
