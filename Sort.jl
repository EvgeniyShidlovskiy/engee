using Statistics

mutable struct Sort
    mode::String
    sort_order ::String
    sort_algorithm::String
    function Sort(mode::String,sort_order = "Acsending"::String,sort_algorithm = "Quick sort"::String)
        if mode != "Value" && mode !="Index" && mode !="Value and Index"
            error("Mode должен быть значенеим Value, Index, Value and Index")
        end
        if sort_order != "Acsending"  && sort_order !="Decsending" 
            error("Sort order должен быть значенеим Acsending или Decsending")
        end
        if sort_algorithm != "Quick sort"  && sosort_algorithm !="Insertion sort" 
            error("Sort algorithm должен быть значенеим Quick sort или Insertion sort")
        end
        new(mode,sort_order,sort_algorithm)
    end
end
function step(var_sort::Sort,x)
    r = false
    if  var_sort.sort_order == "Decsending" 
        r=true
    elseif  var_sort.sort_order == "Acsending" 
        r=false
    end

    if var_sort.sort_algorithm == "Quick sort"
        a=QuickSort
    elseif var_sort.sort_algorithm == "Insertion sort"
        a=InsertionSort
    end

    if var_sort.mode == "Value"
        return val = mapslices(y->sort!(y,rev = r, alg = a),x;dims  = 1)
    elseif var_sort.mode == "Index"
        return  ind = mapslices(y->sortperm(y,rev = r, alg = a), x;dims = 1)
    elseif var_sort.mode == "Value and Index"
         val = mapslices(y->sort!(y,rev = r, alg = a),x;dims  = 1)
         ind = mapslices(y->sortperm(y,rev = r, alg = a), x;dims = 1)
         return val,ind
    end
end
var_sort = Sort("Value and Index")
step(var_sort,[4, 3, 1, 2])