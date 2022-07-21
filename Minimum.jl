using MATLAB
mutable struct Minimum
    mode::String
    min_over::String
    function Minimum(mode::String,min_over::String)
        if mode != "Value" && mode != "Index" && mode != "Value and Index"
            error("Mode должен быть значенеим Value, Index, Value and Index")
        end
        if min_over != "Entire input" && min_over != "Each row" && min_over != "Each column" && min_over != "Specified dimension"
            error("Value over должен быть значенеим Entire input, Each row, Each column,Specified dimension")
        end
        new(mode,min_over)
    end
end
function step(var_minimum::Minimum,x::Array{Float64},i=1::Int64)
    if var_minimum.min_over ==  "Entire input" 
           val = findmin(x)
    elseif var_minimum.min_over == "Each row"
        val = findmin.(eachrow(x))
    elseif var_minimum.min_over == "Each column"
        val = findmin.(eachcol(x))
    else var_minimum.min_over == "Specified dimension"
        val = findmin(x,dims = i)
    end
   
    if var_minimum.mode == "Value"
        if var_minimum.min_over ==  "Entire input" || var_minimum.min_over ==  "Specified dimension"
            val[1]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[1,:]
        end
    elseif var_minimum.mode == "Index"
        if var_minimum.min_over ==  "Entire input" || var_minimum.min_over ==  "Specified dimension"
            val[2]
        else
            n=floor(Int,length(collect(Iterators.flatten(val)))/2)
            return reshape(collect(Iterators.flatten(val)),2,n)[2,:]
    end
    else var_minimum.mode == "Value and Index"
        return val
    end
end
var_minimum=Minimum("Value","Specified dimension")
ouput_jl =step(var_minimum,[2.0 -3.0 58.0 3.0],1)
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Value_Specified_dimension_1')"
ouput_mat=mat"output1'"
test  = vec(ouput_jl) - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Minimum_Value_Specified_dimension_1 пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Value_Specified_dimension_1 не пройден")
end

var_minimum=Minimum("Value","Entire input")
ouput_jl =step(var_minimum,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Value_Entire_input')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Minimum_Value_Entire_input пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Value_Entire_input не пройден")
end

var_minimum=Minimum("Value","Each row")
ouput_jl = step(var_minimum,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Value_Each_row')"
ouput_mat=mat"output1'"
test  = ouput_jl[1] - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Minimum_Value_Each_row пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Value_Each_row не пройден")
end

var_minimum=Minimum("Value","Each column")
ouput_jl = step(var_minimum,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Value_Each_column')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if test<eps_val
    println("Тест Minimum_Value_Each_column пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Value_Each_column не пройден")
end
## need to convert Cartesian Index
#=var_minimum=Minimum("Index","Specified dimension")
ouput_jl =step(var_minimum,[2.0 -3.0 58.0 3.0],1)
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Index_Specified_dimension_1')"
ouput_mat=mat"output1'"
test  = vec(ouput_jl) - ouput_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Minimum_Index_Specified_dimension_1 пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Index_Specified_dimension_1 не пройден")
end

var_minimum=Minimum("Index","Entire input")
ouput_jl =step(var_minimum,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Index_Entire_input')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Minimum_Index_Entire_input пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Index_Entire_input не пройден")
end=#

var_minimum=Minimum("Index","Each row")
ouput_jl = step(var_minimum,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Index_Each_row')"
ouput_mat=mat"output1'"
test  = ouput_jl[1] - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Minimum_Index_Each_row пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Index_Each_row не пройден")
end

var_minimum=Minimum("Index","Each column")
ouput_jl = step(var_minimum,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Minimum_Index_Each_column')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if test<eps_val
    println("Тест Minimum_Index_Each_column пройден")
else vec(test)>vec(eps_val)
    error("Тест Minimum_Index_Each_column не пройден")
end
