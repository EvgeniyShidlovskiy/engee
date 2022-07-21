using Statistics
using MATLAB
mutable struct Sort
    mode::String
    sort_order ::String
    sort_algorithm::String
    function Sort(mode::String,sort_order = "Ascending"::String,sort_algorithm = "Quick sort"::String)
        if mode != "Value" && mode !="Index" && mode !="Value and Index"
            error("Mode должен быть значенеим Value, Index, Value and Index")
        end
        if sort_order != "Ascending"  && sort_order !="Descending" 
            error("Sort order должен быть значенеим Ascending или Descending")
        end
        if sort_algorithm != "Quick sort"  && sort_algorithm !="Insertion sort" 
            error("Sort algorithm должен быть значенеим Quick sort или Insertion sort")
        end
        new(mode,sort_order,sort_algorithm)
    end
end
function step(var_sort::Sort,x)
    r = false
    if  var_sort.sort_order == "Descending" 
        r=true
    elseif  var_sort.sort_order == "Ascending" 
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

var_sort = Sort("Value","Descending","Quick sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])


mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_desc')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"

test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Value_dec_quick пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_dec_quick не пройден")
end

var_sort = Sort("Value","Descending","Insertion sort")
ouput_Sort_Value_dec_ins_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_dec_insert')"
ouput_Sort_Value_dec_ins_mat=mat"output1'"
test =  ouput_Sort_Value_dec_ins_jl - ouput_Sort_Value_dec_ins_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Value_dec_insert пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_dec_insert не пройден")
end

var_sort = Sort("Value and Index","Descending","Quick sort")
ouput_Sort_Value_dec_ins_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_and_Index_dec_quick')"
ouput_Sort_Value_dec_ins_mat=mat"output1'"
ouput2_Sort_Value_dec_ins_mat=mat"output2'"
test1 = ouput_Sort_Value_dec_ins_jl[1] - ouput_Sort_Value_dec_ins_mat 
test2 = ouput_Sort_Value_dec_ins_jl[2] - convert(Vector{Int64}, ouput2_Sort_Value_dec_ins_mat)
eps_val = fill(3*eps(),size(test))
if test1<eps_val && test2<eps_val
    println("Тест Sort_Value_and_Index_dec_quick пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_and_Index_dec_quick не пройден")
end

var_sort = Sort("Value and Index","Descending","Insertion sort")
ouput_Sort_Value_dec_ins_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_and_Index_dec_insert')"
ouput_Sort_Value_dec_ins_mat=mat"output1'"
ouput2_Sort_Value_dec_ins_mat=mat"output2'"
test1 = ouput_Sort_Value_dec_ins_jl[1] - ouput_Sort_Value_dec_ins_mat 
test2 = ouput_Sort_Value_dec_ins_jl[2] - convert(Vector{Int64}, ouput2_Sort_Value_dec_ins_mat)
eps_val = fill(3*eps(),size(test))
if test1<eps_val && test2<eps_val
    println("Тест Sort_Value_and_Index_dec_insert пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_and_Index_dec_insert не пройден")
end

var_sort = Sort("Value and Index","Ascending","Insertion sort")
ouput_Sort_Value_dec_ins_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_and_Index_acs_insert')"
ouput_Sort_Value_dec_ins_mat=mat"output1'"
ouput2_Sort_Value_dec_ins_mat=mat"output2'"
test1 = ouput_Sort_Value_dec_ins_jl[1] - ouput_Sort_Value_dec_ins_mat 
test2 = ouput_Sort_Value_dec_ins_jl[2] - convert(Vector{Int64}, ouput2_Sort_Value_dec_ins_mat)
eps_val = fill(3*eps(),size(test))
if test1<eps_val && test2<eps_val
    println("Тест Sort_Value_and_Index_acs_insert пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_and_Index_acs_insert не пройден")
end

var_sort = Sort("Value and Index","Ascending","Insertion sort")
ouput_Sort_Value_dec_ins_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_and_Index')"
ouput_Sort_Value_dec_ins_mat=mat"output1'"
ouput2_Sort_Value_dec_ins_mat=mat"output2'"
test1 = ouput_Sort_Value_dec_ins_jl[1] - ouput_Sort_Value_dec_ins_mat 
test2 = ouput_Sort_Value_dec_ins_jl[2] - convert(Vector{Int64}, ouput2_Sort_Value_dec_ins_mat)
eps_val = fill(3*eps(),size(test))
if test1<eps_val && test2<eps_val
    println("Тест Sort_Value_and_Index пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_and_Index не пройден")
end

var_sort = Sort("Value","Ascending","Insertion sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value_acs_insert')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"
test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Value_acs_insert пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_acs_insert не пройден")
end

var_sort = Sort("Value","Ascending","Quick sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Value')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"
test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Value_asc_quick пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Value_asc_quick не пройден")
end

var_sort = Sort("Index","Descending","Quick sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Index_dec_quick')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"
test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Index_dec_quick пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Index_dec_quick не пройден")
end

var_sort = Sort("Index","Ascending","Insertion sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Index_acs_insert')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"
test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Index_acs_insert пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Index_acs_insert не пройден")
end

var_sort = Sort("Index","Descending","Insertion sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Index_dec_insert')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"
test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Index_dec_insert пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Index_dec_insert не пройден")
end

var_sort = Sort("Index","Ascending","Quick sort")
ouput_Sort_Value_dec_quick_jl = step(var_sort,[8, 3, -1, 96])
mat"const1=[8, 3, -1, 96]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Sort_Index')"
ouput_Sort_Value_dec_quick_mat=mat"output1'"
test =  ouput_Sort_Value_dec_quick_jl - ouput_Sort_Value_dec_quick_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Sort_Index_asc_quick пройден")
    test_num = test_num + 1;
else test>eps_val
    error("Тест Sort_Index_asc_quick не пройден")
end