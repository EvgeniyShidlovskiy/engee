using Statistics
using MATLAB
mutable struct Median
    mode::String
    function Median(mode::String)
        if mode != "Entire input" && mode !="Each row" && mode !="Each column" && mode !="Specified dimension"
            error("Mode должен быть значенеим Entire input, Each row, Each column, Specified dimension")
        end
        new(mode)
    end
end
function step(var_median::Median,x::Array{Float64},i = 1::Int64)
    if var_median.mode == "Entire input"
        return y = median(x)
    elseif var_median.mode == "Each row"
        return y = median.(eachrow(x))
    elseif var_median.mode == "Each column"
        return y = median.(eachcol(x))
        else var_median.mode == "Specified dimension"
        return y = median(x,dims = i)
    end
end
var_median = Median("Each column")
ouput_jl = step(var_median,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Median_Each_colum')"
ouput_mat=mat"output1'"
test  = ouput_jl - ouput_mat
eps_val = fill(3*eps(),size(test))
if test<eps_val
    println("Тест Median_Each_column пройден")
else vec(test)>vec(eps_val)
    error("Тест Median_Each_column не пройден")
end

var_median = Median("Each row")
ouput_jl=step(var_median,[2.0 -3.0 58.0 3.0])
mat"const1=[2.0 -3.0 58.0 3.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Median_Each_rows')"
ouput_mat=mat"output1'"
test = ouput_jl[1] - ouput_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Median_Each_row пройден")
else test>veceps_val
    error("Тест Median_Each_row не пройден")
end

var_median = Median("Entire input")
ouput_std_each_row_jl=step(var_median,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0])
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Median_Entire_input')"
ouput_std_each_row_mat=mat"output1'"
test = ouput_std_each_row_jl - ouput_std_each_row_mat
eps_val = 3*eps()
if test<eps_val
    println("Тест Median_Entire_input пройден")
else test>eps_val
    error("Тест Median_Entire_input не пройден")
end

var_median = Median("Specified dimension")
ouput_var_spec_dem_jl=step(var_median,[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0],1)
mat"const1=[2.0 -36.0 58.0;5.0 30.0 -86;50.0 -1.0 4.0]"
mat"sim('C:\\Users\\523ur\\OneDrive\\Desktop\\engee-main\\New folder\\Median_Specified_dimension_1')"
ouput_var_spec_dem_mat=mat"output1'"
test = vec(ouput_var_spec_dem_jl) - ouput_var_spec_dem_mat
eps_val = fill(3*eps(),size(test))
if vec(test)<vec(eps_val)
    println("Тест Median_Specified_dimension_1 пройден")
else vec(test)>vec(eps_val)
    error("Тест Median_Specified_dimension_1 не пройден")
end
