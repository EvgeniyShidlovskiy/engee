#need add Running mode
mutable struct Maximum
    mode::String
    max_over::String
    function Maximum(mode::String,max_over::String)
        if mode != "Value" && mode != "Index" && mode != "Value and Index"
            error("Mode должен быть значенеим Value, Index, Value and Index")
        end
        if max_over != "Entire input" && max_over != "Each row" && max_over != "Each column" && max_over != "Specified dimension"
            error("Value over должен быть значенеим Entire input, Each row, Each column,Specified dimension")
        end
        new(mode,max_over)
    end
end
function step(var_maximum::Maximum,x::Array{Float64},i=1::Int64)
    if var_maximum.max_over ==  "Entire input" 
           val = findmax(x)
    elseif var_maximum.max_over == "Each row"
        val = findmax.(eachrow(x))
    elseif var_maximum.max_over == "Each column"
        val = findmax.(eachcol(x))
    else var_maximum.max_over == "Specified dimension"
        val = findmax(x,dims = i)
    end
   
    if var_maximum.mode == "Value"
        if var_maximum.max_over ==  "Entire input" || var_maximum.max_over ==  "Specified dimension"
            val[1]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[1,:]
        end
    elseif var_maximum.mode == "Index"
        if var_maximum.max_over ==  "Entire input" || var_maximum.max_over ==  "Specified dimension"
            val[2]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[2,:]
    end
    else var_maximum.mode == "Value and Index"
        return val
    end
end


var_maximum=Maximum("Value","Specified dimension")
ouput_jl =step(var_maximum
,[2.0 -3.0 58.0 3.0],1)
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Value_Specified_dimension_1')"
ouput_mat=mat"output1'"
test  = vec(ouput_jl) - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Maximum_Value_Specified_dimension_1 пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Maximum_Value_Specified_dimension_1 не пройден")
end

var_maximum=Maximum("Value","Entire input")
ouput_jl =step(var_maximum
,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Value_Entire_input')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Maximum_Value_Entire_input пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Maximum_Value_Entire_input не пройден")
end

var_maximum=Maximum("Value","Each row")
ouput_jl = step(var_maximum
,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Value_Each_row')"
ouput_mat=mat"output1'"
test  = ouput_jl[1] - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Maximum_Value_Each_row пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Maximum_Value_Each_row не пройден")
end

var_maximum=Maximum("Value","Each column")
ouput_jl = step(var_maximum
,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Value_Each_column')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if test<eps_val
    println("Тест Maximum_Value_Each_column пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Maximum_Value_Each_column не пройден")
end
## need to convert Cartesian Index
#=var_maximum
=Maximum("Index","Specified dimension")
ouput_jl =step(var_maximum
,[2.0 -3.0 58.0 3.0],1)
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Index_Specified_dimension_1')"
ouput_mat=mat"output1'"
test  = vec(ouput_jl) - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Maximum_Index_Specified_dimension_1 пройден")
else vec(test)>vec(eps_val)
    error("Тест Maximum_Index_Specified_dimension_1 не пройден")
end

var_maximum
=Maximum("Index","Entire input")
ouput_jl =step(var_maximum
,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Index_Entire_input')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Maximum_Index_Entire_input пройден")
else vec(test)>vec(eps_val)
    error("Тест Maximum_Index_Entire_input не пройден")
end=#

var_maximum=Maximum("Index","Each row")
ouput_jl = step(var_maximum
,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Index_Each_rows')"
ouput_mat=mat"output1'"
test  = ouput_jl[1] - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Maximum_Index_Each_row пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Maximum_Index_Each_row не пройден")
end

var_maximum=Maximum("Index","Each column")
ouput_jl = step(var_maximum
,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Maximum_Index_Each_colum')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if test<eps_val
    println("Тест Maximum_Index_Each_column пройден")
    test_num = test_num + 1;
else vec(test)>vec(eps_val)
    error("Тест Maximum_Index_Each_column не пройден")
end
